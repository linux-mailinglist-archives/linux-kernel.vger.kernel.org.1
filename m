Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE57529623C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508769AbgJVP75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:59:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59630 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S369043AbgJVP7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:59:54 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MFg0v0023899;
        Thu, 22 Oct 2020 17:59:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=+540XUhYrrYVMFG6d2P41z+dQDAtAwvWzMbZT4dmoXI=;
 b=GEAtKF1FEOvdzWRWYA8lC77dfa5tP+QJFixNLDxhOh2GgpIyfaQFzJj2XtZKpdBJNc/x
 RUtgTWWDPplRQmw5UklKRxNnyB2xJYscfJQBwBTr9S91IlEwLdW3nSu8rNXujgVHTc+u
 6kQ099StVYZzScUAneY+4wGTO/pTkTh6lIH9U/qzOxdXyCAWy/17faVOaxccYmAR4/65
 ohUYKgqW0NmgK53fTJj+UUhK3qXFTI8tQAexRJdU9GYJk4E0w9vfAJ0CJGnFHZSQBvEz
 HRqWCLpzzM6Ht0Vdh+2zyftjoQ9RTzYva9scTG4nAphBLHUVd/KwigtrPmlWG69sTLqA 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34apedfrnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 17:59:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E5FB310002A;
        Thu, 22 Oct 2020 17:59:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D09582C7133;
        Thu, 22 Oct 2020 17:59:34 +0200 (CEST)
Received: from SFHDAG2NODE1.st.com (10.75.127.4) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Oct
 2020 17:59:34 +0200
Received: from SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90]) by
 SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90%20]) with mapi id
 15.00.1473.003; Thu, 22 Oct 2020 17:59:34 +0200
From:   Yann GAUTIER <yann.gautier@st.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Ludovic BARRE <ludovic.barre@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: stm32: update sdmmc IP version for STM32MP157
 SOC
Thread-Topic: [PATCH] ARM: dts: stm32: update sdmmc IP version for STM32MP157
 SOC
