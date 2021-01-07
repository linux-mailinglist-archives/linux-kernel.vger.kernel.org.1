Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4822ED6C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 19:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbhAGSfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 13:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhAGSfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:35:10 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C9C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 10:34:30 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxa6g-00867O-4L; Thu, 07 Jan 2021 18:33:58 +0000
Date:   Thu, 7 Jan 2021 18:33:58 +0000
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
Message-ID: <20210107183358.GG3579531@ZenIV.linux.org.uk>
References: <20210107134723.GA28532@xsang-OptiPlex-9020>
 <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 09:43:54AM -0800, Linus Torvalds wrote:

> Before, it would do the whole CLAC/STAC dance inside that loop for
> every entry (and with that commit d55564cfc22 it would be a function
> call, of course).
> 
> Can you verify that this fixes the regression (and in fact I'd expect
> it to improve that test-case)?

I'm not sure it's the best approach, TBH.  How about simply
        for (walk = head; walk; ufds += walk->len, walk = walk->next) {
		if (copy_to_user(ufds, walk->entries,
				 walk->len * sizeof(struct pollfd))
			goto out_fds;
        }
in there?  It's both simpler (obviously matches the copyin side) and
might very well be faster...
