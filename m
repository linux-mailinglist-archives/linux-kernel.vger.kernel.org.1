Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069122B8CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgKSH47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:56:59 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:51582 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgKSH46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:56:58 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ7llaD016520;
        Thu, 19 Nov 2020 08:56:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=LZmy/q8OG+YP+knBreOKw8LvxF/u+yMxTz+nQ0yAExw=;
 b=Nf5HVRPo5Zg4ge9qzpZU8dp33kE8JtRhcqiq1DLhF1/S9SIauRyw04rA0zvp0pv5yHrU
 uGKhcCcYegn6EjLdWeOWALfB31GUFK1B6ROSozlTF26BQPhSyfwl9lsx3b9zq0CnESMs
 tO61DVq1uH2zJMU5IqIcYP9zGxnDuuXmG9qvXrAUJLYKh7ZI55f1PVAYbcYxrdo1H4Ot
 WBaAS/FTR05o9jQWNLy8LIsFHAXvCWAkeJmiklz8c2fWlpYfVTro9lT3CXPHyCU5cI0T
 GatlvcPw2yXabXxeczisiCkgy9M2GrX3JNLLgq6hhyFI+mt0pq0894MuKAHCFTp5Ml2h Gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t5w25n2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 08:56:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4322C100034;
        Thu, 19 Nov 2020 08:56:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 35C1922E87C;
        Thu, 19 Nov 2020 08:56:46 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Nov
 2020 08:56:46 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Thu, 19 Nov 2020 08:56:46 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Alain Volmat <avolmat@me.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reset: sti: reset-syscfg: fix struct description warnings
Thread-Topic: [PATCH] reset: sti: reset-syscfg: fix struct description
 warnings
Thread-Index: AQHWf9ajUS1GG2kbV0GxVIxTwjD+g6nPgpoA
Date:   Thu, 19 Nov 2020 07:56:45 +0000
Message-ID: <295ebff6-e00c-878e-8fbd-f3d9883ed192@st.com>
References: <20200831203804.6568-1-avolmat@me.com>
In-Reply-To: <20200831203804.6568-1-avolmat@me.com>
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
Content-ID: <E99A916D3048CB4597144524E3C58112@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_05:2020-11-17,2020-11-19 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhaW4NCg0KT24gOC8zMS8yMCAxMDozOCBQTSwgQWxhaW4gVm9sbWF0IHdyb3RlOg0KPiBG
aXggZm9ybWF0aW5nIG9mIHN0cnVjdCBkZXNjcmlwdGlvbiB0byBhdm9pZCB3YXJuaW5nIGhpZ2hs
aWdodGVkDQo+IGJ5IFc9MSBjb21waWxhdGlvbi4NCj4NCj4gRml4ZXM6IGU1ZDc2MDc1ZDkzMCAo
ImRyaXZlcnM6IHJlc2V0OiBTVGkgU29DIHN5c3RlbSBjb25maWd1cmF0aW9uIHJlc2V0IGNvbnRy
b2xsZXIgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IEFsYWluIFZvbG1hdCA8YXZvbG1hdEBt
ZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9yZXNldC9zdGkvcmVzZXQtc3lzY2ZnLmMgfCA3ICsr
KystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Jlc2V0L3N0aS9yZXNldC1zeXNjZmcuYyBiL2Ry
aXZlcnMvcmVzZXQvc3RpL3Jlc2V0LXN5c2NmZy5jDQo+IGluZGV4IDkxMjE1YmI4OGY2Mi4uOTli
NjMwMzVmZTcyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Jlc2V0L3N0aS9yZXNldC1zeXNjZmcu
Yw0KPiArKysgYi9kcml2ZXJzL3Jlc2V0L3N0aS9yZXNldC1zeXNjZmcuYw0KPiBAQCAtMTcsNyAr
MTcsNyBAQA0KPiAgI2luY2x1ZGUgInJlc2V0LXN5c2NmZy5oIg0KPiAgDQo+ICAvKioNCj4gLSAq
IFJlc2V0IGNoYW5uZWwgcmVnbWFwIGNvbmZpZ3VyYXRpb24NCj4gKyAqIHN0cnVjdCBzeXNjZmdf
cmVzZXRfY2hhbm5lbCAtIFJlc2V0IGNoYW5uZWwgcmVnbWFwIGNvbmZpZ3VyYXRpb24NCj4gICAq
DQo+ICAgKiBAcmVzZXQ6IHJlZ21hcCBmaWVsZCBmb3IgdGhlIGNoYW5uZWwncyByZXNldCBiaXQu
DQo+ICAgKiBAYWNrOiByZWdtYXAgZmllbGQgZm9yIHRoZSBjaGFubmVsJ3MgYWNrIGJpdCAob3B0
aW9uYWwpLg0KPiBAQCAtMjgsOCArMjgsOSBAQCBzdHJ1Y3Qgc3lzY2ZnX3Jlc2V0X2NoYW5uZWwg
ew0KPiAgfTsNCj4gIA0KPiAgLyoqDQo+IC0gKiBBIHJlc2V0IGNvbnRyb2xsZXIgd2hpY2ggZ3Jv
dXBzIHRvZ2V0aGVyIGEgc2V0IG9mIHJlbGF0ZWQgcmVzZXQgYml0cywgd2hpY2gNCj4gLSAqIG1h
eSBiZSBsb2NhdGVkIGluIGRpZmZlcmVudCBzeXN0ZW0gY29uZmlndXJhdGlvbiByZWdpc3RlcnMu
DQo+ICsgKiBzdHJ1Y3Qgc3lzY2ZnX3Jlc2V0X2NvbnRyb2xsZXIgLSBBIHJlc2V0IGNvbnRyb2xs
ZXIgd2hpY2ggZ3JvdXBzIHRvZ2V0aGVyDQo+ICsgKiBhIHNldCBvZiByZWxhdGVkIHJlc2V0IGJp
dHMsIHdoaWNoIG1heSBiZSBsb2NhdGVkIGluIGRpZmZlcmVudCBzeXN0ZW0NCj4gKyAqIGNvbmZp
Z3VyYXRpb24gcmVnaXN0ZXJzLg0KPiAgICoNCj4gICAqIEByc3Q6IGJhc2UgcmVzZXQgY29udHJv
bGxlciBzdHJ1Y3R1cmUuDQo+ICAgKiBAYWN0aXZlX2xvdzogYXJlIHRoZSByZXNldHMgaW4gdGhp
cyBjb250cm9sbGVyIGFjdGl2ZSBsb3csIGkuZS4gY2xlYXJpbmcNCg0KUmV2aWV3ZWQtYnk6IFBh
dHJpY2UgQ2hvdGFyZCA8cGF0cmljZS5jaG90YXJkQHN0LmNvbT4NCg0KVGhhbmtzDQoNClBhdHJp
Y2UNCg==
