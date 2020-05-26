Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D831B832E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 04:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDYCKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 22:10:25 -0400
Received: from gentwo.org ([3.19.106.255]:35166 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgDYCKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 22:10:25 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 96F853F57C; Sat, 25 Apr 2020 02:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 949283E8A0;
        Sat, 25 Apr 2020 02:10:24 +0000 (UTC)
Date:   Sat, 25 Apr 2020 02:10:24 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
In-Reply-To: <20200423000530.GA63356@carbon.lan>
Message-ID: <alpine.DEB.2.21.2004250208500.7624@www.lameter.com>
References: <20200422204708.2176080-1-guro@fb.com> <20200422204708.2176080-5-guro@fb.com> <alpine.DEB.2.21.2004222349280.20021@www.lameter.com> <20200423000530.GA63356@carbon.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020, Roman Gushchin wrote:

> On Wed, Apr 22, 2020 at 11:52:13PM +0000, Christoph Lameter wrote:
> > On Wed, 22 Apr 2020, Roman Gushchin wrote:
> >
> > >  enum stat_item {
> > >  	ALLOC_FASTPATH,		/* Allocation from cpu slab */
> > > @@ -86,6 +87,7 @@ struct kmem_cache {
> > >  	unsigned long min_partial;
> > >  	unsigned int size;	/* The size of an object including metadata */
> > >  	unsigned int object_size;/* The size of an object without metadata */
> > > +	struct reciprocal_value reciprocal_size;
> >
> >
> > This needs to be moved further back since it is not an item that needs to
> > be cache hot for the hotpaths.
>
> It could be relatively hot, because it's accessed for reading on every
> accounted allocation.

The patch seems to only use it for setup and debugging? It is used for
every "accounted" allocation???? Where? And what is an "accounted"
allocation?

