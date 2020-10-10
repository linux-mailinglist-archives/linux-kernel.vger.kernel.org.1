Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03F928A2AD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391066AbgJJW7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:49 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:42970 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbgJJWep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 18:34:45 -0400
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 3EEF530D8744;
        Sun, 11 Oct 2020 00:34:23 +0200 (CEST)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id 2BCC14000C97; Sun, 11 Oct 2020 00:34:23 +0200 (CEST)
From:   Mark Wielaard <mark@klomp.org>
To:     linux-toolchains@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Wielaard <mark@klomp.org>
Subject: [PATCH] Only add -fno-var-tracking-assignments workaround for old GCC versions.
Date:   Sun, 11 Oct 2020 00:33:50 +0200
Message-Id: <20201010223350.17005-1-mark@klomp.org>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201010215135.GB2666@wildebeest.org>
References: <20201010215135.GB2666@wildebeest.org>
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some old GCC versions between 4.5.0 and 4.9.1 might miscompile code
with -fvar-tracking-assingments (which is enabled by default with -g -O2).
commit 2062afb4f added -fno-var-tracking-assignments unconditionally to
work around this. But newer versions of GCC no longer have this bug, so
only add it for versions of GCC before 5.0.

Signed-off-by: Mark Wielaard <mark@klomp.org>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f84d7e4ca0be..4f4a9416a87a 100644
--- a/Makefile
+++ b/Makefile
@@ -813,7 +813,9 @@ KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero
 KBUILD_CFLAGS	+= -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
 endif
 
-DEBUG_CFLAGS	:= $(call cc-option, -fno-var-tracking-assignments)
+# Workaround https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61801
+# for old versions of GCC.
+DEBUG_CFLAGS	:= $(call cc-ifversion, -lt, 0500, $(call cc-option, -fno-var-tracking-assignments))
 
 ifdef CONFIG_DEBUG_INFO
 ifdef CONFIG_DEBUG_INFO_SPLIT
-- 
2.18.4

