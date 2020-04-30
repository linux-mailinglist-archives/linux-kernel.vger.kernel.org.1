Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3591C027E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgD3Q3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 12:29:51 -0400
Received: from gentwo.org ([3.19.106.255]:55834 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgD3Q3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:29:51 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 8B6B13EEE2; Thu, 30 Apr 2020 16:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 8A3B03E998;
        Thu, 30 Apr 2020 16:29:50 +0000 (UTC)
Date:   Thu, 30 Apr 2020 16:29:50 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
In-Reply-To: <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
Message-ID: <alpine.DEB.2.21.2004301625490.1693@www.lameter.com>
References: <20200422204708.2176080-1-guro@fb.com> <20200422204708.2176080-5-guro@fb.com> <alpine.DEB.2.21.2004222349280.20021@www.lameter.com> <20200423000530.GA63356@carbon.lan> <alpine.DEB.2.21.2004250208500.7624@www.lameter.com> <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com> <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020, Roman Gushchin wrote:

> > Why do you need this? Just slap a pointer to the cgroup as additional
> > metadata onto the slab object. Is that not much simpler, safer and faster?
> >
>
> So, the problem is that not all slab objects are accounted, and sometimes
> we don't know if advance if they are accounted or not (with the current semantics
> of __GFP_ACCOUNT and SLAB_ACCOUNT flags). So we either have to increase
> the size of ALL slab objects, either create a pair of slab caches for each size.

>
> The first option is not that cheap in terms of the memory overhead. Especially
> for those who disable cgroups using a boot-time option.


If the cgroups are disabled on boot time then you can switch back to the
compact version. Otherwise just add a pointer to each object. It will make
it consistent and there is not much memory wastage.

The problem comes about with the power of 2 caches in the kmalloc array.
If one keeps the "natural alignment" instead of going for the normal
alignment of slab caches then the alignment will cause a lot of memory
wastage and thus the scheme of off slab metadata is likely going to be
unavoidable.

But I think we are just stacking one bad idea onto another here making
things much more complex than they could be. Well at least this justifies
all our jobs .... (not mine I am out of work... hehehe)

