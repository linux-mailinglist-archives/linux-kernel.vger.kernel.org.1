Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541C82C4880
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgKYThX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgKYThW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:37:22 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E07EC061A51
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:37:22 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id r9so3286139ioo.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KO/M/u0SKyAHiDpRJL18ynfwCIfU26Y/ceTy3bOazY=;
        b=VfNp8/1QKA/Nsh0aFCVcwN1562EED1Jd2vd71rfujQQeoL5LCoATCM/VgE8sCyaGfg
         ZtiRD+8DK8eBG2O/8GKjCH7qz63Lw0OGUHNihV+c9AsGOIxTFK7t60TLY5qD61vky1R6
         wwjsw2pUiecEeaJmg6tjo3FtR5hP3NtwZO78RQYrlpotqkGtBIMbVz8Pa6kDxxUSM/MF
         696JIsVhJHqONalD5rWOqJzskVfW6efhU9soy4C4WpB3ZDlgkTq58nJnSJW6yJR/HGIl
         2gw3BZcHGZxgPF9HkhXPbHzYXsA55JU/b/6gZExoATdGPSU/Z9wued0PmZMsQqpXBtWS
         ZbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KO/M/u0SKyAHiDpRJL18ynfwCIfU26Y/ceTy3bOazY=;
        b=lIt+VgTSzsdNUl3jbLvjR2mXaxlYPJ0pcoOFl4nPuQL8g0rv8IRuixkk/4y8qD2SeV
         XMEcdgJaTIo/CoJ+bNi3mankW8+1i0qsFm4zC0ovB6TmjP73rP3Cu6jvDkp/oRbgnDAU
         imJl78YKyp3CYUIVozo87YYXFl4A00hgyJjEPSW2X1yNsBo27vE/t+mU7HwrrG/13ejm
         BrJ/M2T1U7zG49hlB2efWeDBpLPrWHxLBuvIeNu1R+/nD2KoWHO14PWK6rOJEauPHbJb
         7ViePSgGgW8Uu3pQwzwkUjBeUDZZftJLUGkiYUjmUVcoefAqqYoHIJ+P+vvCk0yGwtaA
         vFdg==
X-Gm-Message-State: AOAM5325l3NzCKcfzfwk+kSeJDqxKadPd7r6wmkiErcAWUV2J1UN3Scz
        8YEkm7MpjexiP4V6rREOeuo=
X-Google-Smtp-Source: ABdhPJxerGLSlABi7avZmWHb6tL0Sa17Gu8SHBI7l4xXs/pdWZOr7Zg3dgBc1LVoiYuV/2Z9rUYrIw==
X-Received: by 2002:a6b:6418:: with SMTP id t24mr3908358iog.145.1606333041808;
        Wed, 25 Nov 2020 11:37:21 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id f8sm1435548ioc.24.2020.11.25.11.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:37:21 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-mm@kvack.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] dyndbg: add some code to see alignments of linkage data
Date:   Wed, 25 Nov 2020 12:36:22 -0700
Message-Id: <20201125193626.2266995-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201125193626.2266995-1-jim.cromie@gmail.com>
References: <20201125193626.2266995-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to use LSB-stealing (lsb as flag, mask b4 addressing), we
need to know that the alignments of existing data is never odd.  So
add code to check the alignment of pointers in _dyndbg_callsites
section.

It turns out that all these fields point to a variety of odd
alignments in the deeper linkage data.  We will need ALIGN(2) to allow
use of LSB to signal the EOT of differing-tail records.

[    0.587654] dyndbg: 2014 entries. \
     	       repeated entries: 1789 module 1667 file 809 func
