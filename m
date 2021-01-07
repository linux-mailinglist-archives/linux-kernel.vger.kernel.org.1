Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2011A2ED709
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 19:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbhAGS4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 13:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGS4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:56:54 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4256C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 10:56:13 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxaRz-0086Pu-TK; Thu, 07 Jan 2021 18:55:59 +0000
Date:   Thu, 7 Jan 2021 18:55:59 +0000
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
Message-ID: <20210107185559.GI3579531@ZenIV.linux.org.uk>
References: <20210107134723.GA28532@xsang-OptiPlex-9020>
 <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
 <20210107183358.GG3579531@ZenIV.linux.org.uk>
 <20210107184058.GH3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107184058.GH3579531@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 06:40:58PM +0000, Al Viro wrote:
> do_sys_poll(): do the wholesale copyout
> 
> Don't bother with patching up just one field - 16 bits out of each 64.
> The amount of memory traffic is not going to be greater (might be
> smaller, actually) and the loop in copy_to_user() is optimized for
> bulk copy.

	BTW, considering the access pattern, I would expect it to be
considerably cheaper in a lot of cases; basically, we have a copy
of userland array of 64bit values, then we do a non-trivial amount
of work and modify 16 bits out of each 64.  Then we want that
propagated back to the original array.  I suspect that copying just
those 16bit fields out is going to cost more that a bulk copy of
the entire thing, and not just on s390 and similar oddball cases.

	Comments?
