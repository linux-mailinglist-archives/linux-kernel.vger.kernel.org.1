Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17512A5E00
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgKDGCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgKDGCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:02:30 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953A7C061A4D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 22:02:30 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id e7so16379375pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 22:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y/yeOmnK20UKTLT831lanbP1iGRyC45KnY2UMu9QfDg=;
        b=R2BsfZAxekSLJkJX/fyImptd7L1mcZFDhdPOGl9VNCD9bzReCJgnECx4TiUMnvXDsv
         gkpKSLGBWfmoGfn1rLEf2N1/laOn8T+vw67ods6UeA+ssXMy7yvgyqqOOS7kzzVPEie5
         6SqXiyhpnv4SKItVZhleKN+XFAqhmOc/wb/pdiceZcPwflmsAfxWqKjsy91JjaSvDv/b
         l23ASsJYFdAZJFDjx3Uw8ssZnF5p90COiWJiVZJjr2A/QescVV4d6YyvaZ7ZzePfjWuQ
         xOw4qoFoytgZXf72Q7WqI1lz2M1x41pArpdNMjENgeTMFyeRmjyHwUMx8mZrVxoh15ra
         e2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y/yeOmnK20UKTLT831lanbP1iGRyC45KnY2UMu9QfDg=;
        b=i5qXmFgfoh3Ow2jV5RalUAev31qhFLyhxXLLensSv/kmchrGxBpaonf+yueowE9gw6
         7xyNkG0sUR+hJSmiJnj6sx0ZwQfIOHXpYMHx+BmJrgEeOYtoAGWApd8zAilBsCK23krj
         tci23sEuZ+ZSpRum0ZoFBqzi+nQUfajMOD6HVANHLH3pG3dB8Zk+yPkyeZbx+ZWvQa2E
         ZsWv6fHPXkpM7CtNmpqwtqzCbLLe5ootry00uUSpgLNB4y3FTjs4IEGr2Fr8sthaceRm
         Ka/AmZ4P+tbfnux810nd76uOE0MFwqstXNtFh9+gV/N8vmR6A8UxxjIHuPLdxR+6/fhS
         6tEQ==
X-Gm-Message-State: AOAM533co1u1DrvvEKKptzcGrvuqclSCfd0NWJgc/hDtgqWJ0j5M54/F
        u2RPJzTbE1AFbBhoU2b0deg=
X-Google-Smtp-Source: ABdhPJxe3zmVLqXI8JtN8ygwxgtgpkjt9zB6CjN4V6twL2CUgWBoy/lKtJQi108NqsFyWado4ktaPg==
X-Received: by 2002:a17:90a:540f:: with SMTP id z15mr2787817pjh.111.1604469749676;
        Tue, 03 Nov 2020 22:02:29 -0800 (PST)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id 136sm1002561pfa.132.2020.11.03.22.02.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 22:02:28 -0800 (PST)
From:   Junyong Sun <sunjy516@gmail.com>
X-Google-Original-From: Junyong Sun <sunjunyong@xiaomi.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, sunjunyong@xiaomi.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ttyprintk: optimize tpk_close flush code
Date:   Wed,  4 Nov 2020 14:02:24 +0800
Message-Id: <1604469744-8708-1-git-send-email-sunjunyong@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tpk_printk(NULL,0) do nothing but call tpk_flush to
flush buffer, so why don't use tpk_flush diretcly?
this is a small optimization.

Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>
---
 drivers/char/ttyprintk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 6a0059e..2ce78b3 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -104,7 +104,7 @@ static void tpk_close(struct tty_struct *tty, struct file *filp)
 
 	spin_lock_irqsave(&tpkp->spinlock, flags);
 	/* flush tpk_printk buffer */
-	tpk_printk(NULL, 0);
+	tpk_flush();
 	spin_unlock_irqrestore(&tpkp->spinlock, flags);
 
 	tty_port_close(&tpkp->port, tty, filp);
-- 
2.7.4

