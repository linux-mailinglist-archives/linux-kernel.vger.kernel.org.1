Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17C12CA763
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390384AbgLAPtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:49:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbgLAPtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:49:02 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B5DE20870;
        Tue,  1 Dec 2020 15:48:20 +0000 (UTC)
Date:   Tue, 1 Dec 2020 10:48:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] bootconfig: Make size and checksum fields le32
Message-ID: <20201201104818.4ea357d8@gandalf.local.home>
In-Reply-To: <160583933538.547349.272918354455492444.stgit@devnote2>
References: <160583933538.547349.272918354455492444.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 11:28:55 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hello,
> 
> This is a series of patches to make the size and the checksum fields
> in the footer le32 instead of u32.
> 
> In the thread for alignment series[1], Steve pointed that the current
> footer format didn't specify the endianness thus it is hard to apply
> the bootconfig for cross-build initrd if the target endianness is
> different from the host machine.
> 
> I've proposed that the hexadecimal ASCII string in the previous series
> [2] but Linus pointed that making it le32 was enough.
> 
> So this just make those fields le32.
> 
> Thank you,
> 
> [1] https://lore.kernel.org/lkml/20201118112249.30d20147@gandalf.local.home/
> [2] https://lore.kernel.org/linux-doc/CAHk-=wi9RedSQoGF06dVs2mp7tBp4QoiW8+XZzNcDFJr3Zo5gg@mail.gmail.com/
> 
> ---
> 

I have this all tested. Is this something that should go into the current
-rc release, or wait for the next merge window?

-- Steve
