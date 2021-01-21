Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37032FE4C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbhAUIRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:17:17 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:56891 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbhAUIQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:16:50 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10L8FlxqE029465, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10L8FlxqE029465
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Jan 2021 16:15:47 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 16:15:46 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 16:15:46 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee]) by
 RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee%5]) with mapi id
 15.01.2106.006; Thu, 21 Jan 2021 16:15:46 +0800
From:   =?utf-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "ricky_wu@realtek.corp-partner.google.com" 
        <ricky_wu@realtek.corp-partner.google.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "levinale@google.com" <levinale@google.com>,
        "keitasuzuki.park@sslab.ics.keio.ac.jp" 
        <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        "kdlnx@doth.eu" <kdlnx@doth.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtsx: pci: fix device aspm state bug
Thread-Topic: [PATCH] rtsx: pci: fix device aspm state bug
Thread-Index: AQHW78cZCdI+a5xevUmIEuTodtJmaKoxrtDQ//+EZACAAIZHwA==
Date:   Thu, 21 Jan 2021 08:15:46 +0000
Message-ID: <46473ff62a284bf1bdb703e13884beac@realtek.com>
References: <20210121072858.32028-1-ricky_wu@realtek.com>
 <8563fc3264ad4f46bfa05a3cbdb7d644@realtek.com> <YAk2NtOqIohpBJIt@kroah.com>
In-Reply-To: <YAk2NtOqIohpBJIt@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.99]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZyA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBK
YW51YXJ5IDIxLCAyMDIxIDQ6MDcgUE0NCj4gVG86IOWQs+aYiua+hCBSaWNreSA8cmlja3lfd3VA
cmVhbHRlay5jb20+DQo+IENjOiBhcm5kQGFybmRiLmRlOyByaWNreV93dUByZWFsdGVrLmNvcnAt
cGFydG5lci5nb29nbGUuY29tOw0KPiBzYXNoYWxAa2VybmVsLm9yZzsgbGV2aW5hbGVAZ29vZ2xl
LmNvbTsga2VpdGFzdXp1a2kucGFya0Bzc2xhYi5pY3Mua2Vpby5hYy5qcDsNCj4ga2RsbnhAZG90
aC5ldTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBydHN4OiBwY2k6IGZpeCBkZXZpY2UgYXNwbSBzdGF0ZSBidWcNCj4gDQo+IE9uIFRodSwgSmFu
IDIxLCAyMDIxIGF0IDA3OjMzOjAzQU0gKzAwMDAsIOWQs+aYiua+hCBSaWNreSB3cm90ZToNCj4g
PiBIaSBHcmVnIGtoLA0KPiA+DQo+ID4gVGhpcyBwYXRjaCB0byBmaXggbWlzYzogcnRzeCBidWcg
Zm9yIGtlcm5lbCA1LjQNCj4gDQo+IEkgZG8gbm90IHVuZGVyc3RhbmQgd2hhdCB0aGlzIG1lYW5z
LCBzb3JyeS4gIENhbiB5b3UgcGxlYXNlIGV4cGxhaW4gaXQ/DQo+IA0KT24gdGhlIG5ld2VzdCB1
cHN0cmVhbSB3ZSBkb27igJl0IHNldCBjb25maWcgc3BhY2UgZm9yIGVuL2Rpc2FibGUgYXNwbSwg
DQpzbyBpdCB3aWxsIG5vdCBoYXBwZW4gdGhpcyBpc3N1ZQ0KYnV0IG9uIGtlcm5lbCA1LjQgbG9u
Z3Rlcm0gdmVyc2lvbiB3ZSBuZWVkIHRvIGZpeCBpdA0KDQo+IA0KPiAtLS0tLS1QbGVhc2UgY29u
c2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
