Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C0525DC35
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgIDOuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbgIDOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:50:05 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AF6C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 07:50:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e23so9002461eja.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=knHcGvrKe47dDgMpklf6EaakjMbICjDQ8kPM7SJOe0g=;
        b=qFs5cdTin+4XJ14I4314k+lczV2OimLtbY/+jRukUPSyAUxnaIgf3jAMinYQIAPTdc
         fbW2UfhTnzV3WbKFk++GolYrJIYMt0Zo239oodSDZUE3UbttkPV3lhyX4s9eqQl89CXL
         yjIt4EJV3QiTBRDE0KyX4NqhwbWFyPaoISFsVSS1o7o3cuw6Jvcqy9uG+tLOTmctJxJv
         GcBL0y3oFdOtGvt5XVrSRxReSqRptxFI2NipW1G/KlmHn7TlT2hH1adwGUpGtGS4etw6
         d+J8zBCamQJhcekfXzbw0mccYToTZeuR/Z9unLyhPd68JHDUs0ihp1wr8P/uLhXRSzoF
         FVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=knHcGvrKe47dDgMpklf6EaakjMbICjDQ8kPM7SJOe0g=;
        b=de4D6aMozR26SGIibPqtFUzxvBLH2cffTbQloTLtHIHP8j5QOwbZoJGzWBODW839aX
         AT+7N+NO8/vAmGNChopVpvxnfu3L1BTn9Wo/bldax+OH2FBT2j+NTtaiG7Lsn/W0ubE/
         ANGoKGvkhgXzc2oa/IzV1WqFw+sTceWLP3kNcFmqeepUSkd/NGzQBGNCcafXkDDJed2E
         sfxxzdma1YcbEV6MCLdSiyKdAVqB/0z5Di0GC838c7emyUzInfekxnDCutvLGnvHZ/q8
         /TiI0jDdaoagg22HdI5yZtXFCRMUb9eiFP0lXZtkLXdnVifR4lsANjgsFf82j0MMwNrR
         MoIA==
X-Gm-Message-State: AOAM532xviLQvZbs8A03Gv5oQlnFsuLNWIHtNqKDHgP+oo0xg5IwNIXW
        ux/2hUrQX+Tcd2pyFPekVZo=
X-Google-Smtp-Source: ABdhPJzXsjAqBhhZESO7864PPMNv5hMGtP7WEfYyrS4EdQC9zKm/W/hF8VLVTc1xTpANhTw0SeKONg==
X-Received: by 2002:a17:906:1909:: with SMTP id a9mr7562396eje.127.1599231003271;
        Fri, 04 Sep 2020 07:50:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b907:ef64:1d41:83f0:a723:a7e3])
        by smtp.gmail.com with ESMTPSA id v17sm6281327eju.22.2020.09.04.07.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 07:50:02 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH RFC] mm: Let readahead submit larger batches of pages in case of ra->ra_pages == 0
Date:   Fri,  4 Sep 2020 16:48:07 +0200
Message-Id: <20200904144807.31810-1-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Current generic_file_buffered_read() will break up the larger batches of pages
and read data in single page length in case of ra->ra_pages == 0. This patch is
to allow it to pass the batches of pages down to the device if the supported
maximum IO size >= the requested size.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mm/filemap.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1aaea26556cc..0deec1897817 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2062,6 +2062,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
+	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	struct file_ra_state *ra = &filp->f_ra;
 	loff_t *ppos = &iocb->ki_pos;
 	pgoff_t index;
@@ -2098,9 +2099,14 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (!page) {
 			if (iocb->ki_flags & IOCB_NOIO)
 				goto would_block;
-			page_cache_sync_readahead(mapping,
-					ra, filp,
-					index, last_index - index);
+
+			if (!ra->ra_pages && bdi->io_pages >= last_index - index)
+				__do_page_cache_readahead(mapping, filp, index,
+							  last_index - index, 0);
+			else
+				page_cache_sync_readahead(mapping, ra, filp,
+							  index,
+							  last_index - index);
 			page = find_get_page(mapping, index);
 			if (unlikely(page == NULL))
 				goto no_cached_page;
-- 
2.17.1

