Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE78B2AC778
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgKIVmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIVmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:42:22 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34EFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:42:21 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 11so9492997qkd.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IH+26GOQMr05XaqTyGrdYZ/RrSrPo0oxAevl/En+6qA=;
        b=Q/Homuin0M0FwS5y6pFqsW5aBltSd0eWsWd3c2QVqnYa077ljXzwcFIe0IAyr/Rhr0
         EKw8oTVnGQmYlstlZlq7qsVpb0OA45TDn852cvAWZW5GxGK2ZKt+tXDeFN2/wLWBso8H
         B73xLBT/4uTKMoLYe2je8NYKbf3I6Lw00sk3ccWohDmKGQqiEPtruj3T0kEoTI2tgmvN
         o7A9qL97QaSKwJ9tyNZvUUQWHNJXPM4h0cagHt6z8+tixvQDgHjm3R/RRI6tqevMMf/Y
         nEGiiVJMRE0EKyuY4mIWViOGG583+URHNlDWwZOO8nLe6CikXULb76thA+Qq0Itv6GAz
         zyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IH+26GOQMr05XaqTyGrdYZ/RrSrPo0oxAevl/En+6qA=;
        b=oQ7Ifgj+Ap98WV9Vlpl3uUzmX0rRw+4whlnhxAq+yJUhig/eeARtKacZrXoTsTz8sX
         ERZzQEPEwiEHWZua4oRK8NUjAaJCTiZCaO3QgpgMBGn9fEGyjJQgaSa5gVyRoUwr6XPq
         NPsFcwZBCds+0apxzZ99Kj2VaZ6wRdsJ5OUXiyATcUVojVKUJSRdWOx+0AaDayTLQURA
         0qoBFf5PijS62mviyOk3K7ZQVvpZ3MKakbhoA0A0/gQoZ7JJ4xaD484EHB5VKF+maJxz
         VLUuzOUvoIgm2Ei7eBpxFR3RegGc/VmKZtJR3lmdHAd9GjK7NoDFqiQ3dwbt28WCK9Wu
         RsoA==
X-Gm-Message-State: AOAM533tSt7NQ46pTLxv3mZ5i2KEqL4aauv9oetRH41wL90ini42RkiO
        iu1/i53xGzpEqVSgPuHDIRE=
X-Google-Smtp-Source: ABdhPJy/rkmS5CJzxnVGYKowiiS0wEQRfHc91Ty4F+f69CliylLhC3XpEuZwIvZzK5KyN674rJqVbg==
X-Received: by 2002:a05:620a:1599:: with SMTP id d25mr9692555qkk.117.1604958141152;
        Mon, 09 Nov 2020 13:42:21 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h6sm5632625qtm.68.2020.11.09.13.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:42:20 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 9 Nov 2020 16:42:18 -0500
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/mm/sme: Fix definition of PMD_FLAGS_DEC_WP
Message-ID: <20201109214218.GA582504@rani.riverdale.lan>
References: <3960752c-af6c-e7ef-1acc-c7df8f60cf48@amd.com>
 <20201109173543.551282-1-nivedita@alum.mit.edu>
 <fd85ff4f-150f-958a-231a-a95848cd9af4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd85ff4f-150f-958a-231a-a95848cd9af4@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 02:41:48PM -0600, Tom Lendacky wrote:
> On 11/9/20 11:35 AM, Arvind Sankar wrote:
> > The PAT bit is in different locations for 4k and 2M/1G page table
> > entries.
> > 
> > Add a definition for _PAGE_LARGE_CACHE_MASK to represent the three
> > caching bits (PWT, PCD, PAT), similar to _PAGE_CACHE_MASK for 4k pages,
> > and use it in the definition of PMD_FLAGS_DEC_WP to get the correct PAT
> > index for write-protected pages.
> > 
> > Remove a duplication definition of _PAGE_PAT_LARGE.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> Fixes: tag?

It's been broken since it was added in

  6ebcb060713f ("x86/mm: Add support to encrypt the kernel in-place")

but the code has been restructured since then. I think it should be
backportable to 4.19.x if you want, except for that "duplication
definition"[sic] I removed, which was only added in v5.6. Do I need to
split that out into a separate patch?

> 
> Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> > ---
> >  arch/x86/include/asm/pgtable_types.h | 3 +--
> >  arch/x86/mm/mem_encrypt_identity.c   | 4 ++--
> >  2 files changed, 3 insertions(+), 4 deletions(-)
> > 
