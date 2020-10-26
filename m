Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E718D29881D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771370AbgJZIMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:12:33 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7870 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1770350AbgJZIMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:12:32 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09Q8BiPj030048;
        Mon, 26 Oct 2020 09:12:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=IJtekzXmv9vxatMxkzleF5Mc4SjVvGCd4JV42MjXd1s=;
 b=lBfFwwFq8lydzld/V0z0+73qjeH43FVB82XfKUjag/S610ajGRlb0/lb9RJughCs2khu
 4deVm9PxoBOnVNcuPq1TUQzMAwUCwbO016alB/eBjTRCUOKym0CFSWIyYXIEW2UiR+LU
 0qJBkVqxouP68KY61q+i7brvrrThZmvkNi/s84tgEyQ/gQC9PsgYw6MtOtgHWJcRkC3L
 NF5cQu85xmBNL5GAdYGS4WEucn+6cgEE0i7lB4x5+3Nqr8iZz9rHH/zvl6R0lyVDXqPH
 0BMWYouUwAtndXE9fTsoyo6HGarM6r1WI1S+d/si6rVcKixshzMEHHG5q5TlyefUwKuQ rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34ccmqk1kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 09:12:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B8879100034;
        Mon, 26 Oct 2020 09:12:26 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A9CF22ADA16;
        Mon, 26 Oct 2020 09:12:26 +0100 (CET)
Received: from SFHDAG1NODE3.st.com (10.75.127.3) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 09:12:26 +0100
Received: from SFHDAG1NODE3.st.com ([fe80::ad8b:a44d:504a:670d]) by
 SFHDAG1NODE3.st.com ([fe80::ad8b:a44d:504a:670d%20]) with mapi id
 15.00.1473.003; Mon, 26 Oct 2020 09:12:26 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Martin Kaiser <martin@kaiser.cx>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mailbox: stm32-ipcc: remove duplicate error message
Thread-Topic: [PATCH 2/2] mailbox: stm32-ipcc: remove duplicate error message
Thread-Index: AQHWqgodECjhJ37krEyKtF2uVISUUampepkA
Date:   Mon, 26 Oct 2020 08:12:26 +0000
Message-ID: <fc47f0cd-ebbf-8093-6197-43e98e7ffc73@st.com>
References: <20201024133154.22767-1-martin@kaiser.cx>
 <20201024133154.22767-2-martin@kaiser.cx>
In-Reply-To: <20201024133154.22767-2-martin@kaiser.cx>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E3CF5225217A24BA58D4A4D273B94B5@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_04:2020-10-26,2020-10-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFydGluDQoNCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2gNCg0KT24gMjQvMTAvMjAyMCAz
OjMxIHBtLCBNYXJ0aW4gS2Fpc2VyIHdyb3RlOg0KPiBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZSBh
bHJlYWR5IHByaW50cyBhbiBlcnJvciBtZXNzYWdlIGlmIHRoZSByZXF1ZXN0ZWQgaXJxDQo+IHdh
cyBub3QgZm91bmQuIERvbid0IHByaW50IGFub3RoZXIgbWVzc2FnZSBpbiB0aGUgZHJpdmVyLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gS2Fpc2VyIDxtYXJ0aW5Aa2Fpc2VyLmN4Pg0KDQoN
ClJldmlld2VkLWJ5OiBGYWJpZW4gRGVzc2VubmUgPGZhYmllbi5kZXNzZW5uZUBzdC5jb20+DQoN
Cg0KPiAtLS0NCj4gICBkcml2ZXJzL21haWxib3gvc3RtMzItaXBjYy5jIHwgMyAtLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWFpbGJveC9zdG0zMi1pcGNjLmMgYi9kcml2ZXJzL21haWxib3gvc3RtMzItaXBjYy5jDQo+IGlu
ZGV4IGVmOTY2ODg3YWExNS4uYWI4ZmU1NmFmOTQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21h
aWxib3gvc3RtMzItaXBjYy5jDQo+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9zdG0zMi1pcGNjLmMN
Cj4gQEAgLTI1Nyw5ICsyNTcsNiBAQCBzdGF0aWMgaW50IHN0bTMyX2lwY2NfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAJZm9yIChpID0gMDsgaSA8IElQQ0NfSVJRX05V
TTsgaSsrKSB7DQo+ICAgCQlpcGNjLT5pcnFzW2ldID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUo
cGRldiwgaXJxX25hbWVbaV0pOw0KPiAgIAkJaWYgKGlwY2MtPmlycXNbaV0gPCAwKSB7DQo+IC0J
CQlpZiAoaXBjYy0+aXJxc1tpXSAhPSAtRVBST0JFX0RFRkVSKQ0KPiAtCQkJCWRldl9lcnIoZGV2
LCAibm8gSVJRIHNwZWNpZmllZCAlc1xuIiwNCj4gLQkJCQkJaXJxX25hbWVbaV0pOw0KPiAgIAkJ
CXJldCA9IGlwY2MtPmlycXNbaV07DQo+ICAgCQkJZ290byBlcnJfY2xrOw0KPiAgIAkJfQ==
