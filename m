Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00092D245A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgLHH3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:29:52 -0500
Received: from regular1.263xmail.com ([211.150.70.202]:60842 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgLHH3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:29:51 -0500
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 7DBE8757;
        Tue,  8 Dec 2020 15:23:55 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from hp1216 (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P20464T140378982311680S1607412234718334_;
        Tue, 08 Dec 2020 15:23:55 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <bf1563341e3518cf21c038c9a99d4d63>
X-RL-SENDER: zyf@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: zyf@rock-chips.com
X-FST-TO: jbx6244@gmail.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Date:   Tue, 8 Dec 2020 15:23:54 +0800
Organization: =?utf-8?B?55Ge6Iqv5b6u55S15a2Q?=
From:   =?utf-8?B?6LW15Luq5bOw?= <yifeng.zhao@rock-chips.com>
To:     "Johan Jonker" <jbx6244@gmail.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        richard <richard@nod.at>, vigneshr <vigneshr@ti.com>,
        robh+dt <robh+dt@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        =?utf-8?B?SGVpa29TdMO8Ym5lcg==?= <heiko@sntech.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: Re: [PATCH v15 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308, RK2928 and others
References: <20201130100031.22083-1-yifeng.zhao@rock-chips.com>, 
        <20201130100031.22083-3-yifeng.zhao@rock-chips.com>, 
        <0abf1dbd-13bb-cd92-907c-849f05ea887c@gmail.com>, 
        <259fe1ce-6bcb-3a26-493d-87bbd2eaff5e@gmail.com>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.18.111[cn]
Mime-Version: 1.0
Message-ID: <2020120815225461228793@rock-chips.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9oYW4sCgpZZXMsIEkgd2lsbCBwb3N0IE5GQyBjb2RlIHRvIFVib29077yMYnV0IGl0IG1h
eSB0YWtlIGEgd2hpbGUgdG8gbW9kaWZ5IHRoZSBjb2RlIGZvciBVYm9vdC4KCi0tLS0tLS0tLS0t
LS0tCnlpZmVuZwo+SGkgWWlmZW5nLAo+Cj5NZWFud2hpbGUsIGNvdWxkIHlvdSBwb3N0IGEgUkZD
IHZlcnNpb24gZm9yIFVib290IGJhc2VkIG9uIHRoaXMgdmVyc2lvbgo+cGx1cyBjb21tZW50cywg
c28gcGVvcGxlIGNhbiB0ZXN0IHRoZSB3aG9sZSBwcm9jZXNzIGZyb20gcHJvZ3JhbW1pbmcsCj5i
b290aW5nIGFuZCBrZXJuZWw/Cj4KPk9uIDExLzMwLzIwIDE6NDkgUE0sIEpvaGFuIEpvbmtlciB3
cm90ZToKPj4gSGksCj4+Cj4+IExvb2tzIGdvb2QgdG8gbWUuCj4+IERvIHRoZSBtYWludGFpbmVy
cyBvciBzb21lb25lIGVsc2UgaGF2ZSBhbnkgbWFqb3IgaXNzdWVzPwo+PiBDb3VsZCBNaXF1ZWwg
aW5kaWNhdGUgaWYgYSB2ZXJzaW9uIDE2IG11c3QgYmUgc2VuZCBmb3IgdGhhdCAncmV0Jwo+PiB2
YXJpYWJsZSBhbG9uZSBvciBpcyBpdCBPSyBub3c/Cj4+Cj4+Cj4+IE9uIDExLzMwLzIwIDExOjAw
IEFNLCBZaWZlbmcgWmhhbyB3cm90ZToKPj4+IFRoaXMgZHJpdmVyIHN1cHBvcnRzIFJvY2tjaGlw
IE5GQyAoTkFORCBGbGFzaCBDb250cm9sbGVyKSBmb3VuZCBvbiBSSzMzMDgsCj4+PiBSSzI5Mjgs
IFJLUFgzMCwgUlYxMTA4IGFuZCBvdGhlciBTT0NzLiBUaGUgZHJpdmVyIGhhcyBiZWVuIHRlc3Rl
ZCB1c2luZwo+Pj4gOC1iaXQgTkFORCBpbnRlcmZhY2Ugb24gdGhlIEFSTSBiYXNlZCBSSzMzMDgg
cGxhdGZvcm0uCj4KPlsuLl0KPgo+Pj4gKy8qKgo+Pj4gKyAqIHN0cnVjdCBya19lY2NfY250X3N0
YXR1czogcmVwcmVzZW50IGEgZWNjIHN0YXR1cyBkYXRhLgo+Cj5yZXByZXNlbnQgdGhlIEVDQyBz
dGF0dXMgZGF0YS4KPgo+Pj4gKyAqIEBlcnJfZmxhZ19iaXQ6IGVycm9yIGZsYWcgYml0IGluZGV4
IGF0IHJlZ2lzdGVyLgo+Pj4gKyAqIEBsb3c6IEVDQyBjb3VudCBsb3cgYml0IGluZGV4IGF0IHJl
Z2lzdGVyLgo+Pj4gKyAqIEBsb3dfbWFzazogbWFzayBiaXQuCj4+PiArICogQGxvd19ibjogRUND
IGNvdW50IGxvdyBiaXQgbnVtYmVyLgo+Pj4gKyAqIEBoaWdoOiBFQ0MgY291bnQgaGlnaCBiaXQg
aW5kZXggYXQgcmVnaXN0ZXIuCj4+PiArICogQGhpZ2hfbWFzazogbWFzayBiaXQKPj4+ICsgKi8K
Pgo+Cj4=



