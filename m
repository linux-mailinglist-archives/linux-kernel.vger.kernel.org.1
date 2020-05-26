Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57601CC61C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 04:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgEJCBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 22:01:46 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:51158 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgEJCBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 22:01:46 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 04A20oRe019447;
        Sun, 10 May 2020 11:00:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 04A20oRe019447
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589076052;
        bh=rJP2b3m7YpXHpek6yW9rO6PfF4Mu2xGZn7YuDG2S4T0=;
        h=From:To:Cc:Subject:Date:From;
        b=g5EH7kxB/O7eOB7cFGM6OHtuR6mKr2LbtVxcamRKFXPvlW5Zz8hdp3LsrmAQaFumw
         erbo2ygvlj4XWcG+VEGONVSXRIdGE24Cfx6GOKgDJm8b3sKqKF/s2SfmwLv9tQjtmx
         EWan93eX5AWlyY6HpsoSk4BKz4iGwqdiZTxgAlKRMU1YsAaBQ7wOlQotHEMV+WwJ8j
         6KjPihNuw1TF91jKXOW/x0MpSnWhnDa2IUUEYGfZIA9wLLa8G25+eIbD0GSZLk3Tzq
         qM1fXwQj0ONEBTgzgFauouTCwFgzMrZjbTDJzpHyynayWz5aUYMRup7j7UCn6NLL6Z
         tjyMOnARibYiA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        kernel-hardening@lists.openwall.com
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-plugins: remove always false $(if ...) in Makefile
Date:   Sun, 10 May 2020 11:00:44 +0900
Message-Id: <20200510020044.958018-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the remnant of commit c17d6179ad5a ("gcc-plugins: remove unused
GCC_PLUGIN_SUBDIR").

$(if $(findstring /,$(p)),...) is always false because none of plugins
contains '/' in the file name.

Clean up the code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/gcc-plugins/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 80f354289eeb..4014ba7e2fbd 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -14,7 +14,7 @@ $(objtree)/$(obj)/randomize_layout_seed.h: FORCE
 	$(call if_changed,create_randomize_layout_seed)
 targets = randomize_layout_seed.h randomize_layout_hash.h
 
-hostcxxlibs-y := $(foreach p,$(GCC_PLUGIN),$(if $(findstring /,$(p)),,$(p)))
+hostcxxlibs-y := $(GCC_PLUGIN)
 always-y := $(hostcxxlibs-y)
 
 $(foreach p,$(hostcxxlibs-y:%.so=%),$(eval $(p)-objs := $(p).o))
-- 
2.25.1

