Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D854D2F995D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbhARFkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731834AbhARFkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:40:06 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEC4C0613D6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:09 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q4so8018389plr.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zRHgIbGYKUU7i8u06ptczansmdt3ZUL6nqmXPC7YWHI=;
        b=Nljts/+Hi5SMt0E67O1gslKjhJrmb7OANgXusrscqZIVkccPoq3dZKAovkaCnB2B7W
         CaCzr56xHjOw2Gq0ghwaXX4PO+GgJlAMkNxi39jBbUTyUwdzNsqaxpSl/XJBSdINOXwZ
         XqVExjMAFY9o61XB1o9mw4tbf8Rzx5JtrC0J2UZOHHnrCIfgxFjNliLL2lRYfIgYvDOX
         UY1E8XnkknsHXUAvV7qUYty534gN0/AJ0N1kdiUMOmRi2YN2PBXR+FkWZ6xN2c79jaJq
         ad7Jnmt/Cf5BFlBmrm6AjV88HCgklR54gK38ZhsrVaiQ3/JXp9b6AJz9FBkJFFvWVr9l
         QShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRHgIbGYKUU7i8u06ptczansmdt3ZUL6nqmXPC7YWHI=;
        b=N0TdoNfT+Dgr1qzKPMaVsJeTxJsht0ueYn5cn3HVWw3B57JWwqQvFO7e90pzs6saoh
         3Dinqg+Hp0E11pf/Gzv7XRdWLq1GvxfYxzdZG9tqKgfEhH2OKm3EtnkZbHy2NbgH+BL/
         cxDfMtVbtYRIDDdqMrbRmiRPwwEUqwtS2ekY+C/N14MclpdlY3abxJxO8D2z3NNXYmwe
         n1tYOZ4msHacIG4yyTBH1dl35PysS2jmc8V/u/CI+uJxdSm13uwRdGJekpAuX2CzsvtU
         uINuz6pk0GTe9rhtZX7PKVlv2BMH1LEFnz+CldcJEJbUE+0kAuyPsCg3kCOGRY3KvQdL
         9j1g==
X-Gm-Message-State: AOAM532zK1mFTobTH7PLyi84ucTp71IQqeLA0NPD0Be+3D8ZxXd4V9uh
        6vmQtPgVq5v/hd1GsH4Rhwt9hXnqGHow
X-Google-Smtp-Source: ABdhPJw6XDPMZtZTAj+a2T6F7JzC8O9zeI8cL20FrIsf0o5TvK/lzjcdI4+bPhiRwEOJ/hkXgJBCwg==
X-Received: by 2002:a17:90a:c306:: with SMTP id g6mr25147896pjt.104.1610948348738;
        Sun, 17 Jan 2021 21:39:08 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id z6sm14627271pfj.22.2021.01.17.21.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:39:08 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 02/13] ARM: configs: qcom_defconfig: Enable SDX55 pinctrl driver
Date:   Mon, 18 Jan 2021 11:08:42 +0530
Message-Id: <20210118053853.56224-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
References: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Qcom SDX55 pinctrl driver and also enable the PINCTRL_MSM
driver explicitly since it is not selected by default directly.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 55318e814798..bd269ade52cf 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -124,6 +124,7 @@ CONFIG_I2C_QUP=y
 CONFIG_SPI=y
 CONFIG_SPI_QUP=y
 CONFIG_SPMI=y
+CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_APQ8064=y
 CONFIG_PINCTRL_APQ8084=y
 CONFIG_PINCTRL_IPQ4019=y
@@ -132,6 +133,7 @@ CONFIG_PINCTRL_MSM8660=y
 CONFIG_PINCTRL_MSM8960=y
 CONFIG_PINCTRL_MDM9615=y
 CONFIG_PINCTRL_MSM8X74=y
+CONFIG_PINCTRL_SDX55=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
 CONFIG_GPIOLIB=y
-- 
2.25.1

