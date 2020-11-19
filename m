Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB02B8FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgKSJ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:57:47 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:58948 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbgKSJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:57:46 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ9pqo2019428;
        Thu, 19 Nov 2020 10:57:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=6Zu/oR7KRxdp7HRHyuE4U5G3W5I9aC8T8V/VuWRGqQk=;
 b=T858TM6VqWp6Hy4dcn8uBaCFfkV/ER03Y+wtE+CudTDV4HwkMZ6dAp8IlriVlh01udl4
 7Ra7kBTLN/DI/6q+g0Wh+d9xgqdkExrw/WCOC3lp0dhVNuMDs2dwOl/Tgp5K4m6d5OyK
 Q+sceiuIZP/8X0LqEqEI9rcjuXtrbmcuwAm7iEB34bD7Hs/m4cAxlw7Wi9c9GBo1Z2pw
 8yIHEStqXAhEyUKdTElyjJCxi6Tr/JkZyKcLrLy5Y4DUVhY33lcNuQsUqpU/KTrSK9Jm
 75ZAn+D/qOMGBRISNdN0zH+phaMjvUFigtIQQsXnGcXiaOyKTwh5WN/R8qstZOwHYCL1 pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t5w26dp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 10:57:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6264010002A;
        Thu, 19 Nov 2020 10:57:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2FCCF23BFF6;
        Thu, 19 Nov 2020 10:57:23 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Nov
 2020 10:57:22 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Thu, 19 Nov 2020 10:57:22 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Alain Volmat <avolmat@me.com>,
        Russell King <linux@armlinux.org.uk>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Olof Johansson" <olof@lixom.net>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] arm: sti: LL_UART updates & STiH418 addition
Thread-Topic: [PATCH v2 0/2] arm: sti: LL_UART updates & STiH418 addition
Thread-Index: AQHWfwfrE6fqxIT1OkCwFqrVmb6UAKnPh2uAgAAFIgCAABldAA==
Date:   Thu, 19 Nov 2020 09:57:22 +0000
Message-ID: <e1de318e-5bea-ee33-f222-f2c67354e956@st.com>
References: <20200830195748.30221-1-avolmat@me.com>
 <4597cef9-a9f9-bbde-69ac-dd9f96cb7c30@st.com>
 <CACRpkdbigTHKtfwQQSVf7EiJyG8Lby=ksBdmvBKDt0jqPXjUsA@mail.gmail.com>
In-Reply-To: <CACRpkdbigTHKtfwQQSVf7EiJyG8Lby=ksBdmvBKDt0jqPXjUsA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7666B34EB669842909CE1C86E06CF87@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_08:2020-11-17,2020-11-19 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMNCg0KT24gMTEvMTkvMjAgOToyNiBBTSwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4g
T24gVGh1LCBOb3YgMTksIDIwMjAgYXQgOTowOCBBTSBQYXRyaWNlIENIT1RBUkQgPHBhdHJpY2Uu
Y2hvdGFyZEBzdC5jb20+IHdyb3RlOg0KPg0KPj4gSXMgdGhlcmUgYW55IHJlYXNvbiBmb3IgdGhp
cyBzZXJpZXMgbm90IGJlaW5nIG1lcmdlZCA/DQo+IERpZCB5b3UgcHV0IHRoZW0gaW50byBSdXNz
ZWxsJ3MgcGF0Y2ggdHJhY2tlciBhcyBJIGFza2VkPw0KPiBJIGhhdmVuJ3Qgc2VlbiB0aGVtIHRo
ZXJlLg0KPiBodHRwczovL3d3dy5hcm1saW51eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNoZXMvDQoN
Ck5vIGkgaGF2ZW4ndCBwdXQgdGhlbSBpbnRvIHBhdGNoIHRyYWNrZXIsIG15IGJhZC4NCg0KSSB3
aWxsIHJlZ2lzdGVyIHRvIGl0IGFuZCBhZGQgdGhpcyBzZXJpZXMuDQoNClRoYW5rcyBmb3IgdGhl
IHRpcCBMaW51cy4NCg0KUGF0cmljZQ0KDQoNCj4NCj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWo=
