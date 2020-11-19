Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C682B9405
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgKSN7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:59:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgKSN7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:59:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A39B246D3;
        Thu, 19 Nov 2020 13:59:04 +0000 (UTC)
Date:   Thu, 19 Nov 2020 08:59:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 2/4] tools/bootconfig: Fix to check the write failure
 correctly
Message-ID: <20201119085902.05df502b@gandalf.local.home>
In-Reply-To: <20201119104109.8ab69359ce81d74c7d2d9c3f@kernel.org>
References: <160571371674.277955.11736890010190945946.stgit@devnote2>
        <160571373504.277955.1260524414275036851.stgit@devnote2>
        <20201118110437.36e84496@gandalf.local.home>
        <20201119104109.8ab69359ce81d74c7d2d9c3f@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 10:41:09 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > If the first write fails (doesn't modify the initrd), and then this fails,
> > you will show a message of: "may be corrupted. Recommend to rebuild", when
> > that would not be the case. Should a test of the size be done again, to see
> > if it is already the same?  
> 
> Please see the above 2 write error check. You can find
> 
> if (ret < 0)
> 	goto out;
> 
> only in the first check. (I know, it might a bit misleadable)
> So, the first write is failed with error message, it doesn't call rollback.

Ah right, I missed check within the error check. I was only looking at the
first error and the goto at the end.

-- Steve
