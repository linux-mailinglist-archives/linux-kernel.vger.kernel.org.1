Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2AE1B7DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 20:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgDXSdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 14:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726813AbgDXSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:33:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A230DC09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:33:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b188so9593318qkd.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m4GL+2qW5009jJSbr8XQNzoDynO0xHgFGHV6m3bG+R8=;
        b=hOsTdl2DGYElFVwP2AZc1C2xImVIZIem392vC9ZmMVtYinGbekq3qXVWWfWOmru0gB
         VqrNMhb4zz4qns3UJHTvRlTd5EWRrvfpwuhcGVmcv+s0uaxaS1vdWHB5g3KzXkQHQQeu
         jUXv0FwxN+BKUMBwLrqA+tjqfoRj7ItpPsV4rK4xAR9Qal9gyR0TnfSN8qmDsGT0Fx2k
         WH1AnZ3gX6WTIRhKfw7L8VzxEMaBNfOF9Ux/OF2k/Js/9ttbLXgNNPb6lhg0e31uBhnB
         QK8/X40zuNTQy8FpIczrDhFy9EhQqm3/xzi+dkzu8T7J4znLRgO2tPWCFASJuTSzuCYT
         3iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m4GL+2qW5009jJSbr8XQNzoDynO0xHgFGHV6m3bG+R8=;
        b=IlvMLwm0hyl7jtR/0bB9aCKsdynFgC7iRAKUgdi2d+OUVYB5HlzVcSypp4IK2qeg3m
         n28ugqecf6rITtBPRj8Y+AeHdKjwmBfJzse/DafDsHR1l+86aA6IHxsXNwH/50zS8vo7
         drbe57GcnAYEujI0zYWPqcUalgeD3YNEbk9V5uyE9nlM+wCui1UQcoL4QHxNiS2WbnwA
         RgLGzkTFZCKFGxkJmER5awD37JX2dP0mgNCKFFqcuP9O8S7YV8yq4FdrDeeKXqgokLfO
         Sxn/d1r1JpgYk3rH8UT0cId0rokZaTqBy3Pnbn1wtV1TXv3fuk+dQyWcTkwSxU3ocMfo
         mvpw==
X-Gm-Message-State: AGi0PuYPMJ3STBmE4kA8+BVpCpA33d1aY8ESZZBWAvFD57EY5j/n6ihx
        HZzut5cxhJfxIBIqciZ3XxAOYw==
X-Google-Smtp-Source: APiQypIy2HFDJTLHXkfapQFjTL9P9cxp8LoavbehKspKuVFZ3iO8c3HmjkVecVBAoGSW/Tu2ZZz30g==
X-Received: by 2002:a37:65ce:: with SMTP id z197mr10389320qkb.0.1587753192850;
        Fri, 24 Apr 2020 11:33:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j25sm4286619qtn.21.2020.04.24.11.33.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 11:33:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jS38Q-0004lP-Qt; Fri, 24 Apr 2020 15:33:10 -0300
Date:   Fri, 24 Apr 2020 15:33:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3] IB/rdmavt: return proper error code
Message-ID: <20200424183310.GA18285@ziepe.ca>
References: <20200424173146.10970-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424173146.10970-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 06:31:46PM +0100, Sudip Mukherjee wrote:
> The commit 'ff23dfa13457' modified rvt_create_mmap_info() to return
> error code and also NULL but missed fixing codes which called
> rvt_create_mmap_info(). Modify rvt_create_mmap_info() to only return
> errorcode and fix error checking after rvt_create_mmap_info() was
> called.
> 
> Fixes: ff23dfa13457 ("IB: Pass only ib_udata in function prototypes")
> Cc: stable@vger.kernel.org [5.4+]
> Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Acked-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/infiniband/sw/rdmavt/cq.c   | 4 ++--
>  drivers/infiniband/sw/rdmavt/mmap.c | 4 ++--
>  drivers/infiniband/sw/rdmavt/qp.c   | 4 ++--
>  drivers/infiniband/sw/rdmavt/srq.c  | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)

Applied to for-next, thanks

Jason
