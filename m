Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF8F1A16FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 22:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDGUsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 16:48:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgDGUsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8rULhhQv+p0WTqb/15WNhl9X+GtDbdBlJB2dPAS4ssQ=; b=G5DykvVsj9weI1ijkNnZFk14vc
        MgS9CreBR9Hj6KGryZjxmduj0xr3m6Q9C742GdlxPpiCwkNb41h7COmr+/GYM0iO1JrqutybdANm2
        ItatJujji3D5hNY32Dqjzibx2mtQI4ps1fNAMAPp0MFBtSHCRDvKolcrrY75H0yt41L04nQxU5xHb
        tWQ0nSYqAVzemq8az2pK77oKW3bnl/X1dlDV6/MCtPT7gTlVOv5gmZBbgefJLyHSOORkiQMCw64xR
        gUhdDaYz3SNfJ9FML13hAeHVf+1uD8gauVQkL7ykK0s90LTAIlcMD53OEizyF33MIpVzdm9n/P5Gy
        BrMHHvjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLv90-0002vB-6a; Tue, 07 Apr 2020 20:48:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02FCA982F1A; Tue,  7 Apr 2020 22:48:23 +0200 (CEST)
Date:   Tue, 7 Apr 2020 22:48:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 0/4] x86/module: Out-of-tree module decode and sanitize
Message-ID: <20200407204823.GS2452@worktop.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <a53a01b9-2907-4eb3-a9fd-16e6e8029028@citrix.com>
 <20200407194112.GQ2452@worktop.programming.kicks-ass.net>
 <3245cf5e-b21b-634e-a9d7-a63d55145c33@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3245cf5e-b21b-634e-a9d7-a63d55145c33@citrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:21:31PM +0100, Andrew Cooper wrote:
> > +	switch (insn->opcode.bytes[1]) {
> > +	case 0x00:
> > +		if (modrm_mod != 0x03)
> > +			break;
> > +
> 
> Apologies - missed this before.  LLDT and LTR can be encoded with a
> memory operand, so you need to drop the modrm_mod check to spot all
> instances.

I spotted the same, already fixed. Sorry for the mistake, reading opcode
tables it a pain at the best of times :/
