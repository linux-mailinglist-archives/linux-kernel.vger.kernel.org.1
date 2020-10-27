Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18929A621
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508730AbgJ0IEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:04:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41693 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2508690AbgJ0IDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:03:48 -0400
X-UUID: 171b9c2476154cc28e2145d477d9573f-20201027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JyBsc+Y4sIJPtk0rE227nArOS2YDqslqxM8kl64ZCIc=;
        b=kkXTjUIK0rGUK7P6ezJ+4KrgcWlLSccGSZ/OPX+QQxrrPcexsxKzt5zM8PzvvslSsP50fJyLfIK3WC003Yp+8h66D9fspD8Lu+UykEDCRM0sPTqB+IkEoN359mrr9dxHDaz3G4B+GcVNIuEJxxpaM8gY+5awywmDT+aKmUaO5kQ=;
X-UUID: 171b9c2476154cc28e2145d477d9573f-20201027
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1402063274; Tue, 27 Oct 2020 16:03:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Oct 2020 16:03:43 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Oct 2020 16:03:43 +0800
Message-ID: <1603785824.12492.11.camel@mtkswgap22>
Subject: Re: [PATCH v2 2/4] arm: mm: reordering memory type table
From:   Miles Chen <miles.chen@mediatek.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Will Deacon <will.deacon@arm.com>,
        Steve Capper <steve.capper@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "Suren Baghdasaryan" <surenb@google.com>
Date:   Tue, 27 Oct 2020 16:03:44 +0800
In-Reply-To: <20201023101640.GA1551@shell.armlinux.org.uk>
References: <20201023091437.8225-1-miles.chen@mediatek.com>
         <20201023091437.8225-3-miles.chen@mediatek.com>
         <20201023101640.GA1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDExOjE2ICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggYWRtaW4gd3JvdGU6DQo+IE9uIEZyaSwgT2N0IDIzLCAyMDIwIGF0IDA1OjE0OjM1UE0gKzA4
