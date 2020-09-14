Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5E926975F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgINVEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgINVEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:04:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B273C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:04:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bg9so123880plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B+yZcshbsoNrjw9/GyoZ6sfB8u3DeY+uiG54+fPG2CA=;
        b=QIZLLxWuhPfcEVva2nJ767qbObasCjM9V8Jb31/dgJYJjdusHNi8YJsv5gLnNFQ7Yc
         rLHu37Wddk1sIpLHa0uP3I2h9zA71vHPOqj0TBgvBDuJtNcIpUFN3mpmixq4QM8rTCJd
         5RQ6lPaeIlVGNC4K+e1WheYhHnFTvAshW+15lTv/zvbez9g3zYXzhh8MmXmOP/82L8EE
         Kf9PqYHd0cb8gb3Y/GDOZ4tGCV6XOqLSlkPmMblYk+Rl4KQkPGqxbCFqXTzaLci5PVLj
         WJx4XXmmmHz8fepTSyu12BiVF7duEd/kPijfysMl56mAUi9m8XaYBKLjFDMSCx0duFR3
         9e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B+yZcshbsoNrjw9/GyoZ6sfB8u3DeY+uiG54+fPG2CA=;
        b=JnW/A/vacM45NrrX7KxL96XIA4vkTunen2Ep5sGEHzvzaQbNmHhTccbThaBKLBGD/d
         La7F57b0sPeUalxUtjIOo271DoUXVtmU+JFGU9T+x9PVXqRjPGI4PJv9Rrlk1f+vO9WH
         EMUaT9pbb41o571KOPbcegA0+mU13vfa0n8EJi9RrlMXKEr8T1Uj66nfp/JiMB3lhlCT
         5pTreBxj5xRSRtGtaP5NgZkcF0VwlmEN5u0gv6aaiOZ5FzJQ7CcjdZWFswpAjFh1pbLZ
         8LZBUXeXynNYi8PQc/JkEhm89IQ67x+BdpTntsuAkLAOAnzZZyON7DYkuzpTYzt3CwzH
         xS/Q==
X-Gm-Message-State: AOAM530UNY5+oDbmwYgvEg4iJOEaTcNC7Q74i17uPZx0nfB7WLeEUOJF
        Zjx6tOkkDcsjEqopjV+kts0128hHrRlRuw==
X-Google-Smtp-Source: ABdhPJw4meDLhT1GWDTqYGlWuh5s5sZygb+syXL21fk3JYEchsaLbg8+bnuLLk7x6vlu2XvHtk24cQ==
X-Received: by 2002:a17:90a:e513:: with SMTP id t19mr1080297pjy.137.1600117475340;
        Mon, 14 Sep 2020 14:04:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id n9sm11222480pfu.163.2020.09.14.14.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:04:34 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH] irqchip/qcom-pdc: Allow QCOM_PDC to be loadable as a permanent module
Date:   Mon, 14 Sep 2020 21:04:23 +0000
Message-Id: <20200914210423.67579-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200912125148.1271481-7-maz@kernel.org>
References: <20200912125148.1271481-7-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows qcom-pdc driver to be loaded as a permanent module.

An earlier version of this patch was merged in a larger patchset
but was reverted entirely when issues were found with other
drivers, so now that Marc has provided a better solution in his
Hybrid probing patch set, I wanted to re-submit this change.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/irqchip/Kconfig    | 2 +-
 drivers/irqchip/qcom-pdc.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bfc9719dbcdc..bb70b7177f94 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -425,7 +425,7 @@ config GOLDFISH_PIC
          for Goldfish based virtual platforms.
 
 config QCOM_PDC
-	bool "QCOM PDC"
+	tristate "QCOM PDC"
 	depends on ARCH_QCOM
 	select IRQ_DOMAIN_HIERARCHY
 	help
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 8543fa23da10..59eb3c8473b0 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -433,3 +433,5 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 IRQCHIP_HYBRID_DRIVER_BEGIN(qcom_pdc)
 IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
 IRQCHIP_HYBRID_DRIVER_END(qcom_pdc)
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

