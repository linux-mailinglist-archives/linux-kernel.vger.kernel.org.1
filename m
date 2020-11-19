Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19B52B9EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgKSX6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:58:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbgKSX6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:58:11 -0500
Received: from devnote2 (unknown [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA762222D;
        Thu, 19 Nov 2020 23:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605830290;
        bh=bJWR+Naet2mx9h3HZuwqD8kLmSrizdb8YfFZnV3X+eo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DdG2OB3XK4ATuldQr9IY1x//t30slxFx20b2rsKveKL6Z8YbGpRusyP/bmrdFQsos
         319FmvoRGUtTuaZsTo2+zAuBxRPwtiB6/HqomTZ1Gl1ej0PXlNFslJxE1DpBkXePJc
         eHyiBcjppY3Yve9LRQdar2w3RRlYqt9T31zxP5oM=
Date:   Fri, 20 Nov 2020 08:58:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] bootconfig: Use hexadecimal ASCII string for
 size and checksum
Message-Id: <20201120085805.dd581c5fa9dc52f699bcbcc6@kernel.org>
In-Reply-To: <20201119124234.6827fd41@gandalf.local.home>
References: <160579629161.503380.9118263439060046721.stgit@devnote2>
        <CAHk-=wi9RedSQoGF06dVs2mp7tBp4QoiW8+XZzNcDFJr3Zo5gg@mail.gmail.com>
        <20201119124234.6827fd41@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 12:42:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 19 Nov 2020 09:36:47 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Thu, Nov 19, 2020 at 6:31 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > Here is a seires of patches to change the bootconfig footer format
> > > to use 8-bytes hexadecimal ASCII string for size and checksum instead
> > > of u32.  
> > 
> > Ugh.,
> > 
> > Just make it little-endian only.
> > 
> > The _worst_ thing to do is to make it some kind of "native-endian",
> > because then you have to deal with cross building issues etc.
> > 
> > But using a __le32 type and just doing "le32_to_cpu()" is trivial and
> > optimal - not just because everybody relevant is LE anyway, but simply
> > because even if you _aren't_ LE, an unconditional byte swap is better
> > than a conditional native access.
> 
> And since this isn't used in any fast paths, the byte swapping in the
> kernel should be a non-issue.

Thanks for the comment!
OK, let me renew the series to use le32.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
