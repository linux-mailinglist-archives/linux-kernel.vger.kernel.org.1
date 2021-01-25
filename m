Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619D7302732
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbhAYPsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730356AbhAYPpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:45:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A2F023B87;
        Mon, 25 Jan 2021 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611588793;
        bh=UUqFz1GCDzeajvsIz4oIG+JUrq9IF12fIPbYDXS1rmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3FP1W05HV8KVZ1L7JANRqbSkd19MZY3xu2YlCzZS2NeBhwUGgk2VO8fqn4bbElLA
         pNLPkq92eVYG7zDfnLEZiLufvN/5/q2IDC1tCClVDZTNkWDLBlP04Fa7+lPSF+EW1l
         VHbkVM0KDODfZFpI5cLuW4vtmwxUhuxrHg/2s43xsMRPXiwDr7+T3JAmrRiTsJoPlm
         k98K7L7G3Z67fLIorg9UpGTtn/3B09ebV/JGr+wrkXpnWywnh21QTSlJqWq0dVp63o
         /eu2i8AESrhKFqn3c3cpxVAZexvMh7BBXsAwy6+ailA2RdyqJWsVd18Dg8Go7TGMZT
         OS9j2DjtjSZ0g==
Date:   Mon, 25 Jan 2021 17:33:03 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20210125153303.GI6332@kernel.org>
References: <20210115083255.12744-1-rppt@kernel.org>
 <20210115083255.12744-2-rppt@kernel.org>
 <20210125145911.GF23070@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125145911.GF23070@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 03:59:11PM +0100, Borislav Petkov wrote:
> On Fri, Jan 15, 2021 at 10:32:54AM +0200, Mike Rapoport wrote:
> > +	trim_low_memory_range();
> 
> Btw, you can get rid of that one too:
> 
> /*
>  * Here we put platform-specific memory range workarounds, i.e.
>  * memory known to be corrupt or otherwise in need to be reserved on
>  * specific platforms.
>  *
>  * If this gets used more widely it could use a real dispatch mechanism.
>  */
> static void __init trim_platform_memory_ranges(void)
> {
>         trim_snb_memory();
> }
> 
> yeah, yeah, we can do a real dispatch mechanism but we didn't need one
> since 2012 so I guess we can get rid of trim_platform_memory_ranges()
> and call trim_snb_memory() directly and simplify it even more.

Ok.
 
> Thx.
> 

-- 
Sincerely yours,
Mike.
