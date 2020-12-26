Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA42E2E32
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 13:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgLZMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 07:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgLZMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 07:39:03 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52267C061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 04:38:23 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i5so4579157pgo.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 04:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NJH0qz4LjdVtDbPnQEDtbVeqdmqsx1F13+npYKUc6H0=;
        b=tRc7pWyim0QZFtnJGhh2MyTaa6L/IZyyE6TzWu2d7C6o/j/IoV0pMkPiMEEL+jeGJk
         ChTey7Dyos10NNg4wjCUfkNT2l5at4YcJOK+toF8XaWUm5rVpchqW8N/FlV4lDeb6dgr
         MvD9KgX9pXrYcrVf0YYQZHtE6DIlWfp+H96r2gWiVQBEfYmeb7Bz64RnCDPWTQXHkAU8
         KADKyqI/1KJugvOdrnz7M9+1Ox8SZRDJroawimLii2yZDQqJBEsx4YNWc2e0oGgRVYSY
         uqJ31JK5swLA9rVGecsewBLBO7EP73BeqYUFJNXml8Hh4t2+UwfZ4ftTXVdWFEQScbiA
         qmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NJH0qz4LjdVtDbPnQEDtbVeqdmqsx1F13+npYKUc6H0=;
        b=ddyyTMfYh8D4OOUAb/h/w6BczgGbFAWLFNRg81/MtFzXJ9g2XK6h8c51sP+P01a++Q
         bLFGC1HCEVc2Qp+8f8WE+SccaqAo24U9UOMtsOKLGAbVzRfw87haLzTKi2ex0q7hmpc+
         FLQ5Tc9Qx4kP0K+iG3nDy/MXi8O1fLDcyqLM4Gw97wlJDIAEJ8LcxKkShTVJ3LXFG2Z5
         lspnIOoOk+QjsvjyPpcVh6pVZxEa4n9nn/Jbmcc3T+fVYg3trxkzBLCNNX0xh1djLXmG
         YIxuOWWVbvFN7Fku2yle7yaYs/ZgwmVrWFHfWCXDdLaaxLpwOV5ZM8Qr/mMOhLqH8+VX
         e7IA==
X-Gm-Message-State: AOAM530j3IsZdMcdoE2IC3FU47DpQpfxB+CIBrzD3G9ApV4V6QUp3ojs
        O5dX5ovdxOSKT4oBo3+KRDnLIFmrQPs=
X-Google-Smtp-Source: ABdhPJyInvkf7qjg3A1M4UWGUFTdYTtrVxJtzZqPnoIbepxXOmxUmZhyVzDNZBfARITQEJTiwd4RUA==
X-Received: by 2002:a63:44d:: with SMTP id 74mr36005647pge.170.1608986302599;
        Sat, 26 Dec 2020 04:38:22 -0800 (PST)
Received: from ubuntu ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id y16sm23524966pgg.20.2020.12.26.04.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 04:38:21 -0800 (PST)
Date:   Sat, 26 Dec 2020 21:38:18 +0900
From:   Levi Yun <ppbuk5246@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] irq: export irq_check_status_bit
Message-ID: <20201226123818.GA693525@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of missing export symbol for irq_chekc_status_bit,
Building arm_spe_pmu.ko is failure on modpost step.

below is error message what i saw:
ERROR:modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!
make[4]: *** [scripts/Makefile.modpost:111: Module.symvers] Error 1
make[4]: *** Deleting file 'Module.symvers'
make[3]: *** [Makefile:1396: modules] Error 2
make[2]: *** [debian/rules:7: build-arch] Error 2
dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
make[1]: *** [scripts/Makefile.package:83: bindeb-pkg] Error 2

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 kernel/irq/manage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ab8567f32501..dec3f73e8db9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2859,3 +2859,4 @@ bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
 	rcu_read_unlock();
 	return res;
 }
+EXPORT_SYMBOL_GPL(irq_check_status_bit);
-- 
2.27.0
