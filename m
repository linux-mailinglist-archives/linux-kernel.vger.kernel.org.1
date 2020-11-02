Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C542A2600
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgKBIUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:20:45 -0500
Received: from regular1.263xmail.com ([211.150.70.206]:49768 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbgKBIUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:20:44 -0500
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id B62C42615;
        Mon,  2 Nov 2020 16:14:01 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from hp1216 (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26974T140148431894272S1604304841345296_;
        Mon, 02 Nov 2020 16:14:02 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7d77ae4acfc77cc4fc55aff865618565>
X-RL-SENDER: zyf@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: zyf@rock-chips.com
X-FST-TO: miquel.raynal@bootlin.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Date:   Mon, 2 Nov 2020 16:14:01 +0800
Organization: =?utf-8?B?55Ge6Iqv5b6u55S15a2Q?=
From:   =?utf-8?B?6LW15Luq5bOw?= <yifeng.zhao@rock-chips.com>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     "Johan Jonker" <jbx6244@gmail.com>, richard <richard@nod.at>,
        vigneshr <vigneshr@ti.com>, robh+dt <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        =?utf-8?B?SGVpa29TdMO8Ym5lcg==?= <heiko@sntech.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: Re: [PATCH v13 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308, RK2928 and others
References: <20201028095326.15562-1-yifeng.zhao@rock-chips.com>, 
        <20201028095326.15562-3-yifeng.zhao@rock-chips.com>, 
        <a8a7875b-f08b-62c6-a630-245687e0df3b@gmail.com>, 
        <0dabd80e-b281-be65-b8e2-da00f46964fb@gmail.com>, 
        <20201102114503679684135@rock-chips.com>, 
        <20201102083258.3a748c44@xps13>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.18.111[cn]
Mime-Version: 1.0
Message-ID: <20201102161300764203144@rock-chips.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLAoKVGhlIG5hbmRfYmFzZS5jIHdpbGwgY2FsbMKgbmFuZF9kZXNlbGVjdF90YXJn
ZXQgYWZ0ZXIgTkFORCByZWFkL3Byb2dyYW0uLi4gb3BzIGRvbmUsIGFuZCBzZXTCoHZhcmlhYmxl
IGNoaXAtPmN1cl9jcyA9IC0xLApidXQgdGhlIG5hbmQgY29udHJvbGxlciBkbyBub3RoaW5nIGFu
ZCB0aGUgY3Mgb2YgdGhlIE5BTkQgZGV2aWNlIGlzIHN0aWxsIHNlbGVjdGVkLCAKc28gdGhlIE5B
TkQgZGV2aWNlIMKgd2lsbCBub3QgZW50ZXIgYXV0byBwb3dlciBzYXZlIG1vZGUuCgotLS0tLS0t
LS0tLS0tLQpUaGFua3MsCllpZmVuZwoKPkhlbGxvLAo+Cj7otbXku6rls7AgPHlpZmVuZy56aGFv
QHJvY2stY2hpcHMuY29tPiB3cm90ZSBvbiBNb24sIDIgTm92IDIwMjAgMTE6NDY6MDQKPiswODAw
Ogo+Cj4+IEhpIEpvaGFuLAo+Pgo+PiB2b2lkIG5hbmRfZGVzZWxlY3RfdGFyZ2V0KHN0cnVjdCBu
YW5kX2NoaXAgKmNoaXApCj4+IHsKPj4gaWYgKGNoaXAtPmxlZ2FjeS5zZWxlY3RfY2hpcCkKPj4g
Y2hpcC0+bGVnYWN5LnNlbGVjdF9jaGlwKGNoaXAsIC0xKTsKPj4KPj4gY2hpcC0+Y3VyX2NzID0g
LTE7Cj4+IH0KPj4KPj4gSSBuZWVkIGFkZCB0aGUgY29kZSBiZWxvdyBhbmQgaXQgd29yay4KPj4K
Pj4gwqAgwqBjaGlwLT5sZWdhY3kuc2VsZWN0X2NoaXAgPSBya19uZmNfc2VsZWN0X2NoaXA7Cj4+
Cj4+IEJ1dCBJIGZvdW5kwqBhbG1vc3QgYWxsIG5hbmRjIGRyaXZlcnMgZG8gbm90IGFkZCB0aGlz
IGNvZGUuIElzIHRoZXJlIGFueSBvdGhlciB3YXkgdG8gaW1wbGVtZW50IGl077yfCj4KPkluZGVl
ZCwgd2UgZG9uJ3QgYWNjZXB0IG5ldyBjb2RlIHdlIGxlZ2FjeSBiaW5kaW5ncy4KPgo+SSBkb24n
dCB1bmRlcnN0YW5kIHdoYXQgZXh0cmEgY29uc3VtcHRpb24geW91IGFyZSB0cnlpbmcgdG8gYXZv
aWQsCj5iZWNhdXNlIGlmIGl0IGlzIHRoZSBOQU5EIGRldmljZSBpdHNlbGYgdGhhdCBpcyBhYmxl
IHRvIHNhdmUgcG93ZXIgd2hlbgo+aXQgZ2V0cyB1bnNlbGVjdGVkLCBpdCdzIHJlYWxseSBub25l
IG9mIHlvdSBjb250cm9sbGVyJ3MgYnVzaW5lc3MuCj4KPlBlcmhhcHMgaXQncyB0aGUgdGltZSB0
byBmb2N1cyBvbiB0aGUgY29udHJvbGxlciBzdXBwb3J0IGFuZCB0dW5lIHRoZQo+Y29kZSBiYXNl
IGxhdGVyIGluIGEgYmlkIHRvIHJlZHVjZSBjb25zdW1wdGlvbi4KPgo+VGhhbmtzLAo+TWlxdcOo
bAo+Cj4KPg==



