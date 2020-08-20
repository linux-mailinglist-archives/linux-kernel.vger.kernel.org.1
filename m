Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EAD24C867
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 01:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgHTXT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 19:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbgHTXTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:19:55 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794D7C061385;
        Thu, 20 Aug 2020 16:19:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d4so109964pjx.5;
        Thu, 20 Aug 2020 16:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1XFUxolbA7h1HeK5YbtlyNm7bbkj2GGYGOp3MuLqhZo=;
        b=eqzf/OiAqYuMkve9o3Rg2GzzA/6jLGZPEtPfhYoyr9342xlMhSngQCcxYLIDthFc44
         UUDoF359natqKdeAghtC2LYyTQPzIg2AfXD2MCDW8kgNUE8qyC5F3NyYAgket6AT8NZX
         C6dnA0DKIhRg+87oFAnmsOztdZ0eB8yymCaVRso8HDay52lsZUudDdwbNgj0QOSKX0+6
         N6FojIdcqDVo6XGYNKA7m5x7NbW41RWc8A1LXhyZZwLysgZr6fzzJY7dQpft6xUhMYb4
         F09zIOTv8fdcyWJU2Ln6l6J7/iegUOLhTxJf/aBepWLxKWQXt8bgGDxJfH/ZvRt4O9HF
         o+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1XFUxolbA7h1HeK5YbtlyNm7bbkj2GGYGOp3MuLqhZo=;
        b=fs40e/s+Cv6AEg4yh0ZHXDUzP5dDNCVkapaQlC6i1kuXvx3enVaw5zy9kF1TBIEQDq
         0xOVD+zEwy+4n3V6g/6SEi01egabEVgrRgUL7PofDKU9mwgvIDTR/ZgFytf6MmBUAT+k
         UB+/5Q/GWWJl2bY4INtIc+LCauRtkp6jxLOM07Hbmz9rnglBWfA0Qbalnk96DIwhPhgb
         b+4UlLYfbCwOiCUjBRNGQKLMWeJlwzDKVLi6YGbhdjJcRgw4GjQgIvO+a9CWtbfA1QPv
         qcy0XOEmSclQTCVr3k1fMcjJzGSqx96L5r6GpSkyNmCXxYuXh1r1tJBpGRDe9LWUE1Wb
         eR7A==
X-Gm-Message-State: AOAM531EilyJGDCPOIIXVI/UBuk0YYzXNLhFnq4xRbfWBZrPE7LJuOlT
        STVbfHn5Qs3btwfdDDtIv3YVi+3vj2AhVQ==
X-Google-Smtp-Source: ABdhPJw7ZMI0DJ+F4LF445yS7IqFpJ7Ao4uy9XqpsjpadMZlzLMoDBw9nkHIEjI8WBaRHIT9WnIzRg==
X-Received: by 2002:a17:90b:23c9:: with SMTP id md9mr86097pjb.173.1597965593711;
        Thu, 20 Aug 2020 16:19:53 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f195sm150711pfa.96.2020.08.20.16.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 16:19:53 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        tony.luck@intel.com, fenghua.yu@intel.com, schnelle@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, James.Bottomley@HansenPartnership.com, deller@gmx.de
Cc:     sfr@canb.auug.org.au, hch@lst.de, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [RFT][PATCH 0/7] Avoid overflow at boundary_size
Date:   Thu, 20 Aug 2020 16:19:23 -0700
Message-Id: <20200820231923.23678-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are expending the default DMA segmentation boundary to its
possible maximum value (ULONG_MAX) to indicate that a device
doesn't specify a boundary limit. So all dma_get_seg_boundary
callers should take a precaution with the return values since
it would easily get overflowed.

I scanned the entire kernel tree for all the existing callers
and found that most of callers may get overflowed in two ways:
either "+ 1" or passing it to ALIGN() that does "+ mask".

According to kernel defines:
    #define ALIGN_MASK(x, mask) (((x) + (mask)) & ~(mask))
    #define ALIGN(x, a)	ALIGN_MASK(x, (typeof(x))(a) - 1)

We can simplify the logic here:
  ALIGN(boundary + 1, 1 << shift) >> shift
= ALIGN_MASK(b + 1, (1 << s) - 1) >> s
= {[b + 1 + (1 << s) - 1] & ~[(1 << s) - 1]} >> s
= [b + 1 + (1 << s) - 1] >> s
= [b + (1 << s)] >> s
= (b >> s) + 1

So this series of patches fix the potential overflow with this
overflow-free shortcut.

As I don't think that I have these platforms, marking RFT.

Thanks
Nic

Nicolin Chen (7):
  powerpc/iommu: Avoid overflow at boundary_size
  alpha: Avoid overflow at boundary_size
  ia64/sba_iommu: Avoid overflow at boundary_size
  s390/pci_dma: Avoid overflow at boundary_size
  sparc: Avoid overflow at boundary_size
  x86/amd_gart: Avoid overflow at boundary_size
  parisc: Avoid overflow at boundary_size

 arch/alpha/kernel/pci_iommu.c    | 10 ++++------
 arch/ia64/hp/common/sba_iommu.c  |  4 ++--
 arch/powerpc/kernel/iommu.c      | 11 +++++------
 arch/s390/pci/pci_dma.c          |  4 ++--
 arch/sparc/kernel/iommu-common.c |  9 +++------
 arch/sparc/kernel/iommu.c        |  4 ++--
 arch/sparc/kernel/pci_sun4v.c    |  4 ++--
 arch/x86/kernel/amd_gart_64.c    |  4 ++--
 drivers/parisc/ccio-dma.c        |  4 ++--
 drivers/parisc/sba_iommu.c       |  4 ++--
 10 files changed, 26 insertions(+), 32 deletions(-)

-- 
2.17.1

