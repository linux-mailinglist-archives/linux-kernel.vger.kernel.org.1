Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CF22D817C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405963AbgLKWBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404898AbgLKWAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:00:38 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149E5C0613CF;
        Fri, 11 Dec 2020 13:59:56 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f11so12623205ljm.8;
        Fri, 11 Dec 2020 13:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLq4hgFyRDdJAphL4vmU9usVoKceWi8PTh4+Jo/J50I=;
        b=QPEiYE+cwBYhMOfMdiJt/IfXh9tKLWmKYEgx9x+GFwUCp/b6Rt3gTcl7kvOiURQK/l
         ohvj6cFTpEPSHZUK8C82phCzlvyiA+7jHceQYA8MS0v/+CClpo6gj3432tGSSZTTI2MY
         6u+MEECCurX471jMhSB7PUNBGShy3L8FgSy7jehcB22o3Ah2Z/ONj18H/ZMJTHmvs+HC
         PWgvE2YhhFFTcjh688wx3GigZJwXeu2JP6tpVmMUbj4ppSYfVWUP53DypZQ0AeqC6nsE
         VTeKszG3DNnJUbEpTzOVhpy9i4373Un1FQDA4Bo1xE9gZUV66CCQE553lkBOUtECSXX/
         UVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLq4hgFyRDdJAphL4vmU9usVoKceWi8PTh4+Jo/J50I=;
        b=gi5VLsqdIJm+3jkxC3Pinhgo/EHeMP+hwfOgotEmCPOHh7ebdQ2oM/YKyq8wHAzVPr
         wtbk6sHG2Rarf9tLdpns41oCSo+7Mn0/RtaEIvGNb56bSdgu9SdAK6pIcg9FFcKnp+nR
         Sib4q1H5TEZBXgxwUWybezQzwhexRZq6SQP78YbjH2JF1P4zfi/FGN49A2iudPT5vqS0
         tewHccxLYNLenRbLunNP1sH8wnfq0QKOp/37MnNHtw+E9+JU0xfejKiQtNTmH8/bpDRr
         ZkM7vJcWpc94IsxCfMk2+rXoEmm9RBVPe/6e3zaBvwJkFEgxo5fQ9l2jyGG3oFOdfOmj
         GU0Q==
X-Gm-Message-State: AOAM5319u/AAQCjjx00ir0tKKa8ifQ1eQiiQYODk71YEPk8KXd1Nprz7
        39ycqobqPb0MGN07rMCJiJM=
X-Google-Smtp-Source: ABdhPJxgU8MVm0MNrmmXSm3B7t5jS+idZhtKCp/7Jjme0pgo2FncGAqwK1a1lkMqs3M4ncia454HmQ==
X-Received: by 2002:a2e:b5ae:: with SMTP id f14mr6206302ljn.491.1607723994542;
        Fri, 11 Dec 2020 13:59:54 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id d21sm1026140lfi.137.2020.12.11.13.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 13:59:53 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 0/2] Broadcom's PMB (Power Management Bus) support
Date:   Fri, 11 Dec 2020 22:59:40 +0100
Message-Id: <20201211215942.5726-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

PMB is a hardware block used for powering SoC devices like PCIe, USB,
SATA. Initially I planned to treat it as a reset controller and Philipp
pointed out in review that PMB driver should use a power subsystem.

This is my refactored support.

***

Please note one difference when compared to the initial reset attempt.

As I store info about SoC devices in the driver now, I had to put
support for multiple buses there. That's required to avoid things like:

compatible = "brcm,bcm4908-pmb-no-1";
compatible = "brcm,bcm4908-pmb-no-2";

So now a single "reg" covers bigger buses (e.g. 0x40) in size, see:

reg = <0x802800e0 0x40>;

Other SoCs my use something like:

reg = <0x802800e0 0x20>;
reg = <0x802800e0 0x60>;

***

AFAIU this should go through Florian's tree. I based in on top of the
soc-arm64/next.

Rafał Miłecki (2):
  dt-bindings: power: document Broadcom's PMB binding
  soc: bcm: add PM driver for Broadcom's PMB

 .../bindings/power/brcm,bcm-pmb.yaml          |  50 +++
 drivers/soc/bcm/Kconfig                       |   8 +
 drivers/soc/bcm/Makefile                      |   1 +
 drivers/soc/bcm/bcm-pmb.c                     | 335 ++++++++++++++++++
 include/dt-bindings/soc/bcm-pmb.h             |  11 +
 5 files changed, 405 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml
 create mode 100644 drivers/soc/bcm/bcm-pmb.c
 create mode 100644 include/dt-bindings/soc/bcm-pmb.h

-- 
2.26.2

