Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57D2276C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgIXJA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:00:57 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16502 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727211AbgIXJA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:00:57 -0400
X-UUID: 1043106553c7421691effe821b46c226-20200924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3Osfip0/Fmw6EWA75COU3SlVfE6xh4/kF+AnEUPz9NI=;
        b=Owoa8rshe0kIAGVm6AG3NxzCQ4AAbrbU1R5LojRSc+qacfzJEurxoeyt2ZApyn3Ea3BZ0EjDsitfKcfdcJIyA/Fpw4DP0lXZ07VX3XDZWTGyk0CzO9i6N+lYySUk5YldbjJrxb+pFQURRYex1suZAWqzQZujFRlrpZi/Oqzylt0=;
X-UUID: 1043106553c7421691effe821b46c226-20200924
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 37189220; Thu, 24 Sep 2020 17:00:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Sep
 2020 17:00:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Sep 2020 17:00:44 +0800
Message-ID: <1600937901.10428.4.camel@mhfsdcap03>
Subject: Re: [PATCH 1/7] usb: mtu3: convert to
 devm_platform_ioremap_resource_byname
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 24 Sep 2020 16:58:21 +0800
In-Reply-To: <87tuvnej3o.fsf@kernel.org>
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
         <87d02y1190.fsf@kernel.org> <1600400313.20602.4.camel@mhfsdcap03>
         <87tuvnej3o.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1DF56F8CBC2847E8528887447F97D71D9F00CDB10BFFC52207B6F5E6DED157B82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTI0IGF0IDEwOjIwICswMzAwLCBGZWxpcGUgQmFsYmkgd3JvdGU6DQo+
IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4g
PiBIaSBGZWxpcCwNCj4gPg0KPiA+DQo+ID4gT24gTW9uLCAyMDIwLTA5LTA3IGF0IDEwOjQyICsw
MzAwLCBGZWxpcGUgQmFsYmkgd3JvdGU6DQo+ID4+IEhpLA0KPiA+PiANCj4gPj4gQ2h1bmZlbmcg
WXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPiB3cml0ZXM6DQo+ID4+ID4gVXNlIGRldm1f
cGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUoKSB0byBzaW1wbGlmeSBjb2RlDQo+ID4+
ID4NCj4gPj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRp
YXRlay5jb20+DQo+ID4+IA0KPiA+PiB3aHkgaXMgaXQgc28gdGhhdCB5b3VyIHBhdGNoZXMgYWx3
YXlzIGNvbWUgYmFzZTY0IGVuY29kZWQ/IFRoZXkgbG9vaw0KPiA+PiBmaW5lIG9uIHRoZSBlbWFp
bCBjbGllbnQsIGJ1dCB3aGVuIEkgdHJ5IHRvIHBpcGUgdGhlIG1lc3NhZ2UgdG8gZ2l0IGFtDQo+
ID4+IGl0IGFsd2F5cyBnaXZlcyBtZSBhIGxvdCBvZiB0cm91YmxlIGFuZCBJIGhhdmUgdG8gbWFu
dWFsbHkgZGVjb2RlIHRoZQ0KPiA+PiBib2R5IG9mIHlvdXIgbWVzc2FnZXMgYW5kIHJlY29tYmlu
ZSB3aXRoIHRoZSBwYXRjaC4NCj4gPj4gDQo+ID4+IENhbiB5b3UgdHJ5IHRvIHNlbmQgeW91ciBw
YXRjaGVzIGFzIGFjdHVhbCBwbGFpbiB0ZXh0IHdpdGhvdXQgZW5jb2RpbmcNCj4gPj4gdGhlIGJv
ZHkgd2l0aCBiYXNlNjQ/DQo+ID4gTWlzc2VkIHRoZSBlbWFpbC4NCj4gPg0KPiA+IFNvcnJ5IGZv
ciBpbmNvbnZlbmllbmNlIQ0KPiA+IElzIG9ubHkgdGhlIGNvbW1pdCBtZXNzYWdlIGJhc2U2NCBl
bmNvZGVkLCBvciBpbmNsdWRlcyB0aGUgY29kZXM/DQo+IA0KPiBUaGUgZW50aXJlIHRoaW5nIDot
KQ0KSSBjaGVja2VkIG15IGdpdGNvbmZpZywgdXNlIHRoZSBkZWZhdWx0IGVuY29kaW5nLCB0aGF0
IGlzIDhiaXQuIGlmIHlvdQ0Kc3RpbGwgZW5jb3VudGVyIHRoZSBpc3N1ZSB3aGVuIGFwcGx5IHRo
ZSBzZXJpZXMgcGF0Y2gNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE3NjQ5
NTMvDQpJJ2xsIHJlc2VuZCB0aGVtIGJ5ICJnaXQgc2VuZC1lbWFpbCAtLXRyYW5zZmVyLWVuY29k
aW5nPThiaXQgMDAqIg0KDQo+IA0KDQo=

