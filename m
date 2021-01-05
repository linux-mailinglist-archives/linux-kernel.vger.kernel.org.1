Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CE22EA2DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 02:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbhAEB3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 20:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhAEB3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 20:29:22 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AA1C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 17:28:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id j13so725557pjz.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 17:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3UjD26QN0UA/ub3IY5/65dvjqpB+2GS72iiAT/kBTU=;
        b=Slobn0e8o4BZv6BeB5DyM/pu1y93XUeoGPA3Fp5x33Lx8DO5Emw6mGz9vvERtceiwD
         LxLfX4kdY04SBYfvOz/lIJBB0qcMpb9Z0wDeTM58BUXOhPmJu75OMJe0CPOciSCq04Ka
         Y8OpIhDFY5Tj0Di8BCVPz/XhvpoS/uI+/07hQKYFBnF3+M5zRBsv2NNH/FcbFBQti0DX
         KS1/wV4dBtMND6OJkUIbRk8HBShwdL9Lhi1RzBX4FmWn5nh4995NXeVs6BeQuhbFobyV
         YjQ0Wwi6pOKywkEgkUwTTC1J/oTf4TyRFaDWA364u4me/ve7tgCGbt6I9V5G3NbNSczU
         DcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3UjD26QN0UA/ub3IY5/65dvjqpB+2GS72iiAT/kBTU=;
        b=fvCo+mOfN1Trv6w6IUSyyXYA3ImJFDssqnxmaeTPzvuQeISE0B6Z/dfe+h4or7vxvg
         QZnlO/A5nlN5qrPlVfiJwwlHDToQG0fhhUDAc+iwCbgqPITjN7N+ZPXYDadcvneS7v7P
         0UnVgyEbkQqOz2x0D1YZrkGYOsEcV7cRr4Kx4CgtRFxAuyxadxCavL9rcde5UZZ0NfMr
         kExezmG28aHwK7tH5vKlJOts8U4gc0pNum27bq7AKV/Z520o3/xgiuSGQpxYW35PQqm7
         SkIzghRzIMVf9BPO/vXI6owb27e+7gUh1k3HrGjaUrUtnkk6rfPBdH8KYeUQSIxZmSGo
         vJ5w==
X-Gm-Message-State: AOAM530BTtE/GrpSqxxT4zfNsgqyxH9f22mIhqu7s+Usbnd3rFzms2mz
        wbc1KSGXeuB38GsMvLFQih61GdhrqkE=
X-Google-Smtp-Source: ABdhPJxrKeoDrpk/5rKEEhyYr9KaUFCepjqwD9TehEVWXuoIAm/tlbIcKWcAzv1OubjLUWL/lR3lIQ==
X-Received: by 2002:a17:90a:5914:: with SMTP id k20mr1582782pji.199.1609810121409;
        Mon, 04 Jan 2021 17:28:41 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id gk8sm531043pjb.52.2021.01.04.17.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 17:28:40 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH] f2fs: fix null page reference in redirty_blocks
Date:   Tue,  5 Jan 2021 10:28:26 +0900
Message-Id: <20210105012826.956800-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Fixed null page reference when find_lock_page() fails in
redirty_blocks().

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
---
 fs/f2fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9e5275716be8..bf6682a52433 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4060,8 +4060,10 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 
 	for (i = 0; i < page_len; i++, redirty_idx++) {
 		page = find_lock_page(mapping, redirty_idx);
-		if (!page)
+		if (!page) {
 			ret = -ENOENT;
+			continue;
+		}
 		set_page_dirty(page);
 		f2fs_put_page(page, 1);
 		f2fs_put_page(page, 0);
-- 
2.29.2.729.g45daf8777d-goog

