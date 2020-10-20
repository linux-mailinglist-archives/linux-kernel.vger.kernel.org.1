Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05237293914
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 12:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbgJTKWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 06:22:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54725 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387481AbgJTKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 06:22:53 -0400
X-UUID: d70848398012476a9c02a0e472c2010d-20201020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VSgu7Klo8fx0JGYoi+cZ90MUhyrA8re2QkAw6EjV12k=;
        b=gsNzHFL2ziH8AfWuPhEpUKu0FK5+clhGsTDW7GqJV4GcAlHSE14X0oLAEMHZb5rdGLaseU/AFsFnGvs3ME0Pjyg/Kg+3bf4mVrS6rpLHuJgYCSPc4DzX8PYyuSPcpvfEMNx//anFP2wQO5HYghMYgYbUAem8PQX5a/PFbypMAe4=;
X-UUID: d70848398012476a9c02a0e472c2010d-20201020
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1894183512; Tue, 20 Oct 2020 18:22:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 20 Oct 2020 18:22:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Oct 2020 18:22:51 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <matthias.bgg@gmail.com>, <akpm@linux-foundation.org>,
        <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH] mm/cma.c: remove redundant cma_mutex lock
Date:   Tue, 20 Oct 2020 18:22:41 +0800
Message-ID: <20201020102241.3729-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGNtYV9tdXRleCB3aGljaCBwcm90ZWN0cyBhbGxvY19jb250aWdfcmFuZ2UoKSB3YXMgZmly
c3QgYXBwZWFyZWQgaW4NCmNvbW1pdCA3ZWU3OTNhNjJmYThjICgiY21hOiBSZW1vdmUgcG90ZW50
aWFsIGRlYWRsb2NrIHNpdHVhdGlvbiIpLA0KYXQgdGhhdCB0aW1lLCB0aGVyZSBpcyBubyBndWFy
YW50ZWUgdGhlIGJlaGF2aW9yIG9mIGNvbmN1cnJlbmN5IGluc2lkZQ0KYWxsb2NfY29udGlnX3Jh
bmdlKCkuDQoNCkFmdGVyIHRoZSBjb21taXQgMmM3NDUyYTA3NWQ0ZGIyZGMNCigibW0vcGFnZV9p
c29sYXRpb24uYzogbWFrZSBzdGFydF9pc29sYXRlX3BhZ2VfcmFuZ2UoKSBmYWlsIGlmIGFscmVh
ZHkgaXNvbGF0ZWQiKQ0KICA+IEhvd2V2ZXIsIHR3byBzdWJzeXN0ZW1zIChDTUEgYW5kIGdpZ2Fu
dGljDQogID4gaHVnZSBwYWdlcyBmb3IgZXhhbXBsZSkgY291bGQgYXR0ZW1wdCBvcGVyYXRpb25z
IG9uIHRoZSBzYW1lIHJhbmdlLiAgSWYNCiAgPiB0aGlzIGhhcHBlbnMsIG9uZSB0aHJlYWQgbWF5
ICd1bmRvJyB0aGUgd29yayBhbm90aGVyIHRocmVhZCBpcyBkb2luZy4NCiAgPiBUaGlzIGNhbiBy
ZXN1bHQgaW4gcGFnZWJsb2NrcyBiZWluZyBpbmNvcnJlY3RseSBsZWZ0IG1hcmtlZCBhcw0KICA+
IE1JR1JBVEVfSVNPTEFURSBhbmQgdGhlcmVmb3JlIG5vdCBhdmFpbGFibGUgZm9yIHBhZ2UgYWxs
b2NhdGlvbi4NClRoZSBjb25jdXJyZW5jeSBpbnNpZGUgYWxsb2NfY29udGlnX3JhbmdlKCkgd2Fz
IGNsYXJpZmllZC4NCg0KTm93IHdlIGNhbiBmaW5kIHRoYXQgaHVnZXBhZ2UgYW5kIHZpcnRpbyBj
YWxsIGFsbG9jX2NvbnRpZ19yYW5nZSgpIHdpdGhvdXQNCmFueSBsb2NrLCB0aHVzIGNtYV9tdXRl
eCBpcyAicmVkdW5kYW50IiBpbiBjbWFfYWxsb2MoKSBub3cuDQoNClNpZ25lZC1vZmYtYnk6IExl
Y29wemVyIENoZW4gPGxlY29wemVyLmNoZW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogbW0vY21hLmMg
fCA0ICstLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9tbS9jbWEuYyBiL21tL2NtYS5jDQppbmRleCA3ZjQxNWQ3Y2RhOWYu
LjM2OTJhMzRlMjM1MyAxMDA2NDQNCi0tLSBhL21tL2NtYS5jDQorKysgYi9tbS9jbWEuYw0KQEAg
LTM4LDcgKzM4LDYgQEANCiANCiBzdHJ1Y3QgY21hIGNtYV9hcmVhc1tNQVhfQ01BX0FSRUFTXTsN
CiB1bnNpZ25lZCBjbWFfYXJlYV9jb3VudDsNCi1zdGF0aWMgREVGSU5FX01VVEVYKGNtYV9tdXRl
eCk7DQogDQogcGh5c19hZGRyX3QgY21hX2dldF9iYXNlKGNvbnN0IHN0cnVjdCBjbWEgKmNtYSkN
CiB7DQpAQCAtNDU0LDEwICs0NTMsOSBAQCBzdHJ1Y3QgcGFnZSAqY21hX2FsbG9jKHN0cnVjdCBj
bWEgKmNtYSwgc2l6ZV90IGNvdW50LCB1bnNpZ25lZCBpbnQgYWxpZ24sDQogCQltdXRleF91bmxv
Y2soJmNtYS0+bG9jayk7DQogDQogCQlwZm4gPSBjbWEtPmJhc2VfcGZuICsgKGJpdG1hcF9ubyA8
PCBjbWEtPm9yZGVyX3Blcl9iaXQpOw0KLQkJbXV0ZXhfbG9jaygmY21hX211dGV4KTsNCiAJCXJl
dCA9IGFsbG9jX2NvbnRpZ19yYW5nZShwZm4sIHBmbiArIGNvdW50LCBNSUdSQVRFX0NNQSwNCiAJ
CQkJICAgICBHRlBfS0VSTkVMIHwgKG5vX3dhcm4gPyBfX0dGUF9OT1dBUk4gOiAwKSk7DQotCQlt
dXRleF91bmxvY2soJmNtYV9tdXRleCk7DQorDQogCQlpZiAocmV0ID09IDApIHsNCiAJCQlwYWdl
ID0gcGZuX3RvX3BhZ2UocGZuKTsNCiAJCQlicmVhazsNCi0tIA0KMi4xOC4wDQo=

