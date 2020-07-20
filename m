Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373D62254E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 02:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGTANv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 20:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgGTANv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 20:13:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AB3C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 17:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=w3ocKZG4wB9+BN3HWi6dTE1pwLbH0jUZXg8mdu1fAZE=; b=IfvaB5pjviEa3rTvLBwVBYZVfI
        p9QNyt5uyU28PO7PozjAJipC0XsS+cIcnJ8fa1JINcIyT96WBmzTnBSEyBB1MHAdSrmCwvWgyB9dm
        tptQ2GMgiqfJrLebL6qva7Cw7KAfkbmfQgd04vcHL4ivCWW5q6T5qNqL4PTN50eQmdMEOAHE9gcWH
        ufVg0DcyAKzJf7S6ywmCuy+rS7V+Ve27QKmSvbrU9m3n1+dsePyT+1QIE+E5tAV5mDkXd7X9uRBoK
        lXSx+VX8Zb9Zn4GzdlgORNlYbEkUkpnYz3px3nIW6h+HAj1BMkxfN0cFH99ZK0Up48mAwRHWQu9n0
        x1RDlqKg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxJRE-0003y3-Ow; Mon, 20 Jul 2020 00:13:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH] f2fs: segment.h: delete a duplicated word
Date:   Sun, 19 Jul 2020 17:13:44 -0700
Message-Id: <20200720001344.25138-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/segment.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/fs/f2fs/segment.h
+++ linux-next-20200717/fs/f2fs/segment.h
@@ -187,7 +187,7 @@ struct seg_entry {
 	unsigned char *cur_valid_map_mir;	/* mirror of current valid bitmap */
 #endif
 	/*
-	 * # of valid blocks and the validity bitmap stored in the the last
+	 * # of valid blocks and the validity bitmap stored in the last
 	 * checkpoint pack. This information is used by the SSR mode.
 	 */
 	unsigned char *ckpt_valid_map;	/* validity bitmap of blocks last cp */
