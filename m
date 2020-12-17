Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387D52DCB01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 03:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgLQC0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 21:26:54 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:19390 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727090AbgLQC0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 21:26:54 -0500
X-UUID: 6b57a697fc7343769c8cf30d3b0e206e-20201217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=rtpUbaZh/cAA+R5BRc6dTbvK+CjOyeTaJisNHX8GorM=;
        b=M+7JG5RX2/VYnAMDWx472+5+2R3SDuSluClsjhpGaFaZfMt+KDqtPx/Fcdoihp99ptRyk2ve4hjPI+m1Eklg5MxjoHYrwvaTr0kDx6+NBs8Bfl9F4IzmIdOm5yPOUKN2bmRWe5D8Oz43YMUDnzYAfT/VZSMHX63zS+Ao5D5Jf8c=;
X-UUID: 6b57a697fc7343769c8cf30d3b0e206e-20201217
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1295937453; Thu, 17 Dec 2020 10:26:08 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 10:26:07 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 10:26:06 +0800
Message-ID: <1608171967.26323.211.camel@mhfsdcap03>
Subject: Re: [PATCH v3 4/7] iommu: Switch gather->end to unsigned long long
From:   Yong Wu <yong.wu@mediatek.com>
To:     David Laight <David.Laight@ACULAB.COM>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "youlin.pei@mediatek.com" <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "anan.sun@mediatek.com" <anan.sun@mediatek.com>,
        "chao.hao@mediatek.com" <chao.hao@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Date:   Thu, 17 Dec 2020 10:26:07 +0800
In-Reply-To: <6b4a1d37a90f4663adf6b4adb9f80e2b@AcuMS.aculab.com>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
         <20201216103607.23050-5-yong.wu@mediatek.com>
         <6b4a1d37a90f4663adf6b4adb9f80e2b@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B9C6A281BF70BD4B15A9A916FF428EA37530DAF05AB6D1085009CD88534769EA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsDQoNCk9uIFdlZCwgMjAyMC0xMi0xNiBhdCAxMTowMyArMDAwMCwgRGF2aWQgTGFp
Z2h0IHdyb3RlOg0KPiBGcm9tOiBZb25nIFd1DQo+ID4gU2VudDogMTYgRGVjZW1iZXIgMjAyMCAx
MDozNg0KPiA+IA0KPiA+IEN1cnJlbnRseSBnYXRoZXItPmVuZCBpcyAidW5zaWduZWQgbG9uZyIg
d2hpY2ggbWF5IGJlIG92ZXJmbG93IGluDQo+ID4gYXJjaDMyIGluIHRoZSBjb3JuZXIgY2FzZTog
MHhmZmYwMDAwMCArIDB4MTAwMDAwKGlvdmEgKyBzaXplKS4NCj4gPiBBbHRob3VnaCBpdCBkb2Vz
bid0IGFmZmVjdCB0aGUgc2l6ZShlbmQgLSBzdGFydCksIGl0IGFmZmVjdHMgdGhlIGNoZWNraW5n
DQo+ID4gImdhdGhlci0+ZW5kIDwgZW5kIg0KPiA+IA0KPiA+IEZpeGVzOiBhN2QyMGRjMTlkOWUg
KCJpb21tdTogSW50cm9kdWNlIHN0cnVjdCBpb21tdV9pb3RsYl9nYXRoZXIgZm9yIGJhdGNoaW5n
IFRMQiBmbHVzaGVzIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9saW51eC9pb21tdS5oIHwgNSArKystLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvbW11LmggYi9pbmNsdWRlL2xpbnV4
L2lvbW11LmgNCj4gPiBpbmRleCA3OTRkNDA4NWVkZDMuLjZlOTA3YTk1ZDk4MSAxMDA2NDQNCj4g
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lvbW11LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2lv
bW11LmgNCj4gPiBAQCAtMTc4LDcgKzE3OCw3IEBAIGVudW0gaW9tbXVfZGV2X2ZlYXR1cmVzIHsN
Cj4gPiAgICovDQo+ID4gIHN0cnVjdCBpb21tdV9pb3RsYl9nYXRoZXIgew0KPiA+ICAJdW5zaWdu
ZWQgbG9uZwkJc3RhcnQ7DQo+ID4gLQl1bnNpZ25lZCBsb25nCQllbmQ7DQo+ID4gKwl1bnNpZ25l
ZCBsb25nIGxvbmcJZW5kOw0KPiA+ICAJc2l6ZV90CQkJcGdzaXplOw0KPiA+ICB9Ow0KPiANCj4g
RG9lc24ndCB0aGF0IGFkZCB0d28gcGFkIHdvcmRzIG9uIG1hbnkgMzJiaXQgc3lzdGVtcz8NCj4g
WW91IHByb2JhYmx5IG91Z2h0IHRvIHJlLW9yZGVyIHRoZSBzdHJ1Y3R1cmUgdG8ga2VlcCB0aGUg
ZmllbGRzDQo+IG9uIHRoZWlyIG5hdHVyYWwgYm91bmRhcmllcy4NCj4gDQo+IEknbSBub3Qgc3Vy
ZSB3aGF0IGlzIGJlaW5nIG1hcHBlZCBoZXJlLCBidXQgY291bGQgaXQgbWFrZSBzZW5zZQ0KPiB0
byBqdXN0IGF2b2lkIHVzaW5nIHRoZSBoaWdoZXN0IGFkZHJlc3Nlcz8NCj4gVGhlbiB5b3UgbmV2
ZXIgaGl0IHRoZSBwcm9ibGVtLg0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LiBmb2xsb3dpbmcg
Um9iaW4ncyBzdWdnZXN0aW5nLCBJIHdpbGwgdXNlICJpb3ZhICsNCnNpemUgLSAxIiwgdGhlbiBh
dm9pZCB0aGlzLg0KDQo+IA0KPiAJRGF2aWQNCj4gDQo+IC0NCj4gUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQo+IFJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo+IA0KDQo=

