Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C127C2D9E99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440667AbgLNSJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440631AbgLNSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:08:45 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33A5C0613D6;
        Mon, 14 Dec 2020 10:08:04 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id w13so32469666lfd.5;
        Mon, 14 Dec 2020 10:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hv+Ar62w3lLlTVQnYXP/N/k2gR2AlpwwF6ie2NO2vhI=;
        b=hd0orKoRNYBi4s7sz2chxSUGRUe5YTdT9j7qCa8XrqXdppN4EjzNZg6hy6bFA7UK5N
         li2cbkFjjvxVKInYwhcv7IJ3GmgaHie9SWoe7NsT6AS8LX14cVTMHUNX+UkgICsIz8dc
         CEJ/VehbQMk+skWKpdXn9F2KokB+Sy6rPIhZvJJeYv2IvVfncBVHy9/iIbf0bR9Rn8TT
         YeX8tOAl5c3EnaE6gFQUee8fioFdGQaHeOUR0FrNng7kfShxzqe5NRfQWQVozW0VcNXC
         68V49VXorGjkMqPlJ82O8oJ+BASAPZaPhB3McejoBYmshvRBE0EEAX38jo/lXpDT8LqB
         Kz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hv+Ar62w3lLlTVQnYXP/N/k2gR2AlpwwF6ie2NO2vhI=;
        b=GjOBUTGPVu7ULVlHfbW/ecCf8SQP3vSTbErfwqtUESxr7R0UP7/CgpV6z2bQ9YY9WC
         IdjgEiSsyDw5nGkoIqjBmT/cs4+RW92SPWOHKSlY2YpURSYLn8SZaLnPuzHeoK5rsoPB
         kFTzrC7/vtbcZdOrCvZifiw270LIBWaupASreJWnJnKQtwOi15aUQJ06KA/++52DlwYg
         qOxeOwDqa3aa5evrnr4jE4yqsTaICj58bloxLZPTHbvXtP5JzOA9TtFptVI0WInq920A
         76+PALXexqaUOCozorVncttFxLp5HKXZOfsxHZCjPihxfFiCFR8FaaaRt/ol0AlDXRcL
         BsEA==
X-Gm-Message-State: AOAM5312aPx0saJLhOnSui84YCAfUJdDMied8nIrFd0fqnFbEP1C1J+I
        +EsK8N7bSjlSulsjyVVuP5s=
X-Google-Smtp-Source: ABdhPJxh87pNN5JkiSksL8N1M2t5PHV4NWra/OKW4aREqZs9qtCTTg0pXYcOiNnlgHB8yqKPKOzLMg==
X-Received: by 2002:a05:6512:210c:: with SMTP id q12mr9700069lfr.601.1607969282484;
        Mon, 14 Dec 2020 10:08:02 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id t26sm2422349ljo.16.2020.12.14.10.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 10:08:01 -0800 (PST)
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
Subject: [PATCH V2 0/2] Broadcom's PMB (Power Management Bus) support
Date:   Mon, 14 Dec 2020 19:07:41 +0100
Message-Id: <20201214180743.14584-1-zajec5@gmail.com>
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

V2: Use drivers/soc/bcm/bcm63xx/ and add Kconfig help message

Rafał Miłecki (2):
  dt-bindings: power: document Broadcom's PMB binding
  soc: bcm: add PM driver for Broadcom's PMB

 .../bindings/power/brcm,bcm-pmb.yaml          |  50 +++
 MAINTAINERS                                   |  10 +
 drivers/soc/bcm/Makefile                      |   2 +-
 drivers/soc/bcm/bcm63xx/Kconfig               |   9 +
 drivers/soc/bcm/bcm63xx/Makefile              |   1 +
 drivers/soc/bcm/bcm63xx/bcm-pmb.c             | 333 ++++++++++++++++++
 include/dt-bindings/soc/bcm-pmb.h             |  11 +
 7 files changed, 415 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml
 create mode 100644 drivers/soc/bcm/bcm63xx/bcm-pmb.c
 create mode 100644 include/dt-bindings/soc/bcm-pmb.h

-- 
2.26.2

