Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7187C2CE89F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgLDH27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgLDH26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:28:58 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBED7C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 23:28:12 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id h7so3355723pjk.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 23:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FUQZouuGjXV7HSSzP01pZBA9c+FXEpV0zJrdVApAds=;
        b=abcIpuyG156+yQo7RBk+VToXBkhacslHs6qiH3+OqIBHPWtdIkndVjmQGkjTyZ1ARp
         wxsBXZr8KGHOjjPPlTAp3QzJlrRztXfZ0I7V1L9hUgrZOrjTasfEm/imYysm1jTACNF5
         9SunK4/ZzqVcK/prZyGhXESh6oslVhqaZOymADxYDBshwnIUr5HTh03yBnL47ulOaXgC
         x5CP2xQgjX4gM49nu06hftGVu2Rm5PETUTHHraQfeNO3QYN3MZ5bjaGC7TbXSTQ9XK3s
         CCPokds3X8RgK4P0ZjtezE6Z0CjB2vGGvj3/GpRuAhWTH3XWDEgh11Lc3y5LKjaPGpLY
         bEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FUQZouuGjXV7HSSzP01pZBA9c+FXEpV0zJrdVApAds=;
        b=OJRlVptaNAv4h4Sdc3H1uqz030E7wr0ixHShJOTUAy85ehYru7LiPb9yOwlj42puGa
         0c5ZQ39yQ7F9Kf1zygD4sLRmgaBVmSpiPZoCk1sl8kh2EBS1pwqAvql3aMuz2G9f58Ok
         J5yolxVYmwjsunELFcD+7n2IqtPteZptgTQwZ2f5N1DFM3nTtuXT8WXdOHrPFHBXtaWw
         fdHdm/GuVoFIdMwdQGjYRz/je6COMumvcaePktS/oiF61byESm+YvWdFXFMu7HGTbbun
         zj5pyvqnfRqSuwMvoyfglwtR2h0Xw8Vagcpp+jxvU/rAkYKD33Xo1S6VHvUOW9uH222C
         n6Xg==
X-Gm-Message-State: AOAM531DvvIONHONUHQHVdLURKhRzCRVP7n6TrHwlqh6OgqtN2v2KHCw
        6KVQYh2mikfVHJB5pin9/ygxCH3/ntw=
X-Google-Smtp-Source: ABdhPJyX5/lUuPfPfy0V+XJ+9eza3uZQVd4xV93OLzIXber+Tz3h/DysCbJJ5KZ427zr5tmXkCji9w==
X-Received: by 2002:a17:902:76c8:b029:d9:d6c3:357d with SMTP id j8-20020a17090276c8b02900d9d6c3357dmr2922413plt.34.1607066891803;
        Thu, 03 Dec 2020 23:28:11 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id v6sm3371666pgk.2.2020.12.03.23.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 23:28:11 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2] f2fs: fix race of pending_pages in decompression
Date:   Fri,  4 Dec 2020 16:28:02 +0900
Message-Id: <20201204072802.795397-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

I found out f2fs_free_dic() is invoked in a wrong timing, but
f2fs_verify_bio() still needed the dic info and it triggered the
below kernel panic. It has been caused by the race condition of
pending_pages value between decompression and verity logic, when
the same compression cluster had been split in different bios.
By split bios, f2fs_verify_bio() ended up with decreasing
pending_pages value before it is reset to nr_cpages by
f2fs_decompress_pages() and caused the kernel panic.

[ 4416.564763] Unable to handle kernel NULL pointer dereference
               at virtual address 0000000000000000
...
[ 4416.896016] Workqueue: fsverity_read_queue f2fs_verity_work
[ 4416.908515] pc : fsverity_verify_page+0x20/0x78
[ 4416.913721] lr : f2fs_verify_bio+0x11c/0x29c
[ 4416.913722] sp : ffffffc019533cd0
[ 4416.913723] x29: ffffffc019533cd0 x28: 0000000000000402
[ 4416.913724] x27: 0000000000000001 x26: 0000000000000100
[ 4416.913726] x25: 0000000000000001 x24: 0000000000000004
[ 4416.913727] x23: 0000000000001000 x22: 0000000000000000
[ 4416.913728] x21: 0000000000000000 x20: ffffffff2076f9c0
[ 4416.913729] x19: ffffffff2076f9c0 x18: ffffff8a32380c30
[ 4416.913731] x17: ffffffc01f966d97 x16: 0000000000000298
[ 4416.913732] x15: 0000000000000000 x14: 0000000000000000
[ 4416.913733] x13: f074faec89ffffff x12: 0000000000000000
[ 4416.913734] x11: 0000000000001000 x10: 0000000000001000
[ 4416.929176] x9 : ffffffff20d1f5c7 x8 : 0000000000000000
[ 4416.929178] x7 : 626d7464ff286b6b x6 : ffffffc019533ade
[ 4416.929179] x5 : 000000008049000e x4 : ffffffff2793e9e0
[ 4416.929180] x3 : 000000008049000e x2 : ffffff89ecfa74d0
[ 4416.929181] x1 : 0000000000000c40 x0 : ffffffff2076f9c0
[ 4416.929184] Call trace:
[ 4416.929187]  fsverity_verify_page+0x20/0x78
[ 4416.929189]  f2fs_verify_bio+0x11c/0x29c
[ 4416.929192]  f2fs_verity_work+0x58/0x84
[ 4417.050667]  process_one_work+0x270/0x47c
[ 4417.055354]  worker_thread+0x27c/0x4d8
[ 4417.059784]  kthread+0x13c/0x320
[ 4417.063693]  ret_from_fork+0x10/0x18

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2: merged verity_pages with pending_pages, and increased the
    pending_pages count only if STEP_VERITY is set on bio
---
 fs/f2fs/compress.c | 2 --
 fs/f2fs/data.c     | 2 ++
 fs/f2fs/f2fs.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 87090da8693d..832b19986caf 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -803,8 +803,6 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 	if (cops->destroy_decompress_ctx)
 		cops->destroy_decompress_ctx(dic);
 out_free_dic:
-	if (verity)
-		atomic_set(&dic->pending_pages, dic->nr_cpages);
 	if (!verity)
 		f2fs_decompress_end_io(dic->rpages, dic->cluster_size,
 								ret, false);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 42254d3859c7..b825d63cabdd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2290,6 +2290,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		ctx = bio->bi_private;
 		if (!(ctx->enabled_steps & (1 << STEP_DECOMPRESS)))
 			ctx->enabled_steps |= 1 << STEP_DECOMPRESS;
+		if (ctx->enabled_steps & (1 << STEP_VERITY))
+			atomic_inc(&dic->pending_pages);
 
 		inc_page_count(sbi, F2FS_RD_DATA);
 		f2fs_update_iostat(sbi, FS_DATA_READ_IO, F2FS_BLKSIZE);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 94d16bde5e24..a9ee7921c7ec 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1340,7 +1340,7 @@ struct decompress_io_ctx {
 	struct compress_data *cbuf;	/* virtual mapped address on cpages */
 	size_t rlen;			/* valid data length in rbuf */
 	size_t clen;			/* valid data length in cbuf */
-	atomic_t pending_pages;		/* in-flight compressed page count */
+	atomic_t pending_pages;		/* in-flight compressed + verity page count */
 	bool failed;			/* indicate IO error during decompression */
 	void *private;			/* payload buffer for specified decompression algorithm */
 	void *private2;			/* extra payload buffer */
-- 
2.29.2.576.ga3fc446d84-goog

