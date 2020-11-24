Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960202C28E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgKXOAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgKXOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:00:24 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26DC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:00:24 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v21so9478385plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wz1ZQP6uCXs7qi6a92QpxjDP7Q4q0QFNKJSTZ9GgIpg=;
        b=q0CqFe/N2bHDouVmvXJg2CmcpDYcrYnxkM1ztr5yCcahDdIUfjLnGgHKnWG2TDWyAc
         fdUsGj3V7+C5kDHWEpZwVD8/NnC637Q6qhmAnP4AutWWe/nntQaZc8Za6z4tEopzEzWZ
         fY6UpUgja45Kra63EqPQnubeVN7Epco+2arAs0HnBcZ0PtuuzSKTCi94Nc0Dvx1cKcFs
         8Cr9FYkiEy5BlwgShQj1NrDq4Bh6M49pbbjlcDe60oKaxvB0l9HJ58BS+Hp3oo1TPuVm
         1I2G1UX3JSTXagfikS3p0pE/EFQtK2Y/ulIHiaC0CE2VTtOUxnwIaW2BoR6WhXGpKB7L
         Yusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wz1ZQP6uCXs7qi6a92QpxjDP7Q4q0QFNKJSTZ9GgIpg=;
        b=I0PeqR6UVRPBiIpgC4vjffmczFSz2V/xtfS+DJNnNx6/zYE8cm5mkhnualAbhl/247
         R/Z09MZpi15k9oMBdppYjj8XjHrHUVuXjY8yIceMEphTh4Il70CZK9HEXNwJaS07gOX/
         kFtuRq9AFtpq91kn/+L4gohNXx1hJdL4gQ/nL4poihWT9FCGRAsm/6gdTlRZNbokLiFj
         MJJSm985F5pK3MSh2h9pwSKJSgNJ0RxoPSeaIxCJcY6+3obpbf4C6OVzRn1NjasVoxpp
         b7opONwN0FTKFo4fCw8k3Md/y0OdvUqz0DX/0C2cGb818DkuTyOKoOFe0HcOBWMweVPL
         c1lw==
X-Gm-Message-State: AOAM533uqntGx4BIUgAiLtmp/IdaUFTI/wewg/zkDqjwTOSpqKAXndq+
        KtzuvSKZ1FNnUYmt+p9XH2l4
X-Google-Smtp-Source: ABdhPJwV2ZxGORwQLjg9yXA/FyKYMbwb05bi9vAdwITsfIqHF0iNGwJo0RYYIzukOPIo7Mq0JBBtlQ==
X-Received: by 2002:a17:902:8645:b029:da:1a78:1d16 with SMTP id y5-20020a1709028645b02900da1a781d16mr3005273plt.21.1606226423867;
        Tue, 24 Nov 2020 06:00:23 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id u3sm14485937pfu.47.2020.11.24.06.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 06:00:23 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Add devicetree support for SDX55 Modem and MTP
Date:   Tue, 24 Nov 2020 19:30:09 +0530
Message-Id: <20201124140011.134751-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds devicetree support for Qualcomm SDX55 Modem and MTP
board. This series functionally depends on Clock support series [1]
which is under review.

With the current devicetree support, the MTP can boot into initramfs
shell.

Thanks,
Mani

[1] https://lore.kernel.org/linux-arm-msm/20201119072714.14460-1-manivannan.sadhasivam@linaro.org/

Manivannan Sadhasivam (1):
  ARM: dts: qcom: Add SDX55 Modem and MTP board support

Vinod Koul (1):
  dt-bindings: arm: qcom: Document SDX55 Modem and boards

 .../devicetree/bindings/arm/qcom.yaml         |   6 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/qcom-sdx55-mtp.dts          |  27 +++
 arch/arm/boot/dts/qcom-sdx55.dtsi             | 205 ++++++++++++++++++
 4 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/qcom-sdx55-mtp.dts
 create mode 100644 arch/arm/boot/dts/qcom-sdx55.dtsi

-- 
2.25.1

