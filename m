Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121A02C55EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390562AbgKZNjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:39:10 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27346 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390375AbgKZNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:39:07 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AQDc0QT027460;
        Thu, 26 Nov 2020 14:38:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Ci0rfkR7gx5y/cceBVVjShRgXinep4d4vbCk1y7YzFg=;
 b=LHziUzA7/yM4LYU8lvCaQdryQ1AuLjv3vlA4ZdI25aty5dkAmLHjvtLTGyOwUiAb+xy8
 6VYlloF1bMP/kZz21b8uLwf+lmC3gq5QiRfgen3ub32gB1t4FIvVmBGPGPYnxfI34ZTa
 PPldafW1yl8YI3rhkK2UBSKXwqdLOJRxYCSNqv3pwo1EQ+smjFzPqqr9d8mJTv8YsYDc
 ULJarnkYfr4YIVGxwNgNGBmgWAGeUKnhQangz5pqZMpLw2O06ccDlqMEchpu8pnqaRYj
 jhZ/GMFAeqnDg+WeuQBOx/9J7lgHuXCk6qm4dftmdU68cF2X8Ud7JWmjAhT82m+DZ+tW Kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y0hjqsbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 14:38:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 13517100034;
        Thu, 26 Nov 2020 14:38:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E6E5424BAA2;
        Thu, 26 Nov 2020 14:38:39 +0100 (CET)
Received: from SFHDAG2NODE2.st.com (10.75.127.5) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 14:38:39 +0100
Received: from SFHDAG2NODE2.st.com ([fe80::14c2:73ff:db87:a27b]) by
 SFHDAG2NODE2.st.com ([fe80::14c2:73ff:db87:a27b%20]) with mapi id
 15.00.1473.003; Thu, 26 Nov 2020 14:38:39 +0100
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        Amelie DELAUNAY <amelie.delaunay@st.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "prabhakar.mahadev-lad.rj@bp.renesas.com" 
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Lionel DEBIEVE <lionel.debieve@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] ARM: multi_v7_defconfig: enable dfsdm and spdifrx
 support
Thread-Topic: [PATCH v2 0/2] ARM: multi_v7_defconfig: enable dfsdm and spdifrx
 support
Thread-Index: AQHWvx2lhaOQuG0c5kabN1zxgD24ranaPqOAgAAlQgA=
Date:   Thu, 26 Nov 2020 13:38:39 +0000
Message-ID: <5bec2267-5ce6-87c3-38bd-a00f5b124a7a@st.com>
References: <20201120091506.18326-1-olivier.moysan@st.com>
 <c80be2f8-8568-1dae-df31-1134ccea759a@st.com>
In-Reply-To: <c80be2f8-8568-1dae-df31-1134ccea759a@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6873B9CFF1C9A49A22286B6A2DA3922@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_04:2020-11-26,2020-11-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleA0KDQpPbiAxMS8yNi8yMCAxMjoyNSBQTSwgQWxleGFuZHJlIFRvcmd1ZSB3cm90ZToN
Cj4gSGkgT2xpdmllcg0KPiANCj4gT24gMTEvMjAvMjAgMTA6MTUgQU0sIE9saXZpZXIgTW95c2Fu
IHdyb3RlOg0KPj4gQWRkIFNUTTMyIFNQRElGUlggYW5kIERGU0RNIGF1ZGlvIHN1cHBvcnQgdG8g
bXVsdGlfdjdfZGVmY29uZmlnDQo+Pg0KPj4gQ2hhbmdlIGluIHYyOg0KPj4gLSBBZGQgdGFyZ2V0
ZWQgU29DIGluIGNvbW1pdCBtZXNzYWdlIGZvciBERlNETSBjb25maWcNCj4+DQo+PiBPbGl2aWVy
IE1veXNhbiAoMik6DQo+PiDCoMKgIEFSTTogbXVsdGlfdjdfZGVmY29uZmlnOiBlbmFibGUgc3Bk
aWZyeCBzdXBwb3J0DQo+PiDCoMKgIEFSTTogbXVsdGlfdjdfZGVmY29uZmlnOiBlbmFibGUgZGZz
ZG0gYXVkaW8gc3VwcG9ydA0KPj4NCj4+IMKgIGFyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjdfZGVm
Y29uZmlnIHwgMiArKw0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4gDQo+IFRhcmdldGVkIHBsYXRmb3JtIChTVE0zMikgc2hvdWxkIGJlIGFkZGVkIGluIHRoZSBj
b21taXQgdGl0bGUgZm9yIGJvdGggDQo+IHBhdGNoZXMgYXMgeW91IGVuYWJsZSBTVE0zMiBkZnNk
bSBhbmQgU1RNMzIgc3BkaWZyeCBzdXBwb3J0LiBObyA/DQo+IA0KPiBJZiB5b3UgYWdyZWUsIEkn
bGwgYWRkIGl0IGR1cmluZyBtZXJnZS4gTm8gbmVlZCB0byBzZW5kIGEgdjMuDQo+IA0KPiBSZWdh
cmRzDQo+IEFsZXgNCg0KSXQncyBva2F5IGZvciBtZS4NCg0KQlJzDQpPbGl2aWVy
