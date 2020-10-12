Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C6828BBEE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbgJLPbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:31:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23958 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389948AbgJLPbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:31:48 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CFRx2K009325;
        Mon, 12 Oct 2020 17:31:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=N542qLINbv1anFY9bS8CNSsvQ1Mj8Jp+GnbcDJCIDbI=;
 b=yU7Fk4vHgMdVOCof3aFBut/LtAMM901J/RvZxy32Ku5Dnx4qUhdyzsMPhomEYZ7YMPed
 X71IHo7vNGDlixUPzwIPQnGxJkj99McRmV4JIuo9KpqWU2oVGuKstpEfWIdOTJjn7vs8
 EXyDk02BZAmxDo8OOVBdDQo0mUvNPKuknC3hqvya1H1jGlNxwbADhXhBOMjBUUc5/4Cw
 cBn+bphbd811atmWfb57HfZcbfsyPg3fAmMPnw/1nBzib1WY77jiiREYoRD2QeFV2emR
 lUAJZhckT5eoBa1Ij6D34V3UVduYNkGyGFhdAVGenEGQdaSfv8Ki5V4x6MNB6FXW0FWC Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34353w1wd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 17:31:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B97FB10002A;
        Mon, 12 Oct 2020 17:31:32 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 97FFE2A9F57;
        Mon, 12 Oct 2020 17:31:32 +0200 (CEST)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG1NODE1.st.com
 (10.75.127.1) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Oct
 2020 17:31:32 +0200
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Mon, 12 Oct 2020 17:31:32 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Antonio BORNEO <antonio.borneo@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Sam Ravnborg" <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/panel: rm68200: fix mode to 50fps
Thread-Topic: [PATCH] drm/panel: rm68200: fix mode to 50fps
Thread-Index: AQHWk0ZzzcM7a4UXCEW70da9oB7h6KmUEW0A
Date:   Mon, 12 Oct 2020 15:31:32 +0000
Message-ID: <b8b082c2-4543-4080-cf6e-d14fed712669@st.com>
References: <20200925141618.12097-1-yannick.fertre@st.com>
In-Reply-To: <20200925141618.12097-1-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <68D722A0FC36A64FB7104D71B442DF99@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_12:2020-10-12,2020-10-12 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMjUvMjAgNDoxNiBQTSwgWWFubmljayBGZXJ0cmUgd3JvdGU6DQo+IENvbXB1dGUg
bmV3IHRpbWluZ3MgdG8gZ2V0IGEgZnJhbWVyYXRlIG9mIDUwZnBzIHdpdGggYSBwaXhlbCBjbG9j
aw0KPiBANTRNaHouDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWNrIEZlcnRyZSA8eWFubmlj
ay5mZXJ0cmVAc3QuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwt
cmF5ZGl1bS1ybTY4MjAwLmMgfCAxMiArKysrKystLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1yYXlkaXVtLXJtNjgyMDAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9wYW5lbC9wYW5lbC1yYXlkaXVtLXJtNjgyMDAuYw0KPiBpbmRleCAyYjllNDhiMGE0OTEuLjQx
MmMwZGJjYjJiNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLXJh
eWRpdW0tcm02ODIwMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1yYXlk
aXVtLXJtNjgyMDAuYw0KPiBAQCAtODIsMTUgKzgyLDE1IEBAIHN0cnVjdCBybTY4MjAwIHsNCj4g
ICB9Ow0KPiAgIA0KPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSBkZWZh
dWx0X21vZGUgPSB7DQo+IC0JLmNsb2NrID0gNTI1ODIsDQo+ICsJLmNsb2NrID0gNTQwMDAsDQo+
ICAgCS5oZGlzcGxheSA9IDcyMCwNCj4gLQkuaHN5bmNfc3RhcnQgPSA3MjAgKyAzOCwNCj4gLQku
aHN5bmNfZW5kID0gNzIwICsgMzggKyA4LA0KPiAtCS5odG90YWwgPSA3MjAgKyAzOCArIDggKyAz
OCwNCj4gKwkuaHN5bmNfc3RhcnQgPSA3MjAgKyA0OCwNCj4gKwkuaHN5bmNfZW5kID0gNzIwICsg
NDggKyA5LA0KPiArCS5odG90YWwgPSA3MjAgKyA0OCArIDkgKyA0OCwNCj4gICAJLnZkaXNwbGF5
ID0gMTI4MCwNCj4gICAJLnZzeW5jX3N0YXJ0ID0gMTI4MCArIDEyLA0KPiAtCS52c3luY19lbmQg
PSAxMjgwICsgMTIgKyA0LA0KPiAtCS52dG90YWwgPSAxMjgwICsgMTIgKyA0ICsgMTIsDQo+ICsJ
LnZzeW5jX2VuZCA9IDEyODAgKyAxMiArIDUsDQo+ICsJLnZ0b3RhbCA9IDEyODAgKyAxMiArIDUg
KyAxMiwNCj4gICAJLmZsYWdzID0gMCwNCj4gICAJLndpZHRoX21tID0gNjgsDQo+ICAgCS5oZWln
aHRfbW0gPSAxMjIsDQo+IA0KDQpIaSBZYW5uaWNrLA0KVGVzdGVkLWJ5OiBQaGlsaXBwZSBDb3Ju
dSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0KVGhhbmsgeW91LA0KUGhpbGlwcGU=
