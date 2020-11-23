Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DB12C1856
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 23:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgKWWYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 17:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgKWWYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:24:03 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCC6C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:24:03 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id v21so15604559pgi.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sYmwP8t7TxHJ62xKzIUva7lVBCpyFaPUSVAcVVKAMoc=;
        b=aOqJMx++sC+xT7/75CuI3FlV95QEjv3cRGoU1BWcQeShqdvzjNc2247deUlkdkBiMI
         T6aLg5cjgySA5tL2TsTbeL1s+TZI1N8mSgTln4ta865ol7ARUbNv1KhJ5k2vZFyT+P8m
         /fJbrBQXyLZBnkYrl9cgwJFVasnGS9EimQjWlhV7eoJ5tIh0xEYNFe6D2NFOmLVoLewO
         gKM4RZZwvgHOOPcVRL/sR+WiE3TqPrNC4KylQKYWssg5Ng38C6mjUwAeIrcPedHqSAPo
         RWKlGf40b80K7i3Vwza1VCY/kQxHwoaFCZgsiJNCzck/qbbp/MUBi5ygVeESoSXursQZ
         LY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sYmwP8t7TxHJ62xKzIUva7lVBCpyFaPUSVAcVVKAMoc=;
        b=hk7+nxe7pnBJ2997GVGraWO3wpX2tyITSaFpkflRihUSkfP+5xQjrKlQSBQTJJt0ay
         1qqq5dO27RlPs9UPzJhHWDY6wwUoFpXR3vzd5YWMW8hcxZYkF4pMd8NqhE5k3LhKfhLV
         A1kwhzM+vNLKcZXHaMA+MG6W0upNF8ytGYwSOkDuERYpjHtSdaVzxcVUXhu5iYoJKSDn
         x6gIfG6vkdD0pZXqAFdBA8SHLuvxn5bz92FOtBfl4TZ3KNBDoFUrNQDJutdlm6IXV6NJ
         InaDbp5bOUCvrGqhkoSHOr11xAczmFFUvW/wljLtvwhyu5C9au/+8SMH0/SZZITcujBY
         rdMg==
X-Gm-Message-State: AOAM531gr469Dk8sSOf7BB2lKo42jps6L9NRcN1CX1NiILxNoHLUChN7
        xYzgNT+2GmC2MqVc9Egs0aw6l6ToJZ3Qxw==
X-Google-Smtp-Source: ABdhPJyu9Uo9CrcFwMhgI4t9O9QAE3zTseSTSA2FM03Uq9woUurMxRBsbIeTJdDmDSwKdP+xMoWIQQ==
X-Received: by 2002:a17:90a:ee8c:: with SMTP id i12mr1182810pjz.204.1606170242542;
        Mon, 23 Nov 2020 14:24:02 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id ge21sm416029pjb.5.2020.11.23.14.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 14:24:01 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2] regulator: Kconfig: Fix REGULATOR_QCOM_RPMH dependencies to avoid build error
Date:   Mon, 23 Nov 2020 22:23:59 +0000
Message-Id: <20201123222359.103822-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot reported the following build error:

All errors (new ones prefixed by >>):

   xtensa-linux-ld: drivers/regulator/qcom-rpmh-regulator.o: in function `rpmh_regulator_vrm_get_voltage_sel':
   qcom-rpmh-regulator.c:(.text+0x270): undefined reference to `rpmh_write'
   xtensa-linux-ld: drivers/regulator/qcom-rpmh-regulator.o: in function `rpmh_regulator_send_request':
   qcom-rpmh-regulator.c:(.text+0x2f2): undefined reference to `rpmh_write'
   xtensa-linux-ld: drivers/regulator/qcom-rpmh-regulator.o: in function `rpmh_regulator_vrm_get_voltage_sel':
>> qcom-rpmh-regulator.c:(.text+0x274): undefined reference to `rpmh_write_async'
   xtensa-linux-ld: drivers/regulator/qcom-rpmh-regulator.o: in function `rpmh_regulator_send_request':
   qcom-rpmh-regulator.c:(.text+0x2fc): undefined reference to `rpmh_write_async'

Which is due to REGULATOR_QCOM_RPMH depending on
QCOM_RPMH || COMPILE_TEST. The problem is that QOM_RPMH can now
be a module, which in that case requires REGULATOR_QCOM_RPMH=m
to build.

However, if COMPILE_TEST is enabled, REGULATOR_QCOM_RPMH can be
set to =y while QCOM_RPMH=m which will cause build failures.

The fix here is to add (QCOM_RPMH=n && COMPILE_TEST) to the
dependency.

Feedback would be appreciated!

Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Switch dependency logic as suggested by MarkB
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 020a00d6696b..481c7b10133b 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -843,7 +843,7 @@ config REGULATOR_QCOM_RPM
 
 config REGULATOR_QCOM_RPMH
 	tristate "Qualcomm Technologies, Inc. RPMh regulator driver"
-	depends on QCOM_RPMH || COMPILE_TEST
+	depends on QCOM_RPMH || (QCOM_RPMH=n && COMPILE_TEST)
 	help
 	  This driver supports control of PMIC regulators via the RPMh hardware
 	  block found on Qualcomm Technologies Inc. SoCs.  RPMh regulator
-- 
2.17.1

