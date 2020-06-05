Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3BC1EF2DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgFEIMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 04:12:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:51470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgFEIMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:12:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3CE49AD35;
        Fri,  5 Jun 2020 08:12:55 +0000 (UTC)
Date:   Fri, 5 Jun 2020 10:12:50 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
Message-ID: <20200605081250.GR6857@suse.de>
References: <20200603232311.GA205619@roeck-us.net>
 <20200604083512.GN6857@suse.de>
 <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 10:16:07AM -0700, Linus Torvalds wrote:
> On Thu, Jun 4, 2020 at 1:35 AM Joerg Roedel <jroedel@suse.de> wrote:
> >
> > I posted the fix for this already:
> >
> >         https://lore.kernel.org/lkml/20200604074446.23944-1-joro@8bytes.org/
> 
> Ugh.
> 
> I was going to apply this directly, but as I looked at the patch I
> just found it fairly illegible.
> 
> Is there some reason why the 5level-fixup.h versions use that
> very-hard-to-follow macro, rather than the inline functions that the
> main mm.h file uses?
> 
> I'm _assuming_ it's because it gets included in some place where not
> everything is defined yet, so making it a macro means that it works
> (later on) when everything has come together..

Exactly, I had all of the p?d_alloc_track() functions as inlines first,
but that broke compilation on some obscure architectures, so I followed
the rule to make them macros when the p?d_alloc() was also a macro and
defined them close together.


	Joerg