[    0.588653] dyndbg: mod aligns:
[    0.589130] dyndbg:   align 0 0: 107
[    0.589653] dyndbg:   align 0 1: 210
[    0.590271] dyndbg:   align 0 2: 234
[    0.590652] dyndbg:   align 0 3: 179
[    0.591224] dyndbg:   align 0 4: 358
[    0.591652] dyndbg:   align 0 5: 374
[    0.592283] dyndbg:   align 0 6: 231
[    0.592653] dyndbg:   align 0 7: 321
[    0.593203] dyndbg:  mod align totals: 2014
[    0.593652] dyndbg: file aligns:
[    0.594168] dyndbg:   align 1 0: 569
[    0.594652] dyndbg:   align 1 1: 172
[    0.595179] dyndbg:   align 1 2: 263
[    0.595652] dyndbg:   align 1 3: 252
[    0.596368] dyndbg:   align 1 4: 200
[    0.596652] dyndbg:   align 1 5: 126
[    0.597327] dyndbg:   align 1 6: 177
[    0.597669] dyndbg:   align 1 7: 255
[    0.598316] dyndbg:  file align totals: 2014
[    0.598652] dyndbg: func aligns:
[    0.599214] dyndbg:   align 2 0: 2006
[    0.599652] dyndbg:   align 2 1: 7
[    0.600168] dyndbg:   align 2 2: 0
[    0.600648] dyndbg:   align 2 3: 0
[    0.600652] dyndbg:   align 2 4: 0
[    0.601105] dyndbg:   align 2 5: 0
[    0.601652] dyndbg:   align 2 6: 0
[    0.602203] dyndbg:   align 2 7: 1
[    0.602654] dyndbg:  func align totals: 2014
[    0.603431] dyndbg: format aligns:
[    0.603658] dyndbg:   align 3 0: 1053
[    0.604429] dyndbg:   align 3 1: 134
[    0.604653] dyndbg:   align 3 2: 161
[    0.605181] dyndbg:   align 3 3: 142
[    0.605652] dyndbg:   align 3 4: 137
[    0.606250] dyndbg:   align 3 5: 117
[    0.606652] dyndbg:   align 3 6: 124
[    0.607183] dyndbg:   align 3 7: 146
[    0.608669] dyndbg: earlyprintk="serial,ttyS0,115200"

This means low order bits are unavailable for encoding extra info, as
is done in struct static_key.

Consider the last lines of /proc/dynamic_debug/control, here with
matching fields replaced by '^'.  The pattern here is common head(s)
& differing tail(s).

init/main.c main run_init_process "    %s\012" 1339
^ ^ ^ "  with environment:\012" 1337
^ ^ ^ "    %s\012" 1336
^ ^ ^ "  with arguments:\012" 1334
^ ^ initcall_blacklisted "initcall %s blacklisted\012" 1123
^ ^ initcall_blacklist "blacklisting initcall %s\012" 1084

struct ddebug_callsite fields [mod, file, func, format] are 4-tuples;
each element points at different kinds/sources of linkage data
(&module->name, __FILE__, __FUNC__, format-strings).

callsite-tails are 4,3,2,1-tuples, with matching heads removed.

If we can force ALIGN(2) on all those linkage data sources, then we
can use +1 to mark the Beginning-Of-Tuple (or EOT), and so distinguish
amongst the N-tuples, and reconstruct each record by copying and
changing the previous record.  Each new module block starts with a
4-tuple; the init/main example block above is a 4,1,1,1,2,2-tuple
sequence, using 11/24 of the space.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5980d44ff2f8..c84efb4e036b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1079,6 +1079,13 @@ static int __init dynamic_debug_init_control(void)
 	return 0;
 }
 
+
+static __initdata int alignments[4][8];
+static void bump_ct(int i, const char *p)
+{
+	alignments[i][ (long)p & 7 ]++;
+}
+
 static int __init dynamic_debug_init(void)
 {
 	struct _ddebug *iter, *iter_start, *prev = NULL;
@@ -1087,7 +1094,9 @@ static int __init dynamic_debug_init(void)
 	int ret = 0;
 	int n = 0, entries = 0, modct = 0;
 	int modreps = 0, funcreps = 0, filereps = 0;
-
+	int i,k;
+	char *kind[] = { "mod","file","func","format" };
+	
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
 			pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
@@ -1111,6 +1120,12 @@ static int __init dynamic_debug_init(void)
 			prev++; /* one behind iter */
 		}
 		entries++;
+
+		bump_ct(0, iter->site->modname);
+		bump_ct(1, iter->site->filename);
+		bump_ct(2, iter->site->function);
+		bump_ct(3, iter->site->format);
+
 		if (strcmp(modname, iter->site->modname)) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
@@ -1135,6 +1150,16 @@ static int __init dynamic_debug_init(void)
 	vpr_info("%d entries. repeated entries: %d module %d file %d func\n",
 		 entries, modreps, filereps, funcreps);
 
+	/* display alignment info on fields */
+	for (i=0; i<4; i++) {
+		k = 0;
+		vpr_info("%s aligns:\n", kind[i]);
+		for (n=0; n<8; n++) {
+			vpr_info("  align %d %d: %d\n", i, n, alignments[i][n]);
+			k += alignments[i][n];
+		}
+		vpr_info(" %s align totals: %d\n", kind[i], k);
+	}
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
 		pr_warn("ddebug_query param name is deprecated, change it to dyndbg\n");
-- 
2.28.0

