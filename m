Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB8F2C4527
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbgKYQ1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:27:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730560AbgKYQ1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:27:33 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B54312083E;
        Wed, 25 Nov 2020 16:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606321652;
        bh=4guIsYJBgPRIiLG0nUPKOsb5v+5v6jxyqDmQ3XzlsVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qJWrozM0HOM7o+cMlJ+yVBzByAtoJL+roDOJZnRLqh8HcLMP5YELlNr/2nN0o3uhw
         N77RY+w8wAA7RBLJqJ+smz+9TP/WhQQJcYebo/MhJnINKyTV67VieRQdSj/Rtp+g8V
         HLEWfJvzXE+Hghem18pj3DE9CE3o3rh75blxEytU=
Date:   Thu, 26 Nov 2020 01:27:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/insn: Fix vector instructions decoding on big
 endian
Message-Id: <20201126012726.38f23d18069ec54792fc6276@kernel.org>
In-Reply-To: <your-ad-here.call-01606224790-ext-4442@work.hours>
References: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
        <patch.git-a153abbe9170.your-ad-here.call-01605283379-ext-7358@work.hours>
        <20201113173052.vdy72pytmv6ztnbj@treble>
        <your-ad-here.call-01606224790-ext-4442@work.hours>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 14:33:10 +0100
Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Fri, Nov 13, 2020 at 11:30:52AM -0600, Josh Poimboeuf wrote:
> > On Fri, Nov 13, 2020 at 05:09:54PM +0100, Vasily Gorbik wrote:
> > > Running instruction decoder posttest on s390 with allyesconfig shows
> > > errors. Instructions used in couple of kernel objects could not be
> > > correctly decoded on big endian system.
> > > 
> > > insn_decoder_test: warning: objdump says 6 bytes, but insn_get_length() says 5
> > > insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
> > > insn_decoder_test: warning: ffffffff831eb4e1:    62 d1 fd 48 7f 04 24    vmovdqa64 %zmm0,(%r12)
> > > insn_decoder_test: warning: objdump says 7 bytes, but insn_get_length() says 6
> > > insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
> > > insn_decoder_test: warning: ffffffff831eb4e8:    62 51 fd 48 7f 44 24 01         vmovdqa64 %zmm8,0x40(%r12)
> > > insn_decoder_test: warning: objdump says 8 bytes, but insn_get_length() says 6
> > > 
> > > This is because in few places instruction field bytes are set directly
> > > with further usage of "value". To address that introduce and use
> > > insn_set_byte() helper, which correctly updates "value" on big endian
> > > systems.
> > > 
> > > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> > > ---
> > >  Please let me know if this patch is good as it is or I should squash it
> > >  into the patch 2 of my patch series and resend it again.
> > 
> > It all looks good to me, thanks!
> > 
> > Masami, does this patch look good, and also patches 1-2 of the series?
> > (I think you previously ACKed patch 2).
> > 
> 
> Friendly ping...

Sorry for replying late.
Yes, I think this series and the last patch look good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

for this series.

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
