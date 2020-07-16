Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826D4222DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 23:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGPV3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 17:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGPV3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:29:51 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8725FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:29:51 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so10055546ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSgxBMa/LciITm4xNGQOGJtl7ToeFI5VUQq2fMU9kUQ=;
        b=Zbz3DUNTVx11rl3Ngndz8qWW88ScyQKsu4g0teQujRj+i98pjRKuVKYnCW/epc7n5B
         I6wbujCpX75TTtgGwRqGCy9GuR6bWHtM1mKJwuABaWS9ywnSVCWW+ribuQppt7eSH1fR
         wlqea1KflCfEriSbPlJaKWUA3YCXDhBOVvc+mjYC1LlqchzUGgunlKlzCrpUHHbQUjpG
         9CsqSWeHeZ8padjnQUAxssUX8nRZzKAJkOQQuB+kuoY96tb5J6rPPYrrCkkn1Srn4/EH
         2OKjmy2OqpPkUPNbLIpaLPPCCqB8c+XB5Je8hDktji+BDm8+iwVuvE/9/M1IxzuhaJRk
         kYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSgxBMa/LciITm4xNGQOGJtl7ToeFI5VUQq2fMU9kUQ=;
        b=P3JSguGb3nqGZHmGgWJfjqQ4lLx81rN+7QpPRO3VXD4qRF14a8zCjbpW4DZMnR3Boc
         bJXk7yRXQs5tq2JkON0NQJMqlxH1U+JTE17Cf5QdiNfEARYEjBGZMEGsrqRrY9fAkE6a
         3Wua0tM0fzrl90Q5mEKjCRo7gZVB6X6ThB+PwZt+WPMRt0zzmAf4NjZ0lk8asb6+7TEn
         Bhrnq4w1l8GOjSYSpkcgrcOB9A0cLxmh3NmLHLX1G9RdSN+RktO33aNKj7gUz5wGypV5
         s+VZbB52emyBLlR/gNDoseiKOoSASPWuiBbwJjvydMjj9ndAkB1DonQZ61LX1nD0Omyq
         ynhg==
X-Gm-Message-State: AOAM532i3BBb73JvHHWk0VTzzgQK+/LhVtgyWbXwth6bzXwhRvV/qK1L
        /CMtfvQTxnNBXaFXdxGAM3F7iQ==
X-Google-Smtp-Source: ABdhPJyZvXQ8kQ0bJomu189c2+ewR7hN0lGTxEt+uwwWJdCfMT1d2Lobc/YG1w6zV/sSMoEOa52Mzw==
X-Received: by 2002:a2e:8216:: with SMTP id w22mr3132272ljg.2.1594934990067;
        Thu, 16 Jul 2020 14:29:50 -0700 (PDT)
Received: from PackardBell ([82.160.139.10])
        by smtp.gmail.com with ESMTPSA id r11sm1277137ljc.66.2020.07.16.14.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 14:29:49 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id 96f3d442;
        Thu, 16 Jul 2020 21:29:48 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Qualcomm MSM8226 TLMM binding and driver
Date:   Thu, 16 Jul 2020 22:55:27 +0200
Message-Id: <20200716205530.22910-1-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding and driver for the Qualcomm MSM8226 TLMM pinctrl block

Changes in v2:
 - Changed node name pattern to '-pins$' in qcom,msm8226-pinctrl.yaml binding
 - Expanded example in yaml binding with a 'serial-pins' node sample 

Bartosz Dudziak (2):
  dt-bindings: pinctrl: qcom: Add msm8226 pinctrl bindings
  pinctrl: qcom: Add msm8226 pinctrl driver.

 .../pinctrl/qcom,msm8226-pinctrl.yaml         | 132 ++++
 drivers/pinctrl/qcom/Kconfig                  |   9 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-msm8226.c        | 631 ++++++++++++++++++
 4 files changed, 773 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-msm8226.c

-- 
2.25.1

