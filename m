Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679C52648DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 17:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbgIJPgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 11:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbgIJPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:33:49 -0400
Received: from mail-oi1-x263.google.com (mail-oi1-x263.google.com [IPv6:2607:f8b0:4864:20::263])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192A3C061370
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:26:19 -0700 (PDT)
Received: by mail-oi1-x263.google.com with SMTP id d189so6246221oig.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pf2v6K7fWr+bHCgGUrV3kke5q6+ZGtBMsavuxBjru5M=;
        b=SfjaHdsV2lxdGQvWKc7EZuSFskirebpOlxOzXblt3pwchrHV6C4K5BhXP0Gyhrblhy
         6Ox39WJo6pbiXDZEsDnFEqqe1G5RvOK4XY+7AeKH55DNxvUUYoTPEzZ0fQNbH9n6nX1J
         7wtyz9RrLUfN1MJ3ldJ7dUzPrBnOA4tGN2klg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pf2v6K7fWr+bHCgGUrV3kke5q6+ZGtBMsavuxBjru5M=;
        b=SYpLtk60a9UqqNbFrZtpNEfubu6WOPhZGlmjn+XBhwmNya1dnUgWjht+9sjxpvOwBv
         Jd5LpcXDOK+nhtyYEbzWPMLEp2Vbfnu7NYOIdK1LbJ6dOHjpyMb5ByG7hdAF5e/YnF7a
         ivQthdL3BwlZEzFC9SofywLjSKN4HwHqmTTvZQMKqkWnut8d5X1R3SaB8csq2jwv9C06
         xuKgmf1Y3mXiiliqs/ArMMGA3pGvDu+fiMXMS1np+GIPOV8LNFrWBRpUJlXlJu152fIV
         cXdT8qoielEM19b+xxQLM0cqEtSnn7B8Zy9fGWQunXTiZXSfBDGK9ZJug1esYk3DQLjM
         eSnA==
X-Gm-Message-State: AOAM531YPIvij5M0u8k8A29X0C+1sYUz00UjCzeye/T+ARlR8C9k0q4x
        J3DJGv8Awxku/IutY3DlJSEm5gGuvXs9btQ/8lfsshlaSZl4
X-Google-Smtp-Source: ABdhPJzTjwr55nx7RvuWPGr4A0Ppz+2wny0SQ9PbuZXKywFz6zRzamwR7UTzBzOpwY39BqVvHM2+KO4l8h9d
X-Received: by 2002:aca:5752:: with SMTP id l79mr349595oib.86.1599751578361;
        Thu, 10 Sep 2020 08:26:18 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id h4sm943004oom.19.2020.09.10.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:26:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Ray Jui <ray.jui@broadcom.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 3/4] spi: bcm-qspi: Fix probe regression on iProc platforms
Date:   Thu, 10 Sep 2020 08:25:38 -0700
Message-Id: <20200910152539.45584-3-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910152539.45584-1-ray.jui@broadcom.com>
References: <20200910152539.45584-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iProc chips have QSPI controller that does not have the MSPI_REV
offset. Reading from that offset will cause a bus error. Fix it by
having MSPI_REV query disabled in the generic compatible string.

Fixes: 3a01f04d74ef ("spi: bcm-qspi: Handle lack of MSPI_REV offset")
Link: https://lore.kernel.org/linux-arm-kernel/20200909211857.4144718-1-f.fainelli@gmail.com/T/#u
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index c5209b42b0d2..b78d47a4403c 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1300,7 +1300,7 @@ static const struct of_device_id bcm_qspi_of_match[] = {
 	},
 	{
 		.compatible = "brcm,spi-bcm-qspi",
-		.data = &bcm_qspi_rev_data,
+		.data = &bcm_qspi_no_rev_data,
 	},
 	{
 		.compatible = "brcm,spi-bcm7216-qspi",
-- 
2.17.1

