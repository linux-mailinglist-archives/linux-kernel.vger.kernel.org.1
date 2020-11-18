Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71122B861A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKRU6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:58:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57522 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgKRU6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:58:33 -0500
Message-Id: <20201118194838.753436396@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605733111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0069BgO4zunZ3BCjdQm1WHTDs++SOImFblflaj//gkw=;
        b=TJRKGnvplKgd6QcumiiUu9p4bIhWKnGhSBpOEvBNwv6IK7UoCTR9JjruR8MKTzVfEnWokz
        dgyJfqaLS2oWCxqVU0xc5amAXQNcLSDYRdR32Z1OWllWjgHOqah0sVTWlG+ar2KgqqcyEQ
        6YygJeSSkT/GqAKKzn4CfYviux/CSACm9jOsQ8L+k+fo7omgj1+dpeF+sRccDCBz+XkJLw
        gA6OjnfbYepJeTyrCrbWhJIIG4cTyJnhte18zOLGKk5iRO+VVrfY6VDU4w94wZN70g1ulu
        ZUE9VreELU9M6+hwihFVhZJ2OVoYYwLSg3p8apwj2bv24Artqqp5wf8jJuXquA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605733111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0069BgO4zunZ3BCjdQm1WHTDs++SOImFblflaj//gkw=;
        b=ybiGAa/BXJpeqCiRjSCJrFO+k32vi+9Bfxy2iNTt/0ERftQSvvXRaysX/WuZi5ysY+YoID
        30gVLTux2uC7vzBA==
