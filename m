Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7382D28CB3F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbgJMJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:55:20 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:46567 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726120AbgJMJzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:55:19 -0400
X-UUID: 2d083468002b4a54841e6fb34d9036e9-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ErW8HdEIq/FdudMvL/XJKMQpzparYDyvJJpkVDGt/9I=;
        b=A4XIiW+zG7s81RxaMdCDqufQdbZ2FjDXvL2CrFVN760zsODjdZ1mBJ2F+RNEwF2fMV0bP2jiwcFz1BWdD7NNKVuWxg14t8IgtOTRbMQqq9rUE/EkW7gudbCMBR+87GmORZOH0JEzQxqOmgoNtMbpJOUFdoTu86RNHF0z8lowHQ0=;
X-UUID: 2d083468002b4a54841e6fb34d9036e9-20201013
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1675622749; Tue, 13 Oct 2020 17:55:08 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Oct
 2020 17:55:06 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Oct 2020 17:55:03 +0800
Message-ID: <1602582900.10262.0.camel@mszsdaap41>
Subject: Re: [v4 PATCH 0/2] fix scrolling of panel with small hfp or hbp
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <huijuan.xie@mediatek.com>, <stonea168@163.com>,
        <cawa.cheng@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 13 Oct 2020 17:55:00 +0800
In-Reply-To: <CAAOTY_-qZni-o11HJeymH74PAFSJw-0Awdz0wdjiQ0u7Ga1MGA@mail.gmail.com>
References: <20201010070910.11294-1-jitao.shi@mediatek.com>
         <CAAOTY_-qZni-o11HJeymH74PAFSJw-0Awdz0wdjiQ0u7Ga1MGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9058B82AC9E991BE078B9380368DAEE655AD1DF6E08AD11FCBEC7D55ED3BBE992000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTEwLTEyIGF0IDIzOjIyICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgSml0YW86DQo+IA0KPiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+IOaW
vCAyMDIw5bm0MTDmnIgxMOaXpSDpgLHlha0g5LiL5Y2IMzowOeWvq+mBk++8mg0KPiA+DQo+ID4g
Q2hhbmdlcyBzaW5jZSB2MzoNCj4gPiAgLSBSZXZlcnQgdjIsIGZvciB2MiB3aWxsIGNhdXNlIHNv
bWUgYnJpZGdlIGljIG5vIG91dHB1dC4gdGhlIGNhdXNlDQo+ID4gICAgdGhlIHZpZGVvIGxpbmV0
aW1lIGRvZXNuJ3QgbWF0Y2ggZGlzcGxheSBtb2RlIGZyb20gZ2V0IG1vZGUuDQo+ID4gIC0gTWFr
ZSBzdXJlIHRoZSBob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSBhbmQgaG9yaXpvbnRhbF9iYWNr
cG9yY2hfYnl0ZQ0KPiA+ICAgIGFyZSA+IDAuDQo+IA0KPiBCZWNhdXNlIHYyIGlzIG1lcmdlZCBp
bnRvIG1haW5saW5lLCBJIHRoaW5rIHlvdSBzaG91bGQgbWVyZ2UgMS8yIGFuZA0KPiAyLzIgdG8g
b25lIHBhdGNoIHdoaWNoIGZpeCB0aGUgcHJvYmxlbSBjYXVzZWQgYnkgdjIuDQo+IA0KPiBSZWdh
cmRzLA0KPiBDaHVuLUt1YW5nLg0KPiANCg0KVGhhbmtzIGZvciB5b3VyIHJldmlld2luZy4NCkkn
bGwgdXBkYXRlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCBSZWdhcmRzDQpKaXRhbw0KDQo+ID4NCj4g
PiBKaXRhbyBTaGkgKDIpOg0KPiA+ICAgUmV2ZXJ0ICJkcm0vbWVkaWF0ZWs6IGRzaTogRml4IHNj
cm9sbGluZyBvZiBwYW5lbCB3aXRoIHNtYWxsIGhmcCBvcg0KPiA+ICAgICBoYnAiDQo+ID4gICBk
cm0vbWVkaWF0ZWs6IGRzaTogZml4IHNjcm9sbGluZyBvZiBwYW5lbCB3aXRoIHNtYWxsIGhmcCBv
ciBoYnANCj4gPg0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgNjUg
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDI1IGluc2VydGlvbnMoKyksIDQwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gLS0NCj4gPiAy
LjEyLjUNCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPiA+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QNCj4gPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+ID4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwNCg0K

