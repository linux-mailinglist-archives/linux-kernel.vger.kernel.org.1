Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D9D2F18A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbhAKOrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbhAKOru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:47:50 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD4FC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:47:10 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o10so27158324lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zxHRMpq7QR1wTdVkqAqtbQPLo3QS4yb+Ze8e4uPBmNg=;
        b=0PsvqXhwBjpII2h1bnDibLJ2U5fUycGLnHN4ZjykVglnBTVIW3IqkafYB2IF2LFDW7
         EALTfYs0RX65gcyD+YxzVmEdo9cve5qgjlu27kJtEv+sFSql9WNbWuWgZFeI30wNNM1n
         ccN3u/D611TaDas+WamL8PLuzYl7sQW7hSilaEzn5/Z1CI6RpkLYBP/qxddDQN0Aitqy
         xX/WMlG03MwLCRTbY7cmYN1aW7WNA6DwxBjpMqGewl9ppY7prGAQNQqU3i7H8YZv3uui
         Ai788U1Pedc9u9MagNyM4mKPvgqpesGB/q6wiYLSBADStJcYwgLm5t8Mr4e8cg9jI4Ew
         N0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxHRMpq7QR1wTdVkqAqtbQPLo3QS4yb+Ze8e4uPBmNg=;
        b=DWsHrum/y2DjuKIfinSh59MGqlaUb6tuVgk54StklP7k1nxtmw8x2Yd/gJ8fQB9Txj
         0WA6iALDSXJ8JOwRA9nTmFpJq4NlcITDhQMFS7BaNdTcbUvmGOmylrA+RIZQEKKZo10R
         6xsGekavc7NvxwG3TMsssL4YvdqfwzJjkcapE8iEnhQvzbnzV/0OmLOBcIWAK/SOS0V0
         q2ui07goBomAqKsppufT0ZDv5nm65rFPb7negSOAvgiGiDvvaPnV3SBtxGatmevvlSL7
         Dkm1HxaMoEeIIn3kLQLb1PuP0d4uQMfHuqvEHZntajV17lqd8ov/6F5K65NBlYn996fg
         Ighg==
X-Gm-Message-State: AOAM5311VmPDI2cxbUVYo1Kpe1hJomY1jK/q1Lhy0ZOsus1+owfA5UaJ
        m6sejC9kiQfR/EFkyrLbQ3o6nA==
X-Google-Smtp-Source: ABdhPJxYY14f3Jmu7iJJBny100aDrdzfO1NYkQ81PZGiOkzjDhqDGjIefnqaZIh7bpsBBA02i2rMvQ==
X-Received: by 2002:ac2:58e8:: with SMTP id v8mr6725858lfo.630.1610376428654;
        Mon, 11 Jan 2021 06:47:08 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w6sm1168lfn.222.2021.01.11.06.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:47:08 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 47434102238; Mon, 11 Jan 2021 17:47:13 +0300 (+03)
Date:   Mon, 11 Jan 2021 17:47:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] mm: Allow architectures to request 'old' entries
 when prefaulting
Message-ID: <20210111144713.3akhv75xzk7u6rgu@box>
References: <20210108171517.5290-1-will@kernel.org>
 <20210108171517.5290-3-will@kernel.org>
 <20210111142533.oulduqd76mkpdkst@box>
 <20210111143742.GD7642@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111143742.GD7642@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 02:37:42PM +0000, Will Deacon wrote:
> On Mon, Jan 11, 2021 at 05:25:33PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Jan 08, 2021 at 05:15:16PM +0000, Will Deacon wrote:
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index c1f2dc89b8a7..0fb9d1714797 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -3051,14 +3051,18 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> > >  		if (!pte_none(*vmf->pte))
> > >  			goto unlock;
> > >  
> > > +		/* We're about to handle the fault */
> > > +		if (vmf->address == address) {
> > > +			vmf->flags &= ~FAULT_FLAG_PREFAULT;
> > > +			ret = VM_FAULT_NOPAGE;
> > > +		} else {
> > > +			vmf->flags |= FAULT_FLAG_PREFAULT;
> > > +		}
> > > +
> > 
> > Do we need to restore the oririnal status of the bit once we are done?
> 
> I can certainly add that, although it doesn't look like we do that for
> vmf->pte, so it's hard to tell what the rules are here. It certainly feels
> odd to restore some fields but not others, as it looks like vmf->address
> will be out-of-whack with vmf->pte when filemap_map_pages() returns. Am I
> missing something?

Unlike vmf->flags or vmf->address, vmf->pte is not going to be reused.
finish_fault() will overwrite it.

Yeah, it's messy.

-- 
 Kirill A. Shutemov
