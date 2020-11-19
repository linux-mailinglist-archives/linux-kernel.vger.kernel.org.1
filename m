Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6BB2B99DB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgKSRmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729542AbgKSRmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:42:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30BCC246A7;
        Thu, 19 Nov 2020 17:42:36 +0000 (UTC)
Date:   Thu, 19 Nov 2020 12:42:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] bootconfig: Use hexadecimal ASCII string for
 size and checksum
Message-ID: <20201119124234.6827fd41@gandalf.local.home>
In-Reply-To: <CAHk-=wi9RedSQoGF06dVs2mp7tBp4QoiW8+XZzNcDFJr3Zo5gg@mail.gmail.com>
References: <160579629161.503380.9118263439060046721.stgit@devnote2>
        <CAHk-=wi9RedSQoGF06dVs2mp7tBp4QoiW8+XZzNcDFJr3Zo5gg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 09:36:47 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Nov 19, 2020 at 6:31 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Here is a seires of patches to change the bootconfig footer format
> > to use 8-bytes hexadecimal ASCII string for size and checksum instead
> > of u32.  
> 
> Ugh.,
> 
> Just make it little-endian only.
> 
> The _worst_ thing to do is to make it some kind of "native-endian",
> because then you have to deal with cross building issues etc.
> 
> But using a __le32 type and just doing "le32_to_cpu()" is trivial and
> optimal - not just because everybody relevant is LE anyway, but simply
> because even if you _aren't_ LE, an unconditional byte swap is better
> than a conditional native access.

And since this isn't used in any fast paths, the byte swapping in the
kernel should be a non-issue.

-- Steve
