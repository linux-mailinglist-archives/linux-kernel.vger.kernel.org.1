Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC87027A8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgI1HgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:36:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11922 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726625AbgI1HgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:36:18 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08S7WEUW023843;
        Mon, 28 Sep 2020 09:36:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=bmWZg1imqAg7aGfoNL/JguR7NrLHXxFP6oBzs89LewE=;
 b=P4fiwDWswvUbqa/SwVjlNhzH8TkjUvOJYPjf2UP9EwSNbVoolcPWF2eP3sm6vMGWaKyt
 nGy49MKYtgHosMVCMObcGhytKeeHPMfLNbbeTHH9hGmTXG7Zmc3feKo58vBx4bOHPzGh
 UMs5F9yseJQ4G71OfCAMBgUCM3OFHUai2zM8NJmw4eA35mSg1YJ8OsZGwKnZ6W9kzd06
 c626YhsnID4T+HNG59v1GC8mDaa94l+wtl8GWMlLPK+pJnaMZmuGMYKq/wHZ0pmpgib4
 B2OrvxWzMdjH6EwsNrUxKngfQyogqc1paB+5RJTKvXbCmYSEkaBJiYoETUzYhrwMb2Nc XQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33sts7hfqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 09:36:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BFFEC10002A;
        Mon, 28 Sep 2020 09:36:01 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A33CD21E686;
        Mon, 28 Sep 2020 09:36:01 +0200 (CEST)
Received: from SFHDAG6NODE1.st.com (10.75.127.16) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Sep
 2020 09:36:01 +0200
Received: from SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27]) by
 SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27%20]) with mapi id
 15.00.1473.003; Mon, 28 Sep 2020 09:36:01 +0200
From:   Yannick FERTRE <yannick.fertre@st.com>
To:     Joe Perches <joe@perches.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Antonio BORNEO <antonio.borneo@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/stm: dsi: Use dev_ based logging
Thread-Topic: [PATCH] drm/stm: dsi: Use dev_ based logging
Thread-Index: AQHWkyXKfX9abUar20eb4rtFyqzMOal5H6aAgARsjoA=
Date:   Mon, 28 Sep 2020 07:36:01 +0000
Message-ID: <0f034258-c0b7-4739-ddea-b7abe9589504@st.com>
References: <20200925102233.18016-1-yannick.fertre@st.com>
 <c28eae83c4297e14ed039eb00154d3a7e0fddaaa.camel@perches.com>
In-Reply-To: <c28eae83c4297e14ed039eb00154d3a7e0fddaaa.camel@perches.com>
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
Content-ID: <D6EE5DFB51C631478802CC95F60C7892@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_07:2020-09-24,2020-09-28 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMjUvMjAgMjowMiBQTSwgSm9lIFBlcmNoZXMgd3JvdGU6DQo+IE9uIEZyaSwgMjAy
MC0wOS0yNSBhdCAxMjoyMiArMDIwMCwgWWFubmljayBGZXJ0cmUgd3JvdGU6DQo+PiBTdGFuZGFy
ZGl6ZSBvbiB0aGUgZGV2XyBiYXNlZCBsb2dnaW5nIGFuZCBkcm9wIHRoZSBpbmNsdWRlIG9mIGRy
bV9wcmludC5oLg0KPj4gUmVtb3ZlIHVzZWxlc3MgZHNpX2NvbG9yX2Zyb21fbWlwaSBmdW5jdGlv
bi4NCj4gW10NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2R3X21pcGlfZHNp
LXN0bS5jIGIvZHJpdmVycy9ncHUvZHJtL3N0bS9kd19taXBpX2RzaS1zdG0uYw0KPiBbXQ0KPj4g
LQlEUk1fREVCVUdfRFJJVkVSKCJwbGxfaW4gJXVrSHogcGxsX291dCAldWtIeiBsYW5lX21icHMg
JXVNSHpcbiIsDQo+PiAtCQkJIHBsbF9pbl9raHosIHBsbF9vdXRfa2h6LCAqbGFuZV9tYnBzKTsN
Cj4+ICsJZGV2X2RiZyhkc2ktPmRldiwgInBsbF9pbiAldWtIeiBwbGxfb3V0ICV1a0h6IGxhbmVf
bWJwcyAldU1IelxuIiwgcGxsX2luX2toeiwgcGxsX291dF9raHosDQo+PiArCQkqbGFuZV9tYnBz
KTsNCj4gDQo+IFRoZSBsaW5lIHdyYXBwaW5nIGNoYW5nZSBoZXJlIGlzIHByZXR0eSBwb2ludGxl
c3MgYW5kIElNTw0KPiBtYWtlcyB0aGUgY29kZSBoYXJkZXIgdG8gcmVhZC4NCg0KSGksDQpvaywg
SSB3aWxsIHJlc3RvcmUgdGhlIGxpbmUgd3JhcHBpbmcuDQoNCkJlc3QgcmVnYXJkcw0KDQpZYW5u
aWNr
