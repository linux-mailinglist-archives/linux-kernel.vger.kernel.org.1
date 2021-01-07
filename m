Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3902ED710
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbhAGTAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbhAGTAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:00:04 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F6C0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 10:58:27 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxaUC-0086S5-9C; Thu, 07 Jan 2021 18:58:16 +0000
Date:   Thu, 7 Jan 2021 18:58:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Subject: Re: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
Message-ID: <20210107185816.GJ3579531@ZenIV.linux.org.uk>
References: <20210107134723.GA28532@xsang-OptiPlex-9020>
 <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
 <20210107183358.GG3579531@ZenIV.linux.org.uk>
 <CAHk-=wiZaFRt9hGen9=eOr7LA+Q8o5f980eGEvtxBD6+os7nqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZaFRt9hGen9=eOr7LA+Q8o5f980eGEvtxBD6+os7nqA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 10:47:07AM -0800, Linus Torvalds wrote:
> On Thu, Jan 7, 2021 at 10:34 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > I'm not sure it's the best approach, TBH.  How about simply
> >         for (walk = head; walk; ufds += walk->len, walk = walk->next) {
> >                 if (copy_to_user(ufds, walk->entries,
> >                                  walk->len * sizeof(struct pollfd))
> >                         goto out_fds;
> >         }
> > in there?  It's both simpler (obviously matches the copyin side) and
> > might very well be faster...
> 
> I started doing that, but ..  Nope.
> 
> It's not copying the whole entry. It's literally just modifying one
> 16-bit word in each entry.
> 
> Now, the "whole entry" is just 8 bytes, so it's possible that it would
> actually be faster to do a copy of the whole thing rather than write
> just the 16 bits. But I got very nervous about it, because I could
> easily see some threaded app actually changing the 'fd' (or the
> 'event' field) in place (ie writing -1 to it as they close and re-use
> it)

Point...  Pity, that.
