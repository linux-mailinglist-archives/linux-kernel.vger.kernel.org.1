Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC1E1E135C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 19:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391317AbgEYRY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 13:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389370AbgEYRY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 13:24:56 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7701C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 10:24:56 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so17967440qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bvESvaLhhtdJGYqjlNfkZpxLTpkNUIrmn1w48gtvYac=;
        b=T1py55mlsxBq628MiuFleZaRgFYOHjQ6EfTQhD+k4oVv+8/f18oDhYjFECMBxD4d00
         ldCQ4gyeTwMuMwupGs4qyWt2k4Ub/Eit/LCdAKbn/+rRQSw5p+lIx4KKE4Mxhj6apM6N
         KsTWKQUjSmfby8Oc1/B+7T6fTWD46YOMYFIj+7cfxI/8/z8ilH3jeyXSsf6B+u4JGC0p
         BEaGO7mQ5euyrg56ziuWff04oTIIsdb7n1WYRsUfbf9SHTwIIXCgX6llBWT7jYb/ikI+
         Ejkl52FUMjc/F58RXqVP7Bab1lH6EE0iOebK2MfHF0oI5x7sLBET/QIcIMbeeX1UjXVz
         YSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bvESvaLhhtdJGYqjlNfkZpxLTpkNUIrmn1w48gtvYac=;
        b=aCaYdDHe8DczEc4im4oLSfYnejlps1HCZJPTqPjZhY+dbqmIIajJHab5/uhdlKAUrH
         2PgHE/q8d4KMHYsO7oYHlhgXiZZeYLPduA7Xl4KJLLl0a8UECozZqH9GRIQcjIOcLV5r
         qoeu3+2puVgcbwrTiJA56a3be4Sw40B340Eg945HNs2M7Ig+UvgtD5u8G2i52TAP+Wpy
         w2nc0pYdrCekA/4xeST253f4ByxlCpCOICCKACsQ+cKf3RMnp2+kblJbQex5Xu6eb3eo
         EfDgeu7MfY4Y9YrxwYKVHrRZcZwrVTND3AXzTWyNsuOgLkr5qY53JHOoaW7ej+ZdkLuB
         DmlA==
X-Gm-Message-State: AOAM533qZcg5EF9qdxTTcFuY8V5LTmVk5gF3NWDv1T4UGivvjmq1EKXD
        /mp4COTsMsBnsrRvt9Dg7ITYxg==
X-Google-Smtp-Source: ABdhPJwt8/BoSl0QE3JQ+vOSP7+bsmhmZCSKZlIhbS5D0sBTW4rLQ/3vprWwjhtpvRzmPRVEbzhz8A==
X-Received: by 2002:a37:ef0e:: with SMTP id j14mr15376918qkk.292.1590427495958;
        Mon, 25 May 2020 10:24:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m13sm1361300qta.90.2020.05.25.10.24.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 10:24:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdGqN-0007ja-5w; Mon, 25 May 2020 14:24:55 -0300
Date:   Mon, 25 May 2020 14:24:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     wu000273@umn.edu
Cc:     aditr@vmware.com, pv-drivers@vmware.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu
Subject: Re: [PATCH] RDMA: fix missing pci disable in pvrdma_pci_probe()
Message-ID: <20200525172455.GA29516@ziepe.ca>
References: <20200523030457.16160-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200523030457.16160-1-wu000273@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 10:04:57PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> In function pvrdma_pci_probe(), pdev was not disabled in one error
> path. Thus replace the jump target “err_free_device” by
> "err_disable_pdev".
> 
> Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
