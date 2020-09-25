Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566692781E8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgIYHp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYHp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:45:28 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F3CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 00:45:27 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id b7so749015wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 00:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc;
        bh=KG5RlWSqE9DeeNwLXo9IjdrluKdLvBhyhqhCrd2kK0c=;
        b=h9Fb5EwJ2l/lgL2OqJ8NwsSmkT9qjgY9vXVGQfUVJBtpxjxebwPL9nk+3jeT0CwxN0
         llV4YastT2SXR9w/AWElUjMVXv6bGlPr5WHlCHbcxxWngXjAU3PEPFb6aB2tBvuyZX/3
         EsMHHZMT+SP+PDEqKZ+S5CENweiuUB0yR7On+1iFRk8fF3qDwXS6Mv4yITOrSu1FUyS8
         fPgnJd1OohSRGeIVWBr1T9r8LpkAWuVnhKUGL2Lruox5T70ManCxkwYQaHtSpRC0WNuw
         QzzlGkbTcjdANYEn9pI0Aap4BQmk7xsZuZRJBUCNSgRosaksnkDwQ5waUhpiCFPpXxQP
         ky5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc;
        bh=KG5RlWSqE9DeeNwLXo9IjdrluKdLvBhyhqhCrd2kK0c=;
        b=E7AndHIPZHbjwHrk4k/GL/XcirtvwCqkXekkHIQji2yIUqWw9eM3yFDX96FQMf5Erf
         ZXrWiqWSlsh+3iA3LMLlK0gSPhuWDE2PijjFkp2UtgG7VRxAQBNE3r7qeDgVVMsQoJjY
         cmdYR4cO+19FbuoZLhhJUfl5c9Akjv1MRl6GiepiNR/ulli8N2VOyNit5IaHbDwc9xTu
         D/jI/daxDMp08nPc+WG0x3gVk4it2nVbAlGO5eRzG38PII9+256NRhL/lRIdu2XkhTyR
         xKzymmoJPA5XBymQdtb7y8tznVGSc7ZubfftK0BXfQespOQtBvU7mxDtm82xbsnRNndW
         M00Q==
X-Gm-Message-State: AOAM532E2GayKQ/nQpGantt2dKU42264DESKBWJbjD7mgwO0geqY5eXB
        hbHqN/oGThwqNPVV6WtnNTou/Umv4g==
X-Google-Smtp-Source: ABdhPJxg/CqvqZLjpG/D07jNao47Ty5854ZoDa/4Vg2ZrXlyCYvou9i7txo/XgoC4T+LRoXb3lHbUveDAw==
Sender: "misch via sendgmr" <misch@katla.muc.corp.google.com>
X-Received: from katla.muc.corp.google.com ([2a00:79e0:15:10:7220:84ff:fe0d:f6a2])
 (user=misch job=sendgmr) by 2002:a1c:bb88:: with SMTP id l130mr1686055wmf.143.1601019926340;
 Fri, 25 Sep 2020 00:45:26 -0700 (PDT)
Date:   Fri, 25 Sep 2020 09:45:02 +0200
Message-Id: <20200925074502.150448-1-misch@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v2] efivarfs: Replace invalid slashes with exclamation marks
 in dentries.
From:   Michael Schaller <misch@google.com>
Cc:     michael@5challer.de, Michael Schaller <misch@google.com>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch efivarfs_alloc_dentry creates dentries with slashes in
their name if the respective EFI variable has slashes in its name. This in
turn causes EIO on getdents64, which prevents a complete directory listing
of /sys/firmware/efi/efivars/.

This patch replaces the invalid shlashes with exclamation marks like
kobject_set_name_vargs does for /sys/firmware/efi/vars/ to have consistently
named dentries under /sys/firmware/efi/vars/ and /sys/firmware/efi/efivars/.

Signed-off-by: Michael Schaller <misch@google.com>
Tested-by: Michael Schaller <misch@google.com>
---
 fs/efivarfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 28bb5689333a..15880a68faad 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -141,6 +141,9 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 
 	name[len + EFI_VARIABLE_GUID_LEN+1] = '\0';
 
+	/* replace invalid slashes like kobject_set_name_vargs does for /sys/firmware/efi/vars. */
+	strreplace(name, '/', '!');
+
 	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
 				   is_removable);
 	if (!inode)
-- 
2.28.0.681.g6f77f65b4e-goog

