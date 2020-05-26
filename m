Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9CB1E022A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 21:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbgEXTWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 15:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388214AbgEXTWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:22:24 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1315C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:22:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q16so6696249plr.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QX6izj81MoWvGB/E4/khaJEguGwrdsEfxjduXmAWvc=;
        b=FrXCWih/fqy5rFigNvFp2soetQnTjk3UWgjf1t5Fq9zUKajb6xucJmoe4faadG/Dmc
         Lj7A8hdDcSd7cwHUcnjgUu9TkCTHTVgWOuBdk6bdc2aSoswqnHSy3nb37tiShQKrRgwU
         kQGRSX/5Ki0ECJ1FKNiSS5m/Un75CkOharfLmwwahvohU6GmkkVM8hyoaWdv2bMn8DL+
         UUnlV+L9+B+Jj9LPHpFsrshojMI4VFzFwwfeQ/C5Uc0g/CKzE2PcxT0SqhVO8/D14I3X
         LUxExRTj+3BF9xbf6ZL8baH0FFQafDwnYkxJYf311W2Wnbkzfk3xuzawz1p9wlX71+uX
         ZuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QX6izj81MoWvGB/E4/khaJEguGwrdsEfxjduXmAWvc=;
        b=Ra3aW70TEmR/goFXUa9p1gCQ40tVpvVvzjaGjiihnKRGMS8cPZdiLWqRaFV6mKxa0O
         rSY9nGKHq6YOSD35klMmSYmwmRgbXtWqWvVY+XFMo3BisVFsG9imK4Sc6WCdi1ZmdJ8k
         WcOBzVgrPjHYYmnZ7h+wlze3GqluVJwkvpnGbSnx/sS+CLhroUop+V5RyGpQjEgRmfd1
         ocR1g4ibztLWNaLjA79CDJEBKzmMRkjnewmjFMzQC4dFV7CBJAi4TmePnzKBGP5RELhj
         snlayOEpKvyIOwVDNLdj/FXcrmX3TC5kTZatrA7VYLK54KXauifQxoMlBPx0kc19t8iX
         9apQ==
X-Gm-Message-State: AOAM53036OJhi9A4Jy5OjPl021VCivpH1U5ZEuxs5i2OvAk5M8YK3SLO
        Vqh7Zej3Ul4rFLGNiAIFyxZNrQ==
X-Google-Smtp-Source: ABdhPJyjDCYHAk0AUhemwGeKPxGqOTLpvrciZlQVB8VBWPs9J2AE+uiuLeGMBoKTiCckFgaWydI+aw==
X-Received: by 2002:a17:90a:1303:: with SMTP id h3mr15729181pja.44.1590348143383;
        Sun, 24 May 2020 12:22:23 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c871:e701:52fa:2107])
        by smtp.gmail.com with ESMTPSA id t21sm10312426pgu.39.2020.05.24.12.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:22:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/12] block: flag block devices as supporting IOCB_WAITQ
Date:   Sun, 24 May 2020 13:22:02 -0600
Message-Id: <20200524192206.4093-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524192206.4093-1-axboe@kernel.dk>
References: <20200524192206.4093-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 86e2a7134513..ec8dccc81b65 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1851,7 +1851,7 @@ static int blkdev_open(struct inode * inode, struct file * filp)
 	 */
 	filp->f_flags |= O_LARGEFILE;
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 
 	if (filp->f_flags & O_NDELAY)
 		filp->f_mode |= FMODE_NDELAY;
-- 
2.26.2

