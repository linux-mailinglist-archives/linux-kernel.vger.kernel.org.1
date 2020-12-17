Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C60F2DD5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgLQRSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:18:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34724 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727260AbgLQRSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:18:06 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHHBplD031432;
        Thu, 17 Dec 2020 18:17:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=K4kpfHhJ4ffNMdY3z5st+Fqr42PIgLAlFuopVj0ZuDk=;
 b=lOYnUmS9rrUSqXXZTxMn6T6AmRSCTQoaaWttPySfImT01zDLGzwhz0sj1vpZdt+3ZrBe
 DtvzPby6EEfNzPAqc4EVDrp+YcDTzjWqcQ/FW9CuPJNkSvOhFx7oUViEvlRvFd6tcQoO
 oT0eZguPPT55PwbNexiM4Rt8ue+rDePiNPjRn4jZCg65Pn4hCCYynZ1yJF64a1u11Cjb
 GJd8/Ew+U+iK5h1vaBYNXYeWxV5TbvaXeYbwkYz88nLXv6qAxqYVzbJ9BSPyQO8cX8pt
 X5cas06KgakPimIvDd5dGhYh4lKLDfnPG5AqUQR7eNO3npzzz/jN9I/1gG1O+ooK7fxY kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35cpwegym6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 18:17:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CF1C310002A;
        Thu, 17 Dec 2020 18:17:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AFDA9246387;
        Thu, 17 Dec 2020 18:17:11 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE1.st.com
 (10.75.127.4) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec
 2020 18:17:11 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Thu, 17 Dec 2020 18:17:11 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Colin King <colin.king@canonical.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: sti: Fix spelling mistake in Kconfig "targetted" ->
 "targeted"
Thread-Topic: [PATCH] ARM: sti: Fix spelling mistake in Kconfig "targetted" ->
 "targeted"
Thread-Index: AQHW1Jfz37KH7FeRe02N5sVdj5MbaKn7dvQA
Date:   Thu, 17 Dec 2020 17:17:11 +0000
Message-ID: <d53e1ba7-9403-db77-e8a3-72ce41c8f89e@st.com>
References: <20201217171331.57376-1-colin.king@canonical.com>
In-Reply-To: <20201217171331.57376-1-colin.king@canonical.com>
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
Content-ID: <19FA6B65291E1E45B6F79A00DD5DE839@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_11:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4NCg0KT24gMTIvMTcvMjAgNjoxMyBQTSwgQ29saW4gS2luZyB3cm90ZToNCj4gRnJv
bTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4NCj4gVGhlcmUg
aXMgYSBzcGVsbGluZyBtaXN0YWtlIGluIHRoZSBLY29uZmlnIGhlbHAgdGV4dC4gRml4IGl0Lg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwu
Y29tPg0KPiAtLS0NCj4gIGFyY2gvYXJtL21hY2gtc3RpL0tjb25maWcgfCAyICstDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL21hY2gtc3RpL0tjb25maWcgYi9hcmNoL2FybS9tYWNoLXN0aS9LY29uZmln
DQo+IGluZGV4IGIyZDQ1Y2YxMGEzYy4uNzQ2NDBiYmFlYmE2IDEwMDY0NA0KPiAtLS0gYS9hcmNo
L2FybS9tYWNoLXN0aS9LY29uZmlnDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtc3RpL0tjb25maWcN
Cj4gQEAgLTUwLDcgKzUwLDcgQEAgY29uZmlnIFNPQ19TVElINDA3DQo+ICAJc2VsZWN0IFNUSUg0
MDdfUkVTRVQNCj4gIAloZWxwDQo+ICAJICBUaGlzIGVuYWJsZXMgc3VwcG9ydCBmb3IgU1RNaWNy
b2VsZWN0cm9uaWNzIERpZ2l0YWwgQ29uc3VtZXINCj4gLQkgIEVsZWN0cm9uaWNzIGZhbWlseSBT
dGlINDA3IHBhcnRzLCB0YXJnZXR0ZWQgYXQgc2V0LXRvcC1ib3gNCj4gKwkgIEVsZWN0cm9uaWNz
IGZhbWlseSBTdGlINDA3IHBhcnRzLCB0YXJnZXRlZCBhdCBzZXQtdG9wLWJveA0KPiAgCSAgYW5k
IG90aGVyIGRpZ2l0YWwgYXVkaW8vdmlkZW8gYXBwbGljYXRpb25zIHVzaW5nIEZsYXR0ZW5lZCBE
ZXZpY2UNCj4gIAkgIFRyZWVzLg0KPiAgDQoNClJldmlld2VkLWJ5OiBQYXRyaWNlIENob3RhcmQg
PHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQoNClRoYW5rcw0KDQpQYXRyaWNlDQo=
