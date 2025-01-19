*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${DEV_URL}      http://134.209.105.245/product/list
${SIT_URL}      http://159.223.71.75/product/list
${UAT_URL}      http://165.22.255.65/product/list
${BROWSER}      chrome


*** Test Cases ***
ทดสอบซื้อสินค้าชำระเงินด้วย credit card visa ชำระเงินสำเร็จ
    ค้นหาสินค้าด้วย คำค้นหา
    ตรวจสอบผลการค้นหา
    เลือกดูสินค้า
    ตรวจสอบจำนวนแต้มต่อชิ้นที่จะได้รับของ
    เพิ่มจำนวนสินค้าที่ต้องการซื้อ
    เพิ่มสินค้าลงในตะกร้า
    ตรวจสอบจำนวนแต้มต่อชิ้นที่จะได้รับของสินค้าในตะกร้า
    ใส่ที่อยู่จัดส่งสินค้า
    เลือกรูปแบบการจัดส่ง
    ตรวจสอบค่าจัดส่งสินค้าของ Kerry เท่ากันกับ 50.00 บาท
    เลือกช่องทางการชำระเงินแบบ VISA Credit Card และใส่ข้อมูลบัตร
    # ตรวจสอบราคารวมที่ต้องชำระเงิน ต้องเท่ากันกับ
    ยืนยัน OTP
    # ตรวจสอบหมายเลขพัสดุ
    # ยืนยันการส่งการแจ้งเตือนด้วย email และ เบอร์โทรศัพท์

# ทดสอบซื้อสินค้าโดยวิธีจัดส่งเป็น Thai Post ชำระเงินด้วย credit card visa ชำระเงินสำเร็จ
#     ค้นหาสินค้าด้วย คำค้นหา
#     ตรวจสอบผลการค้นหา
#     เลือกดูสินค้า
#     ตรวจสอบจำนวนแต้มต่อชิ้นที่จะได้รับของ
#     เพิ่มจำนวนสินค้าที่ต้องการซื้อ
#     เพิ่มสินค้าลงในตะกร้า
#     ตรวจสอบจำนวนแต้มต่อชิ้นที่จะได้รับของสินค้าในตะกร้า
#     ใส่ที่อยู่จัดส่งสินค้า
#     เลือกรูปแบบการจัดส่ง
#     ตรวจสอบค่าจัดส่งสินค้าของ Kerry เท่ากันกับ 50.00 บาท
#     เลือกช่องทางการชำระเงินแบบ VISA Credit Card และใส่ข้อมูลบัตร
    # ตรวจสอบราคารวมที่ต้องชำระเงิน ต้องเท่ากันกับ
    # ยืนยัน OTP
    # ตรวจสอบหมายเลขพัสดุ
    # ยืนยันการส่งการแจ้งเตือนด้วย email และ เบอร์โทรศัพท์


*** Keywords ***
ค้นหาสินค้าด้วย คำค้นหา
    Open Browser    url=${DEV_URL}    browser=${BROWSER}
    Input Text    id=search-product-input    Bicycle
    Click Element    id=search-product-btn

ตรวจสอบผลการค้นหา
    Wait Until Element Is Visible    id=product-card-name-1
    Element Should Contain    id=product-card-name-1    Balance Training Bicycle
    Element Should Contain    id=product-card-price-1    ฿4,314.60

เลือกดูสินค้า
    Click Element    id:product-card-name-1

ตรวจสอบจำนวนแต้มต่อชิ้นที่จะได้รับของ
    Wait Until Element Is Visible    id=product-detail-product-name
    Element Should Contain    id=product-detail-point    43 Points

เพิ่มจำนวนสินค้าที่ต้องการซื้อ
    Click Button    id:product-detail-quantity-increment-btn
    Element Attribute Value Should Be    id=product-detail-quantity-input    value    2

เพิ่มสินค้าลงในตะกร้า
    Click Button    id:product-detail-add-to-cart-btn
    # Element Should Contain   id:header-menu-cart-badge    1

ตรวจสอบจำนวนแต้มต่อชิ้นที่จะได้รับของสินค้าในตะกร้า
    Click Button    id:header-menu-cart-btn
    Wait Until Element Is Visible    id:product-1-point
    Click Element    id:shopping-cart-checkout-btn
    # Element Should Contain    id:product-1-point    129 Points 

ใส่ที่อยู่จัดส่งสินค้า
    Input Text    name:firstName    ทดสอบชื่อ
    Input Text    name:lastName    ทดสอบนามสกุล
    Input Text    name:address    ทดสอบที่อยู่
    Select From List By Label    id:shipping-form-province-select    กรุงเทพมหานคร
    Select From List By Label    id:shipping-form-district-select    เขตพระนคร
    Select From List By Label    id:shipping-form-sub-district-select    พระบรมมหาราชวัง
    Input Text    id:shipping-form-mobile-input    ทดสอบเบอร์โทรศัพท์

เลือกรูปแบบการจัดส่ง
    Click Element    id=shipping-method-1-time

ตรวจสอบค่าจัดส่งสินค้าของ Kerry เท่ากันกับ 50.00 บาท
    Element Text Should Be    id:order-summary-shipping-fee-price    ฿50.00

เลือกช่องทางการชำระเงินแบบ VISA Credit Card และใส่ข้อมูลบัตร
    Click Element    id:payment-credit-input
    Input Text    name:fullname    ทดสอบชื่อบนบัตร
    Input Text    name:number    0000 0000 0000 0000
    Input Text    name:expiry    00/00
    Input Text    id:payment-credit-form-cvv-input    000

# ตรวจสอบราคารวมที่ต้องชำระเงิน ต้องเท่ากันกับ
#     Element Text Should Be    id:order-summary-total-payment-price    ฿12,993.79

ยืนยัน OTP
    Click Button    id:payment-now-btn
    Sleep    5