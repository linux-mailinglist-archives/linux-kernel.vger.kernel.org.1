Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C556D2EB67A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 00:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbhAEXuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 18:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbhAEXuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:50:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29777C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 15:49:38 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 4so616635plk.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 15:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whc2U5gu5zwKqW7Z1BCd12zYqBfLakFsyLK0IzuWzP8=;
        b=RSYt8aWDjjxG6udavDTUY19W7lHxifCi8492IhANNtipB66/pAWN4AWXhxP+tKJjzj
         NAt6EZe3Zc49FsV8iZqgXQYgJhiyWJGhH2M+FU4a+hrkDhxcKleEPmDxC/dbtEfz1xUt
         pCyc5Z1UjpWdgzYdXymMqBg4/iQss87JLDkc3GBlPcvhXS8glcjpf6uYvbc7H/RMDvu/
         CFA768T2YFosp2nuzRHipHGrkO/FmljBtLCcy/EAk49H2eGvFNq+g4C5l8ia3GpKPluR
         YyRYxluQN/pzIVaPgOrg0Aeix4rrrI4HowMzphddpO2W6+g+v6qwwgOxUHV7jgOodkf9
         oyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whc2U5gu5zwKqW7Z1BCd12zYqBfLakFsyLK0IzuWzP8=;
        b=InyyujnaGFSWnXF9XMTIIbuAWv9wmXSbvxfpUx50+JsXyckbaOsNosdjcDbOGOEk4O
         VkMmuF8u3M3ZAJgK3GRrySKKNDJz1vlsDIkL3IKfMC887oCCpZHwxKtyduXdlzNMRhzy
         W6lT//hD7O8SU9ryKf10X0YNbKS8EjKOQHuzH/iMV6fMbDAY28HwCtKu1QvxDMWWfE07
         w0xH2hOC1J23r5BNkq8plQjpW8/n987h81MLGJA72WWQeE2Ipt1b16b9rDgnTO0MBf41
         Q9N61Dyua6UcX2kyRX6SRg4hL3KO0bpcylRiLRxfvQQOPBiPv6xobe6QS0ZyszhcmvG1
         z41w==
X-Gm-Message-State: AOAM530bgNln7mRCGne9wYXTe9ExzBaw/kswFHZV48ft8flWxkEmsCEm
        ZWeOL8zQM1LxIBLc7ileWSPzW/N/PAk=
X-Google-Smtp-Source: ABdhPJwL704VReSw6jgByR6yvKwqCTroZ13+bPc6/tofWoYLUxpY5mR6MoNopmnlk4n6HDG6LBwFJA==
X-Received: by 2002:a17:902:b693:b029:da:e92c:fc23 with SMTP id c19-20020a170902b693b02900dae92cfc23mr1531675pls.55.1609890577267;
        Tue, 05 Jan 2021 15:49:37 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id 8sm285724pgx.48.2021.01.05.15.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 15:49:36 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH v2] f2fs: fix null page reference in redirty_blocks
Date:   Wed,  6 Jan 2021 08:49:28 +0900
Message-Id: <20210105234928.1598326-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

By Colin's static analysis, we found out there is a null page reference
under low memory situation in redirty_blocks. I've made the page finding
loop stop immediately and return an error not to cause further memory
pressure when we run into a failure to find a page under low memory
condition.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
---
v2: changed error value and quit the page finding loop immediately
    when error occurs
---
 fs/f2fs/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9e5275716be8..d27173c24391 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4060,8 +4060,10 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 
 	for (i = 0; i < page_len; i++, redirty_idx++) {
 		page = find_lock_page(mapping, redirty_idx);
-		if (!page)
-			ret = -ENOENT;
+		if (!page) {
+			ret = -ENOMEM;
+			break;
+		}
 		set_page_dirty(page);
 		f2fs_put_page(page, 1);
 		f2fs_put_page(page, 0);
-- 
2.29.2.729.g45daf8777d-goog

