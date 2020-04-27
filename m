Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEED51BA9FF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 18:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgD0QVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 12:21:03 -0400
Received: from gentwo.org ([3.19.106.255]:35272 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgD0QVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:21:02 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id C6C7A3F4ED; Mon, 27 Apr 2020 16:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id C4DF23E8A0;
        Mon, 27 Apr 2020 16:21:01 +0000 (UTC)
Date:   Mon, 27 Apr 2020 16:21:01 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
In-Reply-To: <20200425024625.GA107755@carbon.lan>
Message-ID: <alpine.DEB.2.21.2004271618340.27701@www.lameter.com>
References: <20200422204708.2176080-1-guro@fb.com> <20200422204708.2176080-5-guro@fb.com> <alpine.DEB.2.21.2004222349280.20021@www.lameter.com> <20200423000530.GA63356@carbon.lan> <alpine.DEB.2.21.2004250208500.7624@www.lameter.com>
 <20200425024625.GA107755@carbon.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020, Roman Gushchin wrote:

> > The patch seems to only use it for setup and debugging? It is used for
> > every "accounted" allocation???? Where? And what is an "accounted"
> > allocation?
> >
> >
>
> Please, take a look at the whole series:
> https://lore.kernel.org/linux-mm/20200422204708.2176080-1-guro@fb.com/T/#t
>
> I'm sorry, I had to cc you directly for the whole thing. Your feedback
> will be highly appreciated.
>
> It's used to calculate the offset of the memcg pointer for every slab
> object which is charged to a memory cgroup. So it must be quite hot.


Ahh... Thanks. I just looked at it.

You need this because you have a separate structure attached to a page
that tracks membership of the slab object to the cgroup. This is used to
calculate the offset into that array....

Why do you need this? Just slap a pointer to the cgroup as additional
metadata onto the slab object. Is that not much simpler, safer and faster?

