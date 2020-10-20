Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9668429449D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 23:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438717AbgJTVf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 17:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733098AbgJTVf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 17:35:57 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036D9C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 14:35:57 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o26so940724ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYeGwSIoad54GydKSNZgZE6g2uU5cfbPFHvZ08BT6RM=;
        b=vz2AkNUQj4/8TjPt9jfB06mE5lh3/rlUf+7TZCmQybUg2w9Uy6vQWbxXQCV3LtCDo6
         8NrtKsKDpJKbo08xxZc3HVsXDnUkKREszdVB2trWrs/2AdrZ3mckGXVRO6A2eIKS2906
         Z3RSSNONukymyOXsAGQm4R3ZP6mqVzcK95g/x/1IMvf8wVgCEz66GYAsUm+U916t5qMV
         Ud4Q2SPAHqkVMkhaMoeNEEg/w+QWIpXZYUr+Go78/SEGrUm7J3KqYmBLlQo51CR7KtRg
         TEmUrewGCc0Mw15SfxVDhlxCP3L6jNmETWroPevOTLaxA96Bn4Xgyce/T0RK/mgi2IXd
         /x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYeGwSIoad54GydKSNZgZE6g2uU5cfbPFHvZ08BT6RM=;
        b=kJsUBiiWWwY9Vy5yJ84b7Q7vTycQUo1oQMwrH5cZQqv7Fs+y1lZ9WIOTw5qFIcIxaK
         ib3btnSCbfgO+5juguwfvPfG+Gx22C2m/oTZmmxyVQ03oQ3gFligVGpHluzggVuR7NIO
         6JG7d0auR2Vh/00+5BRE2sbsHwcecNRoYLv4rF3iEC2wi4YTgfFfDq0a0c9u02EWEMwD
         ffiN/E5kp/fg5fQq3Jj9AZaNEUBnoHV7wgD8Y31pZjScscMHFZZwz/xellZ9BxHdA2S1
         AC6qG7eo3m6wKjfP5YKSc2qBcMRTl34rsbG95AhkkpXDMqBEiy4mMZ3hgBScihiQndbF
         ntuQ==
X-Gm-Message-State: AOAM533haIrrcG7WMWU8KKo6jOVUbTcu9/S4DU6tCDBJMqE5dwNMhaKH
        21RH2skEjJtatyWg7M/ZCgm5Y94ZCH971tmiWCLI+A==
X-Google-Smtp-Source: ABdhPJxdsFzso6n0bhQlIsaXXdnNPz55lLRK+7wVqKJ60Myp6XphIfmevRWnAF5iTVW1mTgE1+z4eTNT633n3PsqwaQ=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr155804ejz.341.1603229755722;
 Tue, 20 Oct 2020 14:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org> <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com> <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 20 Oct 2020 14:35:44 -0700
Message-ID: <CAPcyv4iYOk3i0pPgXxDTy47BxWCXqqXS0J6mrY5o+1M_41XoAw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To:     "Nabeel Meeramohideen Mohamed (nmeeramohide)" 
        <nmeeramohide@micron.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Steve Moyer (smoyer)" <smoyer@micron.com>,
        "Greg Becker (gbecker)" <gbecker@micron.com>,
        "Pierre Labat (plabat)" <plabat@micron.com>,
        "John Groves (jgroves)" <jgroves@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 3:30 PM Nabeel Meeramohideen Mohamed
(nmeeramohide) <nmeeramohide@micron.com> wrote:
>
> Hi Dan,
>
> On Friday, October 16, 2020 4:12 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 2:59 PM Nabeel Meeramohideen Mohamed
> > (nmeeramohide) <nmeeramohide@micron.com> wrote:
> > >
> > > On Thursday, October 15, 2020 2:03 AM, Christoph Hellwig
> > <hch@infradead.org> wrote:
> > > > I don't think this belongs into the kernel.  It is a classic case for
> > > > infrastructure that should be built in userspace.  If anything is
> > > > missing to implement it in userspace with equivalent performance we
> > > > need to improve out interfaces, although io_uring should cover pretty
> > > > much everything you need.
> > >
> > > Hi Christoph,
> > >
> > > We previously considered moving the mpool object store code to user-space.
> > > However, by implementing mpool as a device driver, we get several benefits
> > > in terms of scalability, performance, and functionality. In doing so, we relied
> > > only on standard interfaces and did not make any changes to the kernel.
> > >
> > > (1)  mpool's "mcache map" facility allows us to memory-map (and later unmap)
> > > a collection of logically related objects with a single system call. The objects in
> > > such a collection are created at different times, physically disparate, and may
> > > even reside on different media class volumes.
> > >
> > > For our HSE storage engine application, there are commonly 10's to 100's of
> > > objects in a given mcache map, and 75,000 total objects mapped at a given
> > time.
> > >
> > > Compared to memory-mapping objects individually, the mcache map facility
> > > scales well because it requires only a single system call and single
> > vm_area_struct
> > > to memory-map a complete collection of objects.
>
> > Why can't that be a batch of mmap calls on io_uring?
>
> Agreed, we could add the capability to invoke mmap via io_uring to help mitigate the
> system call overhead of memory-mapping individual objects, versus our mache map
> mechanism. However, there is still the scalability issue of having a vm_area_struct
> for each object (versus one for each mache map).
>
> We ran YCSB workload C in two different configurations -
> Config 1: memory-mapping each individual object
> Config 2: memory-mapping a collection of related objects using mcache map
>
> - Config 1 incurred ~3.3x additional kernel memory for the vm_area_struct slab -
> 24.8 MB (127188 objects) for config 1, versus 7.3 MB (37482 objects) for config 2.
>
> - Workload C exhibited around 10-25% better tail latencies (4-nines) for config 2,
> not sure if it's due the reduced complexity of searching VMAs during page faults.

So this gets to the meta question that is giving me pause on this
whole proposal:

    What does Linux get from merging mpool?

What you have above is a decent scalability bug report. That type of
pressure to meet new workload needs is how Linux interfaces evolve.
However, rather than evolve those interfaces mpool is a revolutionary
replacement that leaves the bugs intact for everyone that does not
switch over to mpool.

Consider io_uring as an example where the kernel resisted trends
towards userspace I/O engines and instead evolved a solution that
maintained kernel control while also achieving similar performance
levels.

The exercise is useful to identify places where Linux has
deficiencies, but wholesale replacing an entire I/O submission model
is a direction that leaves the old apis to rot.
