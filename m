Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C82271C87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgIUH7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:59:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:57940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgIUH73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:59:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14EEEB51E;
        Mon, 21 Sep 2020 08:00:03 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>, Petr Tesarik <ptesarik@suse.cz>,
        Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH 24/41] init: call time_init() before rand_initialize()
Date:   Mon, 21 Sep 2020 09:58:40 +0200
Message-Id: <20200921075857.4424-25-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075857.4424-1-nstange@suse.de>
References: <20200921075857.4424-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d55535232c3d ("random: move rand_initialize() earlier") moved the
rand_initialize() invocation from the early initcalls to right after
timekeeping_init(), but before time_init().

However, rand_initialize() would indirectly invoke random_get_entropy(),
which is an alias to get_cycles() on most archs, in case an architectural
RNG is not available. Problem is that on some archs, e.g. ARM,
get_cycles() can only be relied upon when time_init() has completed.

Move the invocation of time_init() a couple of lines up in start_kernel()
so that it gets called before rand_initialize().

Note that random_get_entropy() data doesn't get any entropy credit and
thus, this issue is not to be considered a bug, but more of an
inconsistency.

Fixes: d55535232c3d ("random: move rand_initialize() earlier")
Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index ae78fb68d231..30892675f48e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -942,6 +942,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	hrtimers_init();
 	softirq_init();
 	timekeeping_init();
+	time_init();
 
 	/*
 	 * For best initial stack canary entropy, prepare it after:
@@ -956,7 +957,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	add_device_randomness(command_line, strlen(command_line));
 	boot_init_stack_canary();
 
-	time_init();
 	perf_event_init();
 	profile_init();
 	call_function_init();
-- 
2.26.2

