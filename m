Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3E82FCC70
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbhATIKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbhATIJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:09:12 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09876C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:06:42 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i7so14682716pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AOs3HzRR3mAFpw46cKXmvSbeM84R4INByCK26V8xTI8=;
        b=b2oNX+bT43fFEBKDnEG9zQ6OcyDDVc4GNtq5N7Rm7SnbaJU2dx/BT9GiMBtvtSXQIX
         ADvaEIEU+4RhYOjFDWQwcqJvxTo491/vjLjeq7mRelmHk/+dZQLxPGPuDG7VJllfNN8k
         Zgtyuo9iM4i2gjcdev3qU+e4E8rCkp7krxKkt1ETLQL7wR7jD5PTBv0x629eMnzccMOr
         KwokXh2cQ7ATdxZkZop7U1duPsO0zb2vplGCwbAa1n2IOi9mVChQ7vB9vL75BhBb7P6j
         0JpSf6cQqQq5FXOjXVYAoU8yHofdZzz9+4siO6xXLnQq0aURjUPpEWDKQ9oAcu4aASCi
         O0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AOs3HzRR3mAFpw46cKXmvSbeM84R4INByCK26V8xTI8=;
        b=kQ0VUQUKPxzTYI9S3QdHenW8WjcABMug1xyf72CGUfuH6lAXjvQmBJZV4O9X491EN8
         N6/+HMFfmnOM0jWw8cgmBbLu6zFiU3iO1gxznxAafwrRA0lgI78/qQO2v2IevKKtR5X0
         SJfik34tTX3mEnCJ6gh9OiP2Ida8GweY7GKl/dhw5+iSOOEhgTSd05WiMkNFABkL/Z4z
         ziaxuxsgSgcGQ0wnnNAmmfy+F9VPwi7NKJU6HzFXnMfMifAMifuwkVzxCP1I2nQxj6zO
         o7geD7kTTSjXXWhBr5RjNoNkYIELpISAIjtQPD/gMQz2oAsNY4UeMfugXKgQm7ZQ3frp
         zS5g==
X-Gm-Message-State: AOAM532zLCD23c+Z5AwsWsKMrQklnn5okM9pxDaTSwK9ae2f3co4WPNv
        +haNNbuKvHzGx6hSjBhm2MGo
X-Google-Smtp-Source: ABdhPJxoiq5/2zDrA3lE7ESI22QLiB2iZq8nx7yhoZ4gEunSxznOx0Cxw/w1cx3JBu+HXtydjfrgFg==
X-Received: by 2002:aa7:9625:0:b029:1a4:3b48:a19c with SMTP id r5-20020aa796250000b02901a43b48a19cmr8150583pfg.13.1611130001378;
        Wed, 20 Jan 2021 00:06:41 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6d85:48cc:b166:aab7:ff85:2769])
        by smtp.gmail.com with ESMTPSA id y1sm1324040pff.17.2021.01.20.00.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:06:40 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     georgi.djakov@linaro.org, robh+dt@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        okukatla@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Add interconnect driver for SDX55
Date:   Wed, 20 Jan 2021 13:36:25 +0530
Message-Id: <20210120080627.20784-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Georgi,

This small series adds interconnect driver support for SDX55 platform for
scaling the bandwidth requirements over RPMh. The driver has been tested
on SDX55-MTP and gives below DDR metrics using mbw [1] tool:

Src port: SDX55_MASTER_AMPSS_M0
Dest port: SDX55_SLAVE_EBI_CH0

Command: mbw 100

With bandwidth 500000:
AVG	Method: MEMCPY	Elapsed: 0.59058	MiB: 100.00000	Copy: 169.324 MiB/s
With bandwidth 700000:
AVG	Method: MEMCPY	Elapsed: 0.29267	MiB: 100.00000	Copy: 341.678 MiB/s
With bandwidth 900000:
AVG	Method: MEMCPY	Elapsed: 0.19608	MiB: 100.00000	Copy: 510.005 MiB/s

The copy speed seems to be the same for all bandwidth less than 500000 and
greater than 900000.

Note: The CPUFreq governer needs to be set to something other than schedutil to
see the difference. Otherwise the speed seems to be the same for all bandwidth.

Thanks,
Mani

Manivannan Sadhasivam (2):
  dt-bindings: interconnect: Add Qualcomm SDX55 DT bindings
  interconnect: qcom: Add SDX55 interconnect provider driver

 .../bindings/interconnect/qcom,rpmh.yaml      |   4 +
 drivers/interconnect/qcom/Kconfig             |  10 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/sdx55.c             | 356 ++++++++++++++++++
 drivers/interconnect/qcom/sdx55.h             |  70 ++++
 include/dt-bindings/interconnect/qcom,sdx55.h |  76 ++++
 6 files changed, 518 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sdx55.c
 create mode 100644 drivers/interconnect/qcom/sdx55.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx55.h

-- 
2.25.1

