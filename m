Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F0519FFEE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 23:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDFVGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 17:06:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33162 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFVGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:06:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay1so364360plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F7oyQrycdBGvwHlAg5l8DJr2cSrN+vxfu/5R7n9PHnM=;
        b=VNG6cwohDXNRbJGMuO22h1hA4687il974YFacYVjjW0YaZFR++a3HGfBJJ7qYyat6E
         Pqlj+VbHwHV5dgg4V3abZvK3Jx7HPojHNnppBCGjRmy5zttmIJEFyNmrgYnSlX32hMra
         3yXr+RSEkAemaAarNl/R7E2W+XqlWrwkrZ/jic14gRTFGVhiuH5wte6NfiUD7YqHiRRz
         nMsqJ/TPb0p0LRYuqFU6gnBkw7sHpqIXM6WIR13FaknYRtX1Vkxc7xonlfLQ2D/jHtDh
         Zks1+3n/eKOHAbsFpvOjiIML7IcRhrRuBzyGI2up5/9vtpyFnNp5mxH2BQ4a4JGo7Qt/
         Rtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F7oyQrycdBGvwHlAg5l8DJr2cSrN+vxfu/5R7n9PHnM=;
        b=fl1W7k2NDpEaBlYa8Wv5nkvqgqv+ZjnXU6AsZ9wn0IcZ9O8mwUzSKIMvygegF5+Var
         ZLsfm4aKcaDWsiD1I5GIT25l8o/PlpojxC0swywI45enYPDvxxLLNVcSeDu4g6WbxGQX
         Tm4K0+XvLTn+WMZ+I/0liM9UFF6s/3naSxpWsCyzgSbCH4NHjKL20ol+Pk+7vEeNH+vD
         aMLHEKALwa0uIXGs3fQRB8RbeFTzNX0IqcaTU8iQeBuhBrjtyqQ1hynTUDo5ClZ6CNYx
         Zcl+JzNorHMeyrcM1tNlhlmFZiAc66y1c6iT32HSFJc43mntUfyPMBIFq43MabCm6TxU
         dgmA==
X-Gm-Message-State: AGi0PuYmPn96jad1DCr7TwTO3K6SDy1pRWS44DqpylewrUihEkxWYt4Y
        EHpV8uNhwcxQkBHbainI10E=
X-Google-Smtp-Source: APiQypKJbIkLMaBwh90y6jKxYqWc9V67C01F47EfkGfkWEkFa7Vx6ItiZnoObiuN7fiA/whRFXG+Dg==
X-Received: by 2002:a17:902:bd02:: with SMTP id p2mr22035795pls.67.1586207201046;
        Mon, 06 Apr 2020 14:06:41 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d71sm12427134pfd.46.2020.04.06.14.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:06:40 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [RFC/RFT][PATCH v2] dma-mapping: set default segment_boundary_mask to ULONG_MAX
Date:   Mon,  6 Apr 2020 14:06:43 -0700
Message-Id: <20200406210643.20665-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default segment_boundary_mask was set to DMA_BIT_MAKS(32)
a decade ago by referencing SCSI/block subsystem, as a 32-bit
mask was good enough for most of the devices.

Now more and more drivers set dma_masks above DMA_BIT_MAKS(32)
while only a handful of them call dma_set_seg_boundary(). This
means that most drivers have a 4GB segmention boundary because
DMA API returns a 32-bit default value, though they might not
really have such a limit.

The default segment_boundary_mask should mean "no limit" since
the device doesn't explicitly set the mask. But a 32-bit mask
certainly limits those devices capable of 32+ bits addressing.

So this patch sets default segment_boundary_mask to ULONG_MAX.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog:
v1->v2
 * Followed Robin's comments to revise the commit message by
   dropping one paragraph of not-entirely-true justification
   (no git-diff level change, so please ack if you tested v1)

 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 330ad58fbf4d..ff8cefe85f30 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
 {
 	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
 		return dev->dma_parms->segment_boundary_mask;
-	return DMA_BIT_MASK(32);
+	return ULONG_MAX;
 }
 
 static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
-- 
2.17.1

