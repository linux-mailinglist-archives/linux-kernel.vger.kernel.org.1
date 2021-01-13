Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F45E2F4DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbhAMOxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbhAMOv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:57 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2EC061343
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y17so2387629wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRcivOWCu86KtmbW2EK6Np9SsvS7JZY4Xqa/qkwVtkE=;
        b=t1ER4nwN/WPM6fNnm/Mdum0Pojlr01P78z/COYqJ1z5HyIHjWoDRfik8SQHtBQqxQK
         YmiySxijr8E0W29ccNGw29mWFYTILvz8yqxd4Jhjz4xgCEkubT+0KFcPLzD/bqSuhqOv
         bwbne25dLdz4tncYRuqLl24YT+dNFgIwqI2SBJY9J4cgkiSXbIrT5qKhC9+mgB4yvQc0
         udbu5Cayvxz6NRQyXKyHcIRbULqdBiGQkpmclevO2khhsi+G7TZ0owLOrYnOEnlNsCCt
         PsWXGjmGYEWJlNT1uNBNNRB3QkWWj1iQNibwkHhjoWky2+41zMmhl3Ve1ioMsvWRW5MO
         3aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRcivOWCu86KtmbW2EK6Np9SsvS7JZY4Xqa/qkwVtkE=;
        b=H1CZ5gf3JxXyy209YduYR+qw8s/cYrIl4lCoNZakfA/J5NT/awrMOiDuG9Hl8hOuvO
         DqDiGLsH5/ftZySMHlfUxH2EwwpR1qEZvPc/OGPZpw9dl1pLI5j1Lh+wu9rC/Tgsm9B+
         IkjcQ1rH9H7sUgIgRYRV0m72+KjeO4o22x8GWmJvnKcRZkd6nVrz90bCc/Mbd3HQP4BH
         9D/fcwsc/tsJq/h8QnY3xs086DMwXd3orILz9iHc/Qgjmg1+mLfOoyzObWFE923ZF8mY
         gp1i/QdS7PeRz4r90T8tFC9E7taYvUm0P5d29PIZhuv11PAUauz7vmm9FLg2Gscp/uWC
         8nMA==
X-Gm-Message-State: AOAM531MKe+Qp7MRVWgx69JMGR1B1/aDIcLO2bg+6wJoO6MNjU4odhxs
        B+0aXFWMxhwnckURVm5aquXcxQ==
X-Google-Smtp-Source: ABdhPJySPsgzKgHkiIcO4ZfvmXeUEmf0jtG+A5MVr9yGI+9UHHrTEsVD5G/gBIMGMpLdJt4RrmnaQg==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr3033393wrv.54.1610549442170;
        Wed, 13 Jan 2021 06:50:42 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hannu Mallat <hmallat@cc.hut.fi>,
        Frodo Looijaard <frodol@dds.nl>,
        Philip Edelbrock <phil@netroedge.com>,
        Ralph Metzler <rjkm@thp.uni-koeln.de>,
        "Mark D. Studebaker" <mdsxyz123@yahoo.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 19/31] video: fbdev: tdfxfb: Remove unused variable 'tmp'
Date:   Wed, 13 Jan 2021 14:49:57 +0000
Message-Id: <20210113145009.1272040-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/tdfxfb.c: In function ‘att_outb’:
 drivers/video/fbdev/tdfxfb.c:209:16: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Hannu Mallat <hmallat@cc.hut.fi>
Cc: Frodo Looijaard <frodol@dds.nl>
Cc: Philip Edelbrock <phil@netroedge.com>
Cc: Ralph Metzler <rjkm@thp.uni-koeln.de>
Cc: "Mark D. Studebaker" <mdsxyz123@yahoo.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/tdfxfb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index f056d80f6359f..67e37a62b07c3 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -206,9 +206,7 @@ static inline u8 crt_inb(struct tdfx_par *par, u32 idx)
 
 static inline void att_outb(struct tdfx_par *par, u32 idx, u8 val)
 {
-	unsigned char tmp;
-
-	tmp = vga_inb(par, IS1_R);
+	vga_inb(par, IS1_R);
 	vga_outb(par, ATT_IW, idx);
 	vga_outb(par, ATT_IW, val);
 }
-- 
2.25.1

