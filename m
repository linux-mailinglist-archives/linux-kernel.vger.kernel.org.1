Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634282AD0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgKJIFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:05:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48898 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726690AbgKJIFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:05:31 -0500
X-UUID: d80d6a35e1714ae2b66c4b019122ba36-20201110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=G0NM2PJOoQh0fLHTUhw48+H0cz6FqLC37EenK/j49so=;
        b=SQwzH+8S37KY581bh3i0AQOVbuMI8VMCF1IRVkgRSTimhzHnflX1P2u54NGnfvXouFJr072r39ZPA5swdPdlNGweSAoRTY6CeEcKNfueP180MA31Gi4YHwM5ShuQW9Rgf4wlKYTDm7l7B2mkCmFNMHQE6Ine7yMhLcO3Qyf0NC0=;
X-UUID: d80d6a35e1714ae2b66c4b019122ba36-20201110
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 814570119; Tue, 10 Nov 2020 16:05:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Nov 2020 16:05:21 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Nov 2020 16:05:21 +0800
Message-ID: <1604995521.14886.9.camel@mtkswgap22>
Subject: Re: binder: add transaction latency tracer
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Date:   Tue, 10 Nov 2020 16:05:21 +0800
In-Reply-To: <X6pHFAqmH0je0n3I@kroah.com>
References: <1602781377-4278-1-git-send-email-Frankie.Chang@mediatek.com>
         <1603987737-2763-1-git-send-email-Frankie.Chang@mediatek.com>
         <20201109174605.GA2426739@kroah.com> <1604993580.14886.5.camel@mtkswgap22>
         <X6pGqcXk3VMgUwu0@kroah.com> <X6pHFAqmH0je0n3I@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DE4DB6F0648F9982A4B76E347E9A09A86A5BB17E305FCBA68C8FC8D2A3564AB62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTEwIGF0IDA4OjUzICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFR1ZSwgTm92IDEwLCAyMDIwIGF0IDA4OjUyOjA5QU0gKzAxMDAsIEdyZWcgS3Jv
YWgtSGFydG1hbiB3cm90ZToNCj4gPiBPbiBUdWUsIE5vdiAxMCwgMjAyMCBhdCAwMzozMzowMFBN
ICswODAwLCBGcmFua2llIENoYW5nIHdyb3RlOg0KPiA+ID4gT24gTW9uLCAyMDIwLTExLTA5IGF0
IDE4OjQ2ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwg
T2N0IDMwLCAyMDIwIGF0IDEyOjA4OjU0QU0gKzA4MDAsIEZyYW5raWUgQ2hhbmcgd3JvdGU6DQo+
ID4gPiA+ID4gQ2hhbmdlIGZyb20gdjExOg0KPiA+ID4gPiA+ICAgLSByZWJhc2UuDQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGlzIHdob2xlIHBhdGNoIHNldCBpcyBzZW50IHdpdGggRE9TIGxpbmUtZW5k
cywgd2hpY2ggbWFrZXMgZ2l0IHJlYWxseQ0KPiA+ID4gPiB1bmhhcHB5IHdoZW4gaXQgdHJpZXMg
dG8gYXBwbHkgaXQsIGFzIHJpZ2h0ZnVsbHksIGl0IGRvZXNuJ3Qga25vdyBob3cgdG8NCj4gPiA+
ID4gY29udmVydCB0aGluZ3MuDQo+ID4gPiA+IA0KPiA+ID4gSG1tLi4sIGFjdHVhbGx5IEkgY2Fu
IHVzZSAnZ2l0IGFwcGx5JyBQQVRDSCB2MTEgZnJvbSB0aGUgbWVzc2FnZQ0KPiA+ID4gZGlyZWN0
bHkuDQo+ID4gDQo+ID4gT2ssIGxldCBtZSBzZWUgaWYgSSBjYW4gZmlndXJlIHRoaXMgb3V0IG9u
IG15IGVuZCwgbGV0IG1lIHRyeSB1c2luZyBgYjRgDQo+ID4gb24gdGhpcyB0byBzZWUgaWYgdGhh
dCBoZWxwcy4uLg0KPiANCj4gTm9wZSwgdGhlcmUncyBzdGlsbCBzb21lIG1lcmdlIGNvbmZsaWN0
cyBoZXJlLiAgYjQgZml4ZWQgdGhlIGxpbmUtZW5kDQo+IGlzc3VlcywgYnV0IGNhbiB5b3UgcGxl
YXNlIHJlYmFzZSBvbiB0b3Agb2YgbXkgY2hhci1taXNjLW5leHQgYnJhbmNoIGluDQo+IHRoZSBj
aGFyLmdpdCB0cmVlIG9uIGdpdC5rZXJuZWwub3JnIGFuZCByZXNlbmQ/ICBJIHRoaW5rIHNvbWUg
Y2hhbmdlcyBieQ0KPiBvdGhlcnMgYXJlIGNvbmZsaWN0aW5nIHdpdGggdGhpcyBwYXRjaHNldCBz
b21laG93Lg0KPiANClRoYW5rcyBmb3IgaGVscGluZyB0aGUgbGluZS1lbmQgaXNzdWVzLCANCkkg
d2lsbCByZWJhc2UgYW5kIHZlcmlmeSBsb2NhbGx5IHRoZW4gcmVzZW5kIHRoZSBwYXRjaCBzZXQg
YWdhaW4uDQoNCk1hbnkgdGhhbmtzDQoNCkZyYW5raWUgQ2hhbmcNCg0K

