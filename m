Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54002B8299
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgKRRDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 12:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgKRRDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:03:19 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5436BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 09:03:17 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so2933051wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 09:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YU4/VDfrF6SXnta/ZtzFGixkNuFm7oEQTxiBQ1MOvE=;
        b=DcCauwZODG9C9KDCCHwf5zbBDn8+ph91my9YgOYBkYeuOJUURcKUXo2Q92GxqVrnT4
         6ESMO8UR63avWUk7hm5ljw5V4CLAzDaIqrMxuq3+NzNO5PvXxTDnFJubeqFAIb3QlTLw
         dFPCUU0hS0EipKsUFkmSV3YqEQ40L/K3O4bh91C2/adgPG+l2rwEECe1ry08I11rEfxV
         Hje9quBPbQIAsbe2KyS8hTv7qsyB26U+eJm+unm7TFLJ/0V8HYwudBUuBBMGTCYBL0rI
         70pnC1hGniV2kPvtYV36xscNR4X9B3gVWO7GrFpGbK83/mUmU+FnvihTcIf2jG13HdGj
         GEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YU4/VDfrF6SXnta/ZtzFGixkNuFm7oEQTxiBQ1MOvE=;
        b=PhMsIrwX83vgdXxgvNbtegCrYRi/wOyyVtn96C/P8PJtVWcFJ/AXie4Xw1kodEH70+
         lVZuED0hmEDauUklWj0WhT27AbfGGoRNWwQ/qmdPLXp4WCUQFxGq/K382vpuyBJabFUw
         4/eDFETw+VvIos0LHyCv9NEf/dFgiHFbovYrZubqoPMWAbsPAKfyGp10AK1/wc+muvca
         qw4CoOtVLtsspIXiOMSGS6DUCWrRjoEBBJMdmUBPPhooIEXv1rAK1HXrYAgOvW5Ua0pe
         PwOF8WzI2TlZd60ZRWVn0LO+EYVmTu1e9CdF9OTx9jdLTvDrLWs6p9X7Myfd3VdNzQLF
         hUqA==
X-Gm-Message-State: AOAM530zjtJZRMWRKGcWu1xIhLNbcM4iQvZ/bFlBhGf/8XrC12HeMfXd
        vynIm6XRj4+Yk6pudiZUkfLmBw==
X-Google-Smtp-Source: ABdhPJwyafVZ5A61NzcRtYd9kIdiWBDwYv7z0pyImojRPLzHk57fiuxR7JwVCGidvBGKaDcufEoR8w==
X-Received: by 2002:adf:8284:: with SMTP id 4mr5950124wrc.386.1605718995969;
        Wed, 18 Nov 2020 09:03:15 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x13sm44233wmi.20.2020.11.18.09.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 09:03:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srinivas.kandagatla@linaro.org, srini@kernel.org
Cc:     bjorn.andersson@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/2] slimbus: qcom-ngd: Add SSR and PDR support
Date:   Wed, 18 Nov 2020 17:02:44 +0000
Message-Id: <20201118170246.16588-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm DSPs support SSR(Subsystem Restart) and PDR(Protection Domain Restart)
which usually restart the associated services!
Current code does only relies on QMI channel notifications, but there could be
race conditions between QMI notifcations and actual PDR/SSR events.

This patchset adds support to these two events to address those race conditions.

Tested it on Dragon Board DB845c.

Srinivas Kandagatla (2):
  slimbus: qcom-ngd-ctrl: add Sub System Restart support
  slimbus: qcom-ngd-ctrl: add Protection Domain Restart Support

 drivers/slimbus/Kconfig         |   2 +
 drivers/slimbus/qcom-ngd-ctrl.c | 121 ++++++++++++++++++++++++++++++--
 2 files changed, 119 insertions(+), 4 deletions(-)

-- 
2.21.0

