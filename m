Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D44C283310
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgJEJUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:20:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:49758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgJEJUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:20:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601889632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/jLybspX4sh2YZYLrtuLA0SCyoflJWvMsPlKpVe9VrQ=;
        b=lUiZk6nvygX1QLMSavN0Ypn4+QRF0067YjB82q7ymFKOSAnzUsfC2KeCF7bm/lVhw4fVZ4
        +GCO/9FZeblj3HeIAZHbkKlSyphBlSIh0yVLiMmkrwLlC1aeTFopt1lCJgomSjHZX5C24M
        Oc5oYnc1sJTm7RcMNPuZZ7LRggp7fCY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38B7DB2A3;
        Mon,  5 Oct 2020 09:20:32 +0000 (UTC)
Date:   Mon, 5 Oct 2020 11:20:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: optionally disable brk()
Message-ID: <20201005092031.GS4555@dhcp22.suse.cz>
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
 <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
 <20201005061248.GN4555@dhcp22.suse.cz>
 <888e62e0-3979-207b-c516-ddfc6b9f3345@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888e62e0-3979-207b-c516-ddfc6b9f3345@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-10-20 11:13:48, David Hildenbrand wrote:
> On 05.10.20 08:12, Michal Hocko wrote:
> > On Sat 03-10-20 00:44:09, Topi Miettinen wrote:
> >> On 2.10.2020 20.52, David Hildenbrand wrote:
> >>> On 02.10.20 19:19, Topi Miettinen wrote:
> >>>> The brk() system call allows to change data segment size (heap). This
> >>>> is mainly used by glibc for memory allocation, but it can use mmap()
> >>>> and that results in more randomized memory mappings since the heap is
> >>>> always located at fixed offset to program while mmap()ed memory is
> >>>> randomized.
> >>>
> >>> Want to take more Unix out of Linux?
> >>>
> >>> Honestly, why care about disabling? User space can happily use mmap() if
> >>> it prefers.
> >>
> >> brk() interface doesn't seem to be used much and glibc is happy to switch to
> >> mmap() if brk() fails, so why not allow disabling it optionally? If you
> >> don't care to disable, don't do it and this is even the default.
> > 
> > I do not think we want to have config per syscall, do we? 
> 
> I do wonder if grouping would be a better option then (finding a proper
> level of abstraction ...).

I have a vague recollection that project for the kernel tinification was
aiming that direction. No idea what is the current state or whether
somebody is pursuing it.

-- 
Michal Hocko
SUSE Labs
