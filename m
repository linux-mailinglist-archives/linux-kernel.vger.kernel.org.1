Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D13F2FC442
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbhASW4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:56:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395064AbhASO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611066294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5oU2Ie/VxNNle5UC5ptcg2zY6dliYar7/T7TMF+R/8=;
        b=VtIaQmiCdvhEZ3fk1eS9pa20pm6I+6HVZYuatrgth4ow105PV+e0Ygbea3HqRwHJper+HJ
        7zAMvKKBLTpFesAjEbJcilUV0s+5RngyWB2+YbQi0HwTGZEMv2PGuw2AX/gsFgEqvyd6eU
        iFlxCQtaQpll/gsrs8kRImrKAVkCXl8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-YKJy7ar7N-CElPQo6wXPLA-1; Tue, 19 Jan 2021 09:24:52 -0500
X-MC-Unique: YKJy7ar7N-CElPQo6wXPLA-1
Received: by mail-qv1-f71.google.com with SMTP id m1so19835196qvp.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 06:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S5oU2Ie/VxNNle5UC5ptcg2zY6dliYar7/T7TMF+R/8=;
        b=WodZLaxuUv0Y3bzy6b2nD2VYXToHZ9L2NBhpFwnj1+/EFSnH+Aa1gZA27SLSz0JIb8
         VRan3DgIAai4FCUubCXPl5xCHJaoEmGU9qj5DCTweHpzZ2i6t0YsOW6Cp4ef15eaPvUU
         kyIxl1OOqKlOtwYSmb/Oq4bxQKhkRb/7HyPRaoAwwvjvYeFQwSIbpF8dpRJDPy8D4y/+
         H0SR3pVFtIUMCXpWpJ9O+LRb2oMTmGTUXAC0aqHdC9gdApm9GflafqYjgKTtDzWKQx2X
         RaJ2lf9pAEhi85Mdw2bNSPXthkBuwOp5nUtu39vfjZbBRj8wX4trXWW3MTbRYh5n3GsC
         s1Jg==
X-Gm-Message-State: AOAM531pQedee0ib4fJO3gtmHhHlpP0stddEUj6W6qQBfzcEXSWWlTVj
        v9df71fhnWEVCjEvsAYv9IXHPucCUC/P26BpU13fcmnXHrRfIaTa0gTUhHsbw+rdG83C5lP/W8H
        SpTbNZIf2qY1phzMmK/Wulkfh
X-Received: by 2002:a0c:eed3:: with SMTP id h19mr4758385qvs.18.1611066292184;
        Tue, 19 Jan 2021 06:24:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxexp38ofvK77a0ePIAQrevhe43Om+FBagMzeBtmCxifRFDTtSYScAIb2+5m2HDB8gP9xBm6A==
X-Received: by 2002:a0c:eed3:: with SMTP id h19mr4758354qvs.18.1611066291871;
        Tue, 19 Jan 2021 06:24:51 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id c136sm12986344qkg.71.2021.01.19.06.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 06:24:51 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:24:49 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RFC 07/30] mm/swap: Introduce the idea of special swap
 ptes
Message-ID: <20210119142449.GE76571@xz-x1>
References: <20210115170907.24498-1-peterx@redhat.com>
 <20210115170907.24498-8-peterx@redhat.com>
 <20210118194013.GM4605@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210118194013.GM4605@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 03:40:13PM -0400, Jason Gunthorpe wrote:
> Does the stuff in hmm.c need updating too?
> 
>         if (!pte_present(pte)) {
>                 swp_entry_t entry = pte_to_swp_entry(pte);

This idea should be cross-tree, so yes.. even if I'm not 100% sure whether HMM
would be a good candidate for file-backed uffd-wp, I agree we should also take
care of those.

I guess I managed to take care of all the is_swap_pte() callers but forget I
should also look for pte_to_swp_entry() users too, since sometimes pte_none()
and pte_present() is checked separately, so there're quite a few places that I
should have taken care of but got lost.  HMM is one of them.

Thanks for spotting this, Jason.  I'll coordinate in the next version.

-- 
Peter Xu

