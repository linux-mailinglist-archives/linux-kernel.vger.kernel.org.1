Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB42636E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 21:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgIIT5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 15:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIT4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:56:48 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD9C061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 12:56:48 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nw23so5340113ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 12:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0/TgPqlSLn/j9s+2UIzvSqC09TziaWTutIlfUbwrOA=;
        b=AeAj5tdFWAaImvn98P+02+VhWs9vtaDJSm+RrRU8mZKNQN8Dr0jCQOYkA+V+4YCnWy
         MjHZLSO4HpwLaodn+7seEdggjVd0XzghTZ5KnZDcaDk6kTP1gddLPu1Wu4w/1lyOceW/
         WhhSnDHao9kJLIZUlzi7kKQvIUhi8pRF3bFgA2a/virMtJ/8NCn3lWk8fW8uBsStZ6de
         wAZWBERlNzL6jrgdT3n2wKLL6+rr6wp4L6JDt6eWUQM/cJd1JVU5vDc5E3lvwlULOlWF
         GAel3Jj1LoAbZ9Wyzp5VFLV+HD2PqCSBVpyapXNpFeUNiXuqOqcfufZjuo2IoYNtjpNi
         q3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0/TgPqlSLn/j9s+2UIzvSqC09TziaWTutIlfUbwrOA=;
        b=dUy93RhU8NhmhblQXt0uPITwEqoHndJzSXzoAC7cf0F0cURtVoJj5EmZ62Nrs9Xef3
         9C8sUMsonS/rLMlgFK35nChQT+cGqoSzmCevo6hqjcVgAnlAEi4icokptJMRN8BzcCw1
         E6xupsxbypct1bpIlfSB++Mjq9/fx+x8Wa119pL0OYssfKGGK/v2WyAVteWrIr5SYmOg
         dQD0P+t2FN5VaSvZyWxdkBlEMzZl0gE+FzXiu5z3JK0kopuQzTtMkbKLwKcs0+VnT69A
         USmilfUQA9jCNfvAedHt5Y0tCukcbWf7lc+BzyoEtQmkzFCFTH6CDvh8JG/elIuOecXl
         8IRw==
X-Gm-Message-State: AOAM530H/z7ERuwWA492HAPDX05ZX5nVvWJALcEkm00qbFN+wMfXuJjS
        1MuKGfZUByfbqnhynRZ1jwAUG1TFGpsLWQ==
X-Google-Smtp-Source: ABdhPJzVuJxTAoddtJ/CC2H74UiOmUq+E3OKfDA0YQUJdntnAKR3jyUqkpRiK4gfYyjaPHwtcu1kfA==
X-Received: by 2002:a17:906:341b:: with SMTP id c27mr5272803ejb.286.1599681406557;
        Wed, 09 Sep 2020 12:56:46 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-133.xnet.hr. [88.207.97.133])
        by smtp.googlemail.com with ESMTPSA id n26sm3510870ejz.89.2020.09.09.12.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:56:46 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v2 0/4] arm: dts: qcom: ipq4019: add more boards
Date:   Wed,  9 Sep 2020 21:56:36 +0200
Message-Id: <20200909195640.3127341-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for some popular IPQ4019 based
boards.

This patch series depends on:
https://patchwork.kernel.org/patch/11765789/
https://patchwork.kernel.org/patch/11760437/

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>

Robert Marko (4):
  arm: dts: qcom: ipq4019: add more labels
  arm: dts: add 8devices Jalapeno
  arm: dts: add Alfa Network AP120C-AC
  arm: dts: add 8devices Habanero DVK

 arch/arm/boot/dts/Makefile                    |   4 +
 .../boot/dts/qcom-ipq4018-ap120c-ac-bit.dts   |  28 ++
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts  |  27 ++
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi | 254 +++++++++++++++
 arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts   | 214 ++++++++++++
 .../boot/dts/qcom-ipq4019-habanero-dvk.dts    | 304 ++++++++++++++++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |   6 +-
 7 files changed, 834 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-habanero-dvk.dts

-- 
2.26.2

