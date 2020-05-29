Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F761E835C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 18:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgE2QPW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 May 2020 12:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2QPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:15:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A2C03E969;
        Fri, 29 May 2020 09:15:21 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jehfC-0000nm-H5; Fri, 29 May 2020 18:15:18 +0200
Date:   Fri, 29 May 2020 18:15:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mark Marshall <markmarshall14@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mark Marshall <mark.marshall@omicronenergy.com>,
        thomas.graziadei@omicronenergy.com,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: Kernel crash due to memory corruption with v5.4.26-rt17 and
 PowerPC e500
Message-ID: <20200529161518.svpxhkeljafbtdz2@linutronix.de>
References: <CAD4b4WK9W+dNZZ_WPt-9ZNpSHvyxdwPW86Rtq4AKOONuvyR37A@mail.gmail.com>
 <20200529131452.pgj7mx7xaz7n4kz3@linutronix.de>
 <CAD4b4WLS36JKepz31m98Z3Ve05d63GnfBGsuuWRXpjXZqPoBrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAD4b4WLS36JKepz31m98Z3Ve05d63GnfBGsuuWRXpjXZqPoBrA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-29 17:38:39 [+0200], Mark Marshall wrote:
> Hi Sebastian & list,
Hi,

> I had assumed that my e-mail had got lost or overlooked, I was meaning to
> post a follow up message this week...
> 
> All I could find from the debugging and tracing that we added was that
> something was going wrong with the mm data structures somewhere in the
> exec code.  In the end I just spent a week or two pouring over the diffs
> of this code between the versions that I new worked and didn't work.
> 
> I eventually found the culprit.  On the working kernel versions there is
> a patch called "mm: Protect activate_mm() by preempt_[disable&enable]_rt()".
> This is commit f0b4a9cb253a on the V4.19.82-rt30 branch, for instance.
> Although the commit message talks about ARM, it seems that we need this for
> PowerPC too (I guess, any PowerPC with the "nohash" MMU?).

Could you drop me your config, please? I need to dig here a little and I
should have seen this on qemu, right?

> Could you please add this commit back to the RT branch?  I'm not sure how
> to find out the history of this commit.  For instance, why has it been
> removed from the RT patchset?  How are these things tracked, generally?

I dropped that patch in v5.4.3-rt1. I couldn't reproduce the issue that
was documented in the patch and the code that triggered the warning was
removed / reworked in commit
    b5466f8728527 ("ARM: mm: remove IPI broadcasting on ASID rollover")

So it looked like no longer needed and then got dropped during the
rebase.
In order to get it back into the RT queue I need to understand why it is
required. What exactly is it fixing. Let me stare at for a little…

> Best regards,
> Mark

Sebastian
