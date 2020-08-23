Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1112124EB16
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 06:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgHWEEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 00:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHWEEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 00:04:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E42AC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 21:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OAYGpfvJpZGXlclvSv+CIEvZpDqOEEpRLEOMBFpgdq4=; b=ivpcJrv7qaSpTRn8A6SqmHQ7nS
        X93GpCbsw+SaUqFnvq34KjjAGfnCRRTjS+SGseM1L4c+tgF2Ljg85PQuQjvf1YqKChBV7u0M8Q3C0
        tnitBPNw3oGWgXlSwQdXuqTbsaahpM41wwbqFETi7GOwI1QyeJYGS71SIqYSWslJrXlDEdR5M2rRl
        PZxBd9kGq1+gt6RZ7V85q4FwssKkKWWvt+iQ9mf5pud8IevWoGJJFwCW4bBwjGg9i5PoYhNZs0H+l
        svs2NfRncTbkltW4E5K2jyHWTtt8ou+TFKHOr/Qo3y+h737JemAinOv+ZvpIx2N5mvy5BfZkeQHXK
        3Sf8XISQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9hFP-0004pD-Cm; Sun, 23 Aug 2020 04:04:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] lib: devres: delete duplicated words
Date:   Sat, 22 Aug 2020 21:04:43 -0700
Message-Id: <20200823040443.25900-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/devres.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/lib/devres.c
+++ linux-next-20200730/lib/devres.c
@@ -217,7 +217,7 @@ void __iomem *devm_ioremap_resource_wc(s
  * Please Note: This is not a one-to-one replacement for of_iomap() because the
  * of_iomap() function does not track whether the region is already mapped.  If
  * two drivers try to map the same memory, the of_iomap() function will succeed
- * but the the devm_of_iomap() function will return -EBUSY.
+ * but the devm_of_iomap() function will return -EBUSY.
  *
  */
 void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
