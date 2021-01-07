Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620662ED5ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbhAGRpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:45:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:39698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbhAGRpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:45:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E703AD78;
        Thu,  7 Jan 2021 17:45:13 +0000 (UTC)
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com>
 <1607743586-80303-2-git-send-email-alex.shi@linux.alibaba.com>
 <e50574aa-87b8-8ddf-2235-ef98e22bcb7d@linux.alibaba.com>
 <alpine.LSU.2.11.2101051919130.1361@eggly.anvils>
 <20210106114620.5c221690f3a9cad7afcc3077@linux-foundation.org>
 <X/YY+mjpq15nmryI@redhat.com>
 <alpine.LSU.2.11.2101061213540.2492@eggly.anvils>
 <bd10e2dc-7a5e-835d-9a1f-9fff36cc22b5@suse.cz> <X/dGhD/R8r5yeElq@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()
Message-ID: <e59e109d-0f46-c789-8e2c-52fc6d023a82@suse.cz>
Date:   Thu, 7 Jan 2021 18:45:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/dGhD/R8r5yeElq@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 6:36 PM, Andrea Arcangeli wrote:
> On Thu, Jan 07, 2021 at 06:28:29PM +0100, Vlastimil Babka wrote:
>> On 1/6/21 9:18 PM, Hugh Dickins wrote:
>> > On Wed, 6 Jan 2021, Andrea Arcangeli wrote:
>> >> 
>> >> I'd be surprised if the kernel can boot with BUG_ON() defined as "do
>> >> {}while(0)" so I guess it doesn't make any difference.
>> > 
>> > I had been afraid of that too, when CONFIG_BUG is not set:
>> > but I think it's actually "if (cond) do {} while (0)".
>> 
>> It's a maze of configs and arch-specific vs generic headers, but I do see this
>> in include/asm-generic/bug.h:
>> 
>> #else /* !CONFIG_BUG */
>> #ifndef HAVE_ARCH_BUG
>> #define BUG() do {} while (1)
>> #endif
>> 
>> So seems to me there *are* configurations possible where side-effects are indeed
>> thrown away, right?
> 
> But this not BUG_ON, 

Oh, you're right, I got lost in the maze.

> and that is an infinite loop while(1), not an

And I overlooked that "1" too.

So that AFAICS means *both* VM_BUG_ON and VM_WARN_ON behave differently wrt
side-effects when disabled than BUG_ON and WARN_ON.

> optimization away as in while (0) that I was suggesting to just throw
> away cond and make it a noop. BUG() is actually the thing to use to
> move functional stuff out of BUG_ON so it's not going to be causing
> issues if it just loops.
> 
> This overall feels mostly an aesthetically issue.
> 
> Thanks,
> Andrea
> 

