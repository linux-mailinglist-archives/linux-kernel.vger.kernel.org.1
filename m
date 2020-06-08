Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4701F2127
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 23:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgFHVET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 17:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgFHVES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:04:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20BCC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 14:04:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s23so7768370pfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=eSnM3Wp5cYoCyZSe8AmKJn6Xd5E1PvqbOrfDYBEtlVE=;
        b=NDE9XGnGI9GYA5H7RMhAelnFzVf+AvRcTPveRM4qk/20TZGUzk7Nl5BFlxeKNEqqk1
         Cl1giFXgHlqX15N7iQucJJcOoPHw6fZ6ffQdKr0X2W7LKnaUuGDih/MGil6dsPc32JUA
         DBqX50+ae1zSTFqe7EhMBHlw2YclobMchWAJUAC2Mv5dF9lx25Vg/7VhyNy/xEEldbm2
         IrHs7R46EfOtXDCmt6m4EYGEQIzbiFgPU8dQ5bTTeYADq9Eh2A/mVZiBurdYo7gb6YMz
         RWF57ZajeU3jjvemUOpsXll7rfy2utMv2pNLaRFQ8W5zk9lFK1MSWKvKDbuRQ1clzKgD
         jJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=eSnM3Wp5cYoCyZSe8AmKJn6Xd5E1PvqbOrfDYBEtlVE=;
        b=JhOBYu7XxSKgxqnbPZ6/X/8fC2TIKwuEwWWX0mPXPRwDEFZ7ifzEYrrl/UtumDE7MX
         gOC7qO4zDj7h0PSABqaCSsnUbUkhdf+42lOHfx2SWq4xbAVdZY2rmyJvuEj58ihrKllP
         NyG+adH+hrStbfYgbrM3ny8Iki8OU5J78M2RUfeYgAl3NzVvi8UKnpCEgETNn3aDNQpT
         871k+BU8H2PO/Tgqg16DPvgmGTviNvZU5gOXGCdKX1zCfzTeh+rCN5T2Vk7n+pq66j08
         ZXEMuqGFi71fAvGAkPAhuQRZ/sdUHxvsQB4JEgCvfwygs7ux03FP4GzSCg7aU0wy1KEd
         G4bg==
X-Gm-Message-State: AOAM5326rfu1LXfsTdkmcJ7IvjV4Z8EGsefwBjRsNCR/iTu7wKmh9lUC
        i2q/t9Tbp1E91B8eYhkAKuSbnQ==
X-Google-Smtp-Source: ABdhPJzonYIXqxiYM91Tp1oE684RePKN0QCjQ24SQclrVHvlV0Njla7yv6NdSMJO4WJRGV1vzs0mDQ==
X-Received: by 2002:a65:6107:: with SMTP id z7mr21088332pgu.341.1591650257907;
        Mon, 08 Jun 2020 14:04:17 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z8sm360368pjr.41.2020.06.08.14.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 14:04:17 -0700 (PDT)
Date:   Mon, 8 Jun 2020 14:04:16 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
In-Reply-To: <20200608132217.29945-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2006081403560.71460@chino.kir.corp.google.com>
References: <20200608132217.29945-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020, Geert Uytterhoeven wrote:

> On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
> memory pools are much larger than intended (e.g. 2 MiB instead of 128
> KiB on a 256 MiB system).
> 
> Fix this by correcting the calculation of the number of GiBs of RAM in
> the system.  Invert the order of the min/max operations, to keep on
> calculating in pages until the last step, which aids readability.
> 
> Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

This works as well and is much more readable.  Thanks Geert!

Acked-by: David Rientjes <rientjes@google.com>
