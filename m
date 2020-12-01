Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C9F2CA385
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgLANOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:14:47 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:53437 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728349AbgLANOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:14:46 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8C1F4466;
        Tue,  1 Dec 2020 08:13:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 01 Dec 2020 08:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=5
        wevszoWbraFHBZPlr9a9uI0gzKRk5nxLinjk7RXHx4=; b=F2J0aIU7XVYAwiTzG
        GP5lE7bmcRVrsDTJFm9QJzuLpStllydLzycotPMocXjO6fLnuR0STLT52meZAoe9
        S71So2GS4vPppVfjRrWPWn2U9ypUWyF69qYkMwX+CLkXKEGAvvp1J7AB7LehDgMx
        oEJv1P/bTFjLmdNK6kGuuant4PqKostrDe7ZgosOnSx/HFfd9MQsiCvUcayvZS7b
        GBcDF0SMF4Ojv8mz64PJ4+aleM0LYwDl+tI7PlqJ3vbhGO5SGHvynsN4ayY3M+Bf
        twczPstzT53MozpidFvLfkGOMz+Dx+RuwFzKrQW9d2Kl9Tq/bWh1YqbVoMK8WA8Y
        56AKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=5wevszoWbraFHBZPlr9a9uI0gzKRk5nxLinjk7RXH
        x4=; b=j9Z/gH7afMxzhh0sAmF7HUw1GI+M8YznzxJ7sn19aCNlGH16pZPwRVhVN
        dJbXfv9wf+I23YdcZBm+QcafwpFm4ZgBrSbAuyDqoXn5+kHSh8xApbPAFmLzpQnD
        9V597u27q/xT46KO6dRiMiaIMaZFnYiLVQMrOeWgV9ywZ2UPZU2Dy5+xYCWluyfF
        Cmw8uP46OT0dgnqIe21BVaiOZm+wr9DOY9IoW0CLQ+K+t3JsHdAETczVbpNY53Bk
        EhYWn7O7uPqJIgau0qfF2HMLCoEud4N9iCvbz/8SDbCmXzLIMj3IFZhojx8gkEOy
        y7VDOWpV4STNGn/D7xqxb56YcWEiA==
X-ME-Sender: <xms:g0HGX2xGgpp-wAX_WyGdz8mzNzdAKtz-0q8TarSSvHdYcBHC3aHQ-w>
    <xme:g0HGXyQgQ7DHvBN2Chy_JzJGGK_bofOhnMZnwBJZdVSRHrgMoigHzQvoyFokCFmlx
    yI1wiZy8YZtBOFqak0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepieefuddtueegudehleetfeefieefhfdvudejgeekieetudefheetffev
    vdduudetnecuffhomhgrihhnpehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgnecukf
    hppeduvdekrddutdejrddvgedurddukedtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:g0HGX4VfBSxR7YZrGuMO12ItNqNa-n-4421mZ8hoIAmlpKotd5CyAA>
    <xmx:g0HGX8iVmjs-mlcmvSqduIjlmjWX-YzBjccnbnpB4-npGB6lWd0BdA>
    <xmx:g0HGX4A6BwRnTs0aXsfvFHfN9jjlyL7ZP1Xl5B8C2pDjH1yaNv-e3g>
    <xmx:hEHGX7PyOiUMvWS1FV_eT23MSVVj32Flz68CQN5NuuHHvIA2aw_h7w>
Received: from cisco (unknown [128.107.241.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B51F1080057;
        Tue,  1 Dec 2020 08:13:37 -0500 (EST)
Date:   Tue, 1 Dec 2020 08:13:34 -0500
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Alban Crequy <alban@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: SECCOMP_IOCTL_NOTIF_ADDFD race condition
Message-ID: <20201201131334.GC103125@cisco>
References: <CADZs7q4sw71iNHmV8EOOXhUKJMORPzF7thraxZYddTZsxta-KQ@mail.gmail.com>
 <20201130232009.GC38675@cisco>
 <20201201124105.GB103125@cisco>
 <20201201130824.GA27822@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201130824.GA27822@ircssh-2.c.rugged-nimbus-611.internal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:08:25PM +0000, Sargun Dhillon wrote:
> On Tue, Dec 01, 2020 at 07:41:05AM -0500, Tycho Andersen wrote:
> > On Mon, Nov 30, 2020 at 06:20:09PM -0500, Tycho Andersen wrote:
> > > Idea 1 sounds best to me, but maybe that's because it's the way I
> > > originally did the fd support that never landed :)
> > > 
> > > But here's an Idea 4: we add a way to remotely close an fd (I don't
> > > see that the current infra can do this, but perhaps I didn't look hard
> > > enough), and then when you get ENOENT you have to close the fd. Of
> > > course, this can't be via seccomp, so maybe it's even more racy.
> > 
> > Or better yet: what if the kernel closed everything it had added via
> > ADDFD if it didn't get a valid response from the supervisor? Then
> > everyone gets this bug fixed for free.
> > 
> > Tycho
> > _______________________________________________
> > Containers mailing list
> > Containers@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/containers
> 
> This doesn't solve the problem universally because of the (Go) preemption 
> problem. Unless we can guarantee that the supervisor can always handle the 
> request in fewer than 10ms, or if it implements resumption behaviour. I know 
> that resumption behaviour is a requirement no matter what, but the easier we can 
> make it to implement resumption, the better chance we are giving users to get 
> this right.

Doesn't automatic cleanup of fds make things easier? I'm not sure I
understand the argument.

I agree it doesn't fix the problem of uncooperative userspace.

Tycho
