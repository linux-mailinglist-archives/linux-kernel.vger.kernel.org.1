Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE02D756E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 13:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395470AbgLKMQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 07:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgLKMPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:15:52 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244E6C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 04:15:12 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e25so8386191wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 04:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSQYi3dLtVwnUE7Pl/TP3BDVgqP8TWHMbxJBiJCII0E=;
        b=Dx5LivaHRPPR2HXGN6NhnuCdmBQJvKcZWNlLrTLzZFJwcB6RzJfmUfHHX4C4GRDH+l
         Fcl2VrSCqpI3weTIOmxR4ST1Ab+nn2xscu6tLq74x6PXQBQG65J05JwnSJmobYeE9qJM
         dVtzrRd4Izqw/X9RQc7u7y0Gf07xW1suebY6PqHPbvgQpw/9xyyNskglhVAb3CQtCOJJ
         yvkfzspi1t+d/nNAM30Lby/YgWlVGRWwtFu2aJkl7Qkl4q0eInKA1+hgGxL3Zq2Yij0n
         ylb9TP1E0wB3Gi46R4nOboIrRT4ILrik9FL+7bvCj7CtuSdXcbyObivBqO36KuGP9+qn
         d1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSQYi3dLtVwnUE7Pl/TP3BDVgqP8TWHMbxJBiJCII0E=;
        b=FHbYCXrIE+m4LCeCiv56xEUQrlBz/cCPRWIm9er/jEML4VDBHg9EWzNUEZoRN9mCtW
         5mfXJ1Z+/1+oIdfjy5pwnLlrLcDW+mCEl/Yw4BgxAuk9yzelkUGyt0rZXi4jZ3/QKMjk
         Wrz2MQjmf/8eXCPOEvBrrGR6eQlIRlUvUVYznRfebPPeQ2d1aoXbJFpFvN7ZPqdhD7f6
         l4sDQNZt6tEUk4i7mEwRqw1M4uFw9iYFQaB5efRmc4WBMqJhYdnwwzaEGspdJlrWtZnx
         ExzlDrSEoe9Ek03wHUhwbhF3qYoGLRl9/uHUBXbJEb4lp/DqWOjGGNfW667PqPLFrFXn
         P55A==
X-Gm-Message-State: AOAM532qHc8HEWqpKh7L9AOl3BbKvS+YHUb2Y0Yh5DyikAWHwFIYRlJS
        /NfnYgsWLAf4f3e3KrxUjrb4OQ==
X-Google-Smtp-Source: ABdhPJzOVm94SMfkeQ9hfL9CF7fkbPYJoEd7mWVHor1srR0OHVa66W4FFAeAs+pfP5iEXHtZs3DlKw==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr13429738wmh.110.1607688910750;
        Fri, 11 Dec 2020 04:15:10 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id s63sm16668115wms.18.2020.12.11.04.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 04:15:10 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Nettleton <jon@solid-run.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [RFC HACK PATCH] PCI: dwc: layerscape: Hack around enumeration problems with Honeycomb LX2K
Date:   Fri, 11 Dec 2020 12:15:07 +0000
Message-Id: <20201211121507.28166-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been chasing down a problem enumerating an NVMe drive on a
Honeycomb LX2K (NXP LX2160A). Specifically the drive can only enumerate
successfully if the we are emitting lots of console messages via a UART.
If the system is booted with `quiet` set then enumeration fails.

I guessed this would be due to the timing impact of printk-to-UART and
tried to find out where a delay could be added to provoke a successful
enumeration.

This patch contains the results. The delay length (1ms) was selected by
binary searching downwards until the delay was not effective for these
devices (Honeycomb LX2K and a Western Digital WD Blue SN550).

I have also included the workaround twice (conditionally compiled). The
first change is the *latest* possible code path that we can deploy a
delay whilst the second is the earliest place I could find.

The summary is that the critical window were we are currently relying on
a call to the console UART code can "mend" the driver runs from calling
dw_pcie_setup_rc() in host init to just before we read the state in the
link up callback.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    This patch is RFC (and HACK) because I don't have much clue *why* this
    patch works... merely that this is the smallest possible change I need
    to replicate the current accidental printk() workaround.  Perhaps one
    could argue that RFC here stands for request-for-clue.  All my
    observations and changes here are empirical and I don't know how best to
    turn them into something that is not a hack!
    
    BTW I noticed many other pcie-designware drivers take advantage
    of a function called dw_pcie_wait_for_link() in their init paths...
    but my naive attempts to add it to the layerscape driver results
    in non-booting systems so I haven't embarrassed myself by including
    that in the patch!

 drivers/pci/controller/dwc/pci-layerscape.c | 35 +++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index f24f79a70d9a..c354904b90ef 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -22,6 +22,8 @@

 #include "pcie-designware.h"

+#define WORKAROUND_LATEST_POSSIBLE
+
 /* PEX1/2 Misc Ports Status Register */
 #define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
 #define LTSSM_STATE_SHIFT	20
@@ -113,10 +115,31 @@ static int ls_pcie_link_up(struct dw_pcie *pci)
 	struct ls_pcie *pcie = to_ls_pcie(pci);
 	u32 state;

+	/*
+	 * Strictly speaking *this* (before the ioread32) is the latest
+	 * point a simple delay can be effective. If we move the delay
+	 * after the ioread32 then the NVMe does not enumerate.
+	 *
+	 * However this function appears to be frequently called so an
+	 * unconditional delay here causes noticeable delay at boot
+	 * time. Hence we implement the workaround by retrying the read
+	 * after a short delay if we think we might need to return false.
+	 */
+
 	state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
 		 pcie->drvdata->ltssm_shift) &
 		 LTSSM_STATE_MASK;

+#ifdef WORKAROUND_LATEST_POSSIBLE
+	if (state < LTSSM_PCIE_L0) {
+		/* see comment above */
+		mdelay(1);
+		state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
+			 pcie->drvdata->ltssm_shift) &
+			 LTSSM_STATE_MASK;
+	}
+#endif
+
 	if (state < LTSSM_PCIE_L0)
 		return 0;

@@ -152,6 +175,18 @@ static int ls_pcie_host_init(struct pcie_port *pp)

 	dw_pcie_setup_rc(pp);

+#ifdef WORKAROUND_EARLIEST_POSSIBLE
+	/*
+	 * This is the earliest point the delay is effective.
+	 * If we move it before dw_pcie_setup_rc() then the
+	 * NVMe does not enumerate.
+	 *
+	 * 500us is too short to reliably work around the issue
+	 * hence adopting 1000us here.
+	 */
+	mdelay(1);
+#endif
+
 	return 0;
 }


base-commit: 0477e92881850d44910a7e94fc2c46f96faa131f
--
2.29.2

