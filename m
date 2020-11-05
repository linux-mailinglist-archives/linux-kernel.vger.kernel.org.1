Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC142A79AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgKEIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:55:05 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:4373 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKEIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604566503; x=1636102503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jG4mFwTomel/V7fH+GSxngZ9Zvpy1TZk4fvxLReXfi4=;
  b=P8pw+LHLAFCWNe7yJci8932bcp71C/jWGvMUeoHu+PGgm4c9L3pRRF6n
   XOtogtw1FYT+u04b8DtlvSoaCJx7Pjlj6BmgGZomv41cYbal0pCX0E/ns
   EhRKQJIbWvwDJaYNA1EwIc00DTymxH6iBY6drIqlU8a0Xp8qk7B0iSQuM
   llzrG6Q2GxhKl+7xo5nSTWuiN8JMrC1BVaAFwskwZQRUhZu556eW1qYRG
   /CvD6geZU286RmZSg2RNVhYJpRhhNNgC0LXyNhj9rHjHdh9wR6SXVnHNQ
   A3AtZl9chFZgIwt20ltd6NE9ak+E0HuRjvd5CJfKojIQC+mTsjS2A443X
   Q==;
IronPort-SDR: RaSsCAeP4gYJ92CUH0gQzr1YrjBxm4uaMSxn41SgE+GhZlVUhaZqXQ6gxrdi1Ijb7k+gKC0xNX
 wlQwO4vLcAmijK6u9IwlxYuZ1fdFGcYO6rtX5rxs6nVPy+79x3k4Q9IcgrxLbyO9ss84X6Seoz
 zzro1k2n2DF88e6V1BuYXmsZslMOd2c6domDWr/InJnpe7Uh+blT7VjCm299Je4GBErbcAxTAH
 SILB4I3HVKNscjDUQkRxPLg9ydoCZwEDvL0HELxtULdqcsw9o0rGRNYqIESLCyked3aUSDWBA2
 R4g=
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="97849470"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Nov 2020 01:55:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 01:55:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 5 Nov 2020 01:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMHBPQkD6ufryAOP+zUtXZlckcH5e1lwx6ijDVCryGj3k5yNpGMT8Vw0T/uiggMEdV4fAMwMZy6fM597iLLQaOCGqd4xJGvJDt6o3on3ccjDXNzfZvg20VryJfFAAMz7L5vWV6qcyWk5jCdciIfXm1EzjYwg/PFDDcCuhODiNneGsLgm0z0FpBpiBp2GUC0HKkcY+Aiw/lvdK2deDR4mBwMdVqhWdtuhJ6na1DpGJ3ysR4sjqeYO4cwCcl5KUMg7G4sij1xbuECA9/eTTR4zcYzCYSVvK8lBxBUraWvtBZxJg+IvfOvmR2tcNVUQuM+YoOUNW5be/RSzd6JuGz9+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG4mFwTomel/V7fH+GSxngZ9Zvpy1TZk4fvxLReXfi4=;
 b=BKb4DuKT6Gq1m0zYmhPFyixMXBIAEKkZ5D1beBG99rP/803f7qMP9xrQGLgUF2pjhdUtM06hfkbAqj9AeRgTj+1n2KKgAlDRvJ2nxafelRAT1oqna9dyEoez5WUC5tMa1ofkyniJwqGVRb6Uw/XmnOpRDL5aO5tfvgY7KS5Vyav8g2qXfyKPVZW75vuRBRuAWpK4y10Me3aUOZz5DKa5KidVxJRfWk6DCbzXZgjDZ3gv42ocnW/Rt//foIcoyj+lRsR7zy4qgGE9+vastKKNeGprtajiNOq7hec3FGWXlKLJF7Blqe4fIF+dzpW6zUSC7KOKH1XLBV4i2vGp3ZRwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG4mFwTomel/V7fH+GSxngZ9Zvpy1TZk4fvxLReXfi4=;
 b=FKq7sOKCRAGVLebaQjre2utINSWwTuCogbfUJ4g8GzcsJpBNxSXQVzkjXg7W1m0Hi/pFxjf+hjitqQOlVZMwMh4pKTTg2q4f+CpTHXFWF2kLqQml0YedELVSaYSk15ntVcJwIuVqWxbYpiUAu5TcqUUdkqKEBZTI8tcHSSqIpT8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2781.namprd11.prod.outlook.com (2603:10b6:805:62::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 5 Nov
 2020 08:55:01 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f%3]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 08:55:01 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <Eugen.Hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/8] clk: at91: sama7g5: fix compilation error
