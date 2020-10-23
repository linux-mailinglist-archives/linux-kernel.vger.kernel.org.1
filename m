Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DEE2978BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756391AbgJWVQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756080AbgJWVQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:16:16 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F2C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 14:16:16 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j62so2243364qtd.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 14:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONKARXAOXhn+rHY7xamM2KWYF09JnFj33g4K/fnpqwM=;
        b=dZHbRTxEQlVNK1Fn3lDYx9KoaG4539IChRW/73vmgucbEoNAKGqY3cxx2C8JihxF4c
         yk3EYGmjEMxQy25x82lgkave7H1cfzUeayLBXwsabmJ6AokqKFFm2RJf+hTwKcOmqkhy
         XW6sqma17y9IoiKWaDvODDu3IpABxcOWlSM3Kg9As/yfa3TLJmM/Jed6fv034H/BfWzr
         +8dmLs8/UtwbnbtKmXCclcshq+lQwXC2cUz6LYS9kxDRBf1zonyOc/qBMDJtp4gjgZq5
         fcDxfhbD+PmByI1v/vxoDkqXC0qdRtpB3fOaMKTkUxTI4QyV+2PvptkOwp2fbXcYATXA
         ZBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONKARXAOXhn+rHY7xamM2KWYF09JnFj33g4K/fnpqwM=;
        b=PqWt2r3HKs4ABbWQVY9q/iTtm14LZDgHBh02nD3/Vms5TSGQq5yJHxQmNgi0/TTzsC
         RUHU/epzvw9sAj/MX1JeNZi9Y0Z5rmwC+XZGccqTtKQaLOU8W1LVmDXDKN3j1DfbgBOe
         cMns1zbfThW2zP8Ds8oTAsbi18jbGCb7yGFQMCkcM+mdPyQ9N2QggQurhMVeH7f0rp49
         o6B5qXg+5x0BSqWRDh2Bt6JFD9YAdvv4Kr62WRtX5CsvBC1wSGNaZ4VNX28ql+YuxOs3
         m/zyBw1F3F5YdWExviUZsnQbnXF9wZZfCO6/xZSD6GKFTPJDns8yRmJa9vgjrq3ovVlR
         ayJQ==
X-Gm-Message-State: AOAM533uSm2RRBkPQXEUMkwoQ/Op3Bs+e/z1BfIbPObYNkzznKxmC3pv
        xdF0+An10LehTmEEnYRp2Yk=
X-Google-Smtp-Source: ABdhPJwtzxN39qc5EDf5nyl74i4knkToIOcMwXNcjycEnGNhwF98VL5WSASbfdRhzrMKL1fGqKzDfg==
X-Received: by 2002:a05:622a:4b:: with SMTP id y11mr4337580qtw.348.1603487775388;
        Fri, 23 Oct 2020 14:16:15 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:a59b:90b7:e05c:ed13])
        by smtp.googlemail.com with ESMTPSA id b23sm1614691qkh.68.2020.10.23.14.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 14:16:14 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Anders Larsen <al@alarsen.net>, linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH] qnx4: do not interpret -EIO as a correct address
Date:   Fri, 23 Oct 2020 17:16:04 -0400
Message-Id: <20201023211604.159074-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qnx4_block_map() may return -EIO on funny qnx4 fs image, in this case do
not interpret -EIO as a correct address

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 fs/qnx4/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e8da1cde87b9..d3a40c5b1a9a 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -59,6 +59,8 @@ static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_h
 	QNX4DEBUG((KERN_INFO "qnx4: qnx4_get_block inode=[%ld] iblock=[%ld]\n",inode->i_ino,iblock));
 
 	phys = qnx4_block_map( inode, iblock );
+	if (phys == -EIO)
+		return -EIO;
 	if ( phys ) {
 		// logical block is before EOF
 		map_bh(bh, inode->i_sb, phys);
-- 
2.25.1

