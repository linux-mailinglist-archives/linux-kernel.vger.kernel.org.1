Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99F32A2697
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgKBJHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgKBJHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:07:04 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3FCC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 01:07:04 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z3so4160753pfz.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 01:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fK+egPCE2bgxCgA1reHpJyulDAd/xhtfW4LIbSxorA=;
        b=cqCvIDmA2H0jS30X5BW3VvHglrlsvQezrFZkIhDUcsNfpIYQ08RdHlj08xPyHGJMaY
         avkafUAhe+UMyuiSNhEHpV+lPIEHo3Ol0DgG9OZLxvpJCo71s4SkFTHXxiLzm9NSuR9K
         yLmcRVHFlZOq/+IqsloyZFmrJ9Hd+bAx4/lPg47G5ntTmS2Q8XEwMBtXlWyeMe9qW61q
         hvdAGf9cXKtI9RDRjUQixvVEtlqEp9jwJBu9/3VCX7C+D+SmXWmVryM9xupwbOQSh8x4
         76mqdLIHg36RSn16vM+fOBfdWxK5aDrEvaqilZahBJXlZOhTx19nAFFzPebWlWaCQpbm
         LZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fK+egPCE2bgxCgA1reHpJyulDAd/xhtfW4LIbSxorA=;
        b=juW8+o5ZgS12+Y2vhwNRxk92RJufSVOqeTVITzJfJ1MzG7k9+rR3mZ9C6PlnVbYvva
         CAALeP8l76f+S1iyV9gUbaqyKOioDnKGAFSwWLH3wwBEqF+jqoAkuEtfirLTACeFQT1j
         Dsy9t/fIgXmkmheI2Q3CIULZYQ4BsDFfxC3ESn5qpq5Fir4tkiV5TgK5GEZ5mffsUfjJ
         M2N7gFiir8wdPSQhKEuzfFTOvfDqlzjKNJ4z/md5BHYGuCHCoFzkvfPpgKc59Bjmefgc
         K3zyX1eP/F9bUQirpUmcYNfsGrggmnxl9Sa/dm+hRguwttzb58M6FaWCm7qbYSAjPLBg
         6RrA==
X-Gm-Message-State: AOAM531Bc55XTvFWLvNhAQWv9nvcLFxUvLAx60LMVaNUiEcjcZQJcalN
        loR9RuI/u+hg/GqiWo90VoU=
X-Google-Smtp-Source: ABdhPJzgBaHinhVOYGJsjQUOly32tiCeKhHK4US6tPoktuTJiLtjm/A66vwPVlQFsptYRdqSVhXOBQ==
X-Received: by 2002:a63:3202:: with SMTP id y2mr12202643pgy.97.1604308023787;
        Mon, 02 Nov 2020 01:07:03 -0800 (PST)
Received: from localhost.localdomain (cl-ubuntu-kdev.xen.prgmr.com. [71.19.148.84])
        by smtp.gmail.com with ESMTPSA id n11sm2083605pjv.52.2020.11.02.01.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 01:07:02 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     anton@tuxera.com
Cc:     Fox Chen <foxhlchen@gmail.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        syzbot+ecbcf37464c627253e44@syzkaller.appspotmail.com
Subject: [PATCH] NTFS: Add name sanity check to ntfs_attr_find
Date:   Mon,  2 Nov 2020 17:06:49 +0800
Message-Id: <20201102090649.140696-1-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mounting, if Attribute data is correupted, doing named attribute
lookup can lead to invalid memory access. This is reported by syzkaller.

This patch adds a sanity check prior to attribute name lookup. If attribute's
name_offset is invalid, It will mark volume error and return -EIO.

Reported-by: syzbot+ecbcf37464c627253e44@syzkaller.appspotmail.com
Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 fs/ntfs/attrib.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index d563abc3e136..e7366f74ff62 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -607,6 +607,16 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
 		 * If @name is present, compare the two names.  If @name is
 		 * missing, assume we want an unnamed attribute.
 		 */
+
+		/*
+		 * Sanity check, a->name_offset should be within the range of a->lengh,
+		 */
+		if (name && ((u8*)a + le16_to_cpu(a->name_offset)) > ((u8*)a + le32_to_cpu(a->length))) {
+			ntfs_error(vol->sb, "Invalid Attribute Name. Inode is corrupt.  Run chkdsk.");
+			NVolSetErrors(vol);
+			return -EIO;
+		}
+
 		if (!name) {
 			/* The search failed if the found attribute is named. */
 			if (a->name_length)
-- 
2.25.1

