Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B3B2E1AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 10:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgLWJxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 04:53:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35141 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726022AbgLWJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 04:53:18 -0500
X-UUID: e8534724cefb4fae886dce3c9f777fab-20201223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=vr5A2JBVZ/YhzPjaegMhl5R2Mqj+btrfDGHqq1PAzkU=;
        b=qJJtDA+tcKnIvTiNzWSNOZgwouKT8/TMEneT1OC207fyLUepp+N2353i19X2CiInmqvDDN9cDHtcDbKm0qYPMa9KPETQoPnf9T5Avvyfu8xpdtXDwMfpB+J3/je6O00PkrnsUupALl7NRJcgzD6cA8BTn/8Sm6aZRvZwmo1EpXs=;
X-UUID: e8534724cefb4fae886dce3c9f777fab-20201223
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 599059773; Wed, 23 Dec 2020 17:52:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Dec 2020 17:52:31 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 17:52:31 +0800
Message-ID: <1608717152.29691.1.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/2] arm64: dts: mt6779: Support devapc
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Hanks Chen =?UTF-8?Q?=28=E9=99=B3=E5=BD=A5=E5=BB=B7=29?= 
        <Hanks.Chen@mediatek.com>,
        Jackson-kt Chang =?UTF-8?Q?=28=E5=BC=B5=E5=9C=8B=E6=BE=A4=29?= 
        <Jackson-kt.Chang@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Wed, 23 Dec 2020 17:52:32 +0800
In-Reply-To: <1608713092-26952-2-git-send-email-neal.liu@mediatek.com>
References: <1608713092-26952-1-git-send-email-neal.liu@mediatek.com>
         <1608713092-26952-2-git-send-email-neal.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K2FkZCBjb21tZW50cyAmIHJldmlld2VkLWJ5IEhhbmtzDQoNCk9uIFdlZCwgMjAyMC0xMi0yMyBh
dCAxNjo0NCArMDgwMCwgTmVhbCBMaXUgd3JvdGU6DQoNClN1cHBvcnQgREVWQVBDIG9uIE1UNjc3
OSBwbGF0Zm9ybXMgYnkgYWRkaW5nIGRldmljZSBub2RlLg0KDQpSZXZpZXdlZC1ieTogSGFua3Mg
Q2hlbiA8aGFua3MuY2hlbkBtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE5lYWwgTGl1
IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDY3NzkuZHRzaSB8ICAgIDggKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210Njc3OS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDY3Nzku
ZHRzaQ0KPiBpbmRleCAzNzBmMzA5Li41MmVjZmM3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ2Nzc5LmR0c2kNCj4gQEAgLTE4OSw2ICsxODksMTQgQEANCj4gIAkJCSNj
bG9jay1jZWxscyA9IDwxPjsNCj4gIAkJfTsNCj4gIA0KPiArCQlkZXZhcGM6IGRldmFwY0AxMDIw
NzAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS1kZXZhcGMiOw0KPiAr
CQkJcmVnID0gPDAgMHgxMDIwNzAwMCAwIDB4MTAwMD47DQo+ICsJCQlpbnRlcnJ1cHRzID0gPEdJ
Q19TUEkgMTY4IElSUV9UWVBFX0xFVkVMX0xPVz47DQo+ICsJCQljbG9ja3MgPSA8JmluZnJhY2Zn
X2FvIENMS19JTkZSQV9ERVZJQ0VfQVBDPjsNCj4gKwkJCWNsb2NrLW5hbWVzID0gImRldmFwYy1p
bmZyYS1jbG9jayI7DQo+ICsJCX07DQo+ICsNCj4gIAkJdWFydDA6IHNlcmlhbEAxMTAwMjAwMCB7
DQo+ICAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS11YXJ0IiwNCj4gIAkJCQkgICAg
ICJtZWRpYXRlayxtdDY1NzctdWFydCI7DQoNCg==

