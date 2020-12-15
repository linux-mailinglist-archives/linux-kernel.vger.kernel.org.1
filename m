Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC8A2DA8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 08:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgLOHuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 02:50:09 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2334 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgLOHuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 02:50:04 -0500
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Cw9Ng6lRgz13TtD;
        Tue, 15 Dec 2020 15:48:19 +0800 (CST)
Received: from DGGEML510-MBX.china.huawei.com ([169.254.2.9]) by
 dggeml405-hub.china.huawei.com ([10.3.17.49]) with mapi id 14.03.0487.000;
 Tue, 15 Dec 2020 15:49:15 +0800
From:   wanghuiqiang <wanghuiqiang@huawei.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Ard Biesheuvel" <ardb@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGlycWNoaXAvZ2ljLXYzOiBDaGVjayBTUkUgYml0?=
 =?utf-8?Q?_for_GICv2_legacy_support?=
Thread-Topic: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
Thread-Index: AQHWxwN3YOmayqAkS0a1b5qHlXVEh6ngmnQAgAABpXCAACfogIAABzIwgAA00gCAAnf7sIAUZQBA
Date:   Tue, 15 Dec 2020 07:49:15 +0000
Message-ID: <07084A11A8AB5A40A40B0218FE6F1CCA0F59630F@dggeml510-mbx.china.huawei.com>
References: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
 <f8a97f360073fa495cae75acc11ecf4f@kernel.org>
 <85bb389a75f347d29ab3f75e4cfae060@huawei.com>
 <846387e4168f1a22638ad07ae670c531@kernel.org>
 <e93770e46c73413882584ebc3fe732e3@huawei.com>
 <CAMj1kXGdEbDzFN2cCNpCx_QJk3++v3zrWZ7Yw08Exrzyy_Q97w@mail.gmail.com>
 <931f76fa185e488fb9e942b2026ae7be@huawei.com>
In-Reply-To: <931f76fa185e488fb9e942b2026ae7be@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.183.14]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgcmVzcG9uc2UgbGF0ZS4NCkhpIFNoYW1lZXIgJiBBcmQsDQoNCkNvdWxkIHlvdSBsZXQg
bWUga25vdyB3aGljaCBmaXJtd2FyZSB5b3UgYXJlIHVzaW5nPyBJZiB0aGUgZGlmZmVyZW5jZSBp
cyBNYWR0IHRhYmxlIHZHSUMgeW91ciBwb2ludGVkICwgdGhleSBhcmUgdGhlIHNhbWUuIFdlIGNo
YW5nZWQgdGhlIHZHSUMgbWVtb3J5IGJhc2UgYWRkcmVzcyBhdCB2ZXJ5IGVhcmx5IGRlc2lnbiBz
dGFnZS4NCg0KVGhhbmtz77yBIA0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6
IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgDQrlj5HpgIHml7bpl7Q6IDIwMjDlubQxMuaciDLm
l6UgMTY6MjMNCuaUtuS7tuS6ujogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCuaK
hOmAgTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz47IGVyaWMuYXVnZXJAcmVkaGF0LmNv
bTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IHdhbmdodWlxaWFu
ZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+OyB4dXdlaSAoTykgPHh1d2VpNUBodWF3ZWkuY29t
Pg0K5Li76aKYOiBSRTogW1BBVENIXSBpcnFjaGlwL2dpYy12MzogQ2hlY2sgU1JFIGJpdCBmb3Ig
R0lDdjIgbGVnYWN5IHN1cHBvcnQNCg0KWytdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQXJkIEJpZXNoZXV2ZWwgW21haWx0bzphcmRiQGtlcm5lbC5vcmddDQo+IFNl
bnQ6IDMwIE5vdmVtYmVyIDIwMjAgMTg6MzINCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhv
ZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gQ2M6IE1hcmMgWnlu
Z2llciA8bWF6QGtlcm5lbC5vcmc+OyBlcmljLmF1Z2VyQHJlZGhhdC5jb207IA0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IA0KPiBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gaXJxY2hpcC9naWMtdjM6IENoZWNrIFNSRSBiaXQgZm9yIEdJQ3YyIGxlZ2FjeSANCj4g
c3VwcG9ydA0KPiANCi4uLg0KDQo+IA0KPiBBbnkgY2x1ZSB3aHkgcHJvZHVjdGlvbiBEMDYgZmly
bXdhcmUgZGV2aWF0ZXMgZnJvbSB0aGUgRDA2IHBvcnQgdGhhdCANCj4gZXhpc3RzIGluIFRpYW5v
Y29yZSdzIGVkazItcGxhdGZvcm1zIHJlcG9zaXRvcnk/IEJlY2F1c2UgdGhhdCB2ZXJzaW9uIA0K
PiBkb2VzIG5vdCBoYXZlIHRoaXMgYnVnLCBhbmQgSSB3b25kZXIgd2h5IHRoYXQgY29kZSB3YXMg
dXBzdHJlYW1lZCBhdCANCj4gYWxsIGlmIGEgc3Vic3RhbnRpYWxseSBkaWZmZXJlbnQgdmVyc2lv
biBnZXRzIHNoaXBwZWQgd2l0aCBwcm9kdWN0aW9uIA0KPiBoYXJkd2FyZS4NCg0KT2suIFRoYW5r
cyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuIEkgaGF2ZSBpbmZvcm1lZCBvdXIgVUVGSSB0ZWFtIGFi
b3V0IHRoaXMuDQpUaGV5IHdpbGwgY2hlY2sgSW50ZXJuYWxseSBhbmQgY2xhcmlmeS4NCg0KUmVn
YXJkcywNClNoYW1lZXINCg==
