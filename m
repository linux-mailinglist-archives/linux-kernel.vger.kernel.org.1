Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5AF2CDAF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389327AbgLCQOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389318AbgLCQOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:14:50 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C588FC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:14:09 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id r6so1721029qtm.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3C2IXAzqvDwlkSCP0xY3vlc/cNVEEj2yRnHaCw31rPw=;
        b=O3ScHLjOE4nAdbi1Lea4bUAn1LU1kQb/kuBnh0lUPCh2f1xOigDCreW4IGQeEfPaCM
         BUkW52UkoFJ0LEfNJj/Ef7cqSVx1FBft91mndnNkrMkF8KJyd0Go0UQI7lVCy9Uc+cRs
         ieAwj/81yQgu7NjZwRjweg/OUVCxLoDzjGL4Db/XWmx8mYJKpAjwcVO0pOqiL8oLDw5+
         T0ppQaow61wKiI0yi94jVhh6RBjonx6PeOptvxuR8gSSo9eehX2aMJEG26DEb+6rjfZh
         iqVKluh0EfseA0IoeYt7zcwLslxCEkHDvYoGLO55iIiY1I3cSlFqdHv5PVWwPsPxB7XN
         JY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3C2IXAzqvDwlkSCP0xY3vlc/cNVEEj2yRnHaCw31rPw=;
        b=Gu+sn+0Fc13/RNB1ZOHQfQPOr17pjlj75DIlx1yToSvJdPc9vhy3ubglBlqouNKKaQ
         eqNARVf6PomLoRPW3bqErzq8HpmS4L5voEEvvX1RZTBTPh33WbgkiVnEcGgyv0mfE98O
         KkJdoi5jgury1l/hYlupXLOMK4Mg+eu40JD97Q4rBh2isu2suxCHqdvm8s6m1xRM7Cl1
         Ugg/BIV+TYN+sU6wfSKuXPvHjOWW3qK8pPJjdD8DUR7SeRRInkx1jqYNYXVNDw4DT0mf
         EY8vBW6W3ppW02FR20CVgpNyD/OYiGSSNVP2YQY+SOEaOdZZNvn9MGnehNN5EKEdjTJg
         h0GQ==
X-Gm-Message-State: AOAM5333oqtQLtE/u8PB5lYmS012oXMDXL9GfQOn4Nev5kKU4AUplVE8
        hh3B+62ClIrPHeO9HhRyCPg=
X-Google-Smtp-Source: ABdhPJzX0y9IFNarcPlCkj3bbRb441LuTvpG16S6aWcCO8KJFBC/QB3ICKJIpBYxAxUDAo1gosCllA==
X-Received: by 2002:ac8:7a95:: with SMTP id x21mr3914143qtr.307.1607012048849;
        Thu, 03 Dec 2020 08:14:08 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 9sm1894554qkm.81.2020.12.03.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:14:07 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 3 Dec 2020 11:14:06 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Kim Phillips <kim.phillips@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>, Pu Wen <puwen@hygon.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/amd: Remove dead code for TSEG region remapping
Message-ID: <X8kOzpXyDXNo2PE7@rani.riverdale.lan>
References: <20201127171324.1846019-1-nivedita@alum.mit.edu>
 <20201127172747.GE13163@zn.tnic>
 <b726e0d7-7dfb-d902-652f-8aab4bf43e89@amd.com>
 <X8gWAJ+Pc6KxfYEB@rani.riverdale.lan>
 <20201203084857.GD3059@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201203084857.GD3059@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 09:48:57AM +0100, Borislav Petkov wrote:
> On Wed, Dec 02, 2020 at 05:32:32PM -0500, Arvind Sankar wrote:
> > The pfn_range_is_mapped() call just checks whether it is mapped at all
> > in the direct mapping. Is the TSEG range supposed to be marked as
> > non-RAM in the E820 map? AFAICS, the only case when a direct mapping is
> > created for non-RAM is for the 0-1Mb real-mode range, and that will
> > always use 4k pages. Above that anything not marked as RAM will create
> > an unmapped hole in the direct map, so in this case the memory just
> > below the TSEG base would already use smaller pages if needed.
> > 
> > If it's possible that the E820 mapping says this range is RAM, then
> > should we also break up the direct map just after the end of the TSEG
> > range for the same reason?
> 
> So I have a machine where TSEG is not 2M aligned and somewhere in the 1G
> range:
> 
> [    1.135094] tseg: 003bf00000
> 
> It is not in the E820 map either:
> 
> [    0.019784] init_memory_mapping: [mem 0x00000000-0x000fffff]
> [    0.020014] init_memory_mapping: [mem 0x3bc00000-0x3bdfffff]
> [    0.020166] init_memory_mapping: [mem 0x20000000-0x3bbfffff]
> [    0.020327] init_memory_mapping: [mem 0x00100000-0x1fffffff]
> [    0.020677] init_memory_mapping: [mem 0x3be00000-0x3be8ffff]
> 
> That doesn't mean that it can happen that there might be some
> configuration where it ends up being mapped.
> 
> So looking at what the code does, it kinda makes sense: you want the 2M
> range between 0x3be00000 and 0x3c000000 to be split into 4K mappings,
> *if* it is mapped.
> 
> I need to find a box where it is mapped *and* not 2M aligned, though,
> for testing. Which appears kinda hard to do as all the new ones are
> aligned.

Do any of them have it mapped at all, regardless of the alignment? There
seems to be nothing else in the kernel that ever looks at the TSEG MSR,
so I would guess that it has to be non-RAM in the E820 map, otherwise
nothing would prevent the kernel from allocating and using that space.

I found the actual original commit, which does has a description of the
reasoning. It's
  8346ea17aa20 ("x86: split large page mapping for AMD TSEG")

It looks like at the time, the direct mapping didn't really look at the
E820 map in any detail, and was always set up with at least 2Mb pages,
or Gb pages if they were available, from 0 to max_pfn_mapped. So the
direct mapping would have covered even holes that weren't in the E820
map.

Commit
  66520ebc2df3 ("x86, mm: Only direct map addresses that are marked as E820_RAM")
changed the direct map setup to avoid mapping holes, because it
apparently became more serious than performance issues: this commit
mentions MCE's getting triggered because of the overmapping.

> 
> The above is from a K8 box which should already be dead, as a matter of
> fact.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
