Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098E12E05CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 06:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgLVFe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 00:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLVFe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 00:34:27 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DC1C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 21:33:47 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id g18so7686983pgk.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 21:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=YUHAHbCI0drInzG6ELg3dNzK8EoYj1q2s5BJB3ePa6k=;
        b=mfoIMfTH5lPKKTgLC8+6cOI8s0gn4w1bAIST6om7gq0J+FRqknNgFnQMReL7PA6Moh
         o3xKvlyl5mZvTzJ51m4rIraymck6lybAXUHgMcDKKt3TbS8q779vvJ2L4nIrOxRkF321
         5duto+vveHCKWLil7dA69JaahAiu/8oww8g1J3HD1H3qduhdT+aCRuBYaCvCFcGe2BQS
         Ccsb+qsIEyk1io5osSV9yhMZR2cUfFFKY2c87Kabf5QJCnkMknMhwCQ9yOxQ7iyjm4Ob
         W61EmqJEtszqk7dijzU9j9NqxWeL5lwQv59LiAh5uDu4mKZVWWpNV1Vos6/mtfpaNUho
         p20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=YUHAHbCI0drInzG6ELg3dNzK8EoYj1q2s5BJB3ePa6k=;
        b=rPecvOg5XWSzzsukUA9BeVggFJ3+o/c2ApQZNgVSX/uFA7PMV0FBze6IRN9Kr0YTk6
         AxKaciEWKMcXWiywVsR7eKz/xYk6HpOB+t+PEu47xz8ZXYwdvlQzUUUKTAO/OfP0SUre
         OqzXoKzZGiSU6de+N9falXrT6tBTdMPPndo8iQEpysktNY2DWbNM7nj3ujbTsdwtt5ib
         JhgUwaRQMGCNh1lo3nQG1XS1UAx2JaY811FggS0VuPINDZbfbLMUi6U1P7zb7MK5/y9O
         T1OadhCpn/LYnyYTAe7iii0eV0L3ijkm8viOVuQTI9nESXX3cS5YsTe5Q7f6jKSAr8tv
         qVDQ==
X-Gm-Message-State: AOAM532qjxyEwXWLSV7eryL0i68yBMFak/EkKlUKb1zNk5fiEgdzsfTD
        T0Fm+Lq1tbmkDA+ggRNwHw+nAQ==
X-Google-Smtp-Source: ABdhPJy498vO/gKUa4ozY9NZj7sN3umFjDxqbk8GZR+n2Ua9kgSLm6fENuOvhUBCMwhkH9nSj9edGA==
X-Received: by 2002:a62:7586:0:b029:19d:9ba9:c1bd with SMTP id q128-20020a6275860000b029019d9ba9c1bdmr18355393pfc.27.1608615226660;
        Mon, 21 Dec 2020 21:33:46 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d6sm18702609pfd.69.2020.12.21.21.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 21:33:46 -0800 (PST)
Subject: [PATCH] clocksource: clint: Avoid remove __iomem in get_cycles_hi()
Date:   Mon, 21 Dec 2020 21:32:30 -0800
Message-Id: <20201222053230.3229427-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        kernel test robot <lkp@intel.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

This cast loses the __iomem qualifier from clint_timer_val, which
triggers an sparse warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 drivers/clocksource/timer-clint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 6cfe2ab73eb0..83a8b38d46f6 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -63,7 +63,7 @@ static struct riscv_ipi_ops clint_ipi_ops = {
 #define clint_get_cycles()	readq_relaxed(clint_timer_val)
 #else
 #define clint_get_cycles()	readl_relaxed(clint_timer_val)
-#define clint_get_cycles_hi()	readl_relaxed(((u32 *)clint_timer_val) + 1)
+#define clint_get_cycles_hi()	readl_relaxed(((u32 __iomem *)clint_timer_val) + 1)
 #endif
 
 #ifdef CONFIG_64BIT
-- 
2.29.2.729.g45daf8777d-goog

