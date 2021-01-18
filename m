Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5072F9964
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbhARFks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbhARFkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:40:24 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57659C061795
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:15 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p18so10224617pgm.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JeHiw/FpwQDcZsNOeLQX3j6js8Hh6OPhfk/qi3q2FA=;
        b=UJ5L4d3u8fwObWmWxX3lvsvXbsM2NLh0fqH72JVW2EAx3PPqdMxbVxnf1/R3eJI/hS
         T8guPZObYK9ilS107tqoRNJW0vjvwcotxBx6/4aJS02+peQcLd2mNz3do5/0miPpRjat
         IwMDm41+/OOh5caph/CJGq88CBJYLTRcvLFZS2M2NPto8k/E1NNZAjyfYQTWCew2ul0c
         1SX4i5XO5EIIfFJWH43awEu+5/iiZoLqPq7W/7OJuQB6s8ern0Nwz1TORyTQXZEeMmyt
         EyLtiAovb0JqjVwH/RRWBeygPxcBzDcs/EABc84pcoBYKP/sGRjrrWRCxH+0twl6G0gx
         W8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JeHiw/FpwQDcZsNOeLQX3j6js8Hh6OPhfk/qi3q2FA=;
        b=HP+hqcy85KAnaVxqJ4LhaPlGN4B+llh9EaBrWtqrL81mqq0k2YF8H6dkm9p10kvAZ3
         lqVps99fynADCRG8MXm8kMDL8+zFg13nwAVNGsyRFabAeVaLPc3b3DGzvKB/ZlvDYbOL
         SFjcewM3ks/0N30XwSbiHneggIL3WPpcsr6hjBdzW7TrhF29SZvKHaf/vftc1+PKtiIw
         WJdMgw1+rjCpWtSd4GMwJQplc7Zy1Ik/paLYyx3AUzbv/Tyi4NQxuNLO7KZlYsGs6ZGX
         ivrUW7nEKrO2dTF++admuESRfLqFWRsjkYllV93pb3kdYo6sZ4HAldHCZ7+k+Fn81mM9
         iYhA==
X-Gm-Message-State: AOAM532PYM16zcnr9e4am7lhyElSVg7Ou/apvpIIJhTE99POP2VBdAxx
        IEPA0lJoe/6UNYocWFJOzvfZ
X-Google-Smtp-Source: ABdhPJz8Myl/GSRJlnlRDvNeDyhShZP1mp/PDis/5zJOQ0IZYfu9Anb21ejc9BuFLRZHaB2qBJOT4g==
X-Received: by 2002:a62:5a03:0:b029:1ae:7e1f:7f1 with SMTP id o3-20020a625a030000b02901ae7e1f07f1mr24942959pfb.9.1610948354892;
        Sun, 17 Jan 2021 21:39:14 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id z6sm14627271pfj.22.2021.01.17.21.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:39:14 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/13] ARM: configs: qcom_defconfig: Enable SMEM partition parser
Date:   Mon, 18 Jan 2021 11:08:44 +0530
Message-Id: <20210118053853.56224-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
References: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Qcom SMEM partition parser driver to make use of the NAND
partitions defined in Shared Memory (SMEM).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 13b5a906b427..6f96a6ec6502 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -66,6 +66,7 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
+CONFIG_MTD_QCOMSMEM_PARTS=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_QCOM_COINCELL=y
-- 
2.25.1

