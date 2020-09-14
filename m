Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE54269894
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgINWId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:08:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33525 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgINWId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:08:33 -0400
Received: by mail-io1-f66.google.com with SMTP id r25so1912192ioj.0;
        Mon, 14 Sep 2020 15:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HfVeQ81fFlvBzyeQzVxZZpi/9tbQOUKFJsP3PWI05Uc=;
        b=sTB5GH9mQbWPoFRaU6oSigDmL0bHqQDA4SHQvdnvc9C6mb9AJYlHj3JbQYpGaO/hrr
         2W+O8dGHx8qKULnZFEeDM46ZwIeDP1BjmRds+ZX5b1eNJb3whCnvnRC8avfv2qIiJXEj
         48jOkikaJv6n+W3nhst6ZzV8A92kUop4tIjUhZ+W2DG0Pncn/+Z9XMqCjfk3RnA7NhFM
         +Fo311wkPe3/MCKdGkxgw4RJWD6z8Rn+F6NIttLda9ODZMVUoZM7dSceOUa4H9XNV37u
         tCHLKEry7/QQlV4/emqqShb2KpWdG7xrrnioUPE5RZYxbjhp4Bx17ESJ6h1q6xd117Gt
         hmdA==
X-Gm-Message-State: AOAM530zVQ48FksqFTN6mnL8HRJ8rWh0IdGsq0jmnU7taiMtkbAn1lch
        Pg3YC4cSDGLUU9WMzkTN8Q==
X-Google-Smtp-Source: ABdhPJzOEWAxnZG+kDpP3Y4L1MtUa0ni/O8Jr2Ub5j+QdhNiZ4nS4jkbiRz6otnEmg9u4/zC1QacmQ==
X-Received: by 2002:a05:6602:15c5:: with SMTP id f5mr11938387iow.42.1600121312167;
        Mon, 14 Sep 2020 15:08:32 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m15sm7558130ild.8.2020.09.14.15.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:08:31 -0700 (PDT)
Received: (nullmailer pid 346892 invoked by uid 1000);
        Mon, 14 Sep 2020 22:08:29 -0000
Date:   Mon, 14 Sep 2020 16:08:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <20200914220829.GA330122@bogus>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904130000.691933-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 02:59:57PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Reserved memory regions can be marked as "active" if hardware is
> expected to access the regions during boot and before the operating
> system can take control. One example where this is useful is for the
> operating system to infer whether the region needs to be identity-
> mapped through an IOMMU.

I like simple solutions, but this hardly seems adequate to solve the 
problem of passing IOMMU setup from bootloader/firmware to the OS. Like 
what is the IOVA that's supposed to be used if identity mapping is not 
used?

If you know enough about the regions to assume identity mapping, then 
can't you know if active or not?

> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/reserved-memory/reserved-memory.txt           | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> index 4dd20de6977f..163d2927e4fc 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> @@ -63,6 +63,13 @@ reusable (optional) - empty property
>        able to reclaim it back. Typically that means that the operating
>        system can use that region to store volatile or cached data that
>        can be otherwise regenerated or migrated elsewhere.
> +active (optional) - empty property
> +    - If this property is set for a reserved memory region, it indicates
> +      that some piece of hardware may be actively accessing this region.
> +      Should the operating system want to enable IOMMU protection for a
> +      device, all active memory regions must have been identity-mapped
> +      in order to ensure that non-quiescent hardware during boot can
> +      continue to access the memory.
>  
>  Linux implementation note:
>  - If a "linux,cma-default" property is present, then Linux will use the
> -- 
> 2.28.0
> 