Date:   Wed, 18 Nov 2020 20:48:38 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [patch V4 0/8] mm/highmem: Preemptible variant of kmap_atomic & friends
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB0aGUgb3V0c3RhbmRpbmcgc2V0IG9mIHBhdGNoZXMgZm9yIHRoZSBwcmVlbXB0aWJs
ZSBrbWFwXyooKQppbXBsZW1lbnRhdGlvbi4gVGhlIHByZXZpb3VzIHZlcnNpb24gaXMgaGVyZToK
CiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIwMTEwMzA5MjcxMi43MTQ0ODA4NDJAbGlu
dXRyb25peC5kZQoKVGhlIGZvbGxvd2luZyBjaGFuZ2VzIGNvbWUgd2l0aCBpdDoKCiAtIEJldHRl
ciBkZWJ1Z2dpbmcgZm9yIGttYXAqIGJ5IGVuZm9yY2luZyB0aGUgdGVtcG9yYXJ5IG1hcHBpbmdz
IGV2ZW4gZm9yCiAgIGxvd21lbSBwYWdlcyB3aGVuIHRoZSBhcmNoaXRlY3R1cmUgYWxsb3dzIGl0
LgoKIC0gU3VwcG9ydCBmb3IgZW5mb3JjZWQgbWFwcGluZ3Mgb24gWDg2IGZvciBib3RoIDMyIGFu
ZCA2NCBiaXQuIEFzCiAgIEtNQVBfTE9DQUwgaXMgYWxyZWFkeSBpbmRlcGVuZGVudCBmcm9tIEhJ
R0hNRU0gdGhpcyBuZWVkcyBvbmx5IHRoZSBleHRyYQogICBmaXhtYXAgc3BhY2Ugb24gNjRiaXQg
YW5kIG5vIGZ1cnRoZXIgY29kZSBjaGFuZ2VzLgoKIC0gUmVtb3ZpbmcgdGhlIFJUIGRlcGVuZGVu
Y3kgZnJvbSBtaWdyYXRlX2Rpc2FibGUvZW5hYmxlKCkuIFRoaXMgcGF0Y2gKICAgc3RpbGwgbmVl
ZHMgc29tZSBoZWxwIGZyb20gdGhlIHNjaGVkdWxlciBmb2xrcyB2cy4gdGhlIGNvbW1lbnQgaW4K
ICAgcHJlZW1wdC5oLgoKIC0gU3dpdGNoaW5nIGZyb20gcGVyIENQVSBzdG9yYWdlIG9mIHRoZSBr
bWFwIGluZGV4IHRvIGEgcGVyIHRhc2sgc3RvcmFnZQogICBieSBhZGRpbmcgYSBwdGV2YWwgYXJy
YXkgdG8gdGhlIHBlciB0YXNrIHN0b3JhZ2Ugd2hpY2ggY29udGFpbnMgdGhlCiAgIHB0ZXZhbHMg
b2YgdGhlIGN1cnJlbnRseSBhY3RpdmUgdGVtcG9yYXJ5IGttYXBzCgogLSBBZGRpbmcgY29udGV4
dCBzd2l0Y2ggY29kZSB3aGljaCBjaGVja3Mgd2hldGhlciB0aGUgb3V0Z29pbmcgb3IgdGhlCiAg
IGluY29taW5nIHRhc2sgaGFzIGFjdGl2ZSB0ZW1wb3Jhcnkga21hcHMuIElmIHNvLCB0aGUgb3V0
Z29pbmcgdGFzaydzCiAgIGttYXBzIGFyZSByZW1vdmVkIGFuZCB0aGUgaW5jb21pbmcgdGFzaydz
IGttYXBzIGFyZSByZXN0b3JlZC4KCiAtIEFkZGluZyBuZXcgaW50ZXJmYWNlcyBrW3VuXW1hcF9s
b2NhbCooKSB3aGljaCBhcmUgbm90IGRpc2FibGluZwogICBwcmVlbXB0aW9uIGFuZCBjYW4gYmUg
Y2FsbGVkIGZyb20gYW55IGNvbnRleHQgKGV4Y2VwdCBOTUkpLgoKICAgQ29udHJhcnkgdG8ga21h
cCgpIHdoaWNoIHByb3ZpZGVzIHByZWVtcHRpYmxlIGFuZCAicGVyc2lzdGFudCIgbWFwcGluZ3Ms
CiAgIHRoZXNlIGludGVyZmFjZXMgYXJlIG1lYW50IHRvIHJlcGxhY2UgdGhlIHRlbXBvcmFyeSBt
YXBwaW5ncyBwcm92aWRlZCBieQogICBrbWFwX2F0b21pYyooKSB0b2RheS4KClRoaXMgYWxsb3dz
IHRvIGdldCByaWQgb2YgY29uZGl0aW9uYWwgbWFwcGluZyBjaG9pY2VzIGFuZCBhbGxvd3MgdG8g
aGF2ZQpwcmVlbXB0aWJsZSBzaG9ydCB0ZXJtICJtYXBwaW5ncyIgb24gNjRiaXQgd2hpY2ggYXJl
IHRvZGF5IGVuZm9yY2VkIHRvIGJlCm5vbi1wcmVlbXB0aWJsZSBkdWUgdG8gdGhlIGhpZ2htZW0g
Y29uc3RyYWludHMuIEl0IGNsZWFybHkgcHV0cyBvdmVyaGVhZCBvbgp0aGUgaGlnaG1lbSB1c2Vy
cywgYnV0IGhpZ2htZW0gaXMgc2xvdyBhbnl3YXkuCgpUaGlzIGlzIG5vdCBhIHdob2xlc2FsZSBj
b252ZXJzaW9uIHdoaWNoIG1ha2VzIGttYXBfYXRvbWljIG1hZ2ljYWxseQpwcmVlbXB0aWJsZSBi
ZWNhdXNlIHRoZXJlIG1pZ2h0IGJlIHVzYWdlIHNpdGVzIHdoaWNoIHJlbHkgb24gdGhlIGltcGxp
Y2l0CnByZWVtcHQgZGlzYWJsZS4gU28gdGhpcyBuZWVkcyB0byBiZSBkb25lIG9uIGEgY2FzZSBi
eSBjYXNlIGJhc2lzIGFuZCB0aGUKY2FsbCBzaXRlcyBjb252ZXJ0ZWQgdG8ga21hcF9sb2NhbCgp
LgoKQ2hhbmdlcyB2cy4gVjM6CgogICAtIFJlYmFzZWQgb24gdG9wIG9mIHRoZSBtZXJnZWQgY29u
c29saWRhdGlvbiBwYXRjaGVzIGFuZCBvbiB0b3Agb2YKICAgICB0aGUgbGF0ZXN0IHZlcnNpb24g
b2YgbWlncmF0ZSBkaXNhYmxlIHN1cHBvcnQuCgogICAtIE5ldyBkZWJ1ZyBmZWF0dXJlcyAoZW5m
b3JjZWQgbWFwcGluZ3MpCgogICAtIERyb3BwZWQgdGhlIGNvbnZlcnNpb24gcGF0Y2hlcyBhcyB0
aGV5IG5lZWQgcmV2aWV3IGZyb20gdGhlIHJlc3BlY3RpdmUKICAgICBzdWJzeXN0ZW1zIGFuZCBi
ZXR0ZXIgZ28gdGhyb3VnaCB0aGUgcmVsZXZhbnQgdHJlZXMgZm9yIDUuMTIKClRoZSBzZXJpZXMg
aXMgYmFzZWQgb24KCiAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90aXAvdGlwLmdpdCBjb3JlL21tCgp3aXRoCgogICBnaXQ6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQgc2NoZWQvY29yZQoKbWVyZ2VkIGlu
LgoKSXQgaXMgYWxzbyBhdmFpbGFibGUgZnJvbSBnaXQ6CgogICBnaXQ6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQgaGlnaG1lbQoKVGhhbmtz
LAoKCXRnbHgKLS0tCiBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvaW8tbWFwcGluZy5yc3QgfCAg
IDc0ICsrKysrKysrKysrLS0tLS0tLS0KIGFyY2gveDg2L0tjb25maWcgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgIDEgCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9maXhtYXAuaCAgICAgICAgICAg
fCAgIDEyICsrLQogYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZV82NF90eXBlcy5oIHwgICAg
NiArCiBhcmNoL3g4Ni9rZXJuZWwvY3Jhc2hfZHVtcF8zMi5jICAgICAgICAgfCAgIDQ4ICsrLS0t
LS0tLS0tLQogaW5jbHVkZS9hc20tZ2VuZXJpYy9rbWFwX3NpemUuaCAgICAgICAgIHwgICAgMiAK
IGluY2x1ZGUvbGludXgvaGlnaG1lbS1pbnRlcm5hbC5oICAgICAgICB8ICAgNTggKysrKysrKysr
KysrKysrCiBpbmNsdWRlL2xpbnV4L2hpZ2htZW0uaCAgICAgICAgICAgICAgICAgfCAgIDQzICsr
KysrKystLS0tCiBpbmNsdWRlL2xpbnV4L2lvLW1hcHBpbmcuaCAgICAgICAgICAgICAgfCAgIDMw
ICsrKysrKysKIGluY2x1ZGUvbGludXgva2VybmVsLmggICAgICAgICAgICAgICAgICB8ICAgMjEg
KysrLS0KIGluY2x1ZGUvbGludXgvcHJlZW1wdC5oICAgICAgICAgICAgICAgICB8ICAgMzggLS0t
LS0tLS0tLQogaW5jbHVkZS9saW51eC9zY2hlZC5oICAgICAgICAgICAgICAgICAgIHwgICAxMSAr
Kwoga2VybmVsL2VudHJ5L2NvbW1vbi5jICAgICAgICAgICAgICAgICAgIHwgICAgMiAKIGtlcm5l
bC9mb3JrLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgCiBrZXJuZWwvc2NoZWQv
Y29yZS5jICAgICAgICAgICAgICAgICAgICAgfCAgIDYzICsrKysrKysrKysrKysrLS0KIGtlcm5l
bC9zY2hlZC9zY2hlZC5oICAgICAgICAgICAgICAgICAgICB8ICAgIDQgLQogbGliL0tjb25maWcu
ZGVidWcgICAgICAgICAgICAgICAgICAgICAgIHwgICAyMiArKysrKwogbGliL3NtcF9wcm9jZXNz
b3JfaWQuYyAgICAgICAgICAgICAgICAgIHwgICAgMiAKIG1tL2hpZ2htZW0uYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAxMjEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0K
IDE5IGZpbGVzIGNoYW5nZWQsIDQwMCBpbnNlcnRpb25zKCspLCAxNTkgZGVsZXRpb25zKC0pCgoK
Cg==
