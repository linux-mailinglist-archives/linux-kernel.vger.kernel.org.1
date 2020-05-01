Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0261C1FE6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 23:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgEAVqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 17:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgEAVqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:46:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A7CC08E859
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 14:46:30 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g26so5214856qtv.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/e974up5L7p2EuoJjEWBhJm9+klgFA+qT9TcmGyWDxo=;
        b=wLK/MVUZkZamne+YmZbJq2sQLoZiWa+KiljiYYOGZcfkHyVBJu09IZuZ9m7a4qLQR/
         B3iZYN5z8neiWvtpjIbZYNtypUzIh+IH9TjQAmHtsmcTu0LOnKzZ4aygmpKffwo6Xy7k
         5qIJ/IwswlLPH/fWKnXouh9thdgOglNuqx6DwxPDILmcap0vKjcjRdEZOU4RhKtcNMQX
         JMXUkIeRULDzBjEhnWoKbNH8mfTvSQtBHQ35AlpeeqDd7DckPA0IUWPCP2GlmggKavaH
         M/j6bvQns92ZNHAv1Lk65bOvDJnCov9wNwEn9j4eZTDJ4oy/amF1bPzEyLkETUsXxXf8
         rJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/e974up5L7p2EuoJjEWBhJm9+klgFA+qT9TcmGyWDxo=;
        b=KfWiuzz0PCR9uwpIe/81Wj0PpBKLEy+uaTx9/wp+VytM9tJ3iSJLMznerivIRF9BTH
         p1KUjGaCzD2fY9/Uwcb88kvpoVhTuy8M3maR49M0b4Po7Jsoc7qqPktdAnvkWng6jfu+
         lSSBcDMVj2htxuFmoBgWroMU0jT/Kfd/4tJ4TsVrtz6pHTCAzMpTYVdq5FoXI9vBpC9u
         NwiAhxnsDhJJCe5TSzRIgPfsUs1EyWorSTD5Ml5z0IOivoJdHEm5znJbIqJrczXSjrcW
         nq1a6xfS6quu8i9zHG2oUcSu8g30LngfmKlU8HzjYAlQ5TVtili9zvWibjE0Gc4BTtQO
         F/JQ==
X-Gm-Message-State: AGi0PuaNytUV6ViaqhKrFrDDf0vGvV72wUHwIUDY25c2XV0Efxk6ZDlx
        xSXmO16ncjFPihL/YtOfTunF4A==
X-Google-Smtp-Source: APiQypKXHzx9oTOTGiRb+iQ4oW2F4i2JoLrfWhiIHML18OG8xyDjXlXVH9MgeiBh20w2RmlSSctQMg==
X-Received: by 2002:ac8:65d4:: with SMTP id t20mr5924751qto.358.1588369589840;
        Fri, 01 May 2020 14:46:29 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z18sm3470982qti.47.2020.05.01.14.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:46:29 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next 0/4] net: ipa: I/O map SMEM and IMEM
Date:   Fri,  1 May 2020 16:46:21 -0500
Message-Id: <20200501214625.31539-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the definition of two memory regions that must be
mapped for IPA to access through an SMMU.  It defines the SMMU for
the SDM845 SoC; the SC7180 already had this defined, though these
memory regions were not previously defined or mapped.

					-Alex

Alex Elder (4):
  arm64: dts: sdm845: add IPA iommus property
  net: ipa: redefine struct ipa_mem_data
  net: ipa: define IMEM memory region for IPA
  net: ipa: define SMEM memory region for IPA

 arch/arm64/boot/dts/qcom/sdm845.dtsi |   2 +
 drivers/net/ipa/ipa.h                |  10 ++
 drivers/net/ipa/ipa_data-sc7180.c    |  14 +-
 drivers/net/ipa/ipa_data-sdm845.c    |  14 +-
 drivers/net/ipa/ipa_data.h           |  23 +--
 drivers/net/ipa/ipa_main.c           |   2 +-
 drivers/net/ipa/ipa_mem.c            | 209 ++++++++++++++++++++++++++-
 drivers/net/ipa/ipa_mem.h            |   3 +-
 8 files changed, 256 insertions(+), 21 deletions(-)

-- 
2.20.1

