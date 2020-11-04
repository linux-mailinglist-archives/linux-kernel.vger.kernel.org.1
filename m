Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2055F2A6C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbgKDSQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKDSQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:16:32 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28317C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:16:32 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id a10so6224267edt.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScsUfMVtHVOkrxRg8IkMHR/vOs6RC0oZtG2XpQSfnDc=;
        b=GG12ddCjF6k3EWW69O4N/rQPdaTqdUAMdjBKaSCmt7TP+4b7THsvZqvOUGHgoM55+X
         U8BB+TLd3mad114TDBfNa1aPlh8EcEgrYUXbrEz8/elsflnkduaiL0E7MaVD6zTliAx5
         OWrrcGjwstb1zHjhKoMJwf1T2lvvcgeWsJ4oNX+CupBWK1jOzEpP0/gXc28FYHvoJkra
         Shrud1EJit4c8TOQMV1/+UcLOjfnHwcOtoHr/rAZxEC2obC5EkSGO7Bnr4j7b9FxPnWE
         kR0gY36H9gGm4FKmwjorKLzL5M+WEeMoxU+K7lhguCDupSK7vg8egQxyUpU0GBVpnRl4
         4XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScsUfMVtHVOkrxRg8IkMHR/vOs6RC0oZtG2XpQSfnDc=;
        b=O2kXg+xFoFo8Q4mp8/XLzDFUANcUs3xNercfB4snGdDvGgkV08kUtJKkeidaqUADub
         jjD3CF25rdqGtCCXyT0jR/oydii+SOsliOzErsGUyaPuDMwDSIqgokKHrCag7blv69+r
         NOf9xycFrjj+aaqzP4n0in1Nq5XZCWFfsdmY2DCYGxSbUqUIGKZ7QqSKB6t53a5K4Of7
         XYvvWzxcNGzfEkQhyYrNOJHWy/bpSgmDHtrQtHZ5SEmlCoeE9jxrVMW0aKoFl3kt1UtJ
         sFVjwm+TW2hn799nHpduW901amylkgJotp/XjzQ4Y4AIpUATAKRhsZ4vQi6fFbuV3Ki8
         0nYQ==
X-Gm-Message-State: AOAM5320CmDzIqpl3NcTibnjkcdtLrEqjuF730rXgt0AD/YcluiA+qba
        RYdJQwaXYBWpPyqCWRbfRjxeVk2Uk0MJ/w==
X-Google-Smtp-Source: ABdhPJxr8Z9P4OM6xMY8BXhqI+5M9rJf2u62htW8jxdcQQPuhJKFw4WGk2swstD7auAmEKLtA0sIPA==
X-Received: by 2002:a05:6402:1158:: with SMTP id g24mr27158697edw.323.1604513790800;
        Wed, 04 Nov 2020 10:16:30 -0800 (PST)
Received: from localhost.localdomain ([85.153.228.172])
        by smtp.gmail.com with ESMTPSA id u26sm1449448edt.39.2020.11.04.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:16:30 -0800 (PST)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] staging: ralink-gdma: fix kconfig dependency bug for DMA_RALINK
Date:   Wed,  4 Nov 2020 21:15:23 +0300
Message-Id: <20201104181522.43567-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DMA_RALINK is enabled and DMADEVICES is disabled, it results in the
following Kbuild warnings:

WARNING: unmet direct dependencies detected for DMA_ENGINE
  Depends on [n]: DMADEVICES [=n]
  Selected by [y]:
  - DMA_RALINK [=y] && STAGING [=y] && RALINK [=y] && !SOC_RT288X [=n]

WARNING: unmet direct dependencies detected for DMA_VIRTUAL_CHANNELS
  Depends on [n]: DMADEVICES [=n]
  Selected by [y]:
  - DMA_RALINK [=y] && STAGING [=y] && RALINK [=y] && !SOC_RT288X [=n]

The reason is that DMA_RALINK selects DMA_ENGINE and DMA_VIRTUAL_CHANNELS
without depending on or selecting DMADEVICES while DMA_ENGINE and
DMA_VIRTUAL_CHANNELS are subordinate to DMADEVICES. This can also fail
building the kernel as demonstrated in a bug report.

Honor the kconfig dependency to remove unmet direct dependency warnings
and avoid any potential build failures.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=210055
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/staging/ralink-gdma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/ralink-gdma/Kconfig b/drivers/staging/ralink-gdma/Kconfig
index 54e8029e6b1a..0017376234e2 100644
--- a/drivers/staging/ralink-gdma/Kconfig
+++ b/drivers/staging/ralink-gdma/Kconfig
@@ -2,6 +2,7 @@
 config DMA_RALINK
 	tristate "RALINK DMA support"
 	depends on RALINK && !SOC_RT288X
+	depends on DMADEVICES
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 
-- 
2.25.1

