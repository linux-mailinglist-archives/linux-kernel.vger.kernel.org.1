Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8920F224715
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 01:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgGQXis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 19:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGQXis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:38:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36BC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZPXx4fGiy7Wd5eCSRJhCZP53MZ395RpJbpqqFuhaB9w=; b=WLOqaxfC66HykGZ0YxGwxs6YVw
        PmF2WBxVIcwImdIFO9UimqOUSvGrOk+bNeSN5dEnXBMtSfH8uTx9SsFkak0vWpWTZAVq/zUDXylcW
        ZT1vc2FVdDOcUNb7SVk98TVmCmEmT+uoxAK5jl3hN5keqaOKwitgoAv1uNYBBFS4FL0vqRDaiRaEn
        5o9z4ATTb7f85sZD84/yFJka/OPkUM9Zv6ZvAsZCYX6usNzehiyxeIxoAHWUFLjBZx2klwwzTbhre
        03m8Ml1hZVlmToFCFbHQJfKKC76PioJBtXQbILEm4sSAjjgIu8k7yNqAVBQFqiXapPcFYWy21+DoK
        h1tquP9A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZw7-0006iF-Bz; Fri, 17 Jul 2020 23:38:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] firewire: linux/firewire-cdev.h: drop duplicated word in a
 comment
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net
Message-ID: <2f56acbd-bf67-4c8b-4ac8-aa142b7fb145@infradead.org>
Date:   Fri, 17 Jul 2020 16:38:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "for" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net
---
 include/uapi/linux/firewire-cdev.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/uapi/linux/firewire-cdev.h
+++ linux-next-20200714/include/uapi/linux/firewire-cdev.h
@@ -844,7 +844,7 @@ struct fw_cdev_queue_iso {
  * struct fw_cdev_start_iso - Start an isochronous transmission or reception
  * @cycle:	Cycle in which to start I/O.  If @cycle is greater than or
  *		equal to 0, the I/O will start on that cycle.
- * @sync:	Determines the value to wait for for receive packets that have
+ * @sync:	Determines the value to wait for receive packets that have
  *		the %FW_CDEV_ISO_SYNC bit set
  * @tags:	Tag filter bit mask.  Only valid for isochronous reception.
  *		Determines the tag values for which packets will be accepted.

