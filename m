Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF198281F1D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgJBXdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJBXdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:33:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86BC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 16:32:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w12so4613978qki.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GMZiH7LK0JBwXG4v1UP0rl5OpalOGQnJVjqVY5DNpuE=;
        b=osG89oxuUd0YEi/7lgR001W6pRaFetREjtQvKsBf/G2TO0d3iiDAi3GxfkxQMcWS0j
         CmEqnKr3FhH90etHJ3wtIUkqfpgA/xNZVkpapgJsAMZgunACHcFylO1+9h/UJCKOGdLp
         8iGTzCKhDGwVXhFyc67PzvKlxwqHDxIVvhrPbe+KLul28oRl7CzqzR0lFLTJiUkEmVaz
         wBvAD3P0Hsgw7I4yG+bPZPftF9vu9uW66bkeRZmkKkwD6cshtmNB+HolXzttsR+MpN90
         RDhuL9K4K1Hlx7lvpQCUodf7ZXpf5xjhIphbDP7YThuTUMdfc3pF2fNS1phFtFq5pYhC
         Yleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GMZiH7LK0JBwXG4v1UP0rl5OpalOGQnJVjqVY5DNpuE=;
        b=dV3pjMx9ZTe3U0VmEaWzmK2jIN+kv6QLrViSMn4O134E4tGFh9wHx2JoapXNEZYc8f
         J4iZrbuSkN+ndssshtQfCxtWH+DdRgR5CUQDKWVmAii8CIlSgCy47CnnK+oaOeKZgfhK
         gz/CX+cpZyZ85MoXY3PCkjoin6yWk5Nyl8Crbs7e4j91W8HExM6NSJbRDa/fUBn6IebW
         H3D258EWp9mOsfryjvHNI7g4vtPiQv3DcVi6zhboRaRqsErRDsDRL9lKC8unBNDJv85d
         brMbcrXRMBQaztq98a5//GfM8do5YG86kpYJf/icjmyEt32Rfs8tLA2fEsf/Ek1adisW
         MErw==
X-Gm-Message-State: AOAM530DM22heMWT/65PmVdpNo/tB+K0YNe0CHEHMwNRlNVPyavTkJnc
        1XC6d5X4KI0Q0853tU7cEreCnkoYzqpQVHkf
X-Google-Smtp-Source: ABdhPJxm+EClKfs6FuWkF0CALoyDH3g4It/uqnblZG9tNSeJybUBEdbQPbKi/8MXkyMeBYGQF/OS3w==
X-Received: by 2002:a05:620a:1367:: with SMTP id d7mr4530227qkl.20.1601681578585;
        Fri, 02 Oct 2020 16:32:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a66sm2079367qkc.52.2020.10.02.16.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 16:32:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kOUXp-006Mce-8c; Fri, 02 Oct 2020 20:32:57 -0300
Date:   Fri, 2 Oct 2020 20:32:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: Remove src/dst mm parameter in copy_page_range()
Message-ID: <20201002233257.GN9916@ziepe.ca>
References: <20201002192647.7161-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002192647.7161-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:26:47PM -0400, Peter Xu wrote:
> Both of the mm pointers are not needed after commit 7a4830c380f3 ("mm/fork:
> Pass new vma pointer into copy_page_range()").
> 
> Jason Gunthorpe also reported that the ordering of copy_page_range() is odd.
> Since working at it, reorder the parameters to be logical, by (1) always put
> the dst_* fields to be before src_* fields, and (2) keep the same type of
> parameters together.
> 
> CC: Jason Gunthorpe <jgg@ziepe.ca>
> CC: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - further reorder some parameters and line format [Jason]
> ---
>  include/linux/mm.h |   4 +-
>  kernel/fork.c      |   2 +-
>  mm/memory.c        | 139 ++++++++++++++++++++++++---------------------
>  3 files changed, 76 insertions(+), 69 deletions(-)

Thanks, looks more readable to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
