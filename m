Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600FC2B7A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKRJrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:47:39 -0500
Received: from de-out1.bosch-org.com ([139.15.230.186]:58078 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKRJri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:47:38 -0500
X-Greylist: delayed 64462 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 04:47:34 EST
Received: from si0vm1948.rbesz01.com (lb41g3-ha-dmz-psi-sl1-mailout.fe.ssn.bosch.com [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 4CbdJj0V4Lz4f3lwy;
        Wed, 18 Nov 2020 10:47:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=key2-intmail; t=1605692853;
        bh=+ZtmImHbO2np+GXZw0lIRqvjeiTwqnhZNRUCHLn+6K8=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=D+bAcqiGYT1YLNx26LS+l5KVeeECkPtjtFznzVUINFSag2IsYuaXP7/fPymGru5hM
         KcgDaQhFFlSilLYEeQJO2DyYmU6O3uYcirxNAW7ndHuKtY6a8J4vdeJX9rLA2mX+xu
         N93C1f3Lu2PQmgoIEkvw3R04c7RCjzo+x3GiUuWc=
Received: from fe0vm1741.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 4CbdJj05Nbz7r6;
        Wed, 18 Nov 2020 10:47:33 +0100 (CET)
X-AuditID: 0a3aad15-fb3ff700000022e8-e4-5fb4edb4be2d
Received: from si0vm1950.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1741.rbesz01.com (SMG Outbound) with SMTP id FA.BF.08936.4BDE4BF5; Wed, 18 Nov 2020 10:47:32 +0100 (CET)
Received: from FE-MBX2050.de.bosch.com (fe-mbx2050.de.bosch.com [10.3.231.60])
        by si0vm1950.rbesz01.com (Postfix) with ESMTPS id 4CbdJh68FZzW7P;
        Wed, 18 Nov 2020 10:47:32 +0100 (CET)
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-MBX2050.de.bosch.com (10.3.231.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 18 Nov 2020 10:47:32 +0100
Received: from FE-MBX2051.de.bosch.com ([fe80::9402:faf1:5852:4e2f]) by
 FE-MBX2051.de.bosch.com ([fe80::9402:faf1:5852:4e2f%6]) with mapi id
 15.01.2106.004; Wed, 18 Nov 2020 10:47:32 +0100
From:   "Jonas Mark (BT-FIR/ENG1-Grb)" <Mark.Jonas@de.bosch.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Jonas Mark (BT-FIR/ENG1-Grb)" <Mark.Jonas@de.bosch.com>
Subject: AW: [PATCH] drm: imx: Move fbdev setup to before output polling
Thread-Topic: [PATCH] drm: imx: Move fbdev setup to before output polling
Thread-Index: AQHWvPnAfxZE9kwfn0Gz111spU5g9qnNecSAgAAN4oCAAAOfAIAAEkZQ
Date:   Wed, 18 Nov 2020 09:47:32 +0000
Message-ID: <38c2d92ac5f04a228e55af43a12a4bd7@de.bosch.com>
References: <20201117155229.9837-1-mark.jonas@de.bosch.com>
 <e089d4d5-3bd8-c2cd-3011-ed87ae4284e8@suse.de>
 <CAKMK7uEpEt4w4kVJLOd2Yw1MnsrCn-NMgT4TjcxROpZBa_xvYg@mail.gmail.com>
 <68af913c-9f4e-73b5-a2cb-8692902a2847@suse.de>
In-Reply-To: <68af913c-9f4e-73b5-a2cb-8692902a2847@suse.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.141.163.207]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsXCZbVWVnfL2y3xBj+WW1r0njvJZPF/20Rm
        iytf37NZrJq6k8Vi0+NrrBZdv1YyW1zeNYfN4u/2TSwWL7aIW2x5M5HVgctj77cFLB6bVnWy
        eWz/9oDV4373cSaPzUvqPTa+28Hk0f/XwGPz6WqPz5vkAjijuGxSUnMyy1KL9O0SuDK2b/3D
        VnBPpaLhwx32BsYnyl2MnBwSAiYSUzdcZe9i5OIQEpjOJHHpdCcbhLOLUWLC90YWkCohgbeM
        EnM6lCHsA4wSCy5zgdhsAnYS+1+/YQKxRQR8JFZNvg02iVngMbPEptMPwRLCAh4ST1+cZYEo
        8pR4N/c5G4TtJrF9AUQNi4CqxJMv99hBbF4Ba4mHPc1MEFc8YZS4+GY/WAMnUKLp+mdGEJtR
        QFZiw4bzzCA2s4C4xKZn31kh/hGQWLIHIi4hICrx8vE/qLiSxIn374AWcADVa0qs36UP0aoo
        MaX7IdReQYmTM5+wTGAUn4Vk6iyEjllIOmYh6VjAyLKKUTQt1aAs19DcxFCvKCm1uMrAUC85
        P3cTIyTKRXcw3un+oHeIkYmD8RCjBAezkgivi8nGeCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        Kjwb44QE0hNLUrNTUwtSi2CyTBycUg1MMzyiOHMf+xamvM6/qfVXU1VTVG/pmy89TuJysy5Y
        8tmm9zz/fbZvRcm8HSeNfr922f9i4lufU83lpQpKy7M3uTnKn2DOu2J/6tmdNc8T9QXW//lT
        McN9ar9Z8FPe+ZJMV3qX1LfG/xHmyM/SVc2ak1ycON17c2y556vtjTd+tbS5rv+eVPrWe8Gh
        1IZdjSEeD8+ztnbJbWGJk5J2/ft6kmncttKlu5iLvshs6X6Z0mTz1n6ysqpog79TQW1tSunj
        knlH3ZjPFu8N0vQ13/4yg6eyQ0nsl37GPs2Pdz7Mst9ePM3XpeXQEtfzFoKBRXcnlz3Uj5Xw
        LHYpurZVjOWJpE15lzNvi5HB6QMfapVYijMSDbWYi4oTAStyvnVhAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzIGFuZCBEYW5pZWwsDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgZmVl
ZGJhY2suIFdlIGFwcHJlY2lhdGUgaXQuDQoNCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vaW14L2lteC1kcm0tY29yZS5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9pbXgvaW14
LWRybS1jb3JlLmMNCj4gPj4+IGluZGV4IDliZjVhZDZkMThhMi4uMjY2NTA0MGUxMWM3IDEwMDY0
NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2lteC9pbXgtZHJtLWNvcmUuYw0KPiA+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2lteC9pbXgtZHJtLWNvcmUuYw0KPiA+Pj4gQEAgLTI0MCwx
NCArMjQwLDE4IEBAIHN0YXRpYyBpbnQgaW14X2RybV9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gPj4+ICAgICAgICAgICAgICAgIGxlZ2FjeWZiX2RlcHRoID0gMTY7DQo+ID4+PiAgICAgICAg
fQ0KPiA+Pj4NCj4gPj4+ICsgICAgIC8qDQo+ID4+PiArICAgICAgKiBUaGUgZ2VuZXJpYyBmYmRl
diBoYXMgdG8gYmUgc2V0dXAgYmVmb3JlIGVuYWJsaW5nIG91dHB1dCBwb2xsaW5nLg0KPiA+Pj4g
KyAgICAgICogT3RoZXJ3aXNlIHRoZSBmYmRldiBjbGllbnQgaXMgbm90IHJlYWR5IHRvIGhhbmRs
ZSBkZWxheWVkIGV2ZW50cy4NCj4gPj4+ICsgICAgICAqLw0KPiA+Pj4gKyAgICAgZHJtX2ZiZGV2
X2dlbmVyaWNfc2V0dXAoZHJtLCBsZWdhY3lmYl9kZXB0aCk7DQo+ID4+PiArDQo+ID4+PiAgICAg
ICAgZHJtX2ttc19oZWxwZXJfcG9sbF9pbml0KGRybSk7DQo+ID4+Pg0KPiA+Pj4gICAgICAgIHJl
dCA9IGRybV9kZXZfcmVnaXN0ZXIoZHJtLCAwKTsNCj4gPj4+ICAgICAgICBpZiAocmV0KQ0KPiA+
Pj4gICAgICAgICAgICAgICAgZ290byBlcnJfcG9sbF9maW5pOw0KPiA+Pj4NCj4gPj4+IC0gICAg
IGRybV9mYmRldl9nZW5lcmljX3NldHVwKGRybSwgbGVnYWN5ZmJfZGVwdGgpOw0KPiA+Pj4gLQ0K
PiA+Pg0KPiA+PiBUaGlzIGRvZXMgbm90IHdvcmsgd2VsbC4gZmJkZXYgaXMgc3VwcG9zZWQgdG8g
YmUgYW5vdGhlciByZWd1bGFyIERSTQ0KPiA+PiBjbGllbnQuIEl0IGhhcyB0byBiZSBlbmFibGVk
IGFmdGVyIHJlZ2lzdGVyaW5nIHRoZSBEUk0gZGV2aWNlLg0KPiA+Pg0KPiA+PiBJJ2QgcmF0aGVy
IGltcHJvdmUgZmJkZXYgb3IgdGhlIGRyaXZlciB0byBoYW5kbGUgdGhpcyBncmFjZWZ1bGx5Lg0K
PiA+DQo+ID4gWWVhaCBJJ20gbm90IHVuZGVyc3RhbmRpbmcgdGhlIHBvaW50IGhlcmUuIE9uY2Ug
ZmJjb24gaXMgcnVubmluZywgeW91DQo+ID4gaGF2ZSBhIHNjcmVlbi4gQW55IGZiZGV2IHVzZXJz
cGFjZSBjbGllbnQgIGFsc28gc2hvdWxkIGRvIGEgbW9kZXNldA0KPiA+IGZpcnN0LiBBbmQgaWYg
dGhleSBkb250IGFuZCBpdCdzIGV4cGVjdGVkIHVhcGkgZm9yIGZiZGV2IGNoYXJkZXYgdGhhdA0K
PiA+IHRoZSBkaXNwbGF5IGJvb3RzIHVwIGVuYWJsZWQsIHRoZW4gd2UgbmVlZCB0byBmaXggdGhh
dCBpbiB0aGUgZmJkZXYNCj4gPiBoZWxwZXJzLCBub3QgdGhyb3VnaCBjbGV2ZXIgcmVvcmRlcmlu
ZyBpbiBkcml2ZXJzIHNvIHRoYXQgYQ0KPiA+IHNpZGUtZWZmZWN0IGNhdXNlcyBhIG1vZGVzZXQu
DQo+ID4NCj4gPiBOb3RlIHRoYXQgdGhpcyBpcyBhIGJpdCB0cmlja3kgc2luY2UgZmJkZXYgc2hv
dWxkbid0IHRha2Ugb3ZlciB0aGUNCj4gPiBzY3JlZW4gYnkgZGVmYXVsdCwgc28gd2UnZCBuZWVk
IHRvIGRlbGF5IHRoaXMgdW50aWwgZmlyc3Qgb3BlbiBvZg0KPiA+IC9kZXYvZmIwLiBBbmQgd2Ug
c2hvdWxkIHByb2JhYmx5IGFsc28gZGVsYXkgdGhlIGhvdHBsdWcgaGFuZGxpbmcgdW50aWwNCj4g
PiB0aGUgZmlyc3Qgb3Blbi4gZmJjb24gYWxzbyBmYWtlLW9wZW5zIHRoZSBmYmRldiBmaWxlLCBz
byBpdCdzIHRoZSBzYW1lDQo+ID4gY29kZSBwYXRoLg0KPiANCj4gQXMgZmFyIGFzIEkgdW5kZXJz
dGFuZCB0aGUgY29tbWl0IG1lc3NhZ2UsIHRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIGRpc3BsYXkN
Cj4gYmxhbmtzIG91dCBhZnRlciByZWdpc3RlcmluZyB0aGUgZHJpdmVyLiBBbmQgZmJkZXYgc29t
ZXdoYXQgbWl0aWdhdGVzIHRoaXMgYnkNCj4gZG9pbmcgYW4gZWFybHkgbW9kZXNldC4gVXNlcnMg
d2l0aCBmYmRldiBkaXNhYmxlZCAobW9zdCBvZiB0aGVtIGluDQo+IGVtYmVkZGVkLCBJIGd1ZXNz
KSB3b3VsZCBzdGlsbCBydW4gaW50byB0aGUgaXNzdWUgdW50aWwgdXNlcnNwYWNlIG1ha2VzIGEN
Cj4gbW9kZXNldC4NCj4gDQo+IE1hcmssIGlmIHRoYXQncyB0aGUgY2FzZSwgYW4gb3B0aW9uIG1p
Z2h0IGJlIHRvIHBpY2sgdXAgdGhlIGRldmljZSBzZXR0aW5ncw0KPiBpbnN0ZWFkIG9mIGNhbGxp
bmcgZHJtX21vZGVfY29uZmlnX3Jlc2V0KCkuIFRoZSBkcml2ZXIgd291bGQgdGhlbiBjb250aW51
ZQ0KPiB0byBkaXNwbGF5IHdoYXRldmVyIGlzIG9uIHRoZSBzY3JlZW4uDQoNCldlIGFyZSBzdGFy
dGVkIHVzaW5nIGZiZGV2IGluIG91ciBlbWJlZGRlZCBhcHBsaWNhdGlvbiB3aXRoIExpbnV4IDMu
MTAsIGxhdGVyDQp1cGRhdGVkIHRvIDQuMTQgYW5kIGFyZSBub3cgaW4gdGhlIHByb2Nlc3Mgb2Yg
dXBkYXRpbmcgdG8gNS40LiBTbyBmYXIgdGhlIHVhcGkNCmFwcGVhcmVkIHRvIHVzIGFzIGlmIHdl
IGNvdWxkIHJlbHkgb24gYW4gYWxyZWFkeSBlbmFibGVkIGZiZGV2LiBUaGF0IGlzLCBub25lDQpv
ZiBvdXIgYXBwbGljYXRpb25zIGRvZXMgYSBtb2Rlc2V0Lg0KDQpXaGVuIHN3aXRjaGluZyB0byA1
LjQgd2Ugbm90aWNlZCB0aGF0IHRoZSBmYmRldiB1YXBpIGNoYW5nZWQuIFRoYXQgaXMsIHRoZQ0K
TENEIGlzIHN3aXRjaGVkIG9mZiB1bnRpbCBpdCBpcyBleHBsaWNpdGx5IGVuYWJsZWQuIEl0IGNv
dWxkIGJlIGVuYWJsZWQgYnkNCndyaXRpbmcgdG8gL3N5cy9jbGFzcy9ncmFwaGljcy9mYjAvYmxh
bmsuDQoNCllvdSBhcmUgcmlnaHQsIHdlIGFyZSBub3QgdXNpbmcgZmJjb24uIGZiY29uIHdpbGwg
c3RpbGwgZW5hYmxlIHRoZSBMQ0QgYnV0IGluIG91cg0KZW1iZWRkZWQgZG9tYWluIHdlIGhhdmUg
aXQgZGlzYWJsZWQgYmVjYXVzZSB3ZSBtdXN0IG5vdCBzaG93IGEgY29uc29sZS4NCg0KRG8gd2Ug
dW5kZXJzdGFuZCB5b3VyIHByb3Bvc2FsIGNvcnJlY3RseSB0byByZXBsYWNlIHRoZSBjYWxsIHRv
DQpkcm1fbW9kZV9jb25maWdfcmVzZXQoKSBpbiBpbXhfZHJtX2JpbmQoKSBbaW14LWRybS1jb3Jl
LmNdIHdpdGggcGlja2luZyB1cA0KdGhlIGRldmljZSBzZXR0aW5ncyBpbnN0ZWFkPw0KDQpodHRw
czovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4xMC1yYzQvc291cmNlL2RyaXZlcnMvZ3B1
L2RybS9pbXgvaW14LWRybS1jb3JlLmMjTDIzMQ0KDQpXZSBhcmUgYSBsaXR0bGUgY2x1ZWxlc3Mg
cmlnaHQgbm93OiBIb3cgZG8gd2UgcGljayB1cCB0aGUgZGV2aWNlIHNldHRpbmdzPw0KDQpHcmVl
dGluZ3MsDQpNYXJrDQo=