Thread-Topic: [PATCH v2 1/8] clk: at91: sama7g5: fix compilation error
Thread-Index: AQHWs1FYPJsW02JaGkKNj9rwleyezw==
Date:   Thu, 5 Nov 2020 08:55:00 +0000
Message-ID: <0c3c2191-d01d-2254-32b4-1873ebb1b78d@microchip.com>
References: <1604511926-29516-1-git-send-email-claudiu.beznea@microchip.com>
 <1604511926-29516-2-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1604511926-29516-2-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [86.127.107.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d13c6e39-8195-443a-6a5a-08d881687ae5
x-ms-traffictypediagnostic: SN6PR11MB2781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2781CB837A2839A0AE1A6359F0EE0@SN6PR11MB2781.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWqL8fSWQkpfhsR/wtoiS6EzzihZlUKDeYCEEBlBPPsRUtXhhwlrVYFaPbdNU/ycEdnhMpKGNLh7kKF4BYx6MpO4hBYkp9GM7w+xuS7+prpkInEwLei/LJNH89Kp/Tf7n9RJi/bljZ7+H5DbRgbYqoSXQbXJl/otV3CC6fP/qrwehr8GS/dn2DBhK3s358KPUHXYruVoPxHPY47UWAk9FNjI5z33JEQ8rakq7QpTicnBiRP9yuMHMg157Lkwqu1leUIDJA3vDR+r5a/tUP5cC52EXQTxL3Y+CFoX7bvqL+MnolWX7QbLjsrEqFe6qnQXjhrRRkMgvTOGrxfKkiHb3PLovn0ir9srpAnbQViIkzkCeHWquLHHwfsJAeYuAh/o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(376002)(39860400002)(5660300002)(31686004)(6486002)(86362001)(36756003)(66446008)(64756008)(8936002)(54906003)(8676002)(66556008)(31696002)(66476007)(186003)(66946007)(76116006)(2616005)(2906002)(4326008)(71200400001)(110136005)(83380400001)(26005)(316002)(6512007)(478600001)(53546011)(6506007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: us8ZYdowVCo5FEFcjeUPNrsJM9eFjdDWg90c6KxS2eeqfEx5x9epP24Z0W6Y5Fbi6eSdpftWVYWdyY+dT33FHkpl7Z/LNbe+Mhgni3k78r/ASnKwaN3GHwzDSSq54BdGxR8tQojRJ6fDFwq0WLsJ4XlN3k4r8fnpkNJCpe37kwTDRgnDEZdotWiOM6WOZausU55g/9nBafDqLczGQvH+PQaKOCAaSAH6WHRUo1K23BFUri+E1d2Hmy3OKpWip80NwAVQaJpE1se5Cfr2Ec2282VacpeHjL6E93QpbMdxtOPvNR1me9msYhcgDdKbRglCOWzAgmsd6nb5RBEhzg2Ninti+Gx1vzIDzx6Pt8B9JCCfzFu29D1abxPT/FeWeI6X0A4CvA5hKQ+m+xf7N+Gak6yRaiU/nIsDtU4efhj6uZS2YQiK4Bjf7c7Vdw2SkasF6/HFIEhCQz+ijU/0/XeEVtKQPM6BC8EmKfW6zQiMof+ByyvK4zqAllqB0theQ2Pz297wGAhJDFyB8OeDN1cwrYjnUtf0TwlLq9QL7m8e9kDcBEgEisNpqr+QtCdpNwZYXh7+njYscGwB5s1T06qZf8tCSgDrS9iJdkznENDg/SxXolGTzIRgUW2CvfZo2vubKoVSRpVWw/JIJOvehggVGw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <28DF38BD2513D848A37A534BA1F61538@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13c6e39-8195-443a-6a5a-08d881687ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 08:55:00.9550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PnRIeQBVVDRl8EwH/BUVOCIPtQlZQM5/jnQ2Nuo5htMNbDYKV9Vhm8WwieUwc2JhMCtD8v8G9Irh1UA47LON8Z+zQ9E5ROEZp69Ab+P82TY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2781
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNC8yMCA3OjQ1IFBNLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4gcG1jX2RhdGFfYWxs
b2NhdGUoKSBoYXMgYmVlbiBjaGFuZ2VkLiBwbWNfZGF0YV9mcmVlKCkgd2FzIHJlbW92ZWQuDQo+
IEFkYXB0IHRoZSBjb2RlIHRha2luZyB0aGlzIGludG8gY29uc2lkZXJhdGlvbi4gV2l0aCB0aGlz
IHRoZSBwcm9ncmFtbWFibGUNCj4gY2xvY2tzIHdlcmUgYWxzbyBzYXZlZCBpbiBzYW1hN2c1X3Bt
YyBzbyB0aGF0IHRoZXkgY291bGQgYmUgbGF0ZXINCj4gcmVmZXJlbmNlZC4NCj4gDQo+IEZpeGVz
OiBjYjc4M2JiYmNmNTQgKCJjbGs6IGF0OTE6IHNhbWE3ZzU6IGFkZCBjbG9jayBzdXBwb3J0IGZv
ciBzYW1hN2c1IikNCj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6
bmVhQG1pY3JvY2hpcC5jb20+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5h
bWJhcnVzQG1pY3JvY2hpcC5jb20+DQpUZXN0ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFt
YmFydXNAbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvY2xrL2F0OTEvc2FtYTdn
NS5jIHwgNiArKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvYXQ5MS9zYW1hN2c1LmMg
Yi9kcml2ZXJzL2Nsay9hdDkxL3NhbWE3ZzUuYw0KPiBpbmRleCAwZGIyYWIzZWNhMTQuLmEwOTJh
OTQwYmFhNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9zYW1hN2c1LmMNCj4gKysr
IGIvZHJpdmVycy9jbGsvYXQ5MS9zYW1hN2c1LmMNCj4gQEAgLTgzOCw3ICs4MzgsNyBAQCBzdGF0
aWMgdm9pZCBfX2luaXQgc2FtYTdnNV9wbWNfc2V0dXAoc3RydWN0IGRldmljZV9ub2RlICpucCkN
Cj4gIAlzYW1hN2c1X3BtYyA9IHBtY19kYXRhX2FsbG9jYXRlKFBNQ19JMlMxX01VWCArIDEsDQo+
ICAJCQkJCW5jayhzYW1hN2c1X3N5c3RlbWNrKSwNCj4gIAkJCQkJbmNrKHNhbWE3ZzVfcGVyaXBo
Y2spLA0KPiAtCQkJCQluY2soc2FtYTdnNV9nY2spKTsNCj4gKwkJCQkJbmNrKHNhbWE3ZzVfZ2Nr
KSwgOCk7DQo+ICAJaWYgKCFzYW1hN2c1X3BtYykNCj4gIAkJcmV0dXJuOw0KPiAgDQo+IEBAIC05
ODAsNiArOTgwLDggQEAgc3RhdGljIHZvaWQgX19pbml0IHNhbWE3ZzVfcG1jX3NldHVwKHN0cnVj
dCBkZXZpY2Vfbm9kZSAqbnApDQo+ICAJCQkJCQkgICAgc2FtYTdnNV9wcm9nX211eF90YWJsZSk7
DQo+ICAJCWlmIChJU19FUlIoaHcpKQ0KPiAgCQkJZ290byBlcnJfZnJlZTsNCj4gKw0KPiArCQlz
YW1hN2c1X3BtYy0+cGNod3NbaV0gPSBodzsNCj4gIAl9DQo+ICANCj4gIAlmb3IgKGkgPSAwOyBp
IDwgQVJSQVlfU0laRShzYW1hN2c1X3N5c3RlbWNrKTsgaSsrKSB7DQo+IEBAIC0xMDUyLDcgKzEw
NTQsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgc2FtYTdnNV9wbWNfc2V0dXAoc3RydWN0IGRldmlj
ZV9ub2RlICpucCkNCj4gIAkJa2ZyZWUoYWxsb2NfbWVtKTsNCj4gIAl9DQo+ICANCj4gLQlwbWNf
ZGF0YV9mcmVlKHNhbWE3ZzVfcG1jKTsNCj4gKwlrZnJlZShzYW1hN2c1X3BtYyk7DQo+ICB9DQo+
ICANCj4gIC8qIFNvbWUgY2xrcyBhcmUgdXNlZCBmb3IgYSBjbG9ja3NvdXJjZSAqLw0KPiANCg0K
