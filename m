Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507D31C5845
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgEEOMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:12:19 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgEEOMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:12:19 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M4JiJ-1jVhJS0JBB-000KCA; Tue, 05 May 2020 16:11:39 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] kcsan: fix section mismatch for __write_once_size/blacklisted_initcalls
Date:   Tue,  5 May 2020 16:11:32 +0200
Message-Id: <20200505141137.665940-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sZ6XTFz2CMPzSBdwXqFLEezhdI6Ey4V6Ow6vBHN3y1kBw7EMdFh
 y5nNhRnXQJ73Pg+qHy/UJHeUVlDg7lkVCQGKEhyeWAy92WId526I8uu/QZro6fYW7ebtZrT
 ul2g/2vxNn9QJr511dIObPohwg3JNFDkoGe6kAj4hn38WAtksBxdNfM0griAJGQc9o9XpQ5
 INo2uJqhRbaGcCB88gHog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RI3Kzrd0e/g=:AIXv0ToRN1k/nvlxAzGBxM
 Tz4lY6vQzIM6rMn48R4pTFOHWdRdvmOBNSQ97XjRhhqf5Yzth2BHoNoKlWdwlPpdHl37rdlFv
 atbnENqa8azxgZkyb2Rly8OxUy4qkvXPc/BeY/pKgqBNFsevVEuVuIivbSPjda3dKrt0Fz1Rp
 zTXt3/HgJVfqyEUERTWfB1pjnIgf6QirPK/namxOZrq+BtKVidVoZ9bldImXck4zuYxp1cgjD
 l/TVoYypaoNIg0mienxNLvJrPfSmm4OMNwhv4GQjYAMIn7mcSHdniKI67YWyqiu5d2KSls9yd
 2XTD4h8sNA017a9Gc6Zx4TV4wgV0EtHXy4xW+f2vZP5mZwZF5+RNAs8WaCnq5z6XiUvaj2+uB
 4XeVo6W3U0UhV+G7iCZ9ctHTZsvKtBm3PHAXqaxPlcCjHx7h9cNI+uTUf2e2k2V9RkeFjMhqw
 ARbWiYYTggSpPtqH8vFbGspdaiBxBWg6iB1SWxZk4K3FDZAVoSX1niVf27VNG0QW907f4giXm
 ETrIGe6sTzhLEx2S9NXsXyPtl2DKPDVM9vBZm4M4WkEo+sPJs07B/KjwugIhlltz3ktOX8qf5
 uFn0h3rYnIecJ/JZq8ZGYLJjZZj9FLiHTM4+8MeT6GFMjLcRQEznClPB0Nbstuxht4qB3L4P0
 xUxT+1WwmnbipawbgfCkvrjBYV/LjNFQlJftcGoPz0JY9TPY45ti69jFaGPV4leHBZyd9eZqe
 28nnXdb2CczmbFMjxXuQKZRWLUeMv5rPijpw+adv8Hmd631RBaTnlUUK/eC2DtkfSx59zR1bB
 ZnFvyifIFRS5cLQL9gJ4Lt8927Zs0oR6upAv3Tb9RxtrE0C4FE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving __write_once_size out of line causes a section mismatch warning
with clang in one instance:

WARNING: modpost: vmlinux.o(.text+0x8dc): Section mismatch in reference from the function __write_once_size() to the variable .init.data:blacklisted_initcalls
The function __write_once_size() references
the variable __initdata blacklisted_initcalls.
This is often because __write_once_size lacks a __initdata
annotation or the annotation of blacklisted_initcalls is wrong.

Remove the __init_or_module annotation from the variable as a workaround.

Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastructure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
So far, my randconfig checks found two such instances, one for read_once
and one for write_once. There are probably a couple more in random
configurations, but I guess they are rare enough that we can just work
around them like this.
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 8f78399697e3..441c384a73cd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1020,7 +1020,7 @@ struct blacklist_entry {
 	char *buf;
 };
 
-static __initdata_or_module LIST_HEAD(blacklisted_initcalls);
+static LIST_HEAD(blacklisted_initcalls);
 
 static int __init initcall_blacklist(char *str)
 {
-- 
2.26.0

