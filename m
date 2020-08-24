Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C21250166
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgHXPpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 11:45:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49149 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728080AbgHXPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598283892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n4X+McYKm2HPSDcgicm1bNMEAs9UALlLnJpaukedpRI=;
        b=Ifmaty39oca7k2cs5AtOjFCOLmlnxjTWweiebXpd7v6uknUIJQhXZAfrNFgnr+AjgRptsa
        KB9tg2WVOO0/swPM+KTikKgV6dSvJiny+X0HuQahc6hZW+hOS2X0+/vHrMKt67j6EHHt4d
        XvYzkI57m/5uRX21WgStcnplrCi+kEs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-Bx59mTLWP6uqSWRHeOAtPw-1; Mon, 24 Aug 2020 11:44:51 -0400
X-MC-Unique: Bx59mTLWP6uqSWRHeOAtPw-1
Received: by mail-qt1-f200.google.com with SMTP id w15so7098832qtv.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 08:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n4X+McYKm2HPSDcgicm1bNMEAs9UALlLnJpaukedpRI=;
        b=hMnKYWZKMoRLwQwkjTTD3YTWr2YeqQBkdKQYgGGihVXXtwfbPESWRPfNxGf3te2Vz2
         zeOVtxQpCHFnN6QJvQIrR89JEsMDIAgjBQ6IEeg51UDNShc4eNvqy1w7BNiv1rrKjkmo
         V2MVHtpx/pmIMWBAkJJuMvc4K3/rms4ufo9YzNfz0tJcoEqRFSf9DkbN9yvYa6+UTw2U
         fCdBiElBpJ1husOhUqCgftPOJKTSIV4pXxveagAzayCZTrUNap4N4RRbNuTHMj/0Jh5K
         Cjf5atVkRrDAQNSTWNFVsDvFRbLRL6CCsqBCJ9Qy6ys/pGbgVP/YlYrERyTNmkJBISWZ
         spPw==
X-Gm-Message-State: AOAM532TkCTVg9cwbaoB3Xqe8Bkfxbe7GkXG6WUABvp6zNwPEq/WkSjt
        AVGiGG+KYZq/8VQwg1ELyjDCWXTYvzPnAc2922j9vp0ae4W3rolb+9VBfT5ZWOqc9SBTw7LG3TV
        rPVb51K2E+RoKJAcxV/DfGmRH
X-Received: by 2002:ac8:794f:: with SMTP id r15mr5292558qtt.383.1598283890944;
        Mon, 24 Aug 2020 08:44:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj33JTZ3mBohbfbvoSOhP7o0yBfz9MoVA2SvBqR0S20h54m5UaHWiw9nh8PxL9WOsgX6JFQw==
X-Received: by 2002:ac8:794f:: with SMTP id r15mr5292543qtt.383.1598283890719;
        Mon, 24 Aug 2020 08:44:50 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id 199sm7679284qkm.13.2020.08.24.08.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:44:50 -0700 (PDT)
Date:   Mon, 24 Aug 2020 11:44:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <alistair@popple.id.au>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/migrate: Fixup setting UFFD_WP flag
Message-ID: <20200824154452.GB8605@xz-x1>
References: <20200824083128.12684-1-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824083128.12684-1-alistair@popple.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 06:31:27PM +1000, Alistair Popple wrote:
> Commit f45ec5ff16a75 ("userfaultfd: wp: support swap and page
> migration") introduced support for tracking the uffd wp bit during page
> migration. However the non-swap PTE variant was used to set the flag for
> zone device private pages which are a type of swap page.
> 
> This leads to corruption of the swap offset if the original PTE has the
> uffd_wp flag set.
> 
> Fixes: f45ec5ff16a75 ("userfaultfd: wp: support swap and page migration")
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Cc: stable@vger.kernel.org
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 34a842a8eb6a..ddb64253fe3e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -251,7 +251,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>  				entry = make_device_private_entry(new, pte_write(pte));
>  				pte = swp_entry_to_pte(entry);
>  				if (pte_swp_uffd_wp(*pvmw.pte))
> -					pte = pte_mkuffd_wp(pte);
> +					pte = pte_swp_mkuffd_wp(pte);
>  			}
>  		}

Looks correct... thanks!

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

