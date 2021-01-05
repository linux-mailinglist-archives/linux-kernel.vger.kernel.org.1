Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296E82EA5F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbhAEH3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:29:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:60630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbhAEH3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:29:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609831732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g9zfEk0l26Pj9jVk+ZnFzhiYCe3O/uNUfabTjYpZ0pI=;
        b=O8XhB7eIBzACYLM2Dgoz+gj1TLmBC4qIJjlMV+xyHgp1HhKl+ArLNtjOB3rErPFOq47yZz
        ipKQZ6/N3rDpPkphSxOSFshWB9urjTn49ipzHnrErvl3uvWt3AC8lxAgIV+KuAQp51tCpG
        toTTdMnp6JqXhDyFBb1oqI7Ku0YFotg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35D5FAA35;
        Tue,  5 Jan 2021 07:28:52 +0000 (UTC)
Date:   Tue, 5 Jan 2021 08:28:51 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Hui Su <sh_def@163.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: remove the static for local variable
 node_order
Message-ID: <20210105072851.GO13207@dhcp22.suse.cz>
References: <20201230114014.GA1934427@ubuntu-A520I-AC>
 <20201230124233.GE28221@casper.infradead.org>
 <20210104152357.d56d10e0443bae984a174f18@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104152357.d56d10e0443bae984a174f18@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-01-21 15:23:57, Andrew Morton wrote:
> On Wed, 30 Dec 2020 12:42:33 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Wed, Dec 30, 2020 at 07:40:14PM +0800, Hui Su wrote:
> > > local variable node_order do not need the static here.
> > 
> > It bloody well does.  It can be up to 2^10 entries on x86 (and larger
> > on others) That's 4kB which you've now moved onto the stack.
> 
> That being said, could we kmalloc the scratch area in
> __build_all_zonelists()?  And maybe remove that static spinlock?

I am not sure we can (e.g. early init code) but even if we could, what
would be an advantage. This code is called very seldom with a very
shallow stacks so using the stack allocation sounds like the easiest
thing to do.

> (what blocks node and cpu hotplug in there??)

Memory hotplug is excluded by the caller when it matters (e.g. no
locking for the early init).
-- 
Michal Hocko
SUSE Labs
