Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AB72DC4AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 17:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLPQxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 11:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgLPQxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:53:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013C9C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 08:52:54 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m12so50087459lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 08:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/qoEY29JOM4sZTGlBEoAlZzOFSKmu84C0sJ7wv+lleg=;
        b=cHhtSiYhsrtHXtHJGx1atrnUKeyBxd6VJvZIGuSPH3Q5hK8FEimFH27NuKRnuquBMe
         PQl797v2Fap3PR2lU56zy3DpSvpQNKi79Hr1Rim3yEKzsD6LoFDtcltOiX/mDjIyV3jJ
         TuzbjDF7pnETa694w4jmjn7Pfc8LkXyGl1g73k6h4W9ELyGxAdu49S9dYXV/3LJBY38O
         F2GYwFs8grUQrxugoet2V3KTwOwLX/Wms34Hj3cH78NpufqwNjGcb5vb7G4Q3RQNvkgP
         c2dOc4yVIetFrij+1k7UnXEP18Bspj/rGQWnll6Q5W4YHZg3N1FTPMgDXgnBdW2IjBNN
         L9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/qoEY29JOM4sZTGlBEoAlZzOFSKmu84C0sJ7wv+lleg=;
        b=MDzR4TlvPmzgChA3luZ/F1K7eDryKdvk22fptOFUBd8gQ9RJjAO+A9/Tst2MgF16ek
         rZL6Etlh/9n9eQ1IM9fKHqGXAI85gRhINXoXrtOvdvqc0BCTOnJ60unsCzzgpEJJkmQI
         pthHxGmIOo2F3DtDx3hmmd7XXG5sLAy+qgeHITluDDVtV8LFBD7Juh2CqnS/aLRv3R91
         TGL5QW/e8fYCx8jgY+h3L4bBHqE+pJchc/SDOSVAQk41kblO/KzvmwcmskJrVCB8XEkY
         bZO13JO20RI64dNKyIVFWjfkfLsL1HNpbMzQfWurvyv3bZxI858c3Za2cOAjTcu1ohck
         assQ==
X-Gm-Message-State: AOAM5333PiHkM/mc0qh+m5OuEZ3NWWNvcpVXi5VGAgoBY9BaFnzVjvbn
        NjBOqesQp/GqoBSvkgX69qWxLQ==
X-Google-Smtp-Source: ABdhPJxQsMNB2IgZX9oGX/FnFzTUJ7cQIdyUv67WiYWnTi4xWyfYhUrx468glupTX95s9Q76wSrQGA==
X-Received: by 2002:a19:58f:: with SMTP id 137mr14290215lff.0.1608137572176;
        Wed, 16 Dec 2020 08:52:52 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id t3sm281645lfe.263.2020.12.16.08.52.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 08:52:51 -0800 (PST)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org, s-anna@ti.com,
        ssantosh@kernel.org
Cc:     grzegorz.jaszczyk@linaro.org, linux-remoteproc@vger.kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, praneeth@ti.com,
        rogerq@ti.com, t-kristo@ti.com
Subject: [PATCH v2 0/5] Introduce PRU remoteproc consumer API
Date:   Wed, 16 Dec 2020 17:52:34 +0100
Message-Id: <20201216165239.2744-1-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The Programmable Real-Time Unit and Industrial Communication Subsystem
(PRU-ICSS or simply PRUSS) on various TI SoCs consists of dual 32-bit
RISC cores (Programmable Real-Time Units, or PRUs) for program execution.

There are 3 foundation components for PRUSS subsystem: the PRUSS platform
driver, the PRUSS INTC driver and the PRUSS remoteproc driver. All were
already merged and can be found under:
1) drivers/soc/ti/pruss.c
   Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
2) drivers/irqchip/irq-pruss-intc.c
   Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
3) drivers/remoteproc/pru_rproc.c
   Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml

The programmable nature of the PRUs provide flexibility to implement custom
peripheral interfaces, fast real-time responses, or specialized data handling.
Example of a PRU consumer drivers will be:
  - Software UART over PRUSS
  - PRU-ICSS Ethernet EMAC

In order to make usage of common PRU resources and allow the consumer drivers to
configure the PRU hardware for specific usage the PRU API is introduced.

Patch #3 of this series depends on one not merged remteproc related patch [1].

Please see the individual patches for exact changes in each patch, following is
the only change from v1:
 - Change the 'prus' property name to 'ti,prus' as suggested by Rob Herring,
 which influences patch #1 and patch #2

[1] https://patchwork.kernel.org/project/linux-remoteproc/patch/20201121030156.22857-3-s-anna@ti.com/

Best regards,
Grzegorz

Roger Quadros (1):
  remoteproc: pru: Add pru_rproc_set_ctable() function

Suman Anna (2):
  dt-bindings: remoteproc: Add PRU consumer bindings
  remoteproc: pru: Deny rproc sysfs ops for PRU client driven boots

Tero Kristo (2):
  remoteproc: pru: Add APIs to get and put the PRU cores
  remoteproc: pru: Configure firmware based on client setup

 .../bindings/remoteproc/ti,pru-consumer.yaml  |  64 +++++
 drivers/remoteproc/pru_rproc.c                | 221 +++++++++++++++++-
 include/linux/pruss.h                         |  78 +++++++
 3 files changed, 360 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
 create mode 100644 include/linux/pruss.h

-- 
2.29.0

