Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82801302851
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbhAYQ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:58:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51334 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729369AbhAYQ51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:57:27 -0500
Received: from zn.tnic (p200300ec2f09db004bb0ee0cb7e01378.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:db00:4bb0:ee0c:b7e0:1378])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A12151EC030D;
        Mon, 25 Jan 2021 17:56:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611593803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BD74lMtV58jwXCy0MpC+aGxOM2Y8WpxjlRkgS1KEFjM=;
        b=lSktTLxvW8kMg+MvEcRC1HRH2dLCN4YLLVW7JV4JweUscGQHhTOSWIuRLYVBY/O7vmpSub
        0ILCirzk/2yRiYh9A0br/PQXlHhBs7KGHwbVh24KdJYatwzBF7bWNPyQwru0Uwft4A/goH
        jWAz0LhPtEsVMpTWf6A1a/ukVMKgQPc=
Date:   Mon, 25 Jan 2021 17:56:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/setup: consolidate early memory reservations
Message-ID: <20210125165643.GH23070@zn.tnic>
References: <20210115083255.12744-1-rppt@kernel.org>
 <20210115083255.12744-2-rppt@kernel.org>
 <20210125145041.GD23070@zn.tnic>
 <20210125153114.GH6332@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125153114.GH6332@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 05:31:14PM +0200, Mike Rapoport wrote:
> This would make sense but it's tricky. From memblock perspective,
> allocations are always allowed and it is the user responsibility to ensure
> all the early reservations are done before allocating memory.

Yah, I don't trust my users to know that for sure...

> So adding such a WARN would require a new memblock API and it's adoption by
> all architectures, which is way beyond the scope of this series :)

So definitely not for those series but I could imagine something like

memblock_reserve()
	
	if (memblock_allocations_allowed())
		WARN

or so. This way you don't need to touch the archtectures. It all depends
on what the other arches need/use.

Or you could even make that a new memblock_reserve_warn() thing or so
and wrap that functionality in it and have x86 call it only...

Anyway, something to that effect.

As to those two patches, you can add

Acked-by: Borislav Petkov <bp@suse.de>

to the next revision since akpm is going to take them.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
