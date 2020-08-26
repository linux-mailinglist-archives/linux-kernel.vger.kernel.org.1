Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA09C252A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 11:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgHZJhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 05:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgHZJfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:35:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C4EC06134C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so1066762wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B4E9cSfXHfJFsjO894WOptYPwQ5/EooDFGNjs8a9MbA=;
        b=r726au1UQ7kMPGArZ786mhNfI/fKyc+1LUzeKJihwwMlnchKe/lERgKWP64vUe1I1Y
         Y0gkWO+MPKS9vCVA2CQ+NstGLZ63RejpdbctRvfT/O7Br7lKyGN2whD+FK7eGP6I0w0u
         Sq6lNnWp4FSZ8OzaKrEziBms5T7UgFNJ3+KNg8l3iN7zNMfgcCvZIckv1RLy+/1a1foE
         zfbyQo4Ui+txno8sEohJnzczCJrpoaoIp4z/btaJoG/G/DCpeSfEQdE9xuNW5GrxPtxv
         UwaPGRS5aS9vlfJLt/8F40AvQeYwr5xL+xXX9FEUqRWEatyULgQBmdICjlGQjsnkwmQb
         632w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B4E9cSfXHfJFsjO894WOptYPwQ5/EooDFGNjs8a9MbA=;
        b=GS6hqByAp9SRScAPxJqpYpS+v3tl5hCQizxv7wZXmWF4/TqMYbOgSVMl+/NB4K1Eis
         aYswUIzuG6pmfiFY+PNqU+yvKI9ZMef7xBGQIyTVsqnlfG0mrUnLNTGAM0pd3Yz9qvQE
         H2fs22ju6OGFoEL/GTAA/U1QZjBrIububrqV1c4pRMhm65SSEYHr6dnWJIfGZ+QARLx3
         QIPuTvDlvTA3B4VS8HNEEGnqWbFkLXlVvqXSSylqUM4fDXoL87Ki0ah/vaY36MRqSmAz
         fNbuYN69uYM1HhvB1VS5RaFnA60nCq/BkD6WK4Mfn9koBKb/VY5PFu2OnbG0fGXH460P
         P2Xg==
X-Gm-Message-State: AOAM5320shRaDfaMrEC0WP8EQimBcyQoqNknCf4BRMmeEZUeWR5PxV58
        XZi55Z575O9wFOCNxdlVyOwjSQ==
X-Google-Smtp-Source: ABdhPJyBLvA6umNRRhVN3ftfM9O0qrl1SQRnCExSXd25zEos5hTnBsQI0+4oZ30F+EHrD5r3+cToow==
X-Received: by 2002:a1c:e4c3:: with SMTP id b186mr6112239wmh.84.1598434471957;
        Wed, 26 Aug 2020 02:34:31 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Subject: [PATCH 22/30] wireless: rsi: rsi_91x_sdio_ops: File headers are not good kernel-doc candidates
Date:   Wed, 26 Aug 2020 10:33:53 +0100
Message-Id: <20200826093401.1458456-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c:24: warning: Incorrect use of kernel-doc format:  * rsi_sdio_master_access_msword() - This function sets the AHB master access
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c:32: warning: Function parameter or member 'adapter' not described in 'rsi_sdio_master_access_msword'
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c:32: warning: Function parameter or member 'ms_word' not described in 'rsi_sdio_master_access_msword'

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio_ops.c b/drivers/net/wireless/rsi/rsi_91x_sdio_ops.c
index 449f6d23c5e36..7825c9a889d36 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio_ops.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio_ops.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2014 Redpine Signals Inc.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
-- 
2.25.1

