Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA4A1AFABF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDSNgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 09:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgDSNgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:36:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADDAC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:36:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d1so3618702pfh.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=RblCpCpLXbWuJsMERuO9DVd650AA3/h6YY4AZD4SWFw=;
        b=X5A5hZLJ0Cj8jqGJUKUcIE4GQrNUmRSnv9COSbDqTK78DuI7VHbY1PurSeC/oJ8trh
         xiP3gyuQ3dauR1F+T7hUxHY+iTGRyAh+ZkbAl72dT6utLGHDJirOSl3hGtxzybpBUXse
         mK9JrMEgswmSgZliP0K8gSzJy19zPoYdiMiUvCtfrlLOiTALVjPfAOQ2nWoAD4PDBcVS
         UXgSE7+FyYopnXSMKg7ie2ziF0iF5X7UBq4gW4iTFRCWJkiu5I5qEpJhzKHoC4m802VN
         701ZXzPXS3AFrIis+h++IwFc9tnKzp5CdhbBblcCcvnWB6teoutj14ab/QkIkvIZ/3cg
         Yx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RblCpCpLXbWuJsMERuO9DVd650AA3/h6YY4AZD4SWFw=;
        b=PhZ6u7HOEoisDVzwQAhGhVmW5iHJOmdvccbM1gtg8saeICFGAp39rkTvRisiooryD2
         7Vjh3GBS6ZMD/3VhujO6pu/+c8YvrYZtPhVI6Je2mS/Ajq5IS7Qr/TM3t9HiQTvneZ2J
         4X3jNOKOdgBoKgqBFuACzq7+gogrhrZCwKAccnWDaPEyUJic7U6bZxjyRnbboZY0YjAM
         extcRafjEcoHAP1+MR+HowqNRxb3XQ5Flp9Xjt3u6K+7iq4sVmBUdqd7Fui4lZjq0n7H
         2Ys11jgAq88w0qnvE2kpRDoaX4zLFZ+/0rhRRd4pEV3bkAVJ92h+C62ExnfLQ76DlCK4
         lvqA==
X-Gm-Message-State: AGi0Pua6celCfNxCx2fZlVxUBUA9b9IhfBlkbEouYFIMSHF/sv5BBnM4
        E96Fe2jbnyG7Hh5AmF9wRB7+RGTX1Y2xSQ==
X-Google-Smtp-Source: APiQypKXFp6SAaX2vn63nMBAn7YQFIRYHg55e3iF2XMDhtxv4RgYHlOgejy6hbVbkuYLLrOC3VbYuQ==
X-Received: by 2002:a63:1a0b:: with SMTP id a11mr11300674pga.29.1587303396605;
        Sun, 19 Apr 2020 06:36:36 -0700 (PDT)
Received: from localhost.localdomain ([115.96.105.18])
        by smtp.gmail.com with ESMTPSA id j24sm10955705pji.20.2020.04.19.06.36.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 06:36:35 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     ani@anirban.org, Ani Sinha <ani@anisinha.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Denis Efremov <efremov@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: pciehp: Cleanup unused HP_SUPR_RM macro
Date:   Sun, 19 Apr 2020 19:06:20 +0530
Message-Id: <1587303383-37819-1-git-send-email-ani@anisinha.ca>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not use PCIE hotplug surprise (PCI_EXP_SLTCAP_HPS) bit anymore.
Consequently HP_SUPR_RM() macro is not used in the kernel source anymore.
Let's clean it up.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 drivers/pci/hotplug/pciehp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index ae44f46..5747967 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -148,7 +148,6 @@ struct controller {
 #define MRL_SENS(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
 #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
 #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
-#define HP_SUPR_RM(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
 #define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
-- 
2.7.4

