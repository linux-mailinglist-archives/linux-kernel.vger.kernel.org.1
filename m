Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17614281A66
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgJBSEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgJBSEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601661859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l9pbAMGnZ/2sPsbUySEmQCGXBz2G/URu0iXROtPzXBA=;
        b=HCaqNSbjqVPtz4EGxpOBwMDCGy2inFmoM/2LpMzEd7n/Wu+ZYRJ7P2O7HjXI+HLlI8cvZd
        oaXCQJOWmf5M0EtlybvW3T1UBS3BqQObRRlbCLsZQ7FI4LRfrf9DDseCIWnF+UfKsWz7LH
        IIjgdvMJEF1gvfNKaZKJwJY0ahTn0pc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-VCq2Q1b0O8SD1S5Ioqfw-Q-1; Fri, 02 Oct 2020 14:04:17 -0400
X-MC-Unique: VCq2Q1b0O8SD1S5Ioqfw-Q-1
Received: by mail-qv1-f69.google.com with SMTP id r16so1305755qvn.18
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l9pbAMGnZ/2sPsbUySEmQCGXBz2G/URu0iXROtPzXBA=;
        b=XMaPp3u4QIintmb3oQ50NdVH8Sp5mlAnM6eaPQae60LeDgVeEZimKajX5x7NjJRJol
         CTYbBvMytz4zg6ROLkQHedicphslYeNSmJS6jRn+1BOqv/2UdXFftCbcyr1Amhqx828O
         kGLHTbj+YW2Sjtzlo2gbFoq0jdHH96cO6jJtgBA+oZOuU3F6F90DbzkhaE5Cayk3tw1i
         JfKyJZ4oYNYrwer+Pe1xBbyHvNjt1sp4iXokRhjrrLTXcArz/3I4c1SsBJC+RIoFK9g3
         cNvK1OIn7IxEFm+hEm3OLEZJtJa10pFnUDXC3BipNz13xm3Xv1zboKkRsocY58Ad6ZJS
         FRog==
X-Gm-Message-State: AOAM531JokKfvcRPrcuUaN9vMeOWq0xBqEseXAjd1ETsJzQm53iCqd51
        OuQ7rSqP/kdA9XzHeuLSiFF0kFGK8zUTPWty2SuHzO7edRD6HTS04F+6RqIOHlmxAfPBxje7rZp
        TJLcoyVv/YaNzaDC7UyE2FcCF
X-Received: by 2002:aed:2b63:: with SMTP id p90mr3475731qtd.71.1601661856684;
        Fri, 02 Oct 2020 11:04:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylJOl0sGwOBRIBnzqiSHxiC6y0cjtp/qSGOEnDKnnqlH1xQk8vhJBoMZQOxX7mpOTY21K8sA==
X-Received: by 2002:aed:2b63:: with SMTP id p90mr3475706qtd.71.1601661856390;
        Fri, 02 Oct 2020 11:04:16 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id t64sm1530965qkd.69.2020.10.02.11.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 11:04:15 -0700 (PDT)
Date:   Fri, 2 Oct 2020 14:04:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] mm: Remove src/dst mm parameter in copy_page_range()
Message-ID: <20201002180414.GD5473@xz-x1>
References: <20200930204950.6668-1-peterx@redhat.com>
 <20201002114312.GI9916@ziepe.ca>
 <20201002171429.GB5473@xz-x1>
 <20201002172858.GK9916@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201002172858.GK9916@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 02:28:58PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 02, 2020 at 01:14:29PM -0400, Peter Xu wrote:
> > On Fri, Oct 02, 2020 at 08:43:12AM -0300, Jason Gunthorpe wrote:
> > > > -static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > > > -		   pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
> > > > -		   struct vm_area_struct *new,
> > > > +static int copy_pte_range(pmd_t *dst_pmd, pmd_t *src_pmd,
> > > > +		   struct vm_area_struct *vma, struct vm_area_struct *new,
> > > >  		   unsigned long addr, unsigned long end)
> > > 
> > > I link this, my only minor quibble is the mixing of dst/src and new
> > > language, and then reversing the order in each place. Would read
> > > better to be consistent:
> > > 
> > >   copy_pte_range(dst_vma, dst_pmd, src_vma, src_pmd, addr, end)
> > 
> > I have no strong opinion on the ordering, but I agree the names are clearer.
> > Considering normally we put the same type of parameters to be together, how
> > about:
> > 
> >   copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd, addr, end)
> 
> I was looking at the order of (dst_pmd, src_pmd, src_vma, dest_vma)
> 
> Whichever, just have some logic to it :)

Oh, sure. :)

-- 
Peter Xu

