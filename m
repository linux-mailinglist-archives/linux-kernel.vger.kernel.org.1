Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31C5268EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgINPEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgINPDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:03:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C92AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:03:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so354074wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oguichTI2JiRh+M6kipMP5TlmvO7QX2E553rfXFO7+0=;
        b=QudsO20Qexc+Ktbp/b4Y3K2E/SCCF3kkzMqHXzNZxpkDra+1CpbXH6bVdbVkjqtZvO
         YbW2MHrCwGzrFdyJh+a6GizWnmcyf8XsQ7ChNgl5d+rCWl5Y/1yhMXl6/hnlE337b0ty
         1zOyYIktjFAR+dOjoSbTBUM+KBG/GRG7QpqL/30sdQtwCM81j2U2NhMgimfeU0J1Fgz8
         ILBSBKK/dfekaXnYV7A3Mktf76hMSGggZ1HfWUqF6YsGmiP666Hy9UwdxabO4FoNQwNP
         bT8Z36ehbnaqgxdpvqBUstw+Y3ciGIS3OLPOY4ypJ2GvGqRgXPU75oZqQ8yCcPnH1evJ
         q97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oguichTI2JiRh+M6kipMP5TlmvO7QX2E553rfXFO7+0=;
        b=nVVg+H0uyFEQatPVa7HZ1bRuCCaA76sjshSdf3QAo027pfJnn1kM7MJIo6n49bB0Bw
         kNloO+W4EKv7bNncScLnson5UokitmvlMpDu0INsWuCcr/4xecC/fta27esgJ1w0Nml0
         i/IPB/Er0fZAfs18CFMMs/3pZLbvYnrLVu5hgBO4bpopa2NO8Vhf4P+meUi5Fmoe37iN
         c5tHGMQ6bktm8uP4wAek87g8bUyuTXB6EbLxZOxDC3f/sto2ftI6B5zS3GdWicOmgoOY
         Di+iIBefRS/w0jqK9FmGhq6YZDWHdy1fVNRRBr1HJ6VbUV1Fr8EpIMjeZH4VbcpzUb/3
         w75g==
X-Gm-Message-State: AOAM530YV979tG2GI2pQ4f5PhWk256y820kIOqc7ZSaX2thRJgzITUa8
        fVS3Rm5JD1rnv5bYNL8PwvA=
X-Google-Smtp-Source: ABdhPJx2lY+MrWtjvr56gCqfupiUyXAQUpFI19jVo/Fv8wbpLoFlzdQNfLBEDFwiZtW3z+bY7XLMAA==
X-Received: by 2002:a1c:7e15:: with SMTP id z21mr7043189wmc.21.1600095809707;
        Mon, 14 Sep 2020 08:03:29 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id i3sm21214910wrs.4.2020.09.14.08.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:03:28 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     sagi@grimberg.me
Cc:     minwoo.im.dev@gmail.com, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] nvme: tcp: fix kconfig dependency warning when !CRYPTO
Date:   Mon, 14 Sep 2020 18:01:21 +0300
Message-Id: <20200914150120.449602-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When NVME_TCP is enabled and CRYPTO is disabled, it results in the
following Kbuild warning:

WARNING: unmet direct dependencies detected for CRYPTO_CRC32C
  Depends on [n]: CRYPTO [=n]
  Selected by [y]:
  - NVME_TCP [=y] && INET [=y] && BLK_DEV_NVME [=y]

The reason is that NVME_TCP selects CRYPTO_CRC32C without depending on or
selecting CRYPTO while CRYPTO_CRC32C is subordinate to CRYPTO.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Fixes: 79fd751d61aa ("nvme: tcp: selects CRYPTO_CRC32C for nvme-tcp")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/nvme/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 3ed9786b88d8..a44d49d63968 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -73,6 +73,7 @@ config NVME_TCP
 	depends on INET
 	depends on BLK_DEV_NVME
 	select NVME_FABRICS
+	select CRYPTO
 	select CRYPTO_CRC32C
 	help
 	  This provides support for the NVMe over Fabrics protocol using
-- 
2.25.1