MDAsIE1pbGVzIENoZW4gd3JvdGU6DQo+ID4gRnJvbTogTWluY2hhbiBLaW0gPG1pbmNoYW5Aa2Vy
bmVsLm9yZz4NCj4gPiANCj4gPiBUbyB1c2UgYml0IDUgaW4gcGFnZSB0YWJsZSBhcyBMX1BURV9T
UEVDSUFMLCB3ZSBuZWVkIGEgcm9vbSBmb3IgdGhhdC4NCj4gPiBJdCBzZWVtcyB3ZSBkb24ndCBu
ZWVkIDQgYml0cyBmb3IgdGhlIG1lbW9yeSB0eXBlIHdpdGggQVJNdjYrLg0KPiA+IElmIGl0J3Mg
dHJ1ZSwgbGV0J3MgcmVvcmRlciBiaXRzIHRvIG1ha2UgYml0IDUgZnJlZS4NCj4gPiANCj4gPiBX
ZSB3aWxsIHVzZSB0aGUgYml0IGZvciBMX1BURV9TUEVDSUFMIGluIG5leHQgcGF0Y2guDQo+ID4g
DQo+ID4gQSBub3RlIGZyb20gQ2F0YWxpbiBpbiBbMV06DQo+ID4gIg0KPiA+ID4gQW55d2F5LCBv
biBBUk12NyBvciBBUk12NitMUEFFLCB0aGUgbm9uLXNoYXJlZCBkZXZpY2UgZ2V0cyBtYXBwZWQg
dG8NCj4gPiA+IHNoYXJlZCBkZXZpY2UgaW4gaGFyZHdhcmUuIExvb2tpbmcgdGhyb3VnaCB0aGUg
YXJtMzIgY29kZSwgaXQgc2VlbXMgdGhhdA0KPiA+ID4gTVRfREVWSUNFX05PTlNIQVJFRCBpcyB1
c2VkIGJ5IGFyY2gvYXJtL21hY2gtc2htb2JpbGUvc2V0dXAtcjhhNzc3OS5jDQo+ID4gPiBhbmQg
SUlVQyB0aGF0J3MgYSB2NyBwbGF0Zm9ybSAoUi1DYXIgSDEsIENvcnRleC1BOSkuIEkgdGhpbmsg
dGhlIGFib3ZlDQo+ID4gPiBzaG91bGQgYmUgZGVmaW5lZCB0byBMX1BURV9NVF9ERVZfU0hBUkVE
LCB1bmxlc3MgSSBtaXNzIGFueSBwbGFjZSB3aGVyZQ0KPiA+ID4gREVWX05PTlNIQVJFRCBpcyBy
ZWxldmFudCBvbiBBUk12NiAoYWRkaW5nIFNpbW9uIHRvIGNvbmZpcm0gb24gc2htYmlsZSkuDQo+
ID4gIg0KPiA+IA0KPiA+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0
Y2gvOTg2NTc0Lw0KPiA+IA0KPiA+IENjOiBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9y
Zy51az4NCj4gPiBDYzogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4N
Cj4gPiBDYzogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+DQo+ID4gQ2M6IFN0ZXZl
IENhcHBlciA8c3RldmUuY2FwcGVyQGxpbmFyby5vcmc+DQo+ID4gQ2M6IFNpbW9uIEhvcm1hbiA8
aG9ybXNAdmVyZ2UubmV0LmF1Pg0KPiA+IENjOiBNaW5jaGFuIEtpbSA8bWluY2hhbkBrZXJuZWwu
b3JnPg0KPiA+IENjOiBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1cmVuYkBnb29nbGUuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IE1pbmNoYW4gS2ltIDxtaW5jaGFuQGtlcm5lbC5vcmc+DQo+ID4gU2ln
bmVkLW9mZi1ieTogTWlsZXMgQ2hlbiA8bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIGFyY2gvYXJtL2luY2x1ZGUvYXNtL3BndGFibGUtMmxldmVsLmggfCAyMSArKysrKysr
KysrKysrKysrKy0tLS0NCj4gPiAgYXJjaC9hcm0vbW0vcHJvYy1tYWNyb3MuUyAgICAgICAgICAg
ICB8ICA0ICsrLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9w
Z3RhYmxlLTJsZXZlbC5oIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vcGd0YWJsZS0ybGV2ZWwuaA0K
PiA+IGluZGV4IDI3YTg2MzVhYmVhMC4uY2RjZDU1Y2NhMzdkIDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gvYXJtL2luY2x1ZGUvYXNtL3BndGFibGUtMmxldmVsLmgNCj4gPiArKysgYi9hcmNoL2FybS9p
bmNsdWRlL2FzbS9wZ3RhYmxlLTJsZXZlbC5oDQo+ID4gQEAgLTE2MSwxNCArMTYxLDI3IEBADQo+
ID4gICNkZWZpbmUgTF9QVEVfTVRfQlVGRkVSQUJMRQkoX0FUKHB0ZXZhbF90LCAweDAxKSA8PCAy
KQkvKiAwMDAxICovDQo+ID4gICNkZWZpbmUgTF9QVEVfTVRfV1JJVEVUSFJPVUdICShfQVQocHRl
dmFsX3QsIDB4MDIpIDw8IDIpCS8qIDAwMTAgKi8NCj4gPiAgI2RlZmluZSBMX1BURV9NVF9XUklU
RUJBQ0sJKF9BVChwdGV2YWxfdCwgMHgwMykgPDwgMikJLyogMDAxMSAqLw0KPiA+ICsjZGVmaW5l
IExfUFRFX01UX0RFVl9TSEFSRUQJKF9BVChwdGV2YWxfdCwgMHgwNCkgPDwgMikJLyogMDEwMCAq
Lw0KPiA+ICsjZGVmaW5lIExfUFRFX01UX1ZFQ1RPUlMJKF9BVChwdGV2YWxfdCwgMHgwNSkgPDwg
MikJLyogMDEwMSAqLw0KPiA+ICAjZGVmaW5lIExfUFRFX01UX01JTklDQUNIRQkoX0FUKHB0ZXZh
bF90LCAweDA2KSA8PCAyKQkvKiAwMTEwIChzYTExMDAsIHhzY2FsZSkgKi8NCj4gPiAgI2RlZmlu
ZSBMX1BURV9NVF9XUklURUFMTE9DCShfQVQocHRldmFsX3QsIDB4MDcpIDw8IDIpCS8qIDAxMTEg
Ki8NCj4gPiAtI2RlZmluZSBMX1BURV9NVF9ERVZfU0hBUkVECShfQVQocHRldmFsX3QsIDB4MDQp
IDw8IDIpCS8qIDAxMDAgKi8NCj4gPiAtI2RlZmluZSBMX1BURV9NVF9ERVZfTk9OU0hBUkVECShf
QVQocHRldmFsX3QsIDB4MGMpIDw8IDIpCS8qIDExMDAgKi8NCj4gDQo+IFNvcnJ5LCBubywgdGhp
cyBpc24ndCBnb2luZyB0byB3b3JrLg0KPiANCj4gVGhlIGxvd2VyIHR3byBiaXRzIG9mIHRoaXMg
KGJpdHMgMiBhbmQgMykgYXJlIGV4cGxpY2l0bHkgZGVzaWduZWQgdG8gZml0DQo+IHRoZSBDIGFu
ZCBCIGJpdHMgdXNlZCBpbiBvbGRlciBhcmNoaXRlY3R1cmVzLiBDaGFuZ2luZyBMX1BURV9NVF9W
RUNUT1JTDQo+IGZyb20gaGF2aW5nIHZhbHVlICcxMScgdG8gJzAxJyBjaGFuZ2VzIHRoZSBmdW5j
dGlvbmFsaXR5IG9uIG9sZGVyIENQVXMuDQo+IA0KDQp0aGFua3MgZm9yIHRoZSBjb21tZW50Lg0K
DQpJcyBpcyBwb3NzaWJsZSB0byBmaW5kIG90aGVyIG9yZGVyIHRvIGZpdCB0aGlzPyBlLmcuLA0K
DQorI2RlZmluZSBMX1BURV9NVF9WRUNUT1JTCShfQVQocHRldmFsX3QsIDB4MDcpIDw8IDIpCS8q
IDAxMTEgKi8NCg0KI2RlZmluZSBMX1BURV9NVF9XUklURUFMTE9DCShfQVQocHRldmFsX3QsIDB4
MDUpIDw8IDIpCS8qIDAxMDEgKi8NCg0Kb3Igb25seSBhbGxvdyB0aGlzIHR5cGVzIGZvciB0aGUg
bmV3IENQVXM/DQoNCg0KTWlsZXMNCg==

