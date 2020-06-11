Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268A61F6DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 21:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgFKTU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 15:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgFKTU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:20:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD769C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:20:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y17so2690201plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=vs8zuDzvjHdETDEcGTy3L+gn3DFxvZBwvmNgqN4PsP8=;
        b=cLhqFJsu1N/2ngljNE1bZa8+nfqnzZi/4WMjB13VYRrKiXxxh9TnKyU3rnpTIuEqso
         LrbP0J0WrIybuzHP4Hy9ob/t/lIMe7AAn2rdgO23DyfahHsHhNNFLgXadYJV1JPpHAZn
         NZo8AWG6yiXW9qWaUFsMOIfIwugr8kjyEJp6RNFql5qP25/9l/K1VZmqeFLH99dd+VIf
         4FNfqf9Q5nQcyO2ezmSMHoC3IuvOiUyCZKDO5ZkKXq08No6Buqb/VdHc2FXM9B37sb+g
         whOTRTL/rvO/vAqmYaglbc8vp1f1CmqUKu1wvN5iEBvg7lfiFI4+oss2G7quLINrYGl9
         i8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=vs8zuDzvjHdETDEcGTy3L+gn3DFxvZBwvmNgqN4PsP8=;
        b=khDcBwP3eEGF0t6IV/URTN0Z8kCrF6rK1JU87DL/9uGxe5RcjBtOqS4PUIG+BFRqGj
         k+jifoPLoCLNwtRuN6aUzW/Cu6fs4onuXIJVrd6Oy9NTxQWo048Dw6+842ggWPVv7sMN
         Odc/kSBzIub5UPBw5T53eplgXmKVde1YCe8BCtiP37Wb5GUUbdSBiXHMw9Qfj6hyHUAq
         cGUcJTNR0wkyn1CC9WK/MEA/9T4TvPXHpAQFhOxW5VbEUt7E3fKNB2K5K2BDvBuwoqxO
         /4ZphgYXftKkOomaLwFiOIbhbK1PTxjyq3GGv544RLL5f26H866D+NFA0g1QMtv89nEf
         Wg7g==
X-Gm-Message-State: AOAM531btsJ2jbYyeJnqK2AlwBllvkHxzpjtDgoFz3k532SINdAiCYsT
        Y4rWDIE6i3tfnw+AcfRCQYBlPw==
X-Google-Smtp-Source: ABdhPJzytk0KYlXV5rOWpFspxq0MH757orr/tBcyS6r2KR2i5RmbUoahzpSj7DOXXQ6kmIJR2nWXhA==
X-Received: by 2002:a17:90a:e801:: with SMTP id i1mr9154849pjy.79.1591903227192;
        Thu, 11 Jun 2020 12:20:27 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f29sm3470376pgf.63.2020.06.11.12.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:20:26 -0700 (PDT)
Date:   Thu, 11 Jun 2020 12:20:25 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Thomas Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [patch for-5.8 0/4] dma-direct: dma_direct_alloc_pages() fixes for
 AMD SEV
Message-ID: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging recently reported issues concerning DMA allocation
practices when CONFIG_AMD_MEM_ENCRYPT is enabled, some curiosities arose
when looking at dma_direct_alloc_pages() behavior.

Fix these up.  These are likely all stable material, so proposing for 5.8.
---
 kernel/dma/direct.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)
