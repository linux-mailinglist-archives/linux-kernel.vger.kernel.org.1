Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684DE24635A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 11:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgHQJ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 05:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgHQJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:28:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8D3C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:28:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r15so4325153wrp.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OZHrD7AsFMu/AjqlVhFN/H/E4vrlCUlBMfXDwCoSB1k=;
        b=tJOL8qVLXsnrVmao1/kfme1r1s7BPYaV2Llpy3btp+lbz8qf5SWwLY5FodS6ODMtOW
         lVkHcC5DFKnzxul97uhq07cmV32gKgVgLGe5efRdIuzMfsKJCbiJ542ZhCntsrg21KzS
         t1ndiyxJS6jZJ/TV+ku/KAytl6EdLfNsxDQdXxDgElKPnmUAlJmocohxcNLU9TvPSEPP
         /Oq1JbCvmGQl18dGytAegkp0UtlnvowDlyvTIv9gE3y63MwVukK/vIuNbLVDJV3hgDzx
         lSKYXbahutZnfvYHKPeSzo98hwcrwtpOXcT79g7EdmVCSjjQwlTwwhnuJXkz9eItb9E3
         1XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OZHrD7AsFMu/AjqlVhFN/H/E4vrlCUlBMfXDwCoSB1k=;
        b=XC9AT+RVAttqQSAjAcdInvC3Vim8REiO9tLywrl02XUyWVta5+UgXqYNBtktjU+VCk
         jLIB+CUH8Z5oNQ2lKQ1LZaah4YM2D67oyiAQsS29vx13hWEG5lCREy4tQo34JUCaMXKH
         KSjgLFRko/WKzIaw7VfjLH23lGPrsdP/oskyiB6uDUt6/h0p/JNBMzUOtwInMtrZ4kP7
         pzlt3QtFtddHKjdU79JZmTw4+SS2FnYyAp0g9pPAGO/kSqTdwNelCagNE3rxyRmeWQsY
         UBIx2OSLK+FUMAL+gwPXrru2EGt5H02qiQAcM38i1cePQtqUx0TGDjCaMKytH622G0hE
         TO1A==
X-Gm-Message-State: AOAM532nKDNQhE2Hp/ny4x2f7rkroCKVEPFxJZwG4nw3hWQLWK1OP41y
        PIGsHl1jXGzQoz6TfDbLl8x6yA==
X-Google-Smtp-Source: ABdhPJyXOFbcuO2y4SsfG64eFw4++PxepXSqaoKyOWHlAufgH8Jeb2VmgQakN+PqFUlSIBjcNZABxg==
X-Received: by 2002:a5d:414e:: with SMTP id c14mr15581729wrq.57.1597656512419;
        Mon, 17 Aug 2020 02:28:32 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a10sm29800393wro.35.2020.08.17.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:28:31 -0700 (PDT)
Date:   Mon, 17 Aug 2020 10:28:30 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
Message-ID: <20200817092830.xcl2gkyxoe5grgnz@holly.lan>
References: <20200811145816.GA424033@kroah.com>
 <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
 <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com>
 <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com>
 <CAD=FV=V8UhQVQvcAp6XCmT3=6FYM=_zPELy4FTj4kMKUswaR8Q@mail.gmail.com>
 <CAFA6WYPxieH6ZTa_BFdaLuiwbqAs6r7eKmxG7ci4XtyRONGN7g@mail.gmail.com>
 <20200813101703.566thqmnc2d7cb3n@holly.lan>
 <CAFA6WYPd-fcDkYNk1KrjYwD=FH3FBvjDGEoxCBBN9CRidoVXbw@mail.gmail.com>
 <20200814141822.opahh33nfc5yodkb@holly.lan>
 <CAFA6WYO3YmgCftr-hFdiHGHATeox9en_HZvgnAL=zhoa=OEi_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYO3YmgCftr-hFdiHGHATeox9en_HZvgnAL=zhoa=OEi_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 10:42:43AM +0530, Sumit Garg wrote:
> On Fri, 14 Aug 2020 at 19:48, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Fri, Aug 14, 2020 at 05:36:36PM +0530, Sumit Garg wrote:
> > > On Thu, 13 Aug 2020 at 15:47, Daniel Thompson
> > > <daniel.thompson@linaro.org> wrote:
> > > >
> > > > On Thu, Aug 13, 2020 at 02:55:12PM +0530, Sumit Garg wrote:
> > > > > On Thu, 13 Aug 2020 at 05:38, Doug Anderson <dianders@chromium.org> wrote:
> > > > > > On Wed, Aug 12, 2020 at 8:27 AM Doug Anderson <dianders@chromium.org> wrote:
> > > > > > > One
> > > > > > > last worry is that I assume that most people testing (and even
> > > > > > > automated testing labs) will either always enable NMI or won't enable
> > > > > > > NMI.  That means that everyone will be only testing one codepath or
> > > > > > > the other and (given the complexity) the non-tested codepath will
> > > > > > > break.
> > > > > > >
> > > > >
> > > > > The current patch-set only makes this NMI to work when debugger (kgdb)
> > > > > is enabled which I think is mostly suitable for development
> > > > > environments. So most people testing will involve existing IRQ mode
> > > > > only.
> > > > >
> > > > > However, it's very much possible to make NMI mode as default for a
> > > > > particular serial driver if the underlying irqchip supports it but it
> > > > > depends if we really see any production level usage of NMI debug
> > > > > feature.
> > > >
> > > > The effect of this patch is not to make kgdb work from NMI it is to make
> > > > (some) SysRqs work from NMI. I think that only allowing it to deploy for
> > > > kgdb users is a mistake.
> > > >
> > > > Having it deploy automatically for kgdb users might be OK but it seems
> > > > sensible to make this feature available for other users too.
> > >
> > > I think I wasn't clear enough in my prior reply. Actually I meant to
> > > say that this patch-set enables NMI support for a particular serial
> > > driver via ".poll_init()" interface and the only current user of that
> > > interface is kgdb.
> > >
> > > So if there are other users interested in this feature, they can use
> > > ".poll_init()" interface as well to enable it.
> >
> > Huh?
> >
> > We appear to speaking interchangably about users (people who sit in
> > front of the machine and want a stack trace) and sub-systems ;-).
> >
> > I don't think other SysRq commands have quite such a direct relationship
> > between the sub-system and the sysrq command. For example who are you
> > expecting to call .poll_init() if a user wants to use the SysRq to
> > provoke a stack trace?
> >
> 
> Ah, I see. So you meant to provide a user-space interface to
> dynamically enable/disable NMI debug, correct? It will require IRQ <->
> NMI switching at runtime which should be doable safely.

I haven't given much thought to the exact mechanism, though I would
perhaps have started by thinking about a module parameter).

From an RFC point of view, I simple think this feature is potentially
useful on systems without kgdb (which, let's be honest, are firmly in
the majority) so making .poll_init() the only way to activate it is a
mistake.


Daniel.
