Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501B02E1175
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 02:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgLWBrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 20:47:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgLWBrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 20:47:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A97992256F;
        Wed, 23 Dec 2020 01:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1608688019;
        bh=ZEPYdvs02rD2KFiANzUJPEVo2S5t5C+itOXnp/i/zBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZJQ9hAgGrHx2BkzIRPPCqIiMxuD+51N6QSnpXoIBzSivbO+7FXnpECel/EmHvIM3c
         WPQ46mZazHTzwakVZe8i8zh7pcxng+OuiC+OyNSMxStLIfcDxChxGPzYysR34wuoJx
         vjXNk2zjoHeGmsnaCQZDo/XN9vsmI82PYeUXF6E4=
Date:   Tue, 22 Dec 2020 17:46:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        gopakumarr@vmware.com, rppt@kernel.org, david@redhat.com
Subject: Re: [PATCH v2 0/5] Fix the incorrect memmep defer init handling and
 do some cleanup
Message-Id: <20201222174658.a2d08ca723a20587467792d9@linux-foundation.org>
In-Reply-To: <20201220082754.6900-1-bhe@redhat.com>
References: <20201220082754.6900-1-bhe@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Dec 2020 16:27:49 +0800 Baoquan He <bhe@redhat.com> wrote:

> VMware reported the performance regression during memmap_init() invocation.
> And they bisected to commit 73a6e474cb376 ("mm: memmap_init: iterate over
> memblock regions rather that check each PFN") causing it.
> 
> https://lore.kernel.org/linux-mm/DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com/
> 
> After investigation, it's caused by incorrect memmap init defer handling
> in memmap_init_zone() after commit 73a6e474cb376. The current
> memmap_init_zone() only handle one memory region of one zone, while
> memmap_init() iterates over all its memory regions and pass them one by
> one into memmap_init_zone() to handle.
> 
> So in this patchset, patch 1/5 fixes the bug observed by VMware. Patch
> 2~5/5 clean up codes.
> accordingly.

This series doesn't apply well to current mainline (plus, perhaps,
material which I sent to Linus today).

So please check all that against mainline in a day or so, refresh,
retest and resend.

Please separate the fix for the performance regression (1/5) into a
single standalone patch, ready for -stable backporting.  And then a
separate 4-patch series with the cleanups for a 5.11 merge.

Thanks.
