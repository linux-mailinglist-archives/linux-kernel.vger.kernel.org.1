Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCB2A8CE4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgKFC3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgKFC3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:29:14 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF6C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:29:14 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 62so2754862pgg.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wzRP1xFBhaZ7hkzZhizDzTNThTBUuNYKfhyIeI3kwA=;
        b=ip+Jsw2GHN9BWtwUEYwpCCONZlTDlDg7sduezAJccplVibKcxo/vRz6YQSqG8QyGGK
         tZSIoM6dsGgn4EDB5Pqg25NsuwMljpo/gqmg0ouDknVBpT9c2ryN2MQdVVE4Hi6te4y1
         64XWcpVPPjDh04JpFhZhqHBM8XGVCyjFIUkKNnaUjpDWUz6vkk36L3yv+t7GUi3mx9DU
         vXTUydZbMqt3dJUrxjhZVl0oyaUoal1fwOTQvwoNYLVCH1W6NJrrQzt2ZBF2A4FFugEv
         7/xdNgzEQ4hoy7r0qBXpR3LU1x2DWWeKQbLYHHaExjV4WayUyvzXfkUPvhyB71JhC+CK
         A2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wzRP1xFBhaZ7hkzZhizDzTNThTBUuNYKfhyIeI3kwA=;
        b=evha3BEkceNjuGTVB+xllJiOMy1tjkMDGxqNREhhYTKYyc+uouv/E15WienabDKvVK
         6p1p5lt9tkSZpFJMjMUVYNZn8VTXgRumyTJ9zukp2Mrtv25DyWPuLLps/8D31rMWXnXh
         eRKCJIJOkcNp+MelfgLf89J/t8q2wT9XjpnZRimD95LC44AntwkvYSpPBsTyj1eVY+n2
         LfDWkNlDSrzKu/348q3N9iXyL8YU4UG2l8wKOdJSP4OYqomANduvFMiZeDu/vqzGPTr4
         /jGmGn5WykhuZbLEvu369c0AApmi9rkmgoDwkf8QY/WE8c3tUjj4lIiRf9T7D8XFfBaO
         IZ2w==
X-Gm-Message-State: AOAM531dh0n09Zi8tLd+39+Ub2hph+X/yXASiM64lJ0BxeQahLO9JUn1
        fQtr3XYjDsPsi7q0oCRCwYgTJg==
X-Google-Smtp-Source: ABdhPJwKAVVPR2Cgpl/Qgt4qKkHmcxtVBDKuEazmOL09edA9alJqrdTutqE+GwB8uj4IrovFY8sEJA==
X-Received: by 2002:a17:90a:8b93:: with SMTP id z19mr5414102pjn.123.1604629754058;
        Thu, 05 Nov 2020 18:29:14 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:29:13 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 25/27] mmc: sdhci-uhs2: add post-mmc_attach_sd hook
Date:   Fri,  6 Nov 2020 11:27:24 +0900
Message-Id: <20201106022726.19831-26-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "post" hook for mmc_attach_sd(), uhs2_post_attach_sd, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4e2cb73a63bd..b85d9d077c61 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -724,6 +724,7 @@ struct sdhci_ops {
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
 	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
+	void    (*uhs2_post_attach_sd)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.28.0

