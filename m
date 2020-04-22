Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF21B4996
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 18:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDVQH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 12:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgDVQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:07:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D2FC03C1A9;
        Wed, 22 Apr 2020 09:07:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v63so1307291pfb.10;
        Wed, 22 Apr 2020 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5xEoHET9vfaEq5LIR2V1cy0U7HP7GDZ0ojpw/b8noo=;
        b=op9xXMUQE7+eoyEI/3bjdKIOPzkykzXpyT3jwTtohkIl/ROFGP/BywJFuagmDWuwpE
         Pm5ctXySjJG9ycaY6+T7WIubSLShz3za1aa2QQQP2EWNTUevUAcBRBQWqzsiYJ1BJKu7
         xy9YWh4AxbbdlChIZ8hlpmnFtegES9UKefSEfv0DtRS5RB3l1JV6s1Sfc0CgakQkl929
         JJjZKyNRND5IAl/p9dFWBZv7zrgLmldP7Bm1ACO7tqLlvaZvwOyrsXQtqf39Q9laMd4L
         2VgpBRjFkOlqvJcgJ/lym5BH+kMH9uN3kZdLbzSsn4XisvPqq0VHigRydEu2zxmhl9YN
         goXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5xEoHET9vfaEq5LIR2V1cy0U7HP7GDZ0ojpw/b8noo=;
        b=CDjcODNvd2MBqzTejfilL0k+Ytp4/L/vlnQzr70wBNkxqNgY4rlEbK72ACS5s+3CYm
         P6RBS8k62A4B3aR5L3KgkSJSpeUt/3q7wLHRKTKl06xUTqdjUt3hIMK64aBM5EBPbe01
         hs24wFmN0y6qVBKcmgFVFrJOWE87eRFeZFJmoRzNASzj8m2iZR/v9sEgKK4J3wRhbga6
         mdcyQcQFVcZqC1LSgIW0YfgHyl7pmHmvywa/EeSXP8SZrMueiyd6iuKPet7ujbmv2eHi
         4maxw1aVLxpHJQxpCwWqBMdDePR/A6wJMAMeoPZLNa+DmnH9GqdAqNYtgA/+HN7Cn9dW
         e63g==
X-Gm-Message-State: AGi0PubbBsKqGJ5wGZ7MYGhUumaBMPwICUwplPVV7SXofaQs0CmwgWPU
        cFhp7p4j0GfkEJuVoLb0yyRCOcgG
X-Google-Smtp-Source: APiQypIKUZKH++J4SaK/mpXI+7xB04AVhcJdfDXy62fFLjyb3yakjYt0JDm/ostuKjQSOUQvZvH34g==
X-Received: by 2002:a63:df42:: with SMTP id h2mr27572335pgj.216.1587571647496;
        Wed, 22 Apr 2020 09:07:27 -0700 (PDT)
Received: from localhost ([89.208.244.140])
        by smtp.gmail.com with ESMTPSA id p190sm4179323pfp.207.2020.04.22.09.07.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 09:07:26 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1] video: fbdev: sm712fb: fix an issue about iounmap for a wrong address
Date:   Thu, 23 Apr 2020 00:07:19 +0800
Message-Id: <20200422160719.27763-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the sfb->fb->screen_base is not save the value get by iounmap() when
the chip id is 0x720. so iounmap() for address sfb->fb->screen_base
is not right.

Fixes: 1461d6672864854 ("staging: sm7xxfb: merge sm712fb with fbdev")
CC: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/video/fbdev/sm712fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 6a1b4a853d9e..8cd655d6d628 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1429,6 +1429,8 @@ static int smtc_map_smem(struct smtcfb_info *sfb,
 static void smtc_unmap_smem(struct smtcfb_info *sfb)
 {
 	if (sfb && sfb->fb->screen_base) {
+		if (sfb->chip_id == 0x720)
+			sfb->fb->screen_base -= 0x00200000;
 		iounmap(sfb->fb->screen_base);
 		sfb->fb->screen_base = NULL;
 	}
-- 
2.25.0

