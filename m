Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D162EA2DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 02:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbhAEBbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 20:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhAEBbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 20:31:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAD5C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 17:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AZ9yvBLzQkyhwGhPhQhb3S0RKliCB25y6JTRong7Zzg=; b=XfUtrknvY01Ka5ohlY3XrY8I0L
        7TiFZD9Hr6resdEAiBJ0spVqKVEvaurmcssFfEbt+7Y4+SvNA/hQMa5UwWW8S4VDOXF3fJPrpdCEy
        90RgYBhUQuL+U8TpFE/0PJ2LdasUdbNOkf6zFTaQt/A4O2F+R1tL0IgEOptvcP0Jx3zzCR0xX+Fp4
        m7FsDn1RKsX4F0mQ5MT4JW0/su/UGfhrU5WpfPfmo+0pKNAf7eGhtMw+SSC2XeRifrICC05+tlcoN
        bynO1CxgetEzjXE1mS7e4HgVjl4qfGd4EHclmgQtSGU/kn/U0aqtXXZaAm2HO1Ug3LxwIaUnitWuz
        eS7N4fTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kwbB4-000k6d-Kg; Tue, 05 Jan 2021 01:30:34 +0000
Date:   Tue, 5 Jan 2021 01:30:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hui Su <sh_def@163.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm/page_alloc: remove the static for local variable
 node_order
Message-ID: <20210105013026.GA175893@casper.infradead.org>
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

On Mon, Jan 04, 2021 at 03:23:57PM -0800, Andrew Morton wrote:
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
> 
> (what blocks node and cpu hotplug in there??)

if we don't have the zonelists built yet, can slab possibly be operational?
