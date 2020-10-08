Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C18287BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgJHS1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgJHS1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:27:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D676C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 11:27:29 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b193so4135368pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qKVACZ37gbwD3Vrxyl3CjxzaTSwtlD53B6L2JTDGMHU=;
        b=Fn3tdWFMiAEW6EWkMQETL2Z/9ovncZzYcTjnB9JoCeEf7x1B9bMmnIOCwW3XnMo/o4
         YQeTr5MDPPN84mG1hI3NPWaazecbGiVAwwZLCRIgs3mT0WGrPwubyYYacBm1GGS86bpQ
         IHafEAhVmAhip4kz7k/3tNbEF3rbrwROgrtWA/jcN8TtwvXtGzMK7Yza10XFYwi9tpvk
         TvXDSVe+2K4oSxX/msRb8qFm5mOxq1VSisZ36LN0PkBsF3nfwig7RbUnyIBnIjRAZhLV
         O1WWPnx3vUzTCAx8JGZsrffLbF3FwA3l0cG9b4jIdhNN90FIxds4sl7n2ZcNqFBuWyVB
         MYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qKVACZ37gbwD3Vrxyl3CjxzaTSwtlD53B6L2JTDGMHU=;
        b=hBl8oUxL4zWrURwnt+DAOj1FSfvR/pH4qZexhLXFKhmJbFGIvR1rq9dpnm5m8+7e6I
         U7yKvz0FckNEWyTF0e9aqLpd5nr7BZ/XEHE191bpT8R+nU1dISZj5wERne92gTunaLGE
         1uS4M0gAnx99s8aJ9JGNdy0DLhdwnLEBAzUZigEFVNhoiC1JypklWenzG3oIeZOd4dGy
         6HHWKnbStKDLMpEjrKMXCi4fUIVh7G19EpcLqxU2M2hLweZ1wxgV2QJMhJqJcs1XoO7d
         /yEdJCEEXoRJXAJAQtvWzJIZF8ksfP0OG46tx28lwL529fM2kb4aw1JpcylckkpqSNAA
         JFkg==
X-Gm-Message-State: AOAM530CucXkbRLMk/yzf73YfHe4ZzQKqce+/vVzPMNj0Nyxb8APUkaS
        0OmFCCmGfFJY1ws0xa1fSen8PXFM9QlPbshz
X-Google-Smtp-Source: ABdhPJy2Y5k/y/cg1OlJGlvvVyWrIFFOlPnUf6VwIHjw6IqMTLEmhNLGn0jaX89EwMyGxkqZNQgX9A==
X-Received: by 2002:a62:7f81:0:b029:152:6197:f1f2 with SMTP id a123-20020a627f810000b02901526197f1f2mr8452244pfd.49.1602181648003;
        Thu, 08 Oct 2020 11:27:28 -0700 (PDT)
Received: from localhost.localdomain ([150.129.237.234])
        by smtp.googlemail.com with ESMTPSA id z8sm8212640pfk.49.2020.10.08.11.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 11:27:27 -0700 (PDT)
From:   Harshal Chaudhari <harshalchau04@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, sudipm.mukherjee@gmail.com,
        linux-kernel@vger.kernel.org, harshalchau04@gmail.com
Subject: [PATCH] char: ppdev: check if ioctl argument is present and valid
Date:   Thu,  8 Oct 2020 23:57:13 +0530
Message-Id: <20201008182713.2764-1-harshalchau04@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking the argument passed to the ioctl is valid
or not. if not then return -EINVAL.

Signed-off-by: Harshal Chaudhari <harshalchau04@gmail.com>
---
 drivers/char/ppdev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 38b46c7d1737..001392980202 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -354,7 +354,7 @@ static int pp_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	unsigned int minor = iminor(file_inode(file));
 	struct pp_struct *pp = file->private_data;
 	struct parport *port;
-	void __user *argp = (void __user *)arg;
+	void __user *argp = NULL;
 	struct ieee1284_info *info;
 	unsigned char reg;
 	unsigned char mask;
@@ -364,6 +364,16 @@ static int pp_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct timespec64 ts;
 	int ret;
 
+	if (_IOC_TYPE(cmd) != PP_IOCTL)
+		return -ENOTTY;
+
+	/* check if ioctl argument is present and valid */
+	if (_IOC_DIR(cmd) != _IOC_NONE) {
+		argp = (void __user *)arg;
+		if (!argp)
+			return -EINVAL;
+	}
+
 	/* First handle the cases that don't take arguments. */
 	switch (cmd) {
 	case PPCLAIM:
-- 
2.17.1

