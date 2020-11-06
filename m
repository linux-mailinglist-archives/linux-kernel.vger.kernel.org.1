Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E622A8CE1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKFC3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgKFC3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:29:12 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A33C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:29:11 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c20so2928330pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VO4alIYzWpT/RwVpJHrL0FuhDDCUQBDuaOz3l1c8Zvg=;
        b=RZb4Z9QTABVXxV5JwDIA8O9KK6r/7ZbyZdiLePOrnMaBNmhNTZG43oWpib94I5Koh/
         Jsqffw5hBp3XloN0cqqMhkvkL4vDJgnma75Bpngzc0hqYe/63+RsFCa8CB9koBJFGe1N
         BAEKkM9HfDGpgfNPx0U7G/BmavcxYjhEFLpQAF4HdkTXxBd3JoVEF5/U833dKhJWI0DJ
         MbvHCVY99JFEdHa53jWt2uapnfrNAEFQw9pU8ipBZtbXESm8KYAhokRrH+0j6Lx8bsDb
         nDxMB0XzLvabJxgTXX2/meMB/J8qPsavu+ly4Ty8nvu8NI74BvtoiJv0WVYCOCTlKOt8
         pqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VO4alIYzWpT/RwVpJHrL0FuhDDCUQBDuaOz3l1c8Zvg=;
        b=SHBtKLCQEl1l72F5uezCKnU9XWy6dmChSMZaPYw2MXpzha1JlfTkWMbOtUPKdTUrDZ
         mJjn2xAQhfO9KBoxQCQ4wpxFyPbHbzF/MkWCUJ5YPt/WvzvxPahevUBNXHsJszkJwVbD
         3tdm0+U5PmnCzUcgx77/jMehrekWlomT6iVa4GqOlBjJU562Yfk5n1o9lFy2+6K9fSKW
         5Hp41lpsGMf9OI5k49bJO3WC+B7Xbq8O5+Ay4n2KVPIF/nQbj6H6uOicip1EvPTZvCjQ
         Du1PH+Z1IMxfByM4DmrkCXZfc4EpK1tcIL2xoLbPzOHZSNj6j0AN9Uo7OoUD8VPClpgb
         tj1A==
X-Gm-Message-State: AOAM5320jw185DmZzKpXlOQDNbjAVJMviUoeNNcky6VPYijnWofTkPpm
        jNchpHcmgl2K2PPo/eENPrtVjg==
X-Google-Smtp-Source: ABdhPJxyUhzSrs60GH/XttMxHZWHngc9fR6hhqUeDkRR7HD8qwlpNDHHkNLwNOHAJR1BveB8/CqD3g==
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr18893pjk.60.1604629751085;
        Thu, 05 Nov 2020 18:29:11 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:29:10 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 24/27] mmc: core: add post-mmc_attach_sd hook
Date:   Fri,  6 Nov 2020 11:27:23 +0900
Message-Id: <20201106022726.19831-25-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This "post" hook for mmc_attach_sd() will be required to enable UHS-II
support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/sd.c    | 6 ++++++
 include/linux/mmc/host.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 54e155ff44ff..9e0a5abe9be1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1411,6 +1411,12 @@ int mmc_attach_sd(struct mmc_host *host)
 		goto remove_card;
 
 	mmc_claim_host(host);
+
+	/* TODO: Is this the right place? */
+	if ((host->flags & MMC_UHS2_INITIALIZED) &&
+	    host->ops->uhs2_post_attach_sd)
+		host->ops->uhs2_post_attach_sd(host);
+
 	return 0;
 
 remove_card:
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 19a265190ad3..03131e4504ad 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -181,6 +181,7 @@ struct mmc_host_ops {
 	int	(*uhs2_set_reg)(struct mmc_host *host, enum uhs2_act act);
 	void    (*uhs2_disable_clk)(struct mmc_host *host);
 	void    (*uhs2_enable_clk)(struct mmc_host *host);
+	void    (*uhs2_post_attach_sd)(struct mmc_host *host);
 };
 
 struct mmc_cqe_ops {
-- 
2.28.0

