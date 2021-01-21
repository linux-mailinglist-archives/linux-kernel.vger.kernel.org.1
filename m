Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C8F2FE2D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbhAUG3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbhAUG0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:26:40 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E209C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 22:26:00 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id f63so886078pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 22:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJxqFT+5qx53zphJZqNCcKwlvAjoGdjphcdT6milPrE=;
        b=ZLcWa7hqgwXCCjlSVXumhxDRuVAzD3Z/O/SEbVb3WNo9rjVWosgNMjemgyCAAiq2Qi
         GV1zPwxD8n8EbbrsgB7j8reHho6elKprcS8MNKhx3R5FssxXBB0ZywjW8bDvCEufEFSj
         ATbU38QHRqbznfReOl2/65UasfWLbdNhL9zuL8zhGH7vsWk5wmqgiKop2YIPYMEF3sS7
         h8Xo43I4MZ6vmyrcmNE8OZHu6Kf8GvA/+ZW2MlseqXu0vtj+3rXtbKB45nDLRc5lJISQ
         BheUw9BAoA9nm/YvU3JYBzXP+MmElhMzuXDXfIAZxb1rxHO3c8fbNU2e6D5/8CKdpkxV
         OAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJxqFT+5qx53zphJZqNCcKwlvAjoGdjphcdT6milPrE=;
        b=CNIMsr7DkKz7fwvGJUdRsoWzx75c39VZiS3wUeM/vP5BGEmZGifLB7QgKju7JiuaYG
         glfqKOZTM4MlJ5Z6/5x6ivO8KNhHigkwgZpiGsgz+JYjHsvrT4pAqqbMtfsWctWBaJLZ
         BcN/uE/dcJ3vJlbfCe0SewLyIijGLQNmm8PTYugHDM82JKl6uFjhfWPoQraSlY/1nYL0
         vQTNO6Hs/xlKPpXHXvBiFo2MaawNFlULmuv/I0PYyRYYjRCv2qaOGjQqE/dXtmuZmuZk
         xQqrcrvWkr0DHn4EYVGg3lYQCJ0z9t/pSbh5+KS+HTPG38qYS3gMVnrg29p1nehEMU7C
         k3fw==
X-Gm-Message-State: AOAM531EgWm84RS5MmBBKciqEFmU8S3CrLD6o8d6oR5s5Rv1wun26zYd
        vh+Lt/bC0ia4opgvTwNxv2ik
X-Google-Smtp-Source: ABdhPJyQ0dm+7soCPKNjt7VdaMA7zt7NaoBhCMhSkEUDUvu/UNSoNl2F3mz1tAb957LKZW2T/AkM1w==
X-Received: by 2002:a63:e058:: with SMTP id n24mr487228pgj.345.1611210359556;
        Wed, 20 Jan 2021 22:25:59 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6182:23c4:4d5:e6d9:fc7e:c8e2])
        by smtp.gmail.com with ESMTPSA id b26sm606498pfo.202.2021.01.20.22.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 22:25:58 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org
Cc:     afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, cristian.ciocaltea@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] pinctrl: actions: Add the platform dependency to drivers
Date:   Thu, 21 Jan 2021 11:55:47 +0530
Message-Id: <20210121062547.27173-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Actions Semi pinctrl drivers are a mix of both ARM32 and ARM64
platforms. So let's add the correct platform dependency to avoid them
being selected on the other.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pinctrl/actions/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/actions/Kconfig b/drivers/pinctrl/actions/Kconfig
index a1d16e8280e5..8bb8345b17da 100644
--- a/drivers/pinctrl/actions/Kconfig
+++ b/drivers/pinctrl/actions/Kconfig
@@ -12,18 +12,21 @@ config PINCTRL_OWL
 
 config PINCTRL_S500
 	bool "Actions Semi S500 pinctrl driver"
+	depends on ARM
 	depends on PINCTRL_OWL
 	help
 	  Say Y here to enable Actions Semi S500 pinctrl driver
 
 config PINCTRL_S700
 	bool "Actions Semi S700 pinctrl driver"
+	depends on ARM64
 	depends on PINCTRL_OWL
 	help
 	  Say Y here to enable Actions Semi S700 pinctrl driver
 
 config PINCTRL_S900
 	bool "Actions Semi S900 pinctrl driver"
+	depends on ARM64
 	depends on PINCTRL_OWL
 	help
 	  Say Y here to enable Actions Semi S900 pinctrl driver
-- 
2.25.1

