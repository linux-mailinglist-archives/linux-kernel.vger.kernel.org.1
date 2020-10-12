Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB7928B398
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgJLLSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:18:12 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:6908 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387681AbgJLLSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:18:11 -0400
X-IronPort-AV: E=Sophos;i="5.77,366,1596492000"; 
   d="scan'208";a="472125793"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:18:00 +0200
Date:   Mon, 12 Oct 2020 13:18:00 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Vincent Guittot <vincent.guittot@linaro.org>
cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gilles Muller <Gilles.Muller@inria.fr>
Subject: Re: SD_LOAD_BALANCE
In-Reply-To: <CAKfTPtDqKqoLg9OOYMy5bVVnQKGNb3Z9hL6tWaxqKzv2+NdFXw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2010121317470.2901@hadrien>
References: <alpine.DEB.2.22.394.2009031605190.2496@hadrien> <jhj7dtaokxe.mognet@arm.com> <alpine.DEB.2.22.394.2010101740290.2691@hadrien> <CAKfTPtCPapkwS7B5X3XQsQFx7GXa-RSzRWO1e6n5JzLT7nTvrA@mail.gmail.com> <alpine.DEB.2.22.394.2010121232410.2901@hadrien>
 <CAKfTPtDqKqoLg9OOYMy5bVVnQKGNb3Z9hL6tWaxqKzv2+NdFXw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Oct 2020, Vincent Guittot wrote:

> On Mon, 12 Oct 2020 at 12:34, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > > > Would it be useful to always check whether prev is idle, perhaps in
> > > > wake_affine_idle or perhaps in select_idle_sibling?
> > >
> > > Yes, that would make sense to add a condition in  wake_affine_idle to
> > > return prev if this cpu is not idle (or about to become idle)
> >
> > The case where this cpu is idle would be in the interrupt case.  If both
> > prev cpu and this cpu are idle, is it more desirable to move the thread to
> > this cpu or to leave it where it was?
>
> I think that we should keep the current behavior regarding this cpu
> and the shared cache case and add one more test before the last return
> of the function.
>
> right now, we select this_cpu:
> -if this cpu is idle,  it shares cache with prev and previous is not idle.
> -if it's a sync wake up because we expect the task to use local data
> of the current running task on this cpu.
>
> Then we add a new case to return prev cpu if it is idle which is your case

OK, sounds good, thanks.

julia
