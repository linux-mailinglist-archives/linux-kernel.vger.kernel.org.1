Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20620A9D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 02:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgFZA1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 20:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFZA1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 20:27:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B4C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 17:27:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l9so7125013ybm.20
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 17:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iv7sfYwPBb+T3sh9Tm/gYiOZsGJSNCHeo7sHuB/mAjU=;
        b=gsWwDuEWxxXpafc13YiTJ2OicmolQf5h7KB/1owTbiu6Ee1j93pn2eUyAh2einvluw
         E8nZ02G/7r07CFhIK5dPv0ZlK2iUzky20NJwNJzL3BmkInHkfTJUi0whj4v7SeoBFp3g
         L/3uvCEgLYksFm2o4W1T7X4v2l1c/6dVt1wvCZUbCr3HPRrMHD/Wx73XJpbZlJYqrhpV
         KaBzdZ96OBEfsKzgIwFT42MUz/2ka3sVvK4ATXx/XlaVPmoIodvUZOQza8cC5ubLjNIz
         E74HpampI/OVzg9d/tQFsKbYUOV6dBx9FZXpN2zmmaEvoJ5q72zzytovyjewoIGXtbDl
         naBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iv7sfYwPBb+T3sh9Tm/gYiOZsGJSNCHeo7sHuB/mAjU=;
        b=Ue9+dyuIvTkGCVbxNHbvCTfduFvnf1q/Ai9bblni80h2LRJnE23BZQuGe0nS4QAPdT
         R8QpSV2s1bbiiZyV5fgjOxJqhJXjrwx4sGcb/16BSxqLkRUDjIGpqKgYEgFI8yF23SWE
         EQCIgbByAQsudYEvMFKmNhFBfetWcr5ZZxdQ+7jSS6UQ+jxIxa2Y1fz5csfYDk2nkTv6
         r3zt4jlVuTbgGpuXps4TihnYKaDenpNIsAor54cttK4eJB/x0ZMMepudaP8BFn84xIsY
         irMvkKDbbD3MZqmZIz1jY6YM2ZuZ9MN4WfQ3uEVyYVBpm+G7v97JaHHSJ+TG9N7l/bQO
         CMAQ==
X-Gm-Message-State: AOAM532rwQXdMEDIUGhRt7ZAbaSf91GmR8aoMDGcnjJ9EbNj4Eb1AIdk
        6zaAK1qgd+lyknudlAULmjPfuib0fFfF
X-Google-Smtp-Source: ABdhPJyJZ32y84BWOCzPlXnj6DBPie+kwwNvt36mcjomQYjcSGXpCQX3nGJKpsx74v22jf/R8UEafr0WqCf3
X-Received: by 2002:a25:aaa9:: with SMTP id t38mr763977ybi.312.1593131235516;
 Thu, 25 Jun 2020 17:27:15 -0700 (PDT)
Date:   Thu, 25 Jun 2020 17:27:09 -0700
Message-Id: <20200626002710.110200-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 1/2] pci: Add pci device even if the driver failed to attach
From:   Rajat Jain <rajatja@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_attach() returning failure indicates a driver error
while trying to probe the device. In such a scenario, the PCI
device should still be added in the system and be visible to
the user.

This patch partially reverts:
commit ab1a187bba5c ("PCI: Check device_attach() return value always")

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 8e40b3e6da77d..3cef835b375fd 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -322,12 +322,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	dev->match_driver = true;
 	retval = device_attach(&dev->dev);
-	if (retval < 0 && retval != -EPROBE_DEFER) {
+	if (retval < 0 && retval != -EPROBE_DEFER)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
-		pci_proc_detach_device(dev);
-		pci_remove_sysfs_dev_files(dev);
-		return;
-	}
 
 	pci_dev_assign_added(dev, true);
 }
-- 
2.27.0.212.ge8ba1cc988-goog

