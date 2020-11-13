Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69E32B172A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMI0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:26:53 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:13265 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgKMI0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:26:52 -0500
X-UUID: db1b0360687746298dce5aa99ddfc815-20201113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ZShn+dzBZrjkCnF7peuUmT+UVHHS3a90GpKlN9nJIjE=;
        b=iPz7D8AoC2HGpmbOaGcHqza8cs8oS/0+fARxwbvs/9Pbh1/1HveSqv8G6T6VBxYsrDf5dPWr2nmSvF9JQaDqaJtrtGwrEYlqc8b1U0jjjcQEsO743kipG4jVbILS9TI7NytfPmLBGJewg0tu9sMSeXKiUS3zwPUk4wqm9toYgzk=;
X-UUID: db1b0360687746298dce5aa99ddfc815-20201113
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 92464501; Fri, 13 Nov 2020 16:26:46 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 13 Nov
 2020 16:26:43 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Nov 2020 16:26:43 +0800
Message-ID: <1605256003.31607.26.camel@mhfsdcap03>
Subject: Re: [PATCH 7/7] usb: musb: convert to
 devm_platform_ioremap_resource_byname
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Bin Liu <b-liu@ti.com>
Date:   Fri, 13 Nov 2020 16:26:43 +0800
In-Reply-To: <CAMuHMdU8ow7J-Db_v3HUM8MmPfYcNpirzpUFmjUQrneeaVGFoA@mail.gmail.com>
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
         <1595404275-8449-7-git-send-email-chunfeng.yun@mediatek.com>
         <CAMuHMdU8ow7J-Db_v3HUM8MmPfYcNpirzpUFmjUQrneeaVGFoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5899ECDA3DC868B0B5D4BFAE4960474BA86ACCF81DC48B0440F0F167947F43C42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTEyIGF0IDE1OjA4ICswMTAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IEhpIENodW5mZW5nLA0KPiANCj4gT24gV2VkLCBKdWwgMjIsIDIwMjAgYXQgOTo1NCBB
TSBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+IFVz
ZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKCkgdG8gc2ltcGxpZnkgY29k
ZQ0KPiA+DQo+ID4gQ2M6IEJpbiBMaXUgPGItbGl1QHRpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+IA0KPiBUaGFua3Mg
Zm9yIHlvdXIgcGF0Y2gsIHdoaWNoIGlzIG5vdyBjb21taXQgMmQzMGU0MDhhMmE2YjM0NCAoInVz
YjogbXVzYjoNCj4gY29udmVydCB0byBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnlu
YW1lIikgaW4gdjUuOS4NCj4gDQo+ID4gLS0tIGEvZHJpdmVycy91c2IvbXVzYi9tdXNiX2RzcHMu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL211c2IvbXVzYl9kc3BzLmMNCj4gPiBAQCAtNDI5LDEy
ICs0MjksMTAgQEAgc3RhdGljIGludCBkc3BzX211c2JfaW5pdChzdHJ1Y3QgbXVzYiAqbXVzYikN
Cj4gPiAgICAgICAgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBhcmVudCA9IHRvX3BsYXRmb3Jt
X2RldmljZShkZXYtPnBhcmVudCk7DQo+ID4gICAgICAgICBjb25zdCBzdHJ1Y3QgZHNwc19tdXNi
X3dyYXBwZXIgKndycCA9IGdsdWUtPndycDsNCj4gPiAgICAgICAgIHZvaWQgX19pb21lbSAqcmVn
X2Jhc2U7DQo+ID4gLSAgICAgICBzdHJ1Y3QgcmVzb3VyY2UgKnI7DQo+ID4gICAgICAgICB1MzIg
cmV2LCB2YWw7DQo+ID4gICAgICAgICBpbnQgcmV0Ow0KPiA+DQo+ID4gLSAgICAgICByID0gcGxh
dGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwYXJlbnQsIElPUkVTT1VSQ0VfTUVNLCAiY29udHJv
bCIpOw0KPiA+IC0gICAgICAgcmVnX2Jhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCBy
KTsNCj4gPiArICAgICAgIHJlZ19iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNl
X2J5bmFtZShwYXJlbnQsICJjb250cm9sIik7DQo+ID4gICAgICAgICBpZiAoSVNfRVJSKHJlZ19i
YXNlKSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIocmVnX2Jhc2UpOw0KPiA+
ICAgICAgICAgbXVzYi0+Y3RybF9iYXNlID0gcmVnX2Jhc2U7DQo+IA0KPiBPbiBCZWFnbGVib25l
IEJsYWNrLCB3aGVyZSBlYWNoIGludGVyZmFjZSBoYXMgMiBjaGlsZHJlbjoNCj4gDQo+ICAgICBt
dXNiLWRzcHMgNDc0MDFjMDAudXNiOiBjYW4ndCByZXF1ZXN0IHJlZ2lvbiBmb3IgcmVzb3VyY2Ug
W21lbQ0KPiAweDQ3NDAxODAwLTB4NDc0MDE5ZmZdDQo+ICAgICBtdXNiLWhkcmMgbXVzYi1oZHJj
LjE6IG11c2JfaW5pdF9jb250cm9sbGVyIGZhaWxlZCB3aXRoIHN0YXR1cyAtMTYNCj4gICAgIG11
c2ItaGRyYzogcHJvYmUgb2YgbXVzYi1oZHJjLjEgZmFpbGVkIHdpdGggZXJyb3IgLTE2DQo+ICAg
ICBtdXNiLWRzcHMgNDc0MDE0MDAudXNiOiBjYW4ndCByZXF1ZXN0IHJlZ2lvbiBmb3IgcmVzb3Vy
Y2UgW21lbQ0KPiAweDQ3NDAxMDAwLTB4NDc0MDExZmZdDQo+ICAgICBtdXNiLWhkcmMgbXVzYi1o
ZHJjLjA6IG11c2JfaW5pdF9jb250cm9sbGVyIGZhaWxlZCB3aXRoIHN0YXR1cyAtMTYNCj4gICAg
IG11c2ItaGRyYzogcHJvYmUgb2YgbXVzYi1oZHJjLjAgZmFpbGVkIHdpdGggZXJyb3IgLTE2DQo+
IA0KPiBCZWZvcmUsIGRldm1faW9yZW1hcF9yZXNvdXJjZSgpIHdhcyBjYWxsZWQgb24gImRldiIg
KCJtdXNiLWhkcmMuMCIgb3INCj4gIm11c2ItaGRyYy4xIiksIGFmdGVyIGl0IGlzIGNhbGxlZCBv
biAiJnBkZXYtPmRldiIgKCI0NzQwMTQwMC51c2IiIG9yDQo+ICI0NzQwMWMwMC51c2IiKSwgbGVh
ZGluZyB0byBhIGR1cGxpY2F0ZSByZWdpb24gcmVxdWVzdCwgd2hpY2ggZmFpbHMuDQo+IA0KTXkg
YmFkLCBJIGRpZG4ndCBub3RpY2UgdGhhdCwgdGhhbmtzIGEgbG90Lg0KDQpBbmQgc29ycnksIEkg
bWlzc2VkIHlvdXIgbWVzc2FnZQ0KDQo+IEkgaGF2ZSBzZW50IGEgcmV2ZXJ0Og0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvMjAyMDExMTIxMzU5MDAuMzgyMjU5OS0xLWdlZXJ0
K3JlbmVzYXNAZ2xpZGVyLmJlLw0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCg0K

