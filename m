Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF0A2ED6D4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 19:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbhAGSlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 13:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbhAGSls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:41:48 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920AEC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 10:41:07 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxaDS-0086DI-JO; Thu, 07 Jan 2021 18:40:58 +0000
Date:   Thu, 7 Jan 2021 18:40:58 +0000
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
Message-ID: <20210107184058.GH3579531@ZenIV.linux.org.uk>
References: <20210107134723.GA28532@xsang-OptiPlex-9020>
 <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
 <20210107183358.GG3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107183358.GG3579531@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 06:33:58PM +0000, Al Viro wrote:
> On Thu, Jan 07, 2021 at 09:43:54AM -0800, Linus Torvalds wrote:
> 
> > Before, it would do the whole CLAC/STAC dance inside that loop for
> > every entry (and with that commit d55564cfc22 it would be a function
> > call, of course).
> > 
> > Can you verify that this fixes the regression (and in fact I'd expect
> > it to improve that test-case)?
> 
> I'm not sure it's the best approach, TBH.  How about simply
>         for (walk = head; walk; ufds += walk->len, walk = walk->next) {
> 		if (copy_to_user(ufds, walk->entries,
> 				 walk->len * sizeof(struct pollfd))
> 			goto out_fds;
>         }
> in there?  It's both simpler (obviously matches the copyin side) and
> might very well be faster...

Something like

do_sys_poll(): do the wholesale copyout

Don't bother with patching up just one field - 16 bits out of each 64.
The amount of memory traffic is not going to be greater (might be
smaller, actually) and the loop in copy_to_user() is optimized for
bulk copy.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/select.c b/fs/select.c
index ebfebdfe5c69..288633053c7f 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1011,12 +1011,9 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 	fdcount = do_poll(head, &table, end_time);
 	poll_freewait(&table);
 
-	for (walk = head; walk; walk = walk->next) {
-		struct pollfd *fds = walk->entries;
-		int j;
-
-		for (j = 0; j < walk->len; j++, ufds++)
-			if (__put_user(fds[j].revents, &ufds->revents))
+	for (walk = head; walk; ufds += walk->len, walk = walk->next) {
+		if (copy_to_user(ufds, walk->entries,
+				 walk->len * sizeof(struct pollfd)))
 				goto out_fds;
   	}
 
