Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C212EA0C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbhADX02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbhADX01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:26:27 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A119C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:25:47 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id h22so68504376lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 15:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bZYZtiZqtjiM5mTKJrFBVkfoUrE9/7TPDo+TfeeGsN0=;
        b=SZ0tfQHLhsr9W1ajzZ39FhUzRaxy3x+zBWBSD+fu8SGm84RUr8oeAtTXXk34EIqT80
         tDMqqZ6IdhqCS6JSANuPqibcoPCEoly7svMmOTZFAPM2+CsDRFNM7PDMeYhE+m7oeIxf
         +8GSdXQNOjaF8R0tToPJnc0n0RUoTrRkrCGnHcNek2i5t/XbwHT1ZJH9ZFYOX5OQTl09
         Tvhaup+6QcssSXygg5EhjaW6SkhdaAA9pFJYgBeZTethdmdHFkGzSKrHPaZpiN0srscY
         HEcLktaEA2rc8qprUWbvJ1yVRNnuoYCACG9cGgQxBit2TOzM4VehHDRkZC0hFtdJysbt
         4KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bZYZtiZqtjiM5mTKJrFBVkfoUrE9/7TPDo+TfeeGsN0=;
        b=Pb7Zzk9LZAwvlk8hoQQR2GFvYRrgJaS3EPuwnM+lZIRfCEPT41fvFvYxS9cMM9XhkV
         /cpgGQa2oUGJNzkOB3KaLpuRJjLLnr/iI6XogTWSuLPEIaYtxBZ6h/I7vAk6CV5nkViz
         SkviQgGu9cSIdCzrV9+EqeqWZLVuN3Z22yDiTwJaP9EJdSmfKMlP2BT5p7zUvtNQP+bi
         FG2bkixk4ROM7h3VO+QnV1mXF6t+7fcms30SOLql/0tPfhGWezXeajux67AsMFX6sLUJ
         dPjX/LDOg3ZvkoVCklZggFuTv255NxAWP4uRDp3rtr6Cyv7vdlLn2BVNBLy+shQIosRH
         5nmA==
X-Gm-Message-State: AOAM531uer1PJIlBdVc4su0MCgdL27fr8bDaWHC5jmNgyxeaM6Emw2Zz
        7YtSfmB7fz5Kp44wmc7B8QuRxCmY2IqN42k2saNyIUdTHF8=
X-Google-Smtp-Source: ABdhPJxXfxM1BhY/5z030aM8G0Z4MMK7+AFboBuQ+Z7CQL9mSMsZkJ/4MtVxebNyRvqCTydGRunUvLgJHIogTDu1raY=
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr65644898ejb.264.1609799386671;
 Mon, 04 Jan 2021 14:29:46 -0800 (PST)
MIME-Version: 1.0
References: <a5ba7bdf-8510-d0a0-9c22-ec1b81019982@intel.com> <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com>
In-Reply-To: <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 4 Jan 2021 14:29:40 -0800
Message-ID: <CAPcyv4hkAN1hz=9yJ2CRYfNQ3Tjwm6z+Fghti9QKZLN-ZfR5aQ@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page
 allocation for __GFP_ZERO
To:     David Hildenbrand <david@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 12:11 PM David Hildenbrand <david@redhat.com> wrote:
>
>
> > Am 04.01.2021 um 20:52 schrieb Dave Hansen <dave.hansen@intel.com>:
> >
> > =EF=BB=BFOn 1/4/21 11:27 AM, Matthew Wilcox wrote:
> >>> On Mon, Jan 04, 2021 at 11:19:13AM -0800, Dave Hansen wrote:
> >>> On 12/21/20 8:30 AM, Liang Li wrote:
> >>>> --- a/include/linux/page-flags.h
> >>>> +++ b/include/linux/page-flags.h
> >>>> @@ -137,6 +137,9 @@ enum pageflags {
> >>>> #endif
> >>>> #ifdef CONFIG_64BIT
> >>>>    PG_arch_2,
> >>>> +#endif
> >>>> +#ifdef CONFIG_PREZERO_PAGE
> >>>> +    PG_zero,
> >>>> #endif
> >>>>    __NR_PAGEFLAGS,
> >>>
> >>> I don't think this is worth a generic page->flags bit.
> >>>
> >>> There's a ton of space in 'struct page' for pages that are in the
> >>> allocator.  Can't we use some of that space?
> >>
> >> I was going to object to that too, but I think the entire approach is
> >> flawed and needs to be thrown out.  It just nukes the caches in extrem=
ely
> >> subtle and hard to measure ways, lowering overall system performance.
> >
> > Yeah, it certainly can't be the default, but it *is* useful for thing
> > where we know that there are no cache benefits to zeroing close to wher=
e
> > the memory is allocated.
> >
> > The trick is opting into it somehow, either in a process or a VMA.
> >
>
> The patch set is mostly trying to optimize starting a new process. So pro=
cess/vma doesn=E2=80=98t really work.
>
> I still wonder if using tmpfs/shmem cannot somehow be used to cover the o=
riginal use case of starting a new vm fast (or rebooting an existing one in=
volving restarting the process).

If it's rebooting a VM then file-backed should be able to skip the
zeroing because the stale data exposure is only to itself. If the
memory is being repurposed to a new VM then the file needs to be
reallocated / re-zeroed just like the anonymous case.
