Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2492F8969
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbhAOXch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:32:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbhAOXch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:32:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7C9B239ED;
        Fri, 15 Jan 2021 23:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610753516;
        bh=/4FDLVLCDDwhVe0VLRVT2f/4U/mN3Mm3RhnvczWdt88=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hMGnU2jeSBR2vnqdtNX5GaxKbzyNS7l25VjsmMmJ14vAYeR1eQ3HX8oKtfxZIfbEX
         tbv8ZFyxnfTw9q3fUI2i4ZCsJx8USZ68BSIUyQCK7FfrLgLhAhqE25N/258VPtdGmM
         Hb8dzHyqQ68h+gBEMHyaDAKQtCosdNkYhJIUWMsHhLTZ/xEsPfJ+fcCsagx56n4bFr
         U5AYLK8/M4Pz5EDGrNa+C2W/ajALrOJb1sgb7OqlCGRH5lQB6ojH6kAV2IJicpktaj
         aFLR/zu/3cL39QLndYUHQc4nHe+CeoCyldBRSBKljI0RuHda+GR/5OPGZpbWZ60uqr
         F+rv6RQBoy98w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 741BE352162B; Fri, 15 Jan 2021 15:31:56 -0800 (PST)
Date:   Fri, 15 Jan 2021 15:31:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcsan: Add missing license and copyright headers
Message-ID: <20210115233156.GO2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210115170953.3035153-1-elver@google.com>
 <20210115215817.GN2743@paulmck-ThinkPad-P72>
 <CANpmjNM9++GSuSHH+Lyfi23kW8v0aXLX+YbD20UX8k5jAAaSnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM9++GSuSHH+Lyfi23kW8v0aXLX+YbD20UX8k5jAAaSnA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 12:21:53AM +0100, Marco Elver wrote:
> On Fri, 15 Jan 2021 at 22:58, Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > This one seemed straightforward and I heard no objections to the previous
> > two-patch series, so I queued them for the v5.13 merge window, thank you!
> >
> > If any of them need adjustment, please send me the updated patch and
> > tell me which one it replaces.  Something about -rcu being in heavy
> > experimental mode at the moment.  ;-)
> 
> Thank you!
> 
> I would have given the go-ahead for the other series next week Monday,
> but I think that's a holiday anyway. :-)

It is indeed!  I guess you had Wednesday last week, with next up being
Friday April 2?  ;-)

							Thanx, Paul
