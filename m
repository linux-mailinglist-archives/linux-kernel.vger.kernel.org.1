Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ECD2DB5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgLOVcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:32:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730338AbgLOVb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608067830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sKWEPlpfqqNs/xMqW8/R+pszI1KfgsclH0Gpy5tp2fw=;
        b=POku6Sn0Tf5B/9B6tAvQpQ+lMSzFMd7JuGn6UHWeQZfT1eAzWLyZIJXp/dsbfpKTte3udm
        1BfErTU25uknchO9vsb2RYCSVUTpplx53F0xhFNqDqUp1EeMb0StCAfdK0Mk7voPu3Rk0y
        87Tc1Vww7A5oBR8ZQq2weudt8A4lgJ8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-svuMdSZcNKSwvYY06yNVLQ-1; Tue, 15 Dec 2020 16:30:28 -0500
X-MC-Unique: svuMdSZcNKSwvYY06yNVLQ-1
Received: by mail-oi1-f198.google.com with SMTP id v5so11399151oig.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 13:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKWEPlpfqqNs/xMqW8/R+pszI1KfgsclH0Gpy5tp2fw=;
        b=sOq7HSOXBcrsGRKJqqGnBN7KFHKY41RjjBW0+WGgqx7B8Q8of5kENoRVjtntz/RXqB
         lkm1Nmr3qhmergUKzib/pO2O9MJDSlYh2bRDiGZUnp6qUPc2Z7UOswJ9SOA9M3VqbuvV
         +Bh0x5Szom0RxjNUxgCBTDN2eGd+JGr535xKjbMCUCY5i5APtOFhQsTiC+xLeoSZxtjr
         Rk4B6WIH1iq9Yp7Xzp8OT2EsC2phYQS1vLsZz+wDmGg6QzykxHX0es8+r2Kan0dh3Mpz
         60IckdZSpBrmc4RDfj3aBKr6fputytyiyIO/YYsQGttfHW72Z5IG8axMDeoBg7sI2Ymw
         xl/g==
X-Gm-Message-State: AOAM531DfMzXs/sEUPozNxTcgWYdeNmsklM9Iv1HSt9CRdM0Jx3v5kj4
        SZP6UvoxT+hesrXeg4fkUcmcvgrCB75rLj6Cg5wO7PUA13fnFA6tcwESzBdR1CWfbuJ8KCX0qqL
        FTWVgfrGS8q/KiLE69MT+rPja
X-Received: by 2002:aca:5302:: with SMTP id h2mr516959oib.41.1608067827513;
        Tue, 15 Dec 2020 13:30:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUbMaBbz+Q+s6nSnnX7/fbpUAEuSAv3937HDnTFQ8Q64p/+7jni7utLN8iMALVXuc/xMW/9Q==
X-Received: by 2002:aca:5302:: with SMTP id h2mr516954oib.41.1608067827373;
        Tue, 15 Dec 2020 13:30:27 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v207sm5425284oif.58.2020.12.15.13.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 13:30:26 -0800 (PST)
From:   trix@redhat.com
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iommu/amd: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 13:30:21 -0800
Message-Id: <20201215213021.2090698-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.

commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 5ff5687a87c7..eb17fb4ba67c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1883,7 +1883,7 @@ static void print_iommu_info(void)
 		struct pci_dev *pdev = iommu->dev;
 		int i;
 
-		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
+		pci_info(pdev, "Found IOMMU cap 0x%x\n", iommu->cap_ptr);
 
 		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
 			pci_info(pdev, "Extended features (%#llx):",
-- 
2.27.0

