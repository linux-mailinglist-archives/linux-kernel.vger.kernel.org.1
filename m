Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7927823E190
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 20:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgHFS51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 14:57:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFS50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:57:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD107AC82;
        Thu,  6 Aug 2020 18:57:42 +0000 (UTC)
Date:   Thu, 6 Aug 2020 20:57:23 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
Message-ID: <20200806185723.GA24304@suse.de>
References: <20200803190354.GA1293087@gmail.com>
 <20200805110348.GA108872@zx2c4.com>
 <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
 <20200806131034.GA2067370@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806131034.GA2067370@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 03:10:34PM +0200, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > So apparently the "the page-table pages are all pre-allocated now" is
> > simply not true. Joerg?

It pre-allocates the whole vmalloc/ioremap PUD/P4D pages, but I actually
only tested it with 4-level paging, as I don't have access to 5-level
paging hardware.

I'll try to make sense of that oops.

> > Unless somebody can figure this out fairly quickly, I think it should
> > just be reverted.
> 
> Agreed. Joerg?

Yeah, please just revert that commit for now until I have an idea what
went wrong.

	
	Joerg
