Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A527630179B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 19:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbhAWSZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 13:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWSZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 13:25:53 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC9BC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 10:25:13 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hs11so12306017ejc.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 10:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lcql6ewYFIvTd5Osic9rDn6xJ4SFHocv/qa6POkiMmw=;
        b=TzTSORwjX83OQ/PFH9Q7QtFQf0XAHV9ZY2g1GtOu9iyUW/Dcq6Z5GakmxAO8QizEig
         Attj3tLZe0K3VPEeZYypsTDMYMCzi1TzxR9eIZJp5AS/zvrVHc6MW/CX+fH1GGVkoKOh
         rpFGhtcInaXdiS1OG8wi3fbYd5VNATpHDsaHEZx4FLvi200OZtXsGlenR9tjfL6wrfFM
         rnyMb7iiitGyvImpJ8jTVp/QjwYB/x2y6i3P9uWZMwspoXTWEeQGyK9P5xKo8maIlM0e
         s4X9nT6Ze2U6axxdXCEAVo9As/3yjRgb0oaFLVeZW1vwnIFwYzM3bn/4SdOPYHnCw3U+
         X0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Lcql6ewYFIvTd5Osic9rDn6xJ4SFHocv/qa6POkiMmw=;
        b=hQcapwAi4FT9pei91mnrdVYIw0YEUU1/fsrfvSssJhBU9C0tLnfjcsWNfMv29BcE0/
         GFqR6BmIdncmVsOSoXWEVOC/3nX5b8GK+PAnIO5iODpvLAQG7OIoxAJvA8OHnxkJ8pYD
         w0DcZSLx5xSJFeWD3kxzmQ/3EuVT69wEqM5oWWIZsuBVx5mK/HRbzF4bwKkBNY6cN/v6
         EpbUpmdse+HG06Md+HDGmQrH9RyZD5dfe0XyNHhwgttGOzmYvflGPCom7z7VePuka8jf
         j9mxDqN8l8YAWovqIZ2Oc+GT6P0vBOJbfYTKIagvZ9l1pkCBY6KuhwuUl1cr5q7hZcZW
         AFPw==
X-Gm-Message-State: AOAM531iLj1t4ub6eTR4eriXlQ7GYEAO9W9uQDF4d7YksN+puQd8/IRq
        0x8MjQt2JgmaK6NM6bTruVI=
X-Google-Smtp-Source: ABdhPJyvCwkUj/PLGcZM8vaiPiVvW5yAyRxOsPqxCVnPf8cEwbbf+Ovko3roYnHKpe4lxxL0BMeTmg==
X-Received: by 2002:a17:907:932:: with SMTP id au18mr6439346ejc.91.1611426312011;
        Sat, 23 Jan 2021 10:25:12 -0800 (PST)
Received: from stitch.. ([2a01:4262:1ab:c:78d8:2ef4:5ead:12bd])
        by smtp.gmail.com with ESMTPSA id k21sm7586579edq.60.2021.01.23.10.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 10:25:11 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] genirq: use new tasklet API for resend_tasklet
Date:   Sat, 23 Jan 2021 19:24:56 +0100
Message-Id: <20210123182456.6521-1-esmil@mailme.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

This converts the resend_tasklet to use the new API in
commit 12cc923f1ccc ("tasklet: Introduce new initialization API")

The new API changes the argument passed to the callback function, but
fortunately the argument isn't used so it is straight forward to use
DECLARE_TASKLET() rather than DECLARE_TASKLET_OLD().

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 kernel/irq/resend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 8ccd32a0cc80..bd1d85c610aa 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -27,7 +27,7 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
 /*
  * Run software resends of IRQ's
  */
-static void resend_irqs(unsigned long arg)
+static void resend_irqs(struct tasklet_struct *unused)
 {
 	struct irq_desc *desc;
 	int irq;
@@ -45,7 +45,7 @@ static void resend_irqs(unsigned long arg)
 }
 
 /* Tasklet to handle resend: */
-static DECLARE_TASKLET_OLD(resend_tasklet, resend_irqs);
+static DECLARE_TASKLET(resend_tasklet, resend_irqs);
 
 static int irq_sw_resend(struct irq_desc *desc)
 {
-- 
2.30.0