Thread-Index: AQHWpuoj4CwDOfZXe066JGuHRV4x1KmjqU6A
Date:   Thu, 22 Oct 2020 15:59:34 +0000
Message-ID: <493a8b1b-02e5-f7f4-4cdf-a091ce1d1387@st.com>
References: <20201020140450.29158-1-a.fatoum@pengutronix.de>
In-Reply-To: <20201020140450.29158-1-a.fatoum@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F314D055A26BB41B82427788603D068@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_11:2020-10-20,2020-10-22 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjAvMjAgNDowNCBQTSwgQWhtYWQgRmF0b3VtIHdyb3RlOg0KPiBGcm9tOiBZYW5uIEdh
dXRpZXIgPHlhbm4uZ2F1dGllckBzdC5jb20+DQo+IA0KPiBVcGRhdGUgdGhlIElQIHZlcnNpb24g
dG8gdjIuMCwgd2hpY2ggc3VwcG9ydHMgbGlua2VkIGxpc3RzIGluIGludGVybmFsIERNQSwNCj4g
YW5kIGlzIHByZXNlbnQgaW4gU1RNMzJNUDEgU29Dcy4NCj4gDQo+IFRoZSBtbWNpIGRyaXZlciBz
dXBwb3J0cyB0aGUgdjIuMCBwZXJpcGggaWQgc2luY2UgN2EyYTk4YmU2NzJiICgibW1jOiBtbWNp
Og0KPiBBZGQgc3VwcG9ydCBmb3Igc2RtbWMgdmFyaWFudCByZXZpc2lvbiAyLjAiKSwgc28gaXQn
cyBub3cgT2sgdG8gYWRkIGl0IGludG8NCj4gdGhlIFNvQyBkZXZpY2UgdHJlZSB0byBiZW5lZml0
IGZyb20gdGhlIGltcHJvdmVkIERNQSBzdXBwb3J0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTHVk
b3ZpYyBCYXJyZSA8bHVkb3ZpYy5iYXJyZUBzdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbm4g
R2F1dGllciA8eWFubi5nYXV0aWVyQHN0LmNvbT4NCj4gW2FmYTogY2hlcnJ5LXBpY2tlZCBmcm9t
IGh0dHBzOi8vZ2l0aHViLmNvbS9TVE1pY3JvZWxlY3Ryb25pY3MvbGludXgvY29tbWl0LzMxZTJh
NmJjOF0NCj4gW2FmYTogZXh0ZW5kZWQgY29tbWl0IG1lc3NhZ2Ugd2l0aCByZWZlcmVuY2UgdG8g
ZHJpdmVyIHBhdGNoXQ0KPiBTaWduZWQtb2ZmLWJ5OiBBaG1hZCBGYXRvdW0gPGEuZmF0b3VtQHBl
bmd1dHJvbml4LmRlPg0KDQpIaSBBaG1hZCwNCg0KQWNrZWQtYnk6IFlhbm4gR2F1dGllciA8eWFu
bi5nYXV0aWVyQHN0LmNvbT4NCg0KDQpSZWdhcmRzLA0KWWFubg0KDQo+IC0tLQ0KPiBDYzogTHVk
b3ZpYyBCYXJyZSA8bHVkb3ZpYy5iYXJyZUBzdC5jb20+DQo+IC0tLQ0KPiAgIGFyY2gvYXJtL2Jv
b3QvZHRzL3N0bTMybXAxNTEuZHRzaSB8IDYgKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9ib290L2R0cy9zdG0zMm1wMTUxLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTUx
LmR0c2kNCj4gaW5kZXggYmZlMjkwMjNmYmQ1Li5iOGQ5OTZkMzJkYzAgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTEuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290
L2R0cy9zdG0zMm1wMTUxLmR0c2kNCj4gQEAgLTEwNDAsNyArMTA0MCw3IEBAIGFkYzI6IGFkY0Ax
MDAgew0KPiAgIA0KPiAgIAkJc2RtbWMzOiBzZG1tY0A0ODAwNDAwMCB7DQo+ICAgCQkJY29tcGF0
aWJsZSA9ICJhcm0scGwxOHgiLCAiYXJtLHByaW1lY2VsbCI7DQo+IC0JCQlhcm0scHJpbWVjZWxs
LXBlcmlwaGlkID0gPDB4MTAxNTMxODA+Ow0KPiArCQkJYXJtLHByaW1lY2VsbC1wZXJpcGhpZCA9
IDwweDAwMjUzMTgwPjsNCj4gICAJCQlyZWcgPSA8MHg0ODAwNDAwMCAweDQwMD47DQo+ICAgCQkJ
aW50ZXJydXB0cyA9IDxHSUNfU1BJIDEzNyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gICAJCQlp
bnRlcnJ1cHQtbmFtZXMgPSAiY21kX2lycSI7DQo+IEBAIC0xMzM4LDcgKzEzMzgsNyBAQCBxc3Bp
OiBzcGlANTgwMDMwMDAgew0KPiAgIA0KPiAgIAkJc2RtbWMxOiBzZG1tY0A1ODAwNTAwMCB7DQo+
ICAgCQkJY29tcGF0aWJsZSA9ICJhcm0scGwxOHgiLCAiYXJtLHByaW1lY2VsbCI7DQo+IC0JCQlh
cm0scHJpbWVjZWxsLXBlcmlwaGlkID0gPDB4MTAxNTMxODA+Ow0KPiArCQkJYXJtLHByaW1lY2Vs
bC1wZXJpcGhpZCA9IDwweDAwMjUzMTgwPjsNCj4gICAJCQlyZWcgPSA8MHg1ODAwNTAwMCAweDEw
MDA+Ow0KPiAgIAkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA0OSBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsNCj4gICAJCQlpbnRlcnJ1cHQtbmFtZXMgPSAiY21kX2lycSI7DQo+IEBAIC0xMzUzLDcgKzEz
NTMsNyBAQCBzZG1tYzE6IHNkbW1jQDU4MDA1MDAwIHsNCj4gICANCj4gICAJCXNkbW1jMjogc2Rt
bWNANTgwMDcwMDAgew0KPiAgIAkJCWNvbXBhdGlibGUgPSAiYXJtLHBsMTh4IiwgImFybSxwcmlt
ZWNlbGwiOw0KPiAtCQkJYXJtLHByaW1lY2VsbC1wZXJpcGhpZCA9IDwweDEwMTUzMTgwPjsNCj4g
KwkJCWFybSxwcmltZWNlbGwtcGVyaXBoaWQgPSA8MHgwMDI1MzE4MD47DQo+ICAgCQkJcmVnID0g
PDB4NTgwMDcwMDAgMHgxMDAwPjsNCj4gICAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTI0IElS
UV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiAgIAkJCWludGVycnVwdC1uYW1lcyA9ICJjbWRfaXJxIjsN
Cj4g
