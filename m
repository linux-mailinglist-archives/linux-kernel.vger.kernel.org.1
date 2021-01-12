Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69B2F286C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbhALGkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387624AbhALGkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:40:20 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128FFC061786;
        Mon, 11 Jan 2021 22:39:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r3so1254695wrt.2;
        Mon, 11 Jan 2021 22:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9LsugDW569FjBERoyKSAR4XOY8TthJz1AKh7ZpXlyG4=;
        b=o7c/bYOmrUdWx+iCTWh+kH1oq89qd9Xh5NfDK6HsSCIjg7JuVOwXKxXBJX9ip9BOc9
         ZskNAZidSRtJ9VysTj22wEoCVydOfJ+gIWfB3wotcX9tcJWywlkHq/uZSxdsMMcGxlhE
         xADGyS7eVQldGtjrUv0fIAzBM7XiFJpzfSmLRvu02/moPgtggmOMPUBWXcwsMYS0uTtw
         +Cwq1h0E8HRqtqwtAv4HNTII117qYCsJtuqUpvuMbEi1saGfedJvVRlkoFH1s2OSXi/d
         Z5cCZC1H4uhoYSnTk1ZTUiV5+RB3K1DvKUuJHKpMRVLf2ONKcHU1Y4LJdXATM4WEBeR+
         CwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9LsugDW569FjBERoyKSAR4XOY8TthJz1AKh7ZpXlyG4=;
        b=CiBWR0nf90WrojUSl2FtbSDRcL1eN260tzt3jus/R0oyscgVoHbqWM2FdaMG7MWQCB
         HahHubURrrvBsl4Q/oOqYlN5L+uzYLr1U/PiExibd+mnxqWRzEgepw3Sq7qT2nAhFX1V
         qbutR/dNwG4GDRMZXfvXiufC3GD1in49g7+wZT2FOUj/BpqwGgGppgLQQ8U5YBLKFivG
         RZUj5QMlNpuVKYsaL8xJ5znxPE6NUj43gGHy1NgMdNYWwycc4GJpOANNW8Mri1m7/pbV
         iqnn8NndPsR9dltFTznxBMt3s0gDX7/mZ3/O+3v9c+ou7CcL1bHE9eWQ6SgZBEAu7tJc
         8rSg==
X-Gm-Message-State: AOAM532P2Emvo3XG/r4ppZhhZS3kSCv0QFoa94gvSoGi2/j4TT2XSe6T
        E+r6KZe2uU/kVVsync2bVr4=
X-Google-Smtp-Source: ABdhPJxmxnoUy1ilxFUvRx/TYVyRWFgEsFRgYTw1CmU8AGC0C9eLPx269jY+DZ/mtB/gxGvJupAEUQ==
X-Received: by 2002:a5d:4d50:: with SMTP id a16mr2466183wru.43.1610433578801;
        Mon, 11 Jan 2021 22:39:38 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d98:7500:f93f:dcaf:eddb:2c7c])
        by smtp.gmail.com with ESMTPSA id k1sm3024760wrn.46.2021.01.11.22.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 22:39:38 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH -next] f2fs: docs: rectify the table header in sysfs-fs-f2fs
Date:   Tue, 12 Jan 2021 07:39:30 +0100
Message-Id: <20210112063930.20525-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 969945899a35 ("f2fs: introduce sb_status sysfs node") documents the
sb_status values in a table in ./Documentation/ABI/testing/sysfs-fs-f2fs,
but the table header of the first column has a wrong length.

Hence, make htmldocs warns:

  Documentation/ABI/testing/sysfs-fs-f2fs:382: WARNING: Malformed table.

Rectify the table header.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210112

 Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index e5918c93f3bf..362803901614 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -383,7 +383,7 @@ Date:		December 2020
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	Show status of f2fs superblock in real time.
 
-		=====  ===================== =================================
+		====== ===================== =================================
 		value  sb status macro       description
 		0x1    SBI_IS_DIRTY          dirty flag for checkpoint
 		0x2    SBI_IS_CLOSE          specify unmounting
-- 
2.17.1

