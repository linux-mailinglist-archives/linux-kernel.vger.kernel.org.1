Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF92BB8BD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgKTWPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:15:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgKTWPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:15:01 -0500
Date:   Fri, 20 Nov 2020 23:14:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605910498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l9HO7qi/CgtyTcImgZFKn9YOTyR3bGoKJJqynYm53xY=;
        b=BP7K1aHSDoVAPGJoZox2+vmOSrpyBxTP7AJ7vWpDn3R8fTcI01MRWvRxqTtc3z/uPt3FHP
        SSYb41H147QVeBhAXBtS76isM0Gro5Od3vo4gMPxTCAyt2bBNqggBXOgPevjZyGLZiz/ur
        SQBKbSa8bWnpWFPkFpicq3Nn+ShPrbc+9M8XtZx4yKfKNYh/gIrfJm1jGoLb5elpAE9WOQ
        C1/cq8WwV73XuPVpMoouwJT/hWrxwVgFEJXlKhVWjrnWIFwTusIaxTj2FpDcHWMxu6TvFJ
        l18lxYJyToqyCaxSj6by+Qdg72veu2XmBoH7ftxPOEzc/hhTjcDqKZ5Ei5Mcgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605910498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l9HO7qi/CgtyTcImgZFKn9YOTyR3bGoKJJqynYm53xY=;
        b=NMMqvJnmHit7utGDXt0A3Sz/TiJ/PNjjdg/Oo1vEqHvCWxnw6rCiiX+d0j9nCOiWAQjcgW
        JK4wmolRgi8uWxAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] v5.10-rc3-rt7
Message-ID: <20201120221456.aaup3ga5kxjt4x6h@linutronix.de>
References: <20201112165824.s56wsbzsovunzwwg@linutronix.de>
 <20201120164944.00fbfadf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120164944.00fbfadf@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-20 16:49:44 [-0500], Steven Rostedt wrote:
> On Thu, 12 Nov 2020 17:58:24 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > Changes since v5.10-rc3-rt6:
> > 
> >   - Mike Galbraith reported a lockdep warning triggered by the nouveau
> >     driver with threaded interrupts.
> 
> Although these patches have:
> 
> Fixes: 710da3c8ea7df ("sched/core: Prevent race condition between cpuset and __sched_setscheduler()")
> 
> Which exists in 5.4, I'm guessing it's not needed for 5.4-rt as there's no
> stable-rt tag in them?

Correct. I posted both upstream and PeterZ asked if this issue could be
addressed within the nouveau driver. So I would suggest to hold on until
there is a decision how to fix it in the end.

> -- Steve

Sebastian
