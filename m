Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554CE2C3859
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 06:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgKYFMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 00:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgKYFMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 00:12:22 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67248C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 21:12:22 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x24so1215825pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 21:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6k1IOsQDjGvUYpOQL8+dKZam2GpJjbx2h3F0tfq99Q=;
        b=lm5wloISPmPIpsMkmVsXeb9y1sX+o8SnV5tVZ1Sli/jgcrDpczXPSa9ZEcFtUXA8Af
         fHn0hzPuzLnZq+t8wRdcjEYGxJrcw00B0VfXcuG5qHiZt/TFqtKqvNws/N1+xjkrIzFg
         T74wOOSZSvMgnVH8Mz4cbWrcyBsIB7deqbVmo1iVhPejKf480JsNpsrrQzcrKIO3jbyx
         4Q8XpaOiAIY4MFmP6hvzyzCWh9/lEC58uJ+ThDjGEL19HdzpXz5tNQxNmBYkJofjjoJz
         pNknomy/0SVSTVLBKGmtXwUZ+kDeS1WzA3JWSLKeEc0UOCfxiVAI+CCkaNiltIbjjybd
         Z2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6k1IOsQDjGvUYpOQL8+dKZam2GpJjbx2h3F0tfq99Q=;
        b=nSmoT1gri8EHPW3fm/005QP+uQH2pmPAsy7ytsMVwpmHKWED3XdZhNzcK9okZX6B65
         ne7WJwwzHyaMMtHtOlniLfQsojCO2wtvfvE6UAAjl+tqITXlmEkq0rP0twmujFC+RvTo
         m1br29OuIYsJf5btR1e8JW3HFyD5J44v7+dn9Jev8e06LzHOYwsH7nBfo+Iz52Npp2yo
         kHTZWIEp51JwcY+9MvfRPWU/ndhPUSoVECx6V+T2vCrRuD8sYdMU64sIq2c0iQmIQCSr
         vZVNa6Ig+PEXEgJvRoD/JpMsoZix4urufLIyVPwjB1fTVOHyz7kSfBxPioIJ6MpgQCkg
         YgTw==
X-Gm-Message-State: AOAM532jcelOXi6gXsAPeQbfqiryJr9NjTVzidBsWeCvfS3cTPhDib1X
        74fj8V/ZZwIcQG5aJUx23I+K
X-Google-Smtp-Source: ABdhPJxSmftf9qmgHx/LwTeuK7k8MhqnLoDp/5fru9cO8O+Wipj7JnSA7Yh6WIiXASkM7GfndP0Lbg==
X-Received: by 2002:a17:90a:de89:: with SMTP id n9mr2093594pjv.224.1606281141935;
        Tue, 24 Nov 2020 21:12:21 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id x30sm763612pgc.86.2020.11.24.21.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 21:12:21 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] Add devicetree support for SDX55 Modem and MTP
Date:   Wed, 25 Nov 2020 10:42:09 +0530
Message-Id: <20201125051211.8089-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds devicetree support for Qualcomm SDX55 platform and MTP
board. This series functionally depends on Clock support series [1]
which is under review.

With the current devicetree support, the MTP can boot into initramfs
shell.

Thanks,
Mani

[1] https://lore.kernel.org/linux-arm-msm/20201119072714.14460-1-manivannan.sadhasivam@linaro.org/

Changes in v2:

* Incorporated review comments from Bjorn. Mostly minor changes.

Manivannan Sadhasivam (1):
  ARM: dts: qcom: Add SDX55 platform and MTP board support

Vinod Koul (1):
  dt-bindings: arm: qcom: Document SDX55 platform and boards

 .../devicetree/bindings/arm/qcom.yaml         |   6 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/qcom-sdx55-mtp.dts          |  27 +++
 arch/arm/boot/dts/qcom-sdx55.dtsi             | 201 ++++++++++++++++++
 4 files changed, 236 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/qcom-sdx55-mtp.dts
 create mode 100644 arch/arm/boot/dts/qcom-sdx55.dtsi

-- 
2.25.1

