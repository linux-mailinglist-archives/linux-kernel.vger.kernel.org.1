Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09382F3A04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392877AbhALTWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392511AbhALTWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:22:18 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46055C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:21:38 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n4so6399793iow.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4tq1P7BnAkatrqNGDQpHOpe5z56inFlYg2XDNhNI+Q=;
        b=biaMRh0O9oDOQvx+oUwwPRWjjh/FX6NN135X/N2buus5TzUhR55MoJv4zuKpIoYAIZ
         Qpk2fPpgtGqm3IMUGA6Ut6s4dlU1YV6VwT/1nmR6PisW2nZxCtwkZQEYYJbktm91R+pD
         zOcMUAD5BhEnxHcec2DUcBehAwEN53a+9pJmMOLCugznPyks1zjPcDykKJL2HlnIlW/e
         Yb0io3THIRc8zzANyucGE9xIuS6jJTosYJzhjoK5qMhTuUblS+yHIhmfQH3N9F/qr21K
         oeEAlM50SXxIOxrXf78GzSs4F+MqZ/Zx6yfUh4YpnVg2Moh7qlwixYve2ADb/AMp5zIC
         Pb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4tq1P7BnAkatrqNGDQpHOpe5z56inFlYg2XDNhNI+Q=;
        b=iZ029i3BfPvltWbUl9jAAC785C1tzIpsEuuCigUmB2YCJ+ywoxGkWQWIeRFeMJR6r3
         Vg59nITZXzIxVhiDFIya3ANy7B1jdDAqk/ie5b1PT8LOxmsxNS5VhbSYJBLcIPqONqit
         jTfu6Cawv841OEZSufjoiYVQbnERbObjBVRDugE5ilGMcSQSx+p1JQOPXS/zGTa8JYK4
         q77S/KufnN/3fyi1zruRVSYtPawQmZdi2YZ8qcxuMi0nRVIBks9CBaSrTD1TYLmZQgaM
         mvyPxMYy1eClvLZ+ltprs/BN7Nf+3KhYovCUJUzQz1VyF2qnS5Sk6vWAy/pWSBeJBp+6
         wKLA==
X-Gm-Message-State: AOAM533gHz6crH5YlNsj0dH57vVuoFcLB9aLd5951WgdKjuNSA//ZZ9c
        xt3wH9PbTjfN3R2ksJQ17EzFEoI/FVotZg==
X-Google-Smtp-Source: ABdhPJxpPxmhQHrmSjY3rRV/bFSkL94mUsO5XSD8ArciPST0jxNWcLFah6PJ0XjEYkWj1KHuJp0D+Q==
X-Received: by 2002:a92:cb44:: with SMTP id f4mr539177ilq.131.1610479297674;
        Tue, 12 Jan 2021 11:21:37 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id x64sm2112147ilk.47.2021.01.12.11.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 11:21:36 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        rdunlap@infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ipa: add config dependency on QCOM_SMEM
Date:   Tue, 12 Jan 2021 13:21:34 -0600
Message-Id: <20210112192134.493-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA driver depends on some SMEM functionality (qcom_smem_init(),
qcom_smem_alloc(), and qcom_smem_virt_to_phys()), but this is not
reflected in the configuration dependencies.  Add a dependency on
QCOM_SMEM to avoid attempts to build the IPA driver without SMEM.
This avoids a link error for certain configurations.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 38a4066f593c5 ("net: ipa: support COMPILE_TEST")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
index 10a0e041ee775..b68f1289b89ef 100644
--- a/drivers/net/ipa/Kconfig
+++ b/drivers/net/ipa/Kconfig
@@ -1,6 +1,6 @@
 config QCOM_IPA
 	tristate "Qualcomm IPA support"
-	depends on 64BIT && NET
+	depends on 64BIT && NET && QCOM_SMEM
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
 	select QCOM_MDT_LOADER if ARCH_QCOM
-- 
2.20.1

