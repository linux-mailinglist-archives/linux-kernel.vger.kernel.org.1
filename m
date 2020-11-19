Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B952B941D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgKSOJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbgKSOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:09:00 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A421CC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:08:58 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o24so6351295ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UF6cB4y26/1x+ilSgxNaVWPYjbbYhd7kb0SvD73E4kU=;
        b=ui9Fzug9MSbXWblCAU0MDz8kBmjHpPOA+hoxmzbFgaHhog5Uei7ieNNzC17jJC5xXk
         OgmaTyHT+6hLr5dzjkIyJ+MVA+gMjtMjOPPVwKlsKNdgckM0bXlqwsmnMKwhrBxl939N
         bWMtMzLSp4CmWBTlibdc83mY3I5xQH1kg5hLJ5Y05IDhp94ygaK5NUvc5ay2VXX5VcEW
         4mhHwhsr4Wi9rNZw7INdbzqllPp3rpMAfeRBHp8vR9XQLe+KC0PpCSWf/ec2kbsYwVek
         Y7XJWjtDXAayJ9/h7GrTvJqHMWdz/a8nYd5Jb17bxrUaSvQmseoNUzeHdOhp8XewYOQg
         SLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UF6cB4y26/1x+ilSgxNaVWPYjbbYhd7kb0SvD73E4kU=;
        b=rF0C+kMzNR1YzMrbn0+x+29RU+a1LX/zKNHg4BTYKBF2g80Tc+fNJzY4bi4vYrjRtC
         LR0yCTuy1XqBhXzIaW/9eN3WH45nrQP8ZTsbAs7QJtj+OsOSM0UPwmVFszl3Pdz+xZoR
         13j/ip60dUGRt0+i3urWmI8UhHHYJS4NExRqecXtruJ6aSbgj9UXoSEg8ARa+3w1mIcb
         9Jzj5nTRJ3p6w7AO4iMVsKF6cz9tpbF4hHgnP+5Ah+0PCetFPsBWgWg/YR9l/pKDBhO/
         ZxXHR7dvS0KWDr1iOjhtjq/Eg8t4a3fekk3jS/252qetntCB67jI1ZMmQf4K0up7mDUm
         Rabg==
X-Gm-Message-State: AOAM530jd6I0ZSKGWIG5BCMHeKyho3r1WtbSBWHdTjHmELvsq8M7hQ8M
        +S4hTyrl1m5BsgRtYGp8juNCEA==
X-Google-Smtp-Source: ABdhPJx0TL5BdSP4dq002vIYpP7fDsQO06jmylq7JLz3JU64d0Gv7AEXiEzyjG8SHTDOmTip9RP+jQ==
X-Received: by 2002:a2e:90cb:: with SMTP id o11mr6356318ljg.465.1605794936946;
        Thu, 19 Nov 2020 06:08:56 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id h12sm4024706lfl.74.2020.11.19.06.08.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 06:08:56 -0800 (PST)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        praneeth@ti.com, rogerq@ti.com
Subject: [PATCH v2 0/6] Add a PRU remoteproc driver
Date:   Thu, 19 Nov 2020 15:08:44 +0100
Message-Id: <20201119140850.12268-1-grzegorz.jaszczyk@linaro.org>
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

The K3 AM65x amd J721E SoCs have the next generation of the PRU-ICSS IP,
commonly called ICSSG. The ICSSG IP on AM65x SoCs has two PRU cores,
two auxiliary custom PRU cores called Real Time Units (RTUs). The K3
AM65x SR2.0 and J721E SoCs have a revised version of the ICSSG IP, and
include two additional custom auxiliary PRU cores called Transmit PRUs
(Tx_PRUs).

This series contains the PRUSS remoteproc driver together with relevant
dt-binding. This is the 3rd foundation component for PRUSS subsystem, the
previous two were already merged and can be found under:
1) drivers/soc/ti/pruss.c
   Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
2) drivers/irqchip/irq-pruss-intc.c
   Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml

The following is a v2 version of the series. Please see the individual patches
for exact changes in each patch, following are the main changes from v1:
- Patch #1: fix two yamllint warnings.
- Patch #2: address Suman comments: minor style improvements and fix for
	    optional resource table handling (moved from patch #3).
- Patch #3: address Suman comment: minor style, comments and trace improvements
	    (no functional changes).
- Patch #4: No changes.
- Patch #5: Update documentation of pru_rproc_memcpy() function and is_k3 flag.
- Patch #6: No changes.

Best regards,
Grzegorz

Grzegorz Jaszczyk (1):
  remoteproc/pru: Add support for PRU specific interrupt configuration

Suman Anna (5):
  dt-bindings: remoteproc: Add binding doc for PRU cores in the PRU-ICSS
  remoteproc/pru: Add a PRU remoteproc driver
  remoteproc/pru: Add pru-specific debugfs support
  remoteproc/pru: Add support for various PRU cores on K3 AM65x SoCs
  remoteproc/pru: Add support for various PRU cores on K3 J721E SoCs

 .../bindings/remoteproc/ti,pru-rproc.yaml     | 214 +++++
 drivers/remoteproc/Kconfig                    |  12 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/pru_rproc.c                | 877 ++++++++++++++++++
 drivers/remoteproc/pru_rproc.h                |  46 +
 5 files changed, 1150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
 create mode 100644 drivers/remoteproc/pru_rproc.c
 create mode 100644 drivers/remoteproc/pru_rproc.h

-- 
2.29.0

