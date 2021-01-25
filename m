Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E0A30252B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 13:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbhAYMvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 07:51:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbhAYMtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:49:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5EA3222F9;
        Mon, 25 Jan 2021 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611577501;
        bh=qtmXOqJxneNT6Fg5ZV7SMY5GLZOcH8Mz0dyQT4DG0Tk=;
        h=From:To:Cc:Subject:Date:From;
        b=NiTVNPuo1Guq4QKFfN6sfcBG1BFpJbOoC+mAt7uwcZTsHXJO5oWIuK5B31l0U7Cwr
         y5wZftk3pKXrbXGPW0cU4rBQLbUT7Yy1I0zfPHGMXVRb7tEAiJ0FPHLWJK3aU3HEZC
         QwtOI/4slqIowRXkyFHrjrS5OIT+0+QvVoepCZDVodpFC7/8Im/HaR/9X2QrDeqHct
         j6G3sgzqNo9lJ8sVSxrgrA1V9Hs60eieQsS5MD86mWB5CAXwNF7q9YgSWuyJfu8qah
         ssRlTP7G5WNsY8S4n20MqtLISdbtjbqEycUL0WSylAH4a7Y/nyVidP7wrl9RpoDP/q
         3g4CZdfwdI5lA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
        Daeho Jeong <daehojeong@google.com>, Jan Kara <jack@suse.cz>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix unused function warning
Date:   Mon, 25 Jan 2021 13:24:45 +0100
Message-Id: <20210125122457.4119313-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The f2fs_compress_set_level() function is only used for zstd and
lz4 compression modes, and otherwise causes a compile-time warning
for having no users.

Change the #ifdef check to match what calls it.

Fixes: c08e95fc6466 ("f2fs: compress: support compress level")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 178bbb79bbcc..c5a69b0543c1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -467,7 +467,7 @@ static int f2fs_set_test_dummy_encryption(struct super_block *sb,
 	return 0;
 }
 
-#ifdef CONFIG_F2FS_FS_COMPRESSION
+#if defined(CONFIG_F2FS_FS_LZ4) || defined(CONFIG_F2FS_FS_ZSTD)
 static int f2fs_compress_set_level(struct f2fs_sb_info *sbi, const char *str,
 						int type)
 {
-- 
2.29.2

