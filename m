Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E641B7F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 21:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgDXTy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 15:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXTy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:54:28 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3A1C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:54:28 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t8so5311059qvw.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VRWGw+Ids2J/IVS8Zfm76j7+TTZ3bwJIR/se+BO3dNs=;
        b=jOkapKtXRrSVdQIX+HKmfTfebHFdL6/rZHzHufL4crJNiVgRl3vuGoCk1k7PYleJTN
         Y9QPA8fFaUnyScF4/gjS6AHcXqS7oQzh8cpQG//Dw+lV1L/7QozlIGx29bUMFXi2zOV/
         Pz+W6NopTcbp+G7mQhJJjbVDXhahbBLhO9D+DofekdIS+rPS1Y9Ye4Z8zassoE23uc4l
         WmDmS1xyw7n9FK9Nh3iKym6l+heBY8VQoVcJ0dQVEcar5Ucl0vytM9nmAkeHDm5mMjjQ
         c4zK603mpXhtDf1bHx2+mMIbeT94YYyQHcGm1fbZN+ZGIzWvEb3fwbr06Qtt/RKZWut7
         O2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VRWGw+Ids2J/IVS8Zfm76j7+TTZ3bwJIR/se+BO3dNs=;
        b=hbGDe4MWdm7UfrZ7//Q3UnyLE/IMPspGM9Nu69DBG9OposqWJDxVCjITNNcjrG9dH3
         vs1+FmyegWT95duBfSFSIqG0H/k0o7HGVnl22eTK7as9zSHGOPkxt/OFh4HeUd/wSI6J
         rd+B6JlbufMJDeTh4jRJj83BkP6TDX8KY3kMl9uKmMts/68nyqH7+dnQ1mqWe6DrnO5G
         eWKt6F5Aw6tEWD5Y2U7RPPds9s07TCflWsTgG/+ovGXie0oEj5hBffo7LBAt3w0qWI3y
         76Y+Z61t8BG46A1GUEjNAILuFLrtfQrW28rTJANP4zhvIETWRjZGoIYT/OqPqpxKPC1p
         sAsg==
X-Gm-Message-State: AGi0PuY+rTKM5yiL9bDuY524dYvs3KWFcDQLAP/8+0GOLcQUc0VV5yP1
        ZKL0xbwGLTDdS4h+82xpOe0ezQ==
X-Google-Smtp-Source: APiQypLWXS5Rfvw4pDLkSd1Bcle5kpvUQdgBT2nx0m2i2bXnCx0BVS6MOSW8pZFqkWdYjJN4WKf/hg==
X-Received: by 2002:ad4:45ec:: with SMTP id q12mr11067687qvu.157.1587758067042;
        Fri, 24 Apr 2020 12:54:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o94sm4612480qtd.34.2020.04.24.12.54.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 12:54:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jS4P4-0007b4-1S; Fri, 24 Apr 2020 16:54:26 -0300
Date:   Fri, 24 Apr 2020 16:54:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 00/18] Refactor mlx5_ib_create_qp (Part I)
Message-ID: <20200424195426.GA29169@ziepe.ca>
References: <20200420151105.282848-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420151105.282848-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 06:10:47PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This is first part of series which tries to return some sanity
> to mlx5_ib_create_qp() function. Such refactoring is required
> to make extension of that function with less worries of breaking
> driver.
> 
> Extra goal of such refactoring is to ensure that QP is allocated
> at the beginning of function and released at the end. It will allow
> us to move QP allocation to be under IB/core responsibility.
> 
> It is based on previously sent [1] "[PATCH mlx5-next 00/24] Mass
> conversion to light mlx5 command interface"
> 
> Thanks
> 
> [1] https://lore.kernel.org/linux-rdma/20200420114136.264924-1-leon@kernel.org
> 
> Leon Romanovsky (18):
>   RDMA/mlx5: Organize QP types checks in one place
>   RDMA/mlx5: Delete impossible GSI port check
>   RDMA/mlx5: Perform check if QP creation flow is valid
>   RDMA/mlx5: Prepare QP allocation for future removal
>   RDMA/mlx5: Avoid setting redundant NULL for XRC QPs
>   RDMA/mlx5: Set QP subtype immediately when it is known
>   RDMA/mlx5: Separate create QP flows to be based on type
>   RDMA/mlx5: Split scatter CQE configuration for DCT QP
>   RDMA/mlx5: Update all DRIVER QP places to use QP subtype
>   RDMA/mlx5: Move DRIVER QP flags check into separate function
>   RDMA/mlx5: Remove second copy from user for non RSS RAW QPs
>   RDMA/mlx5: Initial separation of RAW_PACKET QP from common flow
>   RDMA/mlx5: Delete create QP flags obfuscation
>   RDMA/mlx5: Process create QP flags in one place
>   RDMA/mlx5: Use flags_en mechanism to mark QP created with WQE
>     signature
>   RDMA/mlx5: Change scatter CQE flag to be set like other vendor flags
>   RDMA/mlx5: Return all configured create flags through query QP
>   RDMA/mlx5: Process all vendor flags in one place

This seems reasonable, can you send it so it applies without other
series?

Jason
