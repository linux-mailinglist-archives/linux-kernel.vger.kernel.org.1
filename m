Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018742E19C1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgLWINt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727827AbgLWINs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608711142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1BANFDoSL/jWXuZWm1zwXZxvx6f9NMcc6/oidVj3yPs=;
        b=JxIjy9mm+ZqrjD7jtcggFua3oeiUomxCrl4XM/UrdVTolPCo2Wd8jxB/nM0C2eLUvkMV7s
        712Dk7Tjy1U0vEXXcIn04/oZjqpGCRH4eoQ1oPfb3b5XM8BsaCjjilXfDAG2iPyOyF1eh8
        MOoDaelXgLUlGS/1q9zYjRpRJAgIQt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-TscbMCJFOuq4a33cCDoh1g-1; Wed, 23 Dec 2020 03:12:18 -0500
X-MC-Unique: TscbMCJFOuq4a33cCDoh1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9F0F800D55;
        Wed, 23 Dec 2020 08:12:16 +0000 (UTC)
Received: from localhost (ovpn-13-111.pek2.redhat.com [10.72.13.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2394F60C6A;
        Wed, 23 Dec 2020 08:12:12 +0000 (UTC)
Date:   Wed, 23 Dec 2020 16:12:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        gopakumarr@vmware.com, rppt@kernel.org, david@redhat.com
Subject: Re: [PATCH v2 0/5] Fix the incorrect memmep defer init handling and
 do some cleanup
Message-ID: <20201223081210.GC2205@MiWiFi-R3L-srv>
References: <20201220082754.6900-1-bhe@redhat.com>
 <20201222174658.a2d08ca723a20587467792d9@linux-foundation.org>
 <20201223020534.GA2205@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223020534.GA2205@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/20 at 10:05am, Baoquan He wrote:
> On 12/22/20 at 05:46pm, Andrew Morton wrote:
> > On Sun, 20 Dec 2020 16:27:49 +0800 Baoquan He <bhe@redhat.com> wrote:
> > 
> > > VMware reported the performance regression during memmap_init() invocation.
> > > And they bisected to commit 73a6e474cb376 ("mm: memmap_init: iterate over
> > > memblock regions rather that check each PFN") causing it.
> > > 
> > > https://lore.kernel.org/linux-mm/DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com/
> > > 
> > > After investigation, it's caused by incorrect memmap init defer handling
> > > in memmap_init_zone() after commit 73a6e474cb376. The current
> > > memmap_init_zone() only handle one memory region of one zone, while
> > > memmap_init() iterates over all its memory regions and pass them one by
> > > one into memmap_init_zone() to handle.
> > > 
> > > So in this patchset, patch 1/5 fixes the bug observed by VMware. Patch
> > > 2~5/5 clean up codes.
> > > accordingly.
> > 
> > This series doesn't apply well to current mainline (plus, perhaps,
> > material which I sent to Linus today).
> > 
> > So please check all that against mainline in a day or so, refresh,
> > retest and resend.
> > 
> > Please separate the fix for the performance regression (1/5) into a
> > single standalone patch, ready for -stable backporting.  And then a
> > separate 4-patch series with the cleanups for a 5.11 merge.

Have sent the 1/5 as a standalone patch. Will send the rest 4 patches as
a patchset once the patch 1/5 is merged into linux-next. Thanks, Andrew.

> 
> Sure, doing now. 
> 
> By the way, when sending patches to linux-mm ML, which branch should I
> rebase them on? I usually take your akpm/master as base, thought this
> will make your patch picking easier. Seems my understanding is not true,
> akpm/master is changed very soon, we should always base patch on linus's
> master branch, whether patch is sending to linux-mm or not, right?

