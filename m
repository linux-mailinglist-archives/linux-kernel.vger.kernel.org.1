Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B902D074A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 22:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgLFVVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 16:21:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60218 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgLFVVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 16:21:51 -0500
Message-Id: <20201206211253.919834182@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607289669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=78N4YASvionDygjdJyxpH+khdroZX1Ca/lN2xuO3Y+M=;
        b=r7sQkm/veKSNzQ6fxPvYm3vlaeWpCUtPTa5aRm10eaeGhHLMt+y4PAvPpz2OJnDCmxgPCC
        CHNe+1Hl9MSBLIdTlj0x75orMs9r4swadUt8M8cVFQAgxXF12HkQ71pii6RF2mq790Hwi9
        Niu5x6sN5uatbQinrOC/gyWbUpBeh4H8ivJFXsUTJz8IJw9ZIg+eX1qIRBMvkg7yfbvRUo
        R6pdxXV64EGI6IP3jN5+f0rUilkaZGkthUFvtUJT8/u27V64IPJD5YV8AdwAnbqzu9ndSc
        dB4zpHu8IXFTI3jLrvkJmwi0gZdYry/QrI+RKRIX8JJp3jEHgDKIaJgqm+FOCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607289669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=78N4YASvionDygjdJyxpH+khdroZX1Ca/lN2xuO3Y+M=;
        b=fsGxexKcdre6NZN28kfKMYYZOFmprN0Cqj36djKUUjxh2OG1WOq52sGCGjyrJbxbXgWjVZ
        GMVraCblJdmuMRCg==
Date:   Sun, 06 Dec 2020 22:12:53 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [patch 0/3] tick: Annotate and document the intentionaly racy
 tick_do_timer_cpu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgaGF2ZSBiZWVuIHNldmVyYWwgcmVwb3J0cyBhYm91dCBLQ1NBTiBjb21wbGFpbnRzIHZz
LiB0aGUgcmFjeSBhY2Nlc3MKdG8gdGlja19kb190aW1lcl9jcHUuIFRoZSBzeXpib3QgbW9kZXJh
dGlvbiBxdWV1ZSBoYXMgdGhyZWUgZGlmZmVyZW50CnBhdHRlcm5zIGFsbCByZWxhdGVkIHRvIHRo
aXMuIFRoZXJlIGFyZSBhIGZldyBtb3JlLi4uCgpBcyBJIGtub3cgdGhhdCB0aGlzIGlzIGludGVu
dGlvbmFsIGFuZCBzYWZlLCBJIGRpZCBub3QgcGF5IG11Y2ggYXR0ZW50aW9uCnRvIGl0LCBidXQg
TWFyY28gYWN0dWFsbHkgbWFkZSBtZSBmZWVsIGJhZCBhIGZldyBkYXlzIGFnbyBhcyBoZSBleHBs
YWluZWQKdGhhdCB0aGVzZSBpbnRlbnRpb25hbCByYWNlcyBnZW5lcmF0ZSB0b28gbXVjaCBub2lz
ZSB0byBnZXQgdG8gdGhlCmRhbmdlcm91cyBvbmVzLgoKVGhlcmUgd2FzIGFuIGVhcmxpZXIgYXR0
ZW1wdCB0byBqdXN0IHNpbGVuY2UgS0NTQU4gYnkgc2xhcHBpbmcgUkVBRC9XUklURQpvbmNlIGFs
bCBvdmVyIHRoZSBwbGFjZSB3aXRob3V0IGV2ZW4gdGhlIGZhaW50aWVzdCBhdHRlbXB0IG9mIHJl
YXNvbmluZywKd2hpY2ggaXMgZGVmaW5pdGVseSB0aGUgd3JvbmcgdGhpbmcgdG8gZG8uCgpUaGUg
YmFkIHRoaW5nIGFib3V0IHRpY2tfZG9fdGltZXJfY3B1IGlzIHRoYXQgaXRzIG9ubHkgYmFyZWx5
IGRvY3VtZW50ZWQKd2h5IGl0IGlzIHNhZmUgYW5kIHdvcmtzIGF0IGFsbCwgd2hpY2ggbWFrZXMg
aXQgZXh0cmVtbHkgaGFyZCBmb3Igc29tZW9uZQpub3QgcmVhbGx5IGZhbWlsaWFyIHdpdGggdGhl
IGNvZGUgdG8gY29tZSB1cCB3aXRoIHJlYXNvbmluZy4KClNvIE1hcmNvIG1hZGUgbWUgZmFzdCBm
b3J3YXJkIHRoYXQgaXRlbSBpbiBteSB0b2RvIGxpc3QgYW5kIEkgaGF2ZSB0byBhZG1pdAp0aGF0
IGl0IHdvdWxkIGhhdmUgYmVlbiBkYW1uZWQgaGVscGZ1bCBpZiB0aGF0IEdsZWl4bmVyIGR1ZGUg
d291bGQgaGF2ZQphZGRlZCBwcm9wZXIgY29tbWVudHMgaW4gdGhlIGZpcnN0IHBsYWNlLiBXb3Vs
ZCBoYXZlIHNwYXJlZCBhIGxvdCBvZiBicmFpbgp0d2lzdGluZy4gOikKClN0YXJpbmcgYXQgYWxs
IHVzYWdlIHNpdGVzIHVuZWFydGhlZCBhIGZldyBzaWxseSB0aGluZ3Mgd2hpY2ggYXJlIGNsZWFu
ZWQKdXAgdXBmcm9udC4gVGhlIGFjdHVhbCBhbm5vdGF0aW9uIHVzZXMgZGF0YV9yYWNlKCkgd2l0
aCBwcm9wZXIgY29tbWVudHMgYXMKUkVBRC9XUklURV9PTkNFKCkgZG9lcyBub3QgcmVhbGx5IGJ1
eSBhbnl0aGluZyB1bmRlciB0aGUgYXNzdW1wdGlvbiB0aGF0CnRoZSBjb21waWxlciBkb2VzIG5v
dCBwbGF5IHNpbGx5IGJ1Z2dlcnMgYW5kIHRlYXJzIHRoZSAzMmJpdCBzdG9yZXMvbG9hZHMKaW50
byBieXRlIHdpc2Ugb25lcy4gQnV0IGV2ZW4gdGhhdCB3b3VsZCBjYXVzZSBqdXN0IHBvdGVudGlh
bGx5IHNob3J0ZXIKaWRsZSBzbGVlcHMgaW4gdGhlIHdvcnN0IGNhc2UgYW5kIG5vdCBhIGNvbXBs
ZXRlIG1hbGZ1bmN0aW9uLgoKVGhhbmtzLAoKCXRnbHgKLS0tLQogdGljay1jb21tb24uYyB8ICAg
NTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCiB0aWNrLXNjaGVkLmMgIHwgICA5
NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tCiAyIGZpbGVzIGNoYW5nZWQsIDExNyBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkK
