Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74152FBED4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbhASSVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392581AbhASSUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:20:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C48CC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:19:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n76so26223277ybg.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Ji13liyFDC2lDH5ciCyuoxMctj4vQjl6Y6p/lptZcMQ=;
        b=KahbDg6Qmg7cuIzxVxouSdEQoqwS8E49utrQBHjwJDxSY8Iu9EjXH0WOhgA+XsUrDb
         Q7622J51yBTUUqrn9mhnU+iA/59S00GXUNotCI4ejenbqihvLLuQSx5SwvbWykTLAe6O
         AD8c7jm41fKNEjJnJ1jPujUCA41yV+OZSQYj/uXdhzdlz73gs3bH8lh1kKAcD4YhHr/t
         ZLcTk3rNp3kNPgqrTo9qbyXgfLhXpd681hviEKtBzGt3HWUKwke0RjrVpyYI/pMZcMpr
         Y364NdVt87H8GtQ7qfZxowR0DZ3J3MvWQYBtV1m7ybGJzW86/XzzEalDe6THYlbQ6HUn
         sQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Ji13liyFDC2lDH5ciCyuoxMctj4vQjl6Y6p/lptZcMQ=;
        b=tRi9KBx71WhgRrUpStgp+weYf0uX00A5AbQH3Hm0BLsyFm0LzrRnE0V15xFmswlPXt
         6bOasJBGcqEmqSciSqJuCQT1Z9ks6jRHdtrhsU+j4+tNOfoA/3WRQY+3IkPJzCmJdenl
         Mu41OERgZGzhD9gpFCZg3iHcI6mTpAQLDKwRtAvNURSiH+KhS7z4p8ONtp3GMdT8rVYJ
         iqDJpaPmjjNhtTCUU6Jf2+anFoAdiOvSsPC/BZxmmSZSBkJNiI1Sow7/L+EZUcLx1lPQ
         WAWLWagCaHC2jPe+bkTVdf4MMstKyxHzLFvaeOXOPgqqioJOoca+mpCNm+Sin5QnB+t/
         pgjg==
X-Gm-Message-State: AOAM530wvH4K5v0xBAb9RQIHkSQnZGYhng5Lx2z8tlQUOpAq7u+W8tL/
        d5Tt5AgZaZtdChQgVVxdDDBuUF1fvO0M67XW5fU=
X-Google-Smtp-Source: ABdhPJy+hou+UDcK8kw2WBpbLq4zWJgQR+O5obdxbkZUyouV3vd8l2vNYOf7hyaHUOvqiQywwVa78r8h/D6Tx3gwyzA=
Sender: "paullawrence via sendgmr" <paullawrence@paullawrence.c.googlers.com>
X-Received: from paullawrence.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2534])
 (user=paullawrence job=sendgmr) by 2002:a25:9706:: with SMTP id
 d6mr7695305ybo.211.1611080388823; Tue, 19 Jan 2021 10:19:48 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:19:45 +0000
Message-Id: <20210119181945.2071053-1-paullawrence@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] um: ubd: Fix crash from option parsing
From:   Paul Lawrence <paullawrence@google.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Paul Lawrence <paullawrence@google.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below patch will cause NULL ptr dereferences if the optional filenames
are not present.

Fixes: ef3ba87cb7c9 (um: ubd: Set device serial attribute from cmdline)
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 arch/um/drivers/ubd_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 13b1fe694b90..704989088f28 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -371,15 +371,15 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
 
 break_loop:
 	file = strsep(&str, ",:");
-	if (*file == '\0')
+	if (file && *file == '\0')
 		file = NULL;
 
 	backing_file = strsep(&str, ",:");
-	if (*backing_file == '\0')
+	if (backing_file && *backing_file == '\0')
 		backing_file = NULL;
 
 	serial = strsep(&str, ",:");
-	if (*serial == '\0')
+	if (serial && *serial == '\0')
 		serial = NULL;
 
 	if (backing_file && ubd_dev->no_cow) {
-- 
2.30.0.284.gd98b1dd5eaa7-goog

