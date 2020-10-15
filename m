Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB128EF04
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbgJOJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388636AbgJOJCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:02:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04636C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 02:02:54 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id qp15so2519116ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jwGwzOz2iwiJeRP/ODTx8CbVxZ1hxrUMfR1ipDCP90s=;
        b=qweI/BwrMtF9IhlcAGpBsKH85MRIVZxQma8KEMG7BfTWf1sz0mowzoiuCEvsJiixil
         bkRKKMFFSyK2XWQOdsx8jSzJT9/lrKRS4le4AsLPWoO6q+IMkXLp3VWsZ+AJcuWAWkH3
         QIPaDUVlIXNpUNL/iunpTS14GJOpoRjsyVmA9ZMWjqP7YhmRSebklA+Mj7flGYS49QQ8
         WuIZGIJpF/fNrgO2eEGZZHfV0lczFhw6ZiSwTk0QE2JmmGQg4UhQ6BoFzbJ8md/3mehH
         VI9891UG0SiycGRKXJB0BDJsAVwe0KcBTwmHK/xIsOiklJ2m9nv16cSWxYGIZwrhSpnH
         vJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jwGwzOz2iwiJeRP/ODTx8CbVxZ1hxrUMfR1ipDCP90s=;
        b=IhiVjNMyBpCGlThdrDGi4VwqFhx7wpA1dvBEcsMhW+MnQVbK7PYPYqibBIqpdj4zsJ
         r9+hGahKWY8WVCjMJG048I1NyViYvXcE8PMoAlV1afkarZl7JHTIWdN6/TcfyZFffMMX
         obaZTaeOIABrfL09b9oL9IhCipUa1Sn78jPvxxBcaAirDvxlNTXqguj/BObNAz89G0u8
         wPuPpEpP2IvLrKP77HVfGrnuLL0Qf91V8rxlvc3X1OjneQeoGU0KFHLhDuczDzLmvB2d
         +RE3gugaJpo/o72JvwufzPZuitcXOvYsrb5RzBquBpvL4JiIiWbStyPxC/9VMDdLbaBY
         I2Rw==
X-Gm-Message-State: AOAM531kEo5B1sVqR/ds87tLjiV6Y4JG0qImlWaXbtcBUONBS712nn8Q
        shIVrUbIh3MmFSXSI20Ag0uWhA==
X-Google-Smtp-Source: ABdhPJztgb5AXCuuQNTQ7o/iU4i1S0WhyHCR85sQNeGullTF/FIpxP8ZJsVHxqQduAeyDPWkNehDiQ==
X-Received: by 2002:a17:906:f90a:: with SMTP id lc10mr3439626ejb.272.1602752572593;
        Thu, 15 Oct 2020 02:02:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm1103078ejt.105.2020.10.15.02.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 02:02:51 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        zhangfei.gao@linaro.org, wangzhou1@hisilicon.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        linux-pci@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Date:   Thu, 15 Oct 2020 11:00:27 +0200
Message-Id: <20201015090028.1278108-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a parameter to iommu_sva_unbind_device() that tells the IOMMU driver
whether the PRI queue needs flushing. When looking at the PCIe spec
again I noticed that most of the time the SMMUv3 driver doesn't actually
need to flush the PRI queue. Does this make sense for Intel VT-d as well
or did I overlook something?

Before calling iommu_sva_unbind_device(), device drivers must stop the
device from using the PASID. For PCIe devices, that consists of
completing any pending DMA, and completing any pending page request
unless the device uses Stop Markers. So unless the device uses Stop
Markers, we don't need to flush the PRI queue. For SMMUv3, stopping DMA
means completing all stall events, so we never need to flush the event
queue.

First patch adds flags to unbind(), and the second one lets device
drivers tell whether the PRI queue needs to be flushed.

Other remarks:

* The PCIe spec (see quote on patch 2), says that the device signals
  whether it has sent a Stop Marker or not during Stop PASID. In reality
  it's unlikely that a given device will sometimes use one stop method
  and sometimes the other, so it could be a device-wide flag rather than
  passing it at each unbind(). I don't want to speculate too much about
  future implementation so I prefer having the flag in unbind().

* In patch 1, uacce passes 0 to unbind(). To pass the right flag I'm
  thinking that uacce->ops->stop_queue(), which tells the device driver
  to stop DMA, should return whether faults are pending. This can be
  added later once uacce has an actual PCIe user, but we need to
  remember to do it.

Jean-Philippe Brucker (2):
  iommu: Add flags to sva_unbind()
  iommu: Add IOMMU_UNBIND_FAULT_PENDING flag

 include/linux/intel-iommu.h |  2 +-
 include/linux/iommu.h       | 38 ++++++++++++++++++++++++++++++++++---
 drivers/iommu/intel/svm.c   | 10 ++++++----
 drivers/iommu/iommu.c       | 10 +++++++---
 drivers/misc/uacce/uacce.c  |  4 ++--
 5 files changed, 51 insertions(+), 13 deletions(-)

-- 
2.28.0

