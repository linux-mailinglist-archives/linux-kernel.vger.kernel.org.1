Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93243293820
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392920AbgJTJge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391793AbgJTJgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:36:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E82C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:36:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x125so1450031yba.17
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=PtAKH6DNREdiEN9Qe266UtcfxzWmhFfBqOATLMy+hRI=;
        b=BGBLxfUai4HKny40hSGBeizN8/5UzZyJWwenaL5wQzUmUBQ6BPBY8fbeuhQ8XvS5ZN
         6yMwJ/VxRAaMMFD2DPT0VZTeeI/2XWwSQNbSyEGcvPuHkfHaZE/R1+wt9mayeCp+DeE6
         V7CvietRp6bVwpX/EYZUiAWSv/s6XyTDiPIDQgCIcJnhA/HwlPsRBemssWioNWC6LROD
         Y9IjBhmKBwqMLHY1rYJbAH//eXRfLVskG1NOnHDkbd808Wyr9SWLXnVc8i/un4050csn
         bF3hSajpk9pRbLv2C/CPgRwdL2Mx/UH6f8VoEMAt0UoPMOyTi1+49ZNnS+iJrQylntPr
         IfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=PtAKH6DNREdiEN9Qe266UtcfxzWmhFfBqOATLMy+hRI=;
        b=U7ocXm9qXsErYuv8V+69b7BrePOjc8gcgQgqM/t78frc/E26XM1Uy62To1H0MyobFR
         2RgneShXx4TgXgYv27iewDZoT3tR/O5IAmPeF8YJWkVFVPezzWqaTPkFIo2UL4HcxLkG
         N49EFUS7YdTSBmKl6HVjGbBEIlpya6klPavHyQNFkGZ9h75BEFWDWrKskqrn8swoztrD
         8gbDekAmABlZGeRiT4UZv/J6gFVLa8B8ig/HmRl6LqGjT7M0on2DPTXpbUbq69UMCaOy
         cxl8RAoxSeGXbCsjRUZiwUBsWalv4qm0uENlbqSnxgnIP6T8KnuDCxnon6L5bLTk3STX
         6mUQ==
X-Gm-Message-State: AOAM531mKXq6JAAGDva7H9FRVsic7jiNx5tjjkjMHosua8PHqadCAptC
        OLD6riE5/fiVkyflJUFnmPMuU0cIHa4=
X-Google-Smtp-Source: ABdhPJx5O45MNjK8kPomJpEZBTPeGhK+/Y7uUwZN2nYkT+G2j1powMl/QYaa5dZoBYn4Vx7tOlKOb6ngx5o=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:610a:: with SMTP id v10mr2991061ybb.352.1603186592762;
 Tue, 20 Oct 2020 02:36:32 -0700 (PDT)
Date:   Tue, 20 Oct 2020 02:36:17 -0700
Message-Id: <20201020093627.256885-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v11 00/10] *** TCPM support for FRS and AutoDischarge
 Disconnect ***
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Addressed comments from Rob Herring for dt-bindings patches:
- Added part number for the maxim chip to dt-binding and renamed the
  file. Fixed it on the driver side as well with
  usb: typec: tcpci_maxim: Fix the compatible string
- new-source-frs-typec-current now uses u32.

Added Reviewed by tags from Heikki.

Thanks,
Badhri

Badhri Jagan Sridharan (10):
  dt-bindings: connector: Add property to set initial current cap for
    FRS
  dt-bindings: usb: Maxim type-c controller device tree binding document
  usb: typec: tcpci_maxim: Fix the compatible string
  usb: typec: tcpm: Refactor logic for new-source-frs-typec-current
  usb: typec: tcpm: frs sourcing vbus callback
  usb: typec: tcpci: frs sourcing vbus callback
  usb: typec: tcpci_maxim: Fix vbus stuck on upon diconnecting sink
  usb: typec: tcpm: Implement enabling Auto Discharge disconnect support
  usb: typec: tcpci: Implement Auto discharge disconnect callbacks
  usb: typec: tcpci_maxim: Enable auto discharge disconnect

 .../bindings/connector/usb-connector.yaml     | 19 ++++
 .../devicetree/bindings/usb/maxim,33359.yaml  | 75 ++++++++++++++++
 drivers/usb/typec/tcpm/tcpci.c                | 72 ++++++++++++++-
 drivers/usb/typec/tcpm/tcpci.h                | 18 +++-
 drivers/usb/typec/tcpm/tcpci_maxim.c          | 31 +++----
 drivers/usb/typec/tcpm/tcpm.c                 | 87 ++++++++++++++++---
 include/dt-bindings/usb/pd.h                  |  8 ++
 include/linux/usb/tcpm.h                      | 19 ++++
 8 files changed, 299 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,33359.yaml


base-commit: 270315b8235e3d10c2e360cff56c2f9e0915a252
-- 
2.29.0.rc1.297.gfa9743e501-goog

