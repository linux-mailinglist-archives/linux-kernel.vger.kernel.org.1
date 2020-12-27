Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9AD2E30A5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgL0Jva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 04:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgL0Jv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 04:51:29 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D769C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 01:50:48 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g24so7248376edw.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 01:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qQQMc4gpk+BWVbmKOe1GnIXN5foF/yNqc6YL4gAgekw=;
        b=vNAsCe+r017QkmV6Wd3USOpUfIPlB5qZ0Dj4YMRw7Zwl9xaLAf2Pt8L8Vj41Og3lHC
         y+2KAS2tcwDwsf/SvgDLSrey6bG0GzxmA5pxYXBEsb0nX4J69HCALAv+mIBziWwb7HQQ
         7ZZ/hd13QZUw/ViJ0SrzE+T/nrb5NuJzHPDKecO/a7XwF3JGIe7ulAJo8i4iT/w5djWG
         oT9WoWmC2KI4T4NBx2c8/9eYhsgbnao6yJojgAswToBWpJIEpbwpD1YCdpIVMWvXcJkt
         YA+f7vyHEV5G0jyAr0XdebM60KW8Dlp5GHgb7Gs0qj+QHyD7tXhCr0QGjX9KlqkNOhPU
         8ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=qQQMc4gpk+BWVbmKOe1GnIXN5foF/yNqc6YL4gAgekw=;
        b=O6iawa8e/HZJ6PWqHgY1Ix9JapsOihrHig/PNHr0EHgis11JuFDkYNVLuOYEm8yJof
         VqV3Z7PsbBKf1LjgFGgWHTxYqc9B+jkrK04g8P5Bguq/Epar3CYrfEGuYkVIbLbOm7EP
         gb2zdPPKe1rp40PPwOR5XVrUVbckI6WCg6fsWS2cU9umKRVR/FKwWnaucgYfxB1smvZE
         9rzG9zod25eEJcKIjfS/Xa1Tc9yDka/pESxWFRbN7QEOg86zEKUQmA8TOQgDfduNxcYC
         Mzxr3fw687DBHyCg7cNCWA9wElt1IA2cxGwNOhilguvuG2XY34h5UD/FWGd1tscShqj2
         PqGA==
X-Gm-Message-State: AOAM533Kvr4QJfdPoqaw37h/5cWI80TmBFb6zsikFW28mnuJDA9PnRAS
        e1Q6EzC3Uv9aJ+sCBQb+SvvgOvwcWEA=
X-Google-Smtp-Source: ABdhPJysro/ivVWqAdBdCVO4T8zAxuY89I1EctsYDg7kbDOejjLwSdVH7CSeXhhygqYD0Afy7rhiSg==
X-Received: by 2002:a50:e848:: with SMTP id k8mr37987221edn.77.1609062647241;
        Sun, 27 Dec 2020 01:50:47 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id qp16sm15871750ejb.74.2020.12.27.01.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 01:50:46 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 27 Dec 2020 10:50:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fixes
Message-ID: <20201227095044.GA1841019@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-12-27

   # HEAD: 91ea62d58bd661827c328a2c6c02a87fa4aae88b softirq: Avoid bad tracing / lockdep interaction

Misc fixes/updates:

- Fix static keys usage in module __init sections
- Add separate MAINTAINERS entry for static branches/calls
- Fix lockdep splat with CONFIG_PREEMPTIRQ_EVENTS=y tracing

 Thanks,

	Ingo

------------------>
Peter Zijlstra (3):
      jump_label: Fix usage in module __init
      jump_label/static_call: Add MAINTAINERS
      softirq: Avoid bad tracing / lockdep interaction


 MAINTAINERS         | 16 ++++++++++++++++
 kernel/jump_label.c |  8 +++++---
 kernel/softirq.c    |  2 +-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 281de213ef47..be02614ad28d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16675,6 +16675,22 @@ M:	Ion Badulescu <ionut@badula.org>
 S:	Odd Fixes
 F:	drivers/net/ethernet/adaptec/starfire*
 
+STATIC BRANCH/CALL
+M:	Peter Zijlstra <peterz@infradead.org>
+M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Jason Baron <jbaron@akamai.com>
+R:	Steven Rostedt <rostedt@goodmis.org>
+R:	Ard Biesheuvel <ardb@kernel.org>
+S:	Supported
+F:	arch/*/include/asm/jump_label*.h
+F:	arch/*/include/asm/static_call*.h
+F:	arch/*/kernel/jump_label.c
+F:	arch/*/kernel/static_call.c
+F:	include/linux/jump_label*.h
+F:	include/linux/static_call*.h
+F:	kernel/jump_label.c
+F:	kernel/static_call.c
+
 STEC S1220 SKD DRIVER
 M:	Damien Le Moal <Damien.LeMoal@wdc.com>
 L:	linux-block@vger.kernel.org
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 015ef903ce8c..c6a39d662935 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -793,6 +793,7 @@ int jump_label_text_reserved(void *start, void *end)
 static void jump_label_update(struct static_key *key)
 {
 	struct jump_entry *stop = __stop___jump_table;
+	bool init = system_state < SYSTEM_RUNNING;
 	struct jump_entry *entry;
 #ifdef CONFIG_MODULES
 	struct module *mod;
@@ -804,15 +805,16 @@ static void jump_label_update(struct static_key *key)
 
 	preempt_disable();
 	mod = __module_address((unsigned long)key);
-	if (mod)
+	if (mod) {
 		stop = mod->jump_entries + mod->num_jump_entries;
+		init = mod->state == MODULE_STATE_COMING;
+	}
 	preempt_enable();
 #endif
 	entry = static_key_entries(key);
 	/* if there are no users, entry can be NULL */
 	if (entry)
-		__jump_label_update(key, entry, stop,
-				    system_state < SYSTEM_RUNNING);
+		__jump_label_update(key, entry, stop, init);
 }
 
 #ifdef CONFIG_STATIC_KEYS_SELFTEST
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 09229ad82209..0f1d3a32d53b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -185,7 +185,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	 * Keep preemption disabled until we are done with
 	 * softirq processing:
 	 */
-	preempt_count_sub(cnt - 1);
+	__preempt_count_sub(cnt - 1);
 
 	if (unlikely(!in_interrupt() && local_softirq_pending())) {
 		/*
