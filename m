Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F051B221323
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGORED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 13:04:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53952 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgGORD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:03:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jvkp1-0006U8-Tu; Wed, 15 Jul 2020 17:03:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ufs: avoid potential u32 multiplication overflow
Date:   Wed, 15 Jul 2020 18:03:55 +0100
Message-Id: <20200715170355.1081713-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The 64 bit ino is being compared to the product of two u32
values, however, the multiplication is being performed using
a 32 bit multiply so there is a potential of an overflow. To
be fully safe, cast uspi->s_ncg to a u64 to ensure a 64 bit
multiplication occurs to avoid any chance of overflow.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: f3e2a520f5fb ("ufs: NFS support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ufs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 1da0be667409..e3b69fb280e8 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -101,7 +101,7 @@ static struct inode *ufs_nfs_get_inode(struct super_block *sb, u64 ino, u32 gene
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	struct inode *inode;
 
-	if (ino < UFS_ROOTINO || ino > uspi->s_ncg * uspi->s_ipg)
+	if (ino < UFS_ROOTINO || ino > (u64)uspi->s_ncg * uspi->s_ipg)
 		return ERR_PTR(-ESTALE);
 
 	inode = ufs_iget(sb, ino);
-- 
2.27.0

