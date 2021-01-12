Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B987D2F3696
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392263AbhALRFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391149AbhALRF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:05:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714D5C061786;
        Tue, 12 Jan 2021 09:04:49 -0800 (PST)
Message-Id: <20210112170136.078559026@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610471087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tKnPKgOdjqfVE5gq0YQdeK/yGmcuA2zAsck1bmF/D2g=;
        b=DZu8uG7dTU5Kj0d7WCp3vFU/NgxGwfsBId0ZYpWKrO15VrKfOHQ6VNm/AGD9Py4Zjoack9
        2n+EPNzSvQqfyOwfkk96Z87e4Pq1KmrDUp17O1affQ/OFlq60kvrkgtScr1iU+zVdIkXuK
        m1GyqTRgqqO0eZG6iCqMzaRr1vdmwSNLArKM93EmnsyMUK4caj8oAC6alWjfqVfme4sC/A
        qx6W84y9Q/ntYJbhe9XWeFH2XyVfGdOuRMN8l7qSlw5Yws/H0/dghrl5wfLxZ7RwlyPhW1
        bDTmxl3bJdT7jw3sehfBeQNPG5nsZlR0g4lZxxDRe/u/qWOt47kl3wG1FvJbew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610471087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tKnPKgOdjqfVE5gq0YQdeK/yGmcuA2zAsck1bmF/D2g=;
        b=AKcWVL8y0uJsz/xWkNM+tA6hNPXTIuoAZNyLRkg4cPuyuS0WZRjVpxmVSK2WtpLZB8fv81
        v0zLeIaJtJQT/5AQ==
Date:   Tue, 12 Jan 2021 18:01:36 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andreas Larsson <andreas@gaisler.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [patch 0/4] mm/highmem: Fix fallout from generic kmap_local conversions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGttYXBfbG9jYWwgY29udmVyc2lvbiB3cmVja2FnZWQgc3BhcmMsIG1pcHMgYW5kIHBvd2Vy
cGMgYXMgaXQgbWlzc2VkCnNvbWUgb2YgdGhlIGRldGFpbHMgaW4gdGhlIG9yaWdpbmFsIGltcGxl
bWVudGF0aW9uLgoKVGhlIGZvbGxvd2luZyBzZXJpZXMgYWRkcmVzc2VzIHRoYXQuCgpUaGFua3Ms
CgoJdGdseAotLS0KIGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9oaWdobWVtLmggICAgICB8ICAgIDEg
KwogYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9oaWdobWVtLmggICAgIHwgICAgOSArKysrKy0tLS0K
IGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2hpZ2htZW0uaCB8ICAgIDIgKysKIG1tL2hpZ2ht
ZW0uYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDcgKysrKysrLQogNCBmaWxlcyBjaGFu
Z2VkLCAxNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKCg==
