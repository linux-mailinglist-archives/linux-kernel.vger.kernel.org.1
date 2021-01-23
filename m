Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A83017F5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 20:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbhAWTCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 14:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAWTCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 14:02:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC837C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 11:01:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c2so10200540edr.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 11:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZSgThrW5ePPiaNhxbXHbBnitGKYkT074Mjl+LX4bGY=;
        b=Mv/0gxbo50qb0O5joOOX94jVZprYnP04Qy/zCYZP4RIgDn5FgNOunE3KiNVPcMb9pm
         lALrNINKr/QuBqOAjIujrEY+nUF86w1gVfMKB0T+c34BQL/twOnrSt0yVXeXc258jxoV
         rsgspf0rgPZgvO11abD7sd/v9QRsflrbxzBuOHPndtP0bYOvYjd1NkXRnT6Kt9vOOS2S
         fMVRJtcO1WIeUVneV1irS7Ptop584nDFgeWf0ISPurPvud8uzulYABz7do61mg2/ChPk
         krMuBL6BVTVYsV0CP8JNNkrQ8NsdYMVi/vpLaYbTxIE80D9zKS+Jbba8PM6fnl4RIhtP
         z4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vZSgThrW5ePPiaNhxbXHbBnitGKYkT074Mjl+LX4bGY=;
        b=rOWF6rqIZOf/R+ECRSdDwmm98PqAlJr1g0Fuo1Tr7kqHup4hVU9R3Rm8FFFvG4N78G
         2BzRijlRiyhP12Y14CZPypAf9f57eugkTtvORKUmrWPYsSntZe49yqmc6j4bRO1julZD
         GUMvdhYJCRDS2hfGu8L0bwabUaiFKxsK24BHvsoRG3rYw1mYzOcvA6llYxraoqYA6IqO
         8MOeKuG8qXIRPbtgKubCJs/8RbEc/gKzs1DGjHN5n5BiXxk7vhKlVYpMOyrgQGiqOO/h
         eq5iY0YvAEo0yf6u7eGweOFXItv3c669555fM4hD1bv1a2XNnvfGkMftKeWh7uujIhpY
         HTdA==
X-Gm-Message-State: AOAM533Gaz5+p9RM/0ggpDtt/DiV+QMZwIdRmXnZwhLNjua6ef5BZxZO
        osOY9zqu/9T+QanUGgZZZpUhUVbLg7jrGg==
X-Google-Smtp-Source: ABdhPJzGID7h4uJL4+UFpo2Zh7je3aiXjwAAcapRanlCAnrLQT0644l5FWrqwJ1OzWam5SS3vBaPxg==
X-Received: by 2002:a50:9ee9:: with SMTP id a96mr1387208edf.343.1611428489647;
        Sat, 23 Jan 2021 11:01:29 -0800 (PST)
Received: from stitch.. ([2a01:4262:1ab:c:78d8:2ef4:5ead:12bd])
        by smtp.gmail.com with ESMTPSA id g21sm7731795edh.20.2021.01.23.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 11:01:29 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-kernel@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] kernel/backtracetest: use new API for backtrace tasklet
Date:   Sat, 23 Jan 2021 20:01:15 +0100
Message-Id: <20210123190115.7180-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the backtrace_tasklet to use the new API in
commit 12cc923f1ccc ("tasklet: Introduce new initialization API")

The new API changes the argument passed to the callback function, but
fortunately the argument isn't used so it is straight forward to use
DECLARE_TASKLET() rather than DECLARE_TASKLET_OLD().

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 kernel/backtracetest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/backtracetest.c b/kernel/backtracetest.c
index 370217dd7e39..70a3da716f01 100644
--- a/kernel/backtracetest.c
+++ b/kernel/backtracetest.c
@@ -23,13 +23,13 @@ static void backtrace_test_normal(void)
 
 static DECLARE_COMPLETION(backtrace_work);
 
-static void backtrace_test_irq_callback(unsigned long data)
+static void backtrace_test_irq_callback(struct tasklet_struct *unused)
 {
 	dump_stack();
 	complete(&backtrace_work);
 }
 
-static DECLARE_TASKLET_OLD(backtrace_tasklet, &backtrace_test_irq_callback);
+static DECLARE_TASKLET(backtrace_tasklet, backtrace_test_irq_callback);
 
 static void backtrace_test_irq(void)
 {
-- 
2.30.0

