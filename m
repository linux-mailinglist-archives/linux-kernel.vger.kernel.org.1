Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4832CC9A6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbgLBWdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLBWdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:33:16 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CAEC0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 14:32:36 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ek7so41698qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 14:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2+QkTzqLRvVG/h0GlWvma73TqsO8aCo2dMj3wRMolNE=;
        b=W30bt0dPc1AywjZ59gYmVDUh8/ORi3j2GG4ei/X9QBUfFKCvlmeFsjkzjFjMzNbhXo
         iYuJw4tvXnjw+PBgC+5hXhZSgV0WXTAC7C882dAm3DVoU2+tjJn4+JsENUoEc9WyQHu2
         COV2Z2pg/0QTojyBo56QNWGDln+HG8OX2jSthhkKs5ZnCsxBQBw8SFnDaMsqteGbqB5a
         76BPW6zQaxOrb/HrkhFr6VUn7IBTUjhHW+fUbs+fbg6bivbDkYODD9lo7fCxgWsl8f1A
         upNky2LPzXXrOjOxA0mXmQr/SccEDKgUgzSxn5PaB0Y1/V+R9zUWtFBqSY36pDq7VvSz
         ZswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2+QkTzqLRvVG/h0GlWvma73TqsO8aCo2dMj3wRMolNE=;
        b=qSsTYB/xxQJX/nv/RNvuSjEPtQvjG0+aXypIkA5s7/J75JrUPaYMiXBHz7Pvf6ehZd
         eibLGOKvqg65RQYlDz6ik736TnHC815iZEQt+dDA+K9rRKXzBv9TFJ8YztCZM7JCHUk8
         dzrwndUVdjlIsN/efpejnx+NYeiV2pnFFQMVzKyjRG78me2euW/MSAUv4Qm10DwXBLGe
         qv708q1LZ7IP7QTpaouESM4WP04LB7WfR5+5+XWHKwWm1R74+gRparI01n29H0j+Lxbj
         t54WjPf39WHlsO4G3TqhjEB7ocs4b3lycoTOE5gu8qywiu5YzfFKkRg0NEhfovvwicfQ
         BJUA==
X-Gm-Message-State: AOAM5311HmlkgtV3bf1QSi1ADJEoePOvEdq+88RjXL0yjvG4ryasFTT0
        8rpEQq5AKypAul5a7Drh6f8=
X-Google-Smtp-Source: ABdhPJxcR2cgzHMyhQ6kszl5aG6w7O+5eGAoAWq4Czut4MVFFk2dg/InzSHmq0f4pmQ43x/j/FRO2g==
X-Received: by 2002:a05:6214:2cf:: with SMTP id g15mr162432qvu.7.1606948355487;
        Wed, 02 Dec 2020 14:32:35 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k46sm284560qtb.93.2020.12.02.14.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 14:32:34 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 2 Dec 2020 17:32:32 -0500
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Kim Phillips <kim.phillips@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>, Pu Wen <puwen@hygon.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/amd: Remove dead code for TSEG region remapping
Message-ID: <X8gWAJ+Pc6KxfYEB@rani.riverdale.lan>
References: <20201127171324.1846019-1-nivedita@alum.mit.edu>
 <20201127172747.GE13163@zn.tnic>
 <b726e0d7-7dfb-d902-652f-8aab4bf43e89@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b726e0d7-7dfb-d902-652f-8aab4bf43e89@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:58:15AM -0600, Tom Lendacky wrote:
> On 11/27/20 11:27 AM, Borislav Petkov wrote:
> > On Fri, Nov 27, 2020 at 12:13:24PM -0500, Arvind Sankar wrote:
> >> Commit
> >>    26bfa5f89486 ("x86, amd: Cleanup init_amd")
> >> moved the code that remaps the TSEG region using 4k pages from
> >> init_amd() to bsp_init_amd().
> >>
> >> However, bsp_init_amd() is executed well before the direct mapping is
> >> actually created:
> >>
> >>    setup_arch()
> >>      -> early_cpu_init()
> >>        -> early_identify_cpu()
> >>          -> this_cpu->c_bsp_init()
> >> 	  -> bsp_init_amd()
> >>      ...
> >>      -> init_mem_mapping()
> >>
> >> So the change effectively disabled the 4k remapping, because
> >> pfn_range_is_mapped() is always false at this point.
> >>
> >> It has been over six years since the commit, and no-one seems to have
> >> noticed this, so just remove the code. The original code was also
> >> incomplete, since it doesn't check how large the TSEG address range
> >> actually is, so it might remap only part of it in any case.
> > 
> > Yah, and the patch which added this:
> > 
> > 6c62aa4a3c12 ("x86: make amd.c have 64bit support code")
> > 
> > does not say what for (I'm not surprised, frankly).
> > 
> > So if AMD folks on Cc don't have any need for actually fixing this
> > properly, yap, we can zap it.
> 
> I believe this is geared towards performance. If the TSEG base address is 
> not 2MB aligned, then hardware has to break down a 2MB TLB entry if the OS 
> references the memory within the 2MB page that is before the TSEG base 
> address. This can occur whenever the 2MB TLB entry is re-installed because 
> of TLB flushes, etc.
> 
> I would hope that newer BIOSes are 2MB aligning the TSEG base address, but 
> if not, then this can help.
> 
> So moving it back wouldn't be a bad thing. It should probably only do the 
> set_memory_4k() if the TSEG base address is not 2MB aligned, which I think 
> is covered by the pfn_range_is_mapped() call?
> 

The pfn_range_is_mapped() call just checks whether it is mapped at all
in the direct mapping. Is the TSEG range supposed to be marked as
non-RAM in the E820 map? AFAICS, the only case when a direct mapping is
created for non-RAM is for the 0-1Mb real-mode range, and that will
always use 4k pages. Above that anything not marked as RAM will create
an unmapped hole in the direct map, so in this case the memory just
below the TSEG base would already use smaller pages if needed.

If it's possible that the E820 mapping says this range is RAM, then
should we also break up the direct map just after the end of the TSEG
range for the same reason?

Thanks.
