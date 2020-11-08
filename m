Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03F52AABE2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 16:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgKHPZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 10:25:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46082 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgKHPY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 10:24:56 -0500
Date:   Sun, 08 Nov 2020 15:23:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604849095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qrf++hR9t+iVZvBSBbt+6yRAFOmg6aTRqTUM9CF27eM=;
        b=22wsQ3j87vFUSxOccT6sSaeLgNijO8FMW08f43v/o34gYK6WI8QvIOQFaYDXeRXUV0642r
        DtDnRalDooP9Z0khlMiKy75a+3e/IO4EKb9/Uy+uYPKkq2Ti/fTtTEmI+eHqX5EaBSKGc+
        MwI0yFakpMOyhY/Ewq+F0Jn5GoqSYQAwtI4gpx1iTnyMA+Ga9cgDD3mc5CUqeaWom8959Q
        3I3HRSOkMJZfSnYnba8XEWc740Xwg8Z/mQWyPdeILGbjdcsKf2491Yr+bNui+Mhm8aiUBf
        oIHoeMcQ9qNiPeDsouelBq3RVXkl023DyZgOqNw/KPIuO5ZqjL6YeKFDRkkAPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604849095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qrf++hR9t+iVZvBSBbt+6yRAFOmg6aTRqTUM9CF27eM=;
        b=jutEzjbc/vg0OBZyuvxU9XynY2W2rLJv0VEfd1Znjp+0h08itrnVE4jQTR7BjVMRigegh3
        JR0D0ZrOjCDogYAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for v5.10-rc3
References: <160484899473.4262.9790266201913163807.tglx@nanos>
Message-ID: <160484899834.4262.18402207585184220802.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TGludXMsCgpwbGVhc2UgcHVsbCB0aGUgbGF0ZXN0IHBlcmYvdXJnZW50IGJyYW5jaCBmcm9tOgoK
ICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXAu
Z2l0IHBlcmYtdXJnZW50LTIwMjAtMTEtMDgKCnVwIHRvOiAgN2JkYjE1N2NkZWJiOiBwZXJmL2Nv
cmU6IEZpeCBhIG1lbW9yeSBsZWFrIGluIHBlcmZfZXZlbnRfcGFyc2VfYWRkcl9maWx0ZXIoKQoK
CkEgc2luZ2xlIGZpeCBmb3IgdGhlIHBlcmYgY29yZSBwbHVnZ2luZyBhIG1lbW9yeSBsZWFrIGlu
IHRoZSBhZGRyZXNzIGZpbHRlcgpwYXJzZXIuCgpUaGFua3MsCgoJdGdseAoKLS0tLS0tLS0tLS0t
LS0tLS0tPgpraXlpbijlsLnkuq4pICgxKToKICAgICAgcGVyZi9jb3JlOiBGaXggYSBtZW1vcnkg
bGVhayBpbiBwZXJmX2V2ZW50X3BhcnNlX2FkZHJfZmlsdGVyKCkKCgoga2VybmVsL2V2ZW50cy9j
b3JlLmMgfCAxMiArKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL2V2ZW50cy9jb3JlLmMgYi9rZXJu
ZWwvZXZlbnRzL2NvcmUuYwppbmRleCBkYTQ2N2UxZGQ0OWEuLjVhMjlhYjA5ZTcyZCAxMDA2NDQK
LS0tIGEva2VybmVsL2V2ZW50cy9jb3JlLmMKKysrIGIva2VybmVsL2V2ZW50cy9jb3JlLmMKQEAg
LTEwMDg1LDYgKzEwMDg1LDcgQEAgcGVyZl9ldmVudF9wYXJzZV9hZGRyX2ZpbHRlcihzdHJ1Y3Qg
cGVyZl9ldmVudCAqZXZlbnQsIGNoYXIgKmZzdHIsCiAJCQlpZiAodG9rZW4gPT0gSUZfU1JDX0ZJ
TEUgfHwgdG9rZW4gPT0gSUZfU1JDX0ZJTEVBRERSKSB7CiAJCQkJaW50IGZwb3MgPSB0b2tlbiA9
PSBJRl9TUkNfRklMRSA/IDIgOiAxOwogCisJCQkJa2ZyZWUoZmlsZW5hbWUpOwogCQkJCWZpbGVu
YW1lID0gbWF0Y2hfc3RyZHVwKCZhcmdzW2Zwb3NdKTsKIAkJCQlpZiAoIWZpbGVuYW1lKSB7CiAJ
CQkJCXJldCA9IC1FTk9NRU07CkBAIC0xMDEzMSwxNiArMTAxMzIsMTMgQEAgcGVyZl9ldmVudF9w
YXJzZV9hZGRyX2ZpbHRlcihzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQsIGNoYXIgKmZzdHIsCiAJ
CQkJICovCiAJCQkJcmV0ID0gLUVPUE5PVFNVUFA7CiAJCQkJaWYgKCFldmVudC0+Y3R4LT50YXNr
KQotCQkJCQlnb3RvIGZhaWxfZnJlZV9uYW1lOworCQkJCQlnb3RvIGZhaWw7CiAKIAkJCQkvKiBs
b29rIHVwIHRoZSBwYXRoIGFuZCBncmFiIGl0cyBpbm9kZSAqLwogCQkJCXJldCA9IGtlcm5fcGF0
aChmaWxlbmFtZSwgTE9PS1VQX0ZPTExPVywKIAkJCQkJCSZmaWx0ZXItPnBhdGgpOwogCQkJCWlm
IChyZXQpCi0JCQkJCWdvdG8gZmFpbF9mcmVlX25hbWU7Ci0KLQkJCQlrZnJlZShmaWxlbmFtZSk7
Ci0JCQkJZmlsZW5hbWUgPSBOVUxMOworCQkJCQlnb3RvIGZhaWw7CiAKIAkJCQlyZXQgPSAtRUlO
VkFMOwogCQkJCWlmICghZmlsdGVyLT5wYXRoLmRlbnRyeSB8fApAQCAtMTAxNjAsMTMgKzEwMTU4
LDEzIEBAIHBlcmZfZXZlbnRfcGFyc2VfYWRkcl9maWx0ZXIoc3RydWN0IHBlcmZfZXZlbnQgKmV2
ZW50LCBjaGFyICpmc3RyLAogCWlmIChzdGF0ZSAhPSBJRl9TVEFURV9BQ1RJT04pCiAJCWdvdG8g
ZmFpbDsKIAorCWtmcmVlKGZpbGVuYW1lKTsKIAlrZnJlZShvcmlnKTsKIAogCXJldHVybiAwOwog
Ci1mYWlsX2ZyZWVfbmFtZToKLQlrZnJlZShmaWxlbmFtZSk7CiBmYWlsOgorCWtmcmVlKGZpbGVu
YW1lKTsKIAlmcmVlX2ZpbHRlcnNfbGlzdChmaWx0ZXJzKTsKIAlrZnJlZShvcmlnKTsKIAoK
