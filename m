Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC0228193C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbgJBR3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBR3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:29:00 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA55C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 10:29:00 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f142so2146223qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aNnAT2BQzskDXg/1YI0n2cxBMBjNbeklM38isDwUEeM=;
        b=mEf9bJxnwS4xNn1IMwAZSNUNV8vDqZq7ph3AoN0bL3BY5fNCsmgaL5BQOVi3dlyUZQ
         TjsgWexBqeqlQRV6lXxgEOLbeDHVhOEXHx9H4c5i93Eav3EjE+NwdGV1U/lTpS3fDBFd
         pp+8U6Z/OWKYhEpvteZDTZvFm/2EtE88EUZV62P6rocaI8kZIYpMQXfME8ZiaId5Bchh
         Y01WtgdPiSBo4oSO1qZM09E40RzBMR1BcGT3720MNNSGtCetsktfA70RYuafYEaIJBsn
         7Q5P8bw046abqeIAdGcEEkT5ykFgCqUaDemDodE8/0Jw3pYBAcTUUWGr/MMGjHWiL1+r
         /8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aNnAT2BQzskDXg/1YI0n2cxBMBjNbeklM38isDwUEeM=;
        b=Md4mJQi4doYCbGnhC8RZJe4SJELPSiWYXTl0A3MEVgP8HCIVDE7bwGhaN94RWIlQN8
         vpInoAmO+63xm8dUo6xqHR9ibUfse1sOJrnTh+fjqDpw4uDh2REBJpEgimPEL4cfvDWz
         RC9VLPOIvZIturlINj4JaPQN5V4aSJK9aAFCz+QRtgm7FCLzAnkrHXi2bPI69YRStxAv
         i81ig7xUMFT0cBKR8DEyeBOa3K5ymBz5A2O23JSOimMqUKu9Pr+4nI+uQndY+P1PEY+L
         hcvgRKz+eyAHr/XQ+oNd5MsI0MY4Ik5M6QtG6r6788yc46rkRCw5PI+nWRbEi3zQiUs/
         NDoA==
X-Gm-Message-State: AOAM533ZnJJap7lk7Rsl2UmWlLKzMqD4elkhf63BQt8MUYZQ+zSeiL15
        CFf1QL0Fe413gGP1guLA4nztZQ==
X-Google-Smtp-Source: ABdhPJwUavd9TycFi0pgJ9W6Fi8Zflblx8RCTo/4fXK3hGYnZsj4heUy0UnYz01Zah07mD4L7BIg9A==
X-Received: by 2002:a05:620a:2442:: with SMTP id h2mr3070538qkn.225.1601659739890;
        Fri, 02 Oct 2020 10:28:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x126sm1445128qkb.101.2020.10.02.10.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:28:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kOOra-006FRi-Hh; Fri, 02 Oct 2020 14:28:58 -0300
Date:   Fri, 2 Oct 2020 14:28:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] mm: Remove src/dst mm parameter in copy_page_range()
Message-ID: <20201002172858.GK9916@ziepe.ca>
References: <20200930204950.6668-1-peterx@redhat.com>
 <20201002114312.GI9916@ziepe.ca>
 <20201002171429.GB5473@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002171429.GB5473@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 01:14:29PM -0400, Peter Xu wrote:
> On Fri, Oct 02, 2020 at 08:43:12AM -0300, Jason Gunthorpe wrote:
> > > -static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > > -		   pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
> > > -		   struct vm_area_struct *new,
> > > +static int copy_pte_range(pmd_t *dst_pmd, pmd_t *src_pmd,
> > > +		   struct vm_area_struct *vma, struct vm_area_struct *new,
> > >  		   unsigned long addr, unsigned long end)
> > 
> > I link this, my only minor quibble is the mixing of dst/src and new
> > language, and then reversing the order in each place. Would read
> > better to be consistent:
> > 
> >   copy_pte_range(dst_vma, dst_pmd, src_vma, src_pmd, addr, end)
> 
> I have no strong opinion on the ordering, but I agree the names are clearer.
> Considering normally we put the same type of parameters to be together, how
> about:
> 
>   copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd, addr, end)

I was looking at the order of (dst_pmd, src_pmd, src_vma, dest_vma)

Whichever, just have some logic to it :)

Jason
