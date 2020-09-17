Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7282E26DAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgIQL7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgIQL4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:56:31 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79242C06174A;
        Thu, 17 Sep 2020 04:56:31 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so1213271pgm.11;
        Thu, 17 Sep 2020 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwiQFVnuTHeY2gHO84RjfglTiONbgKCnCABvveUVThQ=;
        b=fog2lnoBs5qYsr5GrZjMLZkHrGQzLIkBtCDjTB6v6YavrHLMIaty8smqYvFmhhMSG3
         /0oWuGGlHgQ4Qmq6Tgzhi73UmJBCceymEh9Qb7pogguXjlESeoA0cXVCOdH6WYggopgS
         hPmPcr3Fq1xge9VxAkQcMfxfIqbHyCHSznSrOPn7N7pM8bfElXrjMK9Dnekm0/Vdv/tt
         M8mplQV1BCO+z1S9pm9dNswcjKy0W/wJN1FfwDltHSnP/LKHy63JEZfwKsKYbm6U8Eh6
         YEvlwNz+CfywCbuGKHbx3ogbeEkqp+3Oe5CkzAAznQ6GNqqjhSblG/CIj6ZR33qnOSdY
         LjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwiQFVnuTHeY2gHO84RjfglTiONbgKCnCABvveUVThQ=;
        b=U3tPe93HDb1stiD6LzxDCENl41CzWvVySvjGplFahPUK1MfiabW2qmjIYlWiYjnsiC
         A95T0tTLUvN+yqY8wlBnWP7oS8CoflQ4BI5zPsFjHDaWLvytX5veP4TTKZ5NtAq1GZCv
         SHClwgtG1G4BBx/WltQA0PiG66HEIOZYJUqHrU1RoGC2wtTktnVk3Y/RYvsOrDir9ubk
         tLrzLgf+EPFe+F5ybwgLQCrjFbEtQnvD8oe46O3kZtI6dZPO4rM7lri3Iizg4Qrw4QaJ
         VIkIxj8PzQtMHtLdXD7Mg0wz7VUMS29iX9B6mny2aaoy0Q9QaYFdAxDzCYFrcS7hWxT+
         EykA==
X-Gm-Message-State: AOAM533A61GP944uShYPpi7zbXmMWxSIG+grxBqJ5yve69t7iIQAw8OP
        nRXGYHRAZ9jtcRXYU/SHofE=
X-Google-Smtp-Source: ABdhPJy5/dKEi8cR2pyPna5g/BJeYZVG7ok2M5MO3E6XURpkuvyW2XKc2jQ9nQoMnhscG7Sd2OX2ew==
X-Received: by 2002:a62:3044:0:b029:142:2501:398b with SMTP id w65-20020a6230440000b02901422501398bmr10772327pfw.80.1600343790923;
        Thu, 17 Sep 2020 04:56:30 -0700 (PDT)
Received: from varodek.localdomain ([223.190.62.192])
        by smtp.gmail.com with ESMTPSA id z1sm20174720pfz.70.2020.09.17.04.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:56:30 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Andres Salomon <dilinger@queued.net>,
        Antonino Daplas <adaplas@gmail.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1] fbdev: aty: remove CONFIG_PM container
Date:   Thu, 17 Sep 2020 17:23:14 +0530
Message-Id: <20200917115313.725622-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changes made in below mentioned commit removed CONFIG_PM containers
from drivers/video/fbdev/aty/atyfb_base.c but not from
drivers/video/fbdev/aty/atyfb.h for respective callbacks.

This resulted in error for implicit declaration for those callbacks.

Fixes: 348b2956d5e6 ("fbdev: aty: use generic power management")

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/video/fbdev/aty/atyfb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb.h b/drivers/video/fbdev/aty/atyfb.h
index a7833bc98225..551372f9b9aa 100644
--- a/drivers/video/fbdev/aty/atyfb.h
+++ b/drivers/video/fbdev/aty/atyfb.h
@@ -287,8 +287,8 @@ static inline void aty_st_8(int regindex, u8 val, const struct atyfb_par *par)
 #endif
 }
 
-#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
-defined (CONFIG_FB_ATY_GENERIC_LCD) || defined (CONFIG_FB_ATY_BACKLIGHT)
+#if defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) || \
+defined (CONFIG_FB_ATY_BACKLIGHT)
 extern void aty_st_lcd(int index, u32 val, const struct atyfb_par *par);
 extern u32 aty_ld_lcd(int index, const struct atyfb_par *par);
 #endif
-- 
2.28.0

