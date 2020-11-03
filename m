Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54A22A46B9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgKCNj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:39:26 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58348 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729232AbgKCNjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:39:24 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3DbkJe011808;
        Tue, 3 Nov 2020 14:38:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=veJLxaZum4JdTDrVxKHaiJiTG54WMzCcdpwiNPTXfGs=;
 b=AC3Rtnim66NSR4Kc9Bid+9yMvnx84VoNGxN69+my2YlB88rFz2AimLb2cw/z4+5b9EZ1
 8HsTxSeH/lbUST1wQyNwjpn2T56IwucKy3/EaiMKQHwQbqTNEmzKH7l+YpiX50jpa7SZ
 WyuJPqCUgC+8Rku/1ZPTUaUlTHgn7Jxwu4oMYEr/JS9pTIznRPg4gvgsjZRsVsQqJnAs
 G/aaTzsfYXTT+XvhavkJcrkAkqXxAHrkcB29Wq+rf/oLIp2saCmJ9N8vnTmtI6tNd0pu
 Iv/vIBlL3bdyttxNueFT/kzvT0th7ktp4PlQsWfX+2bekovJlbJTKwzZPtgTi/oOSzZ2 3w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34gywqspcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:38:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9F59F100034;
        Tue,  3 Nov 2020 14:38:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1DA26254067;
        Tue,  3 Nov 2020 14:38:28 +0100 (CET)
Received: from SFHDAG2NODE2.st.com (10.75.127.5) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 14:38:27 +0100
Received: from SFHDAG2NODE2.st.com ([fe80::14c2:73ff:db87:a27b]) by
 SFHDAG2NODE2.st.com ([fe80::14c2:73ff:db87:a27b%20]) with mapi id
 15.00.1473.003; Tue, 3 Nov 2020 14:38:27 +0100
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] ASoC: stm32: i2s: add master clock provider
Thread-Topic: [PATCH 0/2] ASoC: stm32: i2s: add master clock provider
Thread-Index: AQHWiBzGV/vdLD0mo0u9KLFGd/U756m2rDkA
Date:   Tue, 3 Nov 2020 13:38:27 +0000
Message-ID: <20ed825b-10b6-e71f-9da4-91df38a950de@st.com>
References: <20200911091952.14696-1-olivier.moysan@st.com>
In-Reply-To: <20200911091952.14696-1-olivier.moysan@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BA6C81104F79949A06BE598EA49E90B@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KR2VudGxlIHJlbWluZGVyIG9uIHRoaXMgc2VyaWVzLCBhcyBpdCBzZWVtcyB0
aGF0IHRoZXJlIHdhcyBubyB1cGRhdGUgDQpzaW5jZSBSb2IncyAicmV2aWV3ZWQtYnkiIGZvciBk
dCBiaW5kaW5ncywgb24gMTEvMDkuDQoNCkJScw0KT2xpdmllcg0KDQpPbiA5LzExLzIwIDExOjE5
IEFNLCBPbGl2aWVyIE1veXNhbiB3cm90ZToNCj4gQWRkIG1hc3RlciBjbG9jayBnZW5lcmF0aW9u
IHN1cHBvcnQgaW4gU1RNMzIgSTJTIGRyaXZlci4NCj4gDQo+IE9saXZpZXIgTW95c2FuICgyKToN
Cj4gICAgQVNvQzogZHQtYmluZGluZ3M6IGFkZCBtY2xrIHByb3ZpZGVyIHN1cHBvcnQgdG8gc3Rt
MzIgaTJzDQo+ICAgIEFTb0M6IHN0bTMyOiBpMnM6IGFkZCBtYXN0ZXIgY2xvY2sgcHJvdmlkZXIN
Cj4gDQo+ICAgLi4uL2JpbmRpbmdzL3NvdW5kL3N0LHN0bTMyLWkycy55YW1sICAgICAgICAgIHwg
ICA0ICsNCj4gICBzb3VuZC9zb2Mvc3RtL3N0bTMyX2kycy5jICAgICAgICAgICAgICAgICAgICAg
fCAzMTAgKysrKysrKysrKysrKysrLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNzAgaW5zZXJ0
aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pDQo+IA==
