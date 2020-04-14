Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29931A7F97
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390016AbgDNOX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 10:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389976AbgDNOXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:23:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7216C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dDirLGjSDANdS7yG9pc4umBhYkBv25yXvUeDF2Td5mk=; b=CfWQmYEk1+rahVGB5FD7WgNHsz
        MMgAF5sn0Pksex9GFgLexBLowB6DytF7HfOSIavSH+1JLQClnIiR10VwGZrTdKsmYKpYQhn4GZHjQ
        c0oQmGMoXtk4w5sv1aGJl1QsIHKLUu5yFQD5W6C5DnIi9N4wNHCMyCOrUhCBxv0YH04Aqo3JVKr2Y
        pJQg1lFIIEPw649ri6bctRy+3SULlGRWihsx+wQHseytLvEZygbc6vJxsv6bs8xilpdFBWLr3ICmu
        4JsSt522VEi82WwjQzwNY+fXGX2yhLYNXyeCfXtsza4z4fzyGDPAcbqlFcWf8SakF+rBvB0fIFIEh
        KOkISKTA==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOMT3-00024N-06; Tue, 14 Apr 2020 14:23:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm_sdei: remove the set_fs calls in sdei_event_handler
Date:   Tue, 14 Apr 2020 16:23:02 +0200
Message-Id: <20200414142302.448447-3-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414142302.448447-1-hch@lst.de>
References: <20200414142302.448447-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only two callbacks that can be called, which both
eventually end up calling __ghes_sdei_callback.

__ghes_sdei_callback calls irq_work_queue which is a normal
kernel helper called from all kinds of contexts and
ghes_in_nmi_queue_one_entry.  ghes_in_nmi_queue_one_entry is
also called from other code without messing with the address
limit, so it better work without it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/firmware/arm_sdei.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index bdd6461647d7..1c51b378dfca 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1137,19 +1137,12 @@ int sdei_event_handler(struct pt_regs *regs,
 		       struct sdei_registered_event *arg)
 {
 	int err;
-	mm_segment_t orig_addr_limit;
 	u32 event_num = arg->event_num;
 
-	orig_addr_limit = get_fs();
-	set_fs(USER_DS);
-
 	err = arg->callback(event_num, regs, arg->callback_arg);
 	if (err)
 		pr_err_ratelimited("event %u on CPU %u failed with error: %d\n",
 				   event_num, smp_processor_id(), err);
-
-	set_fs(orig_addr_limit);
-
 	return err;
 }
 NOKPROBE_SYMBOL(sdei_event_handler);
-- 
2.25.1

