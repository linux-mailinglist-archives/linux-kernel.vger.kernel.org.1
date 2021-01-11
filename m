Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC862F117C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbhAKLbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbhAKLbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:31:00 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B13C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 03:30:20 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c13so8077549pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 03:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tZdSKPUdg0QDGbFaZYrIFu/bQSIpB+rjwg75CQ25njY=;
        b=stW3b9K44fBkgtMxHAsx4+skDu2pczIBN/RBBD5gu8f1NY4hdD+XpY+8nvyThDoXZV
         n8CZPQp3M7Slv6ZZNy6ShfxL3RExBrmZxv3FAFwLBLfkptq4aLwXM4lwvFKCTENPGpfN
         6TnIJUlWiWHNcPRTjPkhUkFeYycIhSL+SE/1i+ik7bDReNVN7grjfyL5R/VE4VvvbYhd
         vN0gTKOBxwphTOrrKSzS0F7GBGl3z9w3Nypw51h+WuIidKVfKXFjmzsQXNqCQ7vmU2Ei
         96dCxtHwEZywzxzcg1uR92UZ8JFFW5jmMFtHzg0fHHA/iAjDOrdwo21+WU7Uip8KAWDx
         FiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tZdSKPUdg0QDGbFaZYrIFu/bQSIpB+rjwg75CQ25njY=;
        b=ZWdLkTNWH7oE1Q2wJB/mKUXkY826jsfM42UDAPaDjAbJCh9ec1XNkMJWB93KtZwXy1
         92Fbw2sY07kU5Cgrq2J52f67jb15A2KHmLmU5niWrkrotiIiTQYeGrvNYgpkyvz4LwU+
         pzAwhlwczik90ZoHrCj/9zFVBBvg4bbeZfMTB3JH39dT+J0kJ9ZC335WwerZ9cW75Lvg
         agH6Jtn9ZeGFq8YtsYl+G8TEH7azIhV1S5ja6J7HR4iaa7CaEiiJYwGt97REVoDV7L2v
         potpkEVibqX4if453LtyRVtEHy5PDVb0x9e2Hfbx5JE6wDFYePHOWmR/NmuLl3Ehdszo
         JIVQ==
X-Gm-Message-State: AOAM53144ou7Pte5jrLCkNEWiWrFKsIW/RCPFW/d06S53FUJ8dcNSEeb
        yf+XdzzrXvEA5dwQR7YZKFXY
X-Google-Smtp-Source: ABdhPJy/7FFip09dmwvAlcJzDdJIghXS9SqEMJGUquhj5O/vw+3PSk5AfCKrmnYylJHlOp/JFIYDkg==
X-Received: by 2002:a63:2009:: with SMTP id g9mr19171155pgg.219.1610364619921;
        Mon, 11 Jan 2021 03:30:19 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.160])
        by smtp.gmail.com with ESMTPSA id x20sm18803134pfc.3.2021.01.11.03.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 03:30:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] Add support for USB3 PHY on SDX55
Date:   Mon, 11 Jan 2021 17:00:08 +0530
Message-Id: <20210111113010.32056-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds USB3 PHY support for SDX55 platform. The USB3 PHY is of
type QMP and revision 4.0.0. In this revision, "com_aux" clock is not
utilized.

This series has been tested on SDX55-MTP along with the relevant DT node.

Thanks,
Mani

Changes in v2:

* Fixed the binding to use only 3 clocks

Manivannan Sadhasivam (2):
  dt-bindings: phy: qcom,qmp: Add SDX55 USB PHY binding
  phy: qcom-qmp: Add support for SDX55 QMP PHY

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml | 27 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 83 +++++++++++++++++++
 2 files changed, 110 insertions(+)

-- 
2.25.1

