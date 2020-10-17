Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C370290F3D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411706AbgJQFaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411639AbgJQF3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:29:43 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F8CC05BD33
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 22:20:17 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m11so4512915otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 22:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yoJyq6OLL3E5x13cNBRugp0CPYddMVHysDILDRGaDnk=;
        b=WsQ5NKNWEQyp/lNHV86huvvV1ORT8c4bxu11FIMcxzdN+z/DjV9sC7OrCC8H8YX4wr
         6CVtKlfUDTKTeGXtV6SRK+rVWrRC6f14KCwaFeE7Add7TS9AUJBsDMwAU47lHrT8kAba
         xQ+PQBHv8dVCdKn9r4SKcSQvMkRKy9uefLQhwdwu3pvXuiaeYB6q1/9eJo+5G1ipaTH1
         YiOWgNg1Dl0z6ISfgO8Y13BIsmIiQ2+vFKl4tsF2zvpmWJBjSXrD8EwgzeAO1wnQYY9i
         S1Y5Aqm1n15nBdah8hSoPZ+LqZuv8A5pvbIvizzTXuZXNnHvYtfKmdAtykiy/TGtIIOm
         rBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yoJyq6OLL3E5x13cNBRugp0CPYddMVHysDILDRGaDnk=;
        b=jqo/vMI2WMNuxGc/Tr8P98Ra3N7ZHTdqr+5cy3AwUACCuwWuAPIzDZemuq46YzECoo
         Ib6r06SXoMZpYg40jqrGtygtWoTXqqCIb22bMLWgAB/8e1LbCOLyzVZ6OmG7lEB0XyaK
         OvO29BDQ1BV9IYWfBhno7xnr03P6j/QSNQfKEbjgUP2oBsGw3VqDZv4ID3bKYj8y6JVd
         zfeq1QFlmqT99TPNMjjKsbv1A0wg/rSxvEbLO1iNijeVEj0+pBFarotE+hxJbfO0WSoE
         E0S9CQ8pShlMtMOCRa3xQKrs5m2lBoV51/MGYy5QX2VNyK+ca4cKUcG1MZvnuFP9qWH8
         D5wA==
X-Gm-Message-State: AOAM531Q6ArDDswTxEuMyAO2NPCUAP4+EmAfr0b9OZJHtBfU0vbS20A3
        DTN4Z6Wv7hWYoVw66eM6nYXg3w==
X-Google-Smtp-Source: ABdhPJz/PYEQ27V6dj+y6ecyGo++ehAUJb2XYgGhMfsvY4XVD97JcbWmXfJf+e8G+BCOzG7Vv3gQQw==
X-Received: by 2002:a9d:34d:: with SMTP id 71mr4689442otv.251.1602912016658;
        Fri, 16 Oct 2020 22:20:16 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f2sm1572769ots.64.2020.10.16.22.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 22:20:15 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v5 0/4] Qualcomm Light Pulse Generator
Date:   Fri, 16 Oct 2020 22:20:53 -0700
Message-Id: <20201017052057.2698588-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a generic pattern interface in the LED class and
a driver for the Qualcomm Light Pulse Generator.

It seems like it's been almost 3 years since I posted v3, which was hung
up on the lack of conclusion on the hw_pattern and multicolor support.
Now that those are concluded I hope we can make some progress on the LPG
support again.

The dts patches are included in the series as "examples", ultimately my
expectation is that the dt binding and driver patches are picked up
through the leds tree, while Andy or myself take the dts patches.

Bjorn Andersson (4):
  dt-bindings: leds: Add Qualcomm Light Pulse Generator binding
  leds: Add driver for Qualcomm LPG
  arm64: dts: qcom: pm(i)8994: Add mpp and lpg blocks
  arm64: dts: qcom: Add user LEDs on db820c

 .../bindings/leds/leds-qcom-lpg.yaml          |  170 +++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi  |   49 +
 arch/arm64/boot/dts/qcom/pm8994.dtsi          |    9 +
 arch/arm64/boot/dts/qcom/pmi8994.dtsi         |   20 +
 drivers/leds/Kconfig                          |    9 +
 drivers/leds/Makefile                         |    1 +
 drivers/leds/leds-qcom-lpg.c                  | 1206 +++++++++++++++++
 7 files changed, 1464 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
 create mode 100644 drivers/leds/leds-qcom-lpg.c

-- 
2.28.0

