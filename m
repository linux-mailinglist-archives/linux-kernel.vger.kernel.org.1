Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C31E2B1EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgKMPb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:31:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgKMPb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:31:57 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE112208D5;
        Fri, 13 Nov 2020 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605281516;
        bh=D+K4eSnXMa89LSYZ7jMaE8u+DXUbJR1/k9ED80rrD7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIa+n2qHt2lDhuEwBt0MljRqQxaq0sqOY4cMgfJ3+csbJx9x2mLT7Sc38QXTYVCl3
         WDlCXMAFV6wi6QOHdHqb9JDAMmnPQ3igo8lcfJA3OaspPbUkgu+qp3VRkw8kpWX7Sb
         +hHPtYlmIWiY7lHRbInh4m/G1boQ2bwcxWSYpj2I=
Date:   Fri, 13 Nov 2020 16:32:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4] kcov, usb: only collect coverage from
 __usb_hcd_giveback_urb in softirq
Message-ID: <X66nJSTbppPoFneS@kroah.com>
References: <f3a7a153f0719cb53ec385b16e912798bd3e4cf9.1602856358.git.andreyknvl@google.com>
 <20201113123035.tjllvijjzd54npsf@linutronix.de>
 <CAAeHK+zd0ucaj8EJ8ro+0ekubrxp5GiBMaBULHJB05dDrzpQGw@mail.gmail.com>
 <20201113132818.zhtdhzg6ukv4wgxl@linutronix.de>
 <CAAeHK+yZEQ7r1bBWbUhdys8s1CntwpOyF+Fm+H=NiuK0g3KwYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+yZEQ7r1bBWbUhdys8s1CntwpOyF+Fm+H=NiuK0g3KwYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 02:42:44PM +0100, Andrey Konovalov wrote:
> On Fri, Nov 13, 2020 at 2:28 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2020-11-13 13:51:19 [+0100], Andrey Konovalov wrote:
> > > Hi Sebastian,
> >
> > Hi Andrey,
> >
> > > Replaced with what and why?
> >
> > Linus requested in
> >         https://lkml.kernel.org/r/CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com/
> >
> > that drivers should not change their behaviour on context magic like
> > in_atomic(), in_interrupt() and so on.
> > The USB bits were posted in
> >         https://lkml.kernel.org/r/20201019100629.419020859@linutronix.de
> >
> > and merged (which is probably the same time as this patch).
> >
> > I haven't look what this code should do or does but there are HCDs for
> > which this is never true like the UHCI/OHCI controller for instance.
> 
> We could go back to adding softirq-specific kcov callbacks. Perhaps
> with a simpler implementation than what we had before to only cover
> this case. Something like kcov_remote_start_usb_softirq() and
> kcov_remote_stop_softirq() that do the softirq check internally.
> 
> Greg, what would you prefer?

I really have no idea, sorry.
