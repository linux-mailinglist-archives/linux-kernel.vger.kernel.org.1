Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF971301219
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 02:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbhAWBpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 20:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbhAWBpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:45:08 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAE2C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:44:26 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id l12so6137470ljc.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3e7pALlOJ19aHX2ythHC5kZ2SsW79vgYjMZJGeJUhKw=;
        b=uta6t1Z33tI7TQilA8NWV65/K68sgO6oNit9BZE4k+6uvfQaoWfPArI8J22mbdfZnp
         OWTfh2RpYja+R46GlpykFWKlOlaK2IDOmvyBHpgH1sYzTZOP5ECISowKKIxNJnyqsYGT
         ksCL15puXcVCRftS7LLNKgV1HdxbECaXS3hM4zqzWgSbJ9H4ukwhFkL44cyn0PEtYG5Z
         fK2P46SZzR16iNmpX6LCjuBPciQYjOOLgUfoUEvBjY9mzbJPluQCO9VPN0RQ+GzhQhac
         MhhdxgA6CIa3b9FlE6seigMheYOy6dE5FbjMASBVy9geiaDdaEYeerVck+OWQGxacEhO
         DQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3e7pALlOJ19aHX2ythHC5kZ2SsW79vgYjMZJGeJUhKw=;
        b=JSNhde5sIGFi5NH6zw02obH+V1rwSA3lT53jdls5ZUrvo9nz9JASfJcbsbu5ODk2Rg
         JTieYxzc1BO1qf/9gtz0NTpIJTF1eD+7dMHxNXirKnnt+8vfNrO7mTiaIqj9TBg0pfK0
         69Qtke8vjkwFOMrRF4J31iM/kX9hJyWSKkU6GWl8JmQYn7tEvewBAWNSAMY/2mIA7rWe
         xq/TIivht6ooPLq/nMGSAfPytKvX8ne3m4cla46G8NuRKAovva8hsCGmc1/Xt8H36ICN
         bXrhUHzmdYUPy8kbgXbh/s/48IXQSqxFN49plo4g1G9PjWV5nAyTjLxo6UrPkslauI+Z
         +ydg==
X-Gm-Message-State: AOAM530LSo3D5p67b27gdpeu6A8jqVDYW09W9YIBCnSqlTOOHFCYgg4q
        P1N9FOTvwof8InWveGFrqpteKg==
X-Google-Smtp-Source: ABdhPJz+wZ42Z8uxG3vZyUYvRZ9Voualg1NJScVwKaE9NOzHJg6feRwc+Xqsf7ZAHGroELeGeUB/7g==
X-Received: by 2002:a05:651c:118a:: with SMTP id w10mr842157ljo.13.1611366264832;
        Fri, 22 Jan 2021 17:44:24 -0800 (PST)
Received: from localhost.localdomain (89-70-221-122.dynamic.chello.pl. [89.70.221.122])
        by smtp.gmail.com with ESMTPSA id m8sm1154147lji.57.2021.01.22.17.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 17:44:24 -0800 (PST)
From:   Lukasz Majczak <lma@semihalf.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
Date:   Sat, 23 Jan 2021 02:42:47 +0100
Message-Id: <20210123014247.989368-1-lma@semihalf.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a missing call to start_tpm_chip before the call to
the tpm_get_timeouts() and tpm_tis_probe_irq_single(). As the current
approach maight work for tpm2, it fails for tpm1.x - in that case
call to tpm_get_timeouts() or tpm_tis_probe_irq_single() tries to
transmit TPM commands on a disabled chip what what doesn't succeed
and in turn causes tpm_tis_core_init() to fail.
Tested on Samsung Chromebook Pro (Caroline).

Signed-off-by: Lukasz Majczak <lma@semihalf.com>
---
 drivers/char/tpm/tpm_tis_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 92c51c6cfd1b..ff0e5fe46a9d 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1063,12 +1063,16 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	init_waitqueue_head(&priv->read_queue);
 	init_waitqueue_head(&priv->int_queue);
 	if (irq != -1) {
+		rc = tpm_chip_start(chip);
+		if (rc)
+			goto out_err;
 		/* Before doing irq testing issue a command to the TPM in polling mode
 		 * to make sure it works. May as well use that command to set the
 		 * proper timeouts for the driver.
 		 */
 		if (tpm_get_timeouts(chip)) {
 			dev_err(dev, "Could not get TPM timeouts and durations\n");
+			tpm_chip_stop(chip);
 			rc = -ENODEV;
 			goto out_err;
 		}
@@ -1085,6 +1089,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		} else {
 			tpm_tis_probe_irq(chip, intmask);
 		}
+		tpm_chip_stop(chip);
 	}
 
 	rc = tpm_chip_register(chip);
-- 
2.25.1

