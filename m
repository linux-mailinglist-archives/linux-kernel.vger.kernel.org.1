Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C355F2818E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbgJBROf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgJBROf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601658874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9YNVR6BrU2NGxneUWWYLKFH1m7KwKMpGFjULgODVOM=;
        b=QnVoVH9Vk8YJzaKCIDQn5kM/9ePRUkE80/BAILPqm1eNdx0u2Gq1xHFQFibQU+hDEUUlRT
        s/7hTITQwkwbKLl8cnSdFrJfkwtF1ECXBPhEs5PlSRql4hKxmemUxEXqv3higO9TGlG7H1
        CfgfQJN2pkko+HNywqsfTCXuC4O9F8A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-E0v9ozjlOISlwPyO1fyaPA-1; Fri, 02 Oct 2020 13:14:32 -0400
X-MC-Unique: E0v9ozjlOISlwPyO1fyaPA-1
Received: by mail-qk1-f199.google.com with SMTP id 16so1522292qky.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H9YNVR6BrU2NGxneUWWYLKFH1m7KwKMpGFjULgODVOM=;
        b=FYLhgcVluBRC0pJuTCx6KcKiqBDrCtwm2+NeZCV07kqJVPxa1SpjIr7eTEvbqod5Ol
         URDcFECwih7wOVZSkqj0JomJ0QU4yRmYG4PbCTnR2P26nkJFtfmtgGt0ACUqPY74qjYM
         A5u/xX9/PE2k0efzG7GP5q8bsMfftLxhlaZ66j+RaiOVCk2r+87DCLkgRKbDHuFsXkpA
         nEEC+ioM3le6gyEZRYo0JVB3xFvSz43bfOzucP391rDLQf6RavOrxX+DaOljoO7lZ4Cn
         kjJP6Z9S5wXJMLRWEhr2J8o51X1+2OORBxXb6sUR2D2GCxaT3ChOxI3Hirr/vjowMYab
         rAnQ==
X-Gm-Message-State: AOAM53386s4LnZzVfztnhzJ0gOKNmRB7dd0tuo38I0yCwwQQrcuvtK+w
        6iUT/c5miHh4eBmGMf8TIEP1Xq/pUfyaKrh8SRs3GExLgNQ87clciQXGyA9iLMicB8pcm0wl0Wf
        trDgRSnwomcCjWs1wKwPTxgxF
X-Received: by 2002:a05:620a:2082:: with SMTP id e2mr2899156qka.421.1601658871955;
        Fri, 02 Oct 2020 10:14:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz91o8uz8PP283FAWSk1vB20zLLcd1fcgGHGqnN6wLniDiAftqBWCSKtKyZioCRYQC5Pw5w+Q==
X-Received: by 2002:a05:620a:2082:: with SMTP id e2mr2899141qka.421.1601658871663;
        Fri, 02 Oct 2020 10:14:31 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id g14sm1461694qkk.38.2020.10.02.10.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:14:31 -0700 (PDT)
Date:   Fri, 2 Oct 2020 13:14:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] mm: Remove src/dst mm parameter in copy_page_range()
Message-ID: <20201002171429.GB5473@xz-x1>
References: <20200930204950.6668-1-peterx@redhat.com>
 <20201002114312.GI9916@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201002114312.GI9916@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 08:43:12AM -0300, Jason Gunthorpe wrote:
> > -static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > -		   pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
> > -		   struct vm_area_struct *new,
> > +static int copy_pte_range(pmd_t *dst_pmd, pmd_t *src_pmd,
> > +		   struct vm_area_struct *vma, struct vm_area_struct *new,
> >  		   unsigned long addr, unsigned long end)
> 
> I link this, my only minor quibble is the mixing of dst/src and new
> language, and then reversing the order in each place. Would read
> better to be consistent:
> 
>   copy_pte_range(dst_vma, dst_pmd, src_vma, src_pmd, addr, end)

I have no strong opinion on the ordering, but I agree the names are clearer.
Considering normally we put the same type of parameters to be together, how
about:

  copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd, addr, end)

Thanks,

-- 
Peter Xu

