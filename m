Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F6A2E90E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbhADHXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 02:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbhADHX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 02:23:26 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB4BC061795
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 23:22:40 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id e2so18529974pgi.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 23:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pXFP/mDtbX6rOKoKmCzMOZbkWkRy48BUP7gekqphCDg=;
        b=brRLnzPM+VCNZQWtez6ENRPD5HNQEo3PCZwVieBiA/8lJWMIzQwXuVEHn8mV1qWFwT
         RchZ0s9ml91okYiuwbNypm5R81tyH0IJvHjcDtf/A2n9yUnoXXbI2idHRh5AkIYu5xcU
         6lnm//V+Xw2TZj6UeCN+mfzJoiMeLwkOTY4z3j94WyvkrbQaqNVhWe0WIGlMxHTGosCM
         NJA8cUZkRfE1/GswcVV3MQH1/J9XSqFKfVEgkEdu6o5Z+gI+lRgbrClPNhahrLNH9v6N
         tgO5AQ1svI4ULETEhCPyBWanET8p5m1hf8vFWM7I1nxh/Le58jZJsId/ZzhS60diHzy3
         429g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pXFP/mDtbX6rOKoKmCzMOZbkWkRy48BUP7gekqphCDg=;
        b=g9L41eWwO/17FQpiUVQokTR/PEVnY+6jVnxr6C+pQSsjiFUtyTFwsXyBWAECzGRtDp
         5KZ5tC65KJcs0vGy954kI6glp/QxI2csPLJP3M6zDU/Vq/YyP3CQQhe1VCiJU8M3n9Op
         /XURqRoy5PrNHE3iyLnOIdKAQqk7Ay8WjqQKaQ703yYV8BZA7XTUBCqRXGDnulMe7zSd
         K0VFByL3yTukfOD1kqTc/qvWbOYGrHYhsjcXgjMGJrgLyfWbrW4uRns+w33VeJDu3TCY
         G9wioUQX04jhgkNOeF8d0LhEbHhjj1iRcEYkK45lmg5ky7yVm33E7j/VH5YAy1XZ+3LM
         dpaw==
X-Gm-Message-State: AOAM5323h5m88ft1vWqJ0OI/ukEU8mRO9mh+jOsh2EHVJb4XUC6YF96G
        f/+BNzuaWvLwGUFWhsbIUMoc9nU1zC8d
X-Google-Smtp-Source: ABdhPJz5zeJcaEXihwL5Z4D5OXRnNcKttdAONkI46PsJpNlLkxQ/qEihV7OsTSAl7yWZ+bxGIJfdSg==
X-Received: by 2002:a63:1214:: with SMTP id h20mr46514167pgl.379.1609744960015;
        Sun, 03 Jan 2021 23:22:40 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.160])
        by smtp.gmail.com with ESMTPSA id h7sm56676668pfr.210.2021.01.03.23.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 23:22:39 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Add support for USB3 PHY on SDX55
Date:   Mon,  4 Jan 2021 12:52:10 +0530
Message-Id: <20210104072212.144960-1-manivannan.sadhasivam@linaro.org>
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

Manivannan Sadhasivam (2):
  dt-bindings: phy: qcom,qmp: Add SDX55 USB PHY binding
  phy: qcom-qmp: Add support for SDX55 QMP PHY

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  2 +
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 83 +++++++++++++++++++
 2 files changed, 85 insertions(+)

-- 
2.25.1

