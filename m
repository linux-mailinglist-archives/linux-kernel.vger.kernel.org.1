Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6103C29D7B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbgJ1W0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733054AbgJ1W0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:26:14 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9546C0613CF;
        Wed, 28 Oct 2020 15:26:13 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id c25so254751ooe.13;
        Wed, 28 Oct 2020 15:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FK45UsEFUJMqjnQFfEw2JOOplxSwJOaVgJWuuCrbxGQ=;
        b=E91sXcD3l4E8upi2Jm/K8WbyFI3KhHE0/7BKcniyKEi8wGansk/FBJQXKyeuliJWJ9
         79j4Yb2qaVaSSg4ylBSTEATL8LBRnAe8mpyKw62A3aYfuz9PHYeqFGG5hMxzuLF3VFmg
         PacdQ8OzYXhFS5kXmSXCFwpFHteXnuCLXKad50LzlZRf+JhaZFs+amM6xZxb/dRFAWDq
         9F2dh/o8LoqJaWAV/jFO/yPlZGwU6aFiUmE1bdzMLWC5MA5i8t0roAOdJfg3eeaya5y2
         QHOCpB6K2J1MVmvDhivLgPod3NEk2BgYke05yKIHLEdw9/1CUGj5g0lJ3z+d6kYUBgRF
         lc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FK45UsEFUJMqjnQFfEw2JOOplxSwJOaVgJWuuCrbxGQ=;
        b=iEfhjs47mnYBwG9QuxsnrNdEGpdp104L0J0FNt5b/OJSOMZxBbcXuBsNmEDcUHEi0B
         9AlVXulnFnBMAeqqxgq+FjjM7gPeYVw+TOf0MNzrgsxPwtZ/9PPmuThceW2kXAOrsMSV
         sp+dvVGQ+wF0sKQM9GbmTYhSCu3nWqOdYI7/ruU99GgrYuE7+2Oj2x1m1Q7EHQougtB5
         PJCjGMH1D92Ji/rO+YOrGDrkh7r9LigJuaztSAZCXxqFL3NDAV+hWQOdYMnKf0Gv3kKn
         z3cWFr3YlqoTK9Wjouug4bOYl5B0Q9LT1MZaqXMXekXdAogeCh6hdUgf99dO6IPOzVh4
         5BdA==
X-Gm-Message-State: AOAM531odZKYmLitr0y2bToIT0LMwNPdFmrWGHZN4vmVbYzOrXKmauTB
        gqI1ZOBKXr6XKtg4wsBriKMWRiPwGb9PBefWU7vTNGui7tM=
X-Google-Smtp-Source: ABdhPJzAWDKe7Om5QMAw8dmU/sek2nFcNeyNm7ZIqqXouZ54rMExbLH9ZQklwYJv4CtxUIyds2QUuSAPYJRVigCVm8w=
X-Received: by 2002:a4a:a2ca:: with SMTP id r10mr4041487ool.90.1603851893453;
 Tue, 27 Oct 2020 19:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <1597873980-204052-1-git-send-email-raphael.norwitz@nutanix.com> <d81c567970db5aefcc59d6f967c82f17@kernel.org>
In-Reply-To: <d81c567970db5aefcc59d6f967c82f17@kernel.org>
From:   Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date:   Tue, 27 Oct 2020 22:24:42 -0400
Message-ID: <CAFubqFtywPbUtQ+T8widqoeaZyzRU6sJMiksKUQ0umQ7PTL5Kg@mail.gmail.com>
Subject: Re: [PATCH] Fix typo in irq_domain documentation
To:     Marc Zyngier <maz@kernel.org>
Cc:     Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping - looks like this was never applied?

On Tue, Aug 25, 2020 at 6:23 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-08-19 22:53, Raphael Norwitz wrote:
> > The irq_domain documentation states that "Here the interrupt number
> > loose all kind of correspondence to hardware interrupt numbers:...".
> > It's clear from the context that the author means to use "loses"
> > instead
> > of "loose". To avoid future confusion, this change fixes the
> > aforementioned wording.
> >
> > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > ---
> >  Documentation/core-api/irq/irq-domain.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/core-api/irq/irq-domain.rst
> > b/Documentation/core-api/irq/irq-domain.rst
> > index 096db12..eba5e41 100644
> > --- a/Documentation/core-api/irq/irq-domain.rst
> > +++ b/Documentation/core-api/irq/irq-domain.rst
> > @@ -15,7 +15,7 @@ such as GPIO controllers avoid reimplementing
> > identical callback
> >  mechanisms as the IRQ core system by modelling their interrupt
> >  handlers as irqchips, i.e. in effect cascading interrupt controllers.
> >
> > -Here the interrupt number loose all kind of correspondence to
> > +Here the interrupt number loses all kind of correspondence to
> >  hardware interrupt numbers: whereas in the past, IRQ numbers could
> >  be chosen so they matched the hardware IRQ line into the root
> >  interrupt controller (i.e. the component actually fireing the
>
> Acked-by: Marc Zyngier <maz@kernel.org>
>
>          M.
> --
> Jazz is not dead. It just smells funny...
