Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210691FD3BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 19:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgFQRv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 13:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgFQRv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:51:28 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6562421527;
        Wed, 17 Jun 2020 17:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592416287;
        bh=U94GeFraD01aVQEM8vl0Oh3vdf1LW+6sHme4vUAVTcs=;
        h=Date:From:To:Cc:Subject:From;
        b=HgiE+iQsxkKj1piB7LAgU1JiiOlZZ49+RlrRCXfbLUMEwSBpXPuZRtHNKTgCfLq3k
         xLikeI01z5XBmS4nX02fm0hjslVKjpOWS8xFwuiLE7tr/UXhSC+DtI6QZN4f3+MmH+
         mmuivD/x1ZkhF5iR0tCF+LK8sp+V/LjFmh8o6U5o=
Date:   Wed, 17 Jun 2020 12:56:47 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] fbdev/fb.h: Use struct_size() helper in kzalloc()
Message-ID: <20200617175647.GA26370@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/fb.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3b4b2f0c6994..2b530e6d86e4 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -506,8 +506,9 @@ struct fb_info {
 };
 
 static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
-	struct apertures_struct *a = kzalloc(sizeof(struct apertures_struct)
-			+ max_num * sizeof(struct aperture), GFP_KERNEL);
+	struct apertures_struct *a;
+
+	a = kzalloc(struct_size(a, ranges, max_num), GFP_KERNEL);
 	if (!a)
 		return NULL;
 	a->count = max_num;
-- 
2.27.0

