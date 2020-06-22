Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6F920367E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 14:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgFVMLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 08:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgFVMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:11:38 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD11C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:11:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n24so17788505ejd.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zwilt9vL4hQVp9xstjNnlSMflEMCndqnATlv+WlgaOk=;
        b=uYNoiKQgiqbIFRXqocXZ0XQ5Sgg9QqfrYhCT/KpGOozaG1eU+xKiwLXUXE1twUgJsO
         FlBlEW/EruQMaIP0kHpFsUJSNIOpgtqZZgOwirV1fHoevKw4M6hhCmL21W5ZyhtPsNAI
         41ZTBm+4FMiPuQgtVy0o9pTqm28rGRwUjVr2UigqUAPJtnbQ2bSseVvrp7YYqMvANMud
         QXCqSpViZciAMF+K6kMpk6FL19gqjV6DNNQFChvkMXlQNVQUsDxoaLR+aTChO8zxaEJ9
         8nX1X+hve2JfYwAQzBtrP45rUmWP7DRlKSkBqpjbl8EgvYVmz1IQr+VeohcVp9sdWYUx
         GZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zwilt9vL4hQVp9xstjNnlSMflEMCndqnATlv+WlgaOk=;
        b=Nbk6ceRXOdVZl7besInWckBltoC1NbTebuHI+H/Fyi2lpesi7hpApiwtv+0QI99B89
         X8jg+utv7YsYORefyibyWjCAMkY7oxSbvfycFNTvo10f9aV6p9DGbeor7ARKpTh07D+K
         glPoQMKt+mX+423k2G33hXYJuJ2yCXcw6BJgU5VViLiss2V2kDmekgbLnd1AJoe7awWi
         Xd82aHBdK/4zH3ENgb0IHFYMMF7DFe0VJgDv7GgRuYHXYfI4UtgIN3CQKZNnRHL5xcIw
         Gj52jI8kz52FTKfxHfKaqxSenUZnS28vE0Wk+MdGtQJyEKLmivfLHYEHqs8+KKsFsMUC
         MQbg==
X-Gm-Message-State: AOAM533uxfgRgzk+o1FHRnaLTAlWntYKxrfcT5hanqA675Ph16B3wxa9
        mK5ozcFX2eAE46WOp0cQyyfzfN61
X-Google-Smtp-Source: ABdhPJyKLq6DZRNFLtGsYdWfeKFkZ6GDdxLaa/HZvqwh0eh0fHf6gb/gYU8cugP51b87cw2PWYryTA==
X-Received: by 2002:a17:906:fcb1:: with SMTP id qw17mr1940194ejb.445.1592827897047;
        Mon, 22 Jun 2020 05:11:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:c5d2:e67d:372a:5e48])
        by smtp.gmail.com with ESMTPSA id bs1sm12242112edb.43.2020.06.22.05.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 05:11:36 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] openrisc: fix __user in raw_copy_to_user()'s prototype
Date:   Mon, 22 Jun 2020 14:11:24 +0200
Message-Id: <20200622121124.80398-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

raw_copy_to_user()'s prototype seems to be a copy & paste of
raw_copy_from_user() and as such has the __user annotation
in the 'from' argument instead of the 'to'.

So, move the __user annotation in the prototype to the 'to'.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 17c24f14615f..46e31bb4a9ad 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -241,7 +241,7 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long size)
 	return __copy_tofrom_user(to, (__force const void *)from, size);
 }
 static inline unsigned long
-raw_copy_to_user(void *to, const void __user *from, unsigned long size)
+raw_copy_to_user(void __user *to, const void *from, unsigned long size)
 {
 	return __copy_tofrom_user((__force void *)to, from, size);
 }
-- 
2.27.0

