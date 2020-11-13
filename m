Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B352B1D12
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKMOYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgKMOYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C017EC0613D1;
        Fri, 13 Nov 2020 06:24:15 -0800 (PST)
Message-Id: <20201113140207.499353218@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PPLSKX/xmwMFedV4IKRF5BuAJaVvtEPUqA8f9IDGXCY=;
        b=l6bH+B8+huzeAxpMYHuCQ+BdXfK4ENMqPIutQyozeuaag6I+Pmy6ws+WrwDbEagC3owhXI
        e4kOg45yiOiOBMpnbUwvzjw1Tlx6yx4Ye3qjtp2kB3pq0AXDAY0An3a6gQMMuvB9iI5QfZ
        6TZbWH8hO0g2VO+IUwYA8+zv2sktar1yVgv1Xh66xRbP5r7MCuWHWzeEHg1Yb8Gaiy1nqx
        B7O33xFns3qON2zrMoRmKB6KwXQMe40ktnUKHoQlcuNns3+6hSrP50xwIMejS/s24v7nt2
        +SpT+tCx3yonhfxcC3z29pyyJjzqseiDZ6UACrnYcf5sbVrhUdT9ZIS6cWp21w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PPLSKX/xmwMFedV4IKRF5BuAJaVvtEPUqA8f9IDGXCY=;
        b=AtBmIxr4B4x8cNg20chnLUnH8GQLpcWJEzBvaxV/w167Qbq0G7oSGl8oTsx7v+PGYUbpun
        UEH3CJUGQMXh0FBQ==
Date:   Fri, 13 Nov 2020 15:02:07 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [patch 00/19] softirq: Cleanups and RT awareness
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UlQgcnVucyBzb2Z0aXJxIHByb2Nlc3NpbmcgYWx3YXlzIGluIHRocmVhZCBjb250ZXh0IGFuZCBp
dCByZXF1aXJlcyB0aGF0CmJvdGggdGhlIHNvZnRpcnEgZXhlY3V0aW9uIGFuZCB0aGUgQkggZGlz
YWJsZWQgc2VjdGlvbnMgYXJlIHByZWVtcHRpYmxlLgoKVGhpcyBpcyBhY2hpZXZlZCBieSBzZXJp
YWxpemF0aW9uIHRocm91Z2ggcGVyIENQVSBsb2NhbCBsb2NrcyBhbmQKc3Vic3RpdHV0aW5nIGEg
ZmV3IHBhcnRzIG9mIHRoZSBleGlzdGluZyBzb2Z0aXJxIHByb2Nlc3NpbmcgY29kZSB3aXRoCmhl
bHBlciBmdW5jdGlvbnMuCgpUaGUgZm9sbG93aW5nIHNlcmllcyBoYXMgdHdvIHBhcnRzOgoKICAg
IDEpIENsZWFudXAgaXJxX2NwdXN0YXRzIGFuZCBjb25zb2xpZGF0aW9uIG9mIHRoZSBwcmVlbXB0
IGNvdW50IG1hemUKICAgICAgIHNvIHNvZnRpcnFfY291bnQoKSBhbmQgcmVsYXRlZCBwYXJ0cyBj
YW4gYmUgc3Vic3RpdHV0ZWQgZm9yIFJUCgogICAgMikgVGhlIGFjdHVhbCBjb3JlIGltcGxlbWVu
dGF0aW9uIGluY2x1ZGluZyB0aGUgcmVxdWlyZWQgZml4dXBzIGZvcgogICAgICAgTk9IWiwgUkNV
IGFuZCB0YXNrbGV0cy4KClRoZSBzZXJpZXMgaXMgYWxzbyBhdmFpbGFibGUgZnJvbSBnaXQ6Cgog
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90Z2x4L2RldmVs
LmdpdCBzb2Z0aXJxCgpUaGUgUlQgdmFyaWFudCBoYXMgc3VjZXNzZnVsbHkgYmVlbiB0ZXN0ZWQg
aW4gdGhlIGN1cnJlbnQgNS4xMC1ydApwYXRjaGVzLiBGb3Igbm9uLVJUIGtlcm5lbHMgdGhlcmUg
aXMgbm8gZnVuY3Rpb25hbCBjaGFuZ2UuCgpUaGFua3MsCgoJdGdseAotLS0KIGIvYXJjaC9hcm0v
aW5jbHVkZS9hc20vaGFyZGlycS5oICAgIHwgICAxMSAKIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20v
aXJxLmggICAgICAgIHwgICAgMiAKIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9oYXJkaXJxLmgg
IHwgICAgNyAKIGIvYXJjaC9wYXJpc2MvaW5jbHVkZS9hc20vaGFyZGlycS5oIHwgICAgMSAKIGIv
YXJjaC9zaC9pbmNsdWRlL2FzbS9oYXJkaXJxLmggICAgIHwgICAxNCAtCiBiL2FyY2gvc2gva2Vy
bmVsL2lycS5jICAgICAgICAgICAgICB8ICAgIDIgCiBiL2FyY2gvc2gva2VybmVsL3RyYXBzLmMg
ICAgICAgICAgICB8ICAgIDIgCiBiL2FyY2gvdW0vaW5jbHVkZS9hc20vaGFyZGlycS5oICAgICB8
ICAgMTcgLQogYi9pbmNsdWRlL2FzbS1nZW5lcmljL2hhcmRpcnEuaCAgICAgfCAgICA2IAogYi9p
bmNsdWRlL2xpbnV4L2JvdHRvbV9oYWxmLmggICAgICAgfCAgICA4IAogYi9pbmNsdWRlL2xpbnV4
L2hhcmRpcnEuaCAgICAgICAgICAgfCAgICAxIAogYi9pbmNsdWRlL2xpbnV4L2ludGVycnVwdC5o
ICAgICAgICAgfCAgIDEzIC0KIGIvaW5jbHVkZS9saW51eC9wcmVlbXB0LmggICAgICAgICAgIHwg
ICAzNiArLS0KIGIvaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5oICAgICAgICAgIHwgICAgMyAKIGIv
aW5jbHVkZS9saW51eC9zY2hlZC5oICAgICAgICAgICAgIHwgICAgMyAKIGIva2VybmVsL3NvZnRp
cnEuYyAgICAgICAgICAgICAgICAgIHwgIDQxMiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0KIGIva2VybmVsL3RpbWUvdGljay1zY2hlZC5jICAgICAgICAgIHwgICAgMiAKIGlu
Y2x1ZGUvbGludXgvaXJxX2NwdXN0YXQuaCAgICAgICAgIHwgICAyOCAtLQogMTggZmlsZXMgY2hh
bmdlZCwgNDA1IGluc2VydGlvbnMoKyksIDE2MyBkZWxldGlvbnMoLSkKCgoKCgoK
