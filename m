Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1FF2A8CDF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKFC3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgKFC3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:29:08 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A42CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:29:08 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id e21so2761913pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cx3VoQbaR+Z5v6mQk7FBIZ1yEyqwjxeeLB00ez5Q8ag=;
        b=MiUWaRZjxNWNLJlY97uyYRnFY3hLDVTrcG8EYyZuJYr2d5xfpNdLTnXBcGGhXJATKQ
         ASMZwZ+k7MDAq0hH52UczCF+gNKBiBtPNBk719ajwrAkl/BQ0oSTjgAoYjnUsbqsvKXg
         /nfrYyhTa3PTnXpNJdHaBAcGYTKlBftdJhrE6HENKNd8Jab11KDOyaUEKdaLQW1GWDPy
         AuBI4+EG6CSbPDFnJ06xN6zcY7k7lHU65KKuw+vpGC5z6CdexR9lMBhZBDK+bxlTnCIn
         t0cj0oY/4dFvSSicw006yG5TPTUf9ptLMYKUDGPRa1av6h/FnAzp9nI/4FH4dkxN/GC2
         l8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cx3VoQbaR+Z5v6mQk7FBIZ1yEyqwjxeeLB00ez5Q8ag=;
        b=Pch1lBbdxgiAl0JiXYyNrO9+Pv7gCCLfICnQoYQxVAntNOLTGqHolLploOLd/ydpQE
         ieUS91OypR8yIO0FNVgY2I9/DcZThma7vbaICUh4x1j54bAe225Dg9oWjcaY6OV9jqB9
         ay1M36P1sBuPIxqJH4Ci0ZP7B2799sMg3E9WMGWXXcsuvp8vaIfjF2BYJi5Wog0DniX4
         gk285hf7KgR0e5ftGB7t5C6jylefFbHtLBm/kh6UeGZL+pMQ8OmRb7h+G4LcxMjS8qfi
         Armu+RW3N9weB7IGnk5sGp8f2gH9z03edW2aJQp7VEXFZKDhJ6QGfXEOw/8Wmdx03+6R
         hevg==
X-Gm-Message-State: AOAM533ywNcuCPnJGBi7Z0NFuZ+2DSiDFplYJyExzY40Svm/iwhmzAz1
        RoiZBZYs6GuAC29ZU9ZP81SWtw==
X-Google-Smtp-Source: ABdhPJypRNlTCibcoawN7Q6kChCkjFXba6Cszjbj36YKmhg/NcAC4TV+sGQVNS4zQa3kZJ2wWLZGOA==
X-Received: by 2002:aa7:8bdd:0:b029:18b:9cb:dead with SMTP id s29-20020aa78bdd0000b029018b09cbdeadmr5304786pfd.24.1604629748103;
        Thu, 05 Nov 2020 18:29:08 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:29:07 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 23/27] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Fri,  6 Nov 2020 11:27:22 +0900
Message-Id: <20201106022726.19831-24-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 5d3362ea138f..3dd81c89d8f1 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1631,6 +1631,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 	DBG("%s: begin UHS2 init.\n", __func__);
 	spin_lock_irqsave(&host->lock, flags);
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n",
 			mmc_hostname(host->mmc));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b1d856664b58..4e2cb73a63bd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -723,6 +723,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.28.0

