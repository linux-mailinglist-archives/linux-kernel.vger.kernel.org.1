Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976332F77DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbhAOLoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbhAOLoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610710954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bhu4y2f3F+cLocNZKlQ1jcFMY431IMwK7wnJQxmVPic=;
        b=GUFLj7Vaw3qgvXlkajK/HF3tAy7kLeU72aoEX4ELwGQswame6Me+uB5ZnWwkrJ722e+LsX
        Zv+D5SpL2CYgM/n67LPxJlxH/XJzSHMGuywf+j3btT4NFn0AIge8ImupKSWMSvemyuPxSK
        iAAANSeOykN1r5KT0Sl40V+z3PdeXjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-gXi2dR1QPn-FMSxt9-y8_A-1; Fri, 15 Jan 2021 06:42:32 -0500
X-MC-Unique: gXi2dR1QPn-FMSxt9-y8_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E88011034B3A;
        Fri, 15 Jan 2021 11:42:29 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51FD65C1A3;
        Fri, 15 Jan 2021 11:42:23 +0000 (UTC)
Date:   Fri, 15 Jan 2021 19:42:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 0/2] x86/setup: consolidate early memory reservations
Message-ID: <20210115114219.GA19300@MiWiFi-R3L-srv>
References: <20210115083255.12744-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115083255.12744-1-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/15/21 at 10:32am, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> David noticed that we do some of memblock_reserve() calls after allocations
> are possible:
> 
> https://lore.kernel.org/lkml/6ba6bde3-1520-5cd0-f987-32d543f0b79f@redhat.com

Thanks for CC-ing me, so I think the above patch from Roman is dangerous.
KASLR does put kernel randomly in a place, but we did a brutal parse to
get SRAT table so that we know where is hotpluggable area during boot
decompression stage. In kernel, at the beginning, we don't know that
before ACPI init. Roman's patch is wrong if I don't miss something.

I will add comment in that thread.

Thanks
Baoquan

> 
> For now there is no actual problem because in top-down mode we allocate
> from the end of the memory and in bottom-up mode we allocate above the
> kernel image. But there is a patch in the mm tree that allow bottom-up
> allocations below the kernel:
> 
> https://lore.kernel.org/lkml/20201217201214.3414100-2-guro@fb.com
> 
> and with this change we may get a memory corruption if an allocation steps
> on some of the firmware areas that are yet to be reserved.
> 
> The below patches consolidate early memory reservations done during
> setup_arch() so that memory used by firmware, bootloader, kernel text/data
> and the memory that should be excluded from the available memory for
> whatever other reason is reserved before memblock allocations are possible.
> 
> The patches are vs v5.11-rc3-mmots-2021-01-12-02-00 as I think they are
> prerequisite for the memblock bottom-up changes, but if needed I can rebase
> then on another tree.
> 
> Mike Rapoport (2):
>   x86/setup: consolidate early memory reservations
>   x86/setup: merge several reservations of start of the memory
> 
>  arch/x86/kernel/setup.c | 85 +++++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 42 deletions(-)
> 
> -- 
> 2.28.0
> 

