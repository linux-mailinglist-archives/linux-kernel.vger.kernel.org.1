Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56C82D3FD3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgLIKZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:25:49 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:9666 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729768AbgLIKZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:25:48 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B9ALjkV009341;
        Wed, 9 Dec 2020 11:24:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=yXmr3U5SX4npLvfcODKgnf17m3eKFwfTHPr77/J6VGc=;
 b=IR77BzS36+Fj3yPucEKqv2LZXjPHMf0N8jixTA6NRaMqWLaRkdzDzJEHcrOh+UHslGCt
 MBv8Af0NRWX8ciPS/JLL96qIsaKl+a5Oh1Yh+Qp2psXC78YcHfnqGqwBlHN8XSl/LxMW
 iIgvKcPB2nRF4ai/lLjgxufToArMu1z82lHsVNB/ZOBa9Z5A0Y8IV0JFQ9j5EtxUf0U2
 8A8SXqF7EeahxoqAU8zU8gn8Hbpd3Cy/tRyrGNx7C7tAgxzeKm71paGbhVWzNiOS/EGZ
 oUDtwnTg47NLNzWnnPam6KBhkphlBHM3MApH4oNF2X8VgPLIzlRowJ37aguX9DnvH/F6 Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35ag8j3ua2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 11:24:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2FE51100034;
        Wed,  9 Dec 2020 11:24:52 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC36924F859;
        Wed,  9 Dec 2020 11:24:52 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 11:24:52 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Wed, 9 Dec 2020 11:24:52 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/10] arm: dts: stih407-family: Harmonize DWC USB3 DT
 nodes name
Thread-Topic: [PATCH v3 07/10] arm: dts: stih407-family: Harmonize DWC USB3 DT
 nodes name
Thread-Index: AQHWyx86nqHsSxgnd0CP0+EaXpM5d6nuhAyA
Date:   Wed, 9 Dec 2020 10:24:52 +0000
Message-ID: <ff7c5956-ec08-c0e4-a607-da68a2698a6a@st.com>
References: <20201205155621.3045-1-Sergey.Semin@baikalelectronics.ru>
 <20201205155621.3045-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201205155621.3045-8-Sergey.Semin@baikalelectronics.ru>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <678B28C3ACF3614EA219E8F307814C9C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_08:2020-12-09,2020-12-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VyZ2UNCg0KT24gMTIvNS8yMCA0OjU2IFBNLCBTZXJnZSBTZW1pbiB3cm90ZToNCj4gSW4g
YWNjb3JkYW5jZSB3aXRoIHRoZSBEV0MgVVNCMyBiaW5kaW5ncyB0aGUgY29ycmVzcG9uZGluZyBu
b2RlDQo+IG5hbWUgaXMgc3VwcG9zZSB0byBjb21wbHkgd2l0aCB0aGUgR2VuZXJpYyBVU0IgSENE
IERUIHNjaGVtYSwgd2hpY2gNCj4gcmVxdWlyZXMgdGhlIFVTQiBub2RlcyB0byBoYXZlIHRoZSBu
YW1lIGFjY2VwdGFibGUgYnkgdGhlIHJlZ2V4cDoNCj4gIl51c2IoQC4qKT8iIC4gTWFrZSBzdXJl
IHRoZSAic25wcyxkd2MzIi1jb21wYXRpYmxlIG5vZGVzIGFyZSBjb3JyZWN0bHkNCj4gbmFtZWQu
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IFNlcmdlIFNlbWluIDxTZXJnZXkuU2VtaW5AYmFpa2FsZWxl
Y3Ryb25pY3MucnU+DQo+IEFja2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5l
bC5vcmc+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQwNy1mYW1pbHkuZHRzaSB8
IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQwNy1mYW1pbHkuZHRzaSBi
L2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MDctZmFtaWx5LmR0c2kNCj4gaW5kZXggMjNhMTc0NmYz
YmFhLi4yMzUyZjc2YjVhNjkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0
MDctZmFtaWx5LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQwNy1mYW1pbHku
ZHRzaQ0KPiBAQCAtNjgxLDcgKzY4MSw3IEBAIHN0X2R3YzM6IGR3YzNAOGY5NDAwMCB7DQo+ICAN
Cj4gIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICANCj4gLQkJCWR3YzM6IGR3YzNAOTkwMDAw
MCB7DQo+ICsJCQlkd2MzOiB1c2JAOTkwMDAwMCB7DQo+ICAJCQkJY29tcGF0aWJsZQk9ICJzbnBz
LGR3YzMiOw0KPiAgCQkJCXJlZwkJPSA8MHgwOTkwMDAwMCAweDEwMDAwMD47DQo+ICAJCQkJaW50
ZXJydXB0cwk9IDxHSUNfU1BJIDE1NSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCg0KUmV2aWV3ZWQt
Ynk6IFBhdHJpY2UgQ2hvdGFyZCA8cGF0cmljZS5jaG90YXJkQHN0LmNvbT4NCg0KVGhhbmtzDQoN
ClBhdHJpY2UNCg==
