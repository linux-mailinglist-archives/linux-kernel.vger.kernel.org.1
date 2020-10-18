Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941F12917B2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgJROEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgJROEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 10:04:51 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFDBC061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 07:04:50 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id hS4n230024C55Sk06S4nH9; Sun, 18 Oct 2020 16:04:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kU9Il-0001r6-1S; Sun, 18 Oct 2020 16:04:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kU9Ik-0005Sz-VV; Sun, 18 Oct 2020 16:04:46 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] lib/test_free_pages: Add basic progress indicators
Date:   Sun, 18 Oct 2020 16:04:45 +0200
Message-Id: <20201018140445.20972-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test module to check that free_pages() does not leak memory does not
provide any feedback whatsoever its state or progress, but may take some
time on slow machines.  Add the printing of messages upon starting each
phase of the test, and upon completion.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 lib/test_free_pages.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/test_free_pages.c b/lib/test_free_pages.c
index 074e76bd76b2b3c9..25ae1ac2624ae481 100644
--- a/lib/test_free_pages.c
+++ b/lib/test_free_pages.c
@@ -5,6 +5,8 @@
  * Author: Matthew Wilcox <willy@infradead.org>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/gfp.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -26,8 +28,11 @@ static void test_free_pages(gfp_t gfp)
 
 static int m_in(void)
 {
+	pr_info("Testing with GFP_KERNEL\n");
 	test_free_pages(GFP_KERNEL);
+	pr_info("Testing with GFP_KERNEL | __GFP_COMP\n");
 	test_free_pages(GFP_KERNEL | __GFP_COMP);
+	pr_info("Test completed\n");
 
 	return 0;
 }
-- 
2.17.1

