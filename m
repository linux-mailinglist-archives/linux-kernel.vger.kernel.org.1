Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A8B27346B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgIUU4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:56:55 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46302 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgIUU4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:56:54 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 16:56:53 EDT
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72A582D7;
        Mon, 21 Sep 2020 22:56:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1600721812;
        bh=0ufRJd15vYVOMYf2643FoPvs/mz3t46PJ2prwsZl1DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oW++ioxIzAreehCCQJKUn1cD6I/Wv7SUWXEKp9GkaAE93ShinuiFXxahNlgoMkZQl
         EyVlBKtm0n8roED3mSuWgg7CPf5vCRvZqhcYKPZttF2Gc04hqHEY5ndprAVE36Ptg0
         HTkcHM8aCQJz9Ql3+rBnV2irFdp6LSKsnfzcyPWg=
Date:   Mon, 21 Sep 2020 23:56:20 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [GIT RFC PULL rcu/urgent] Fix rcu-tasks compilation warning
Message-ID: <20200921205620.GD18343@pendragon.ideasonboard.com>
References: <20200921193703.GA20208@paulmck-ThinkPad-P72>
 <CAHk-=wh52SXRqz9CndHZqjuA1GO7MDdNusQ7CgDOpLkD8ocZaA@mail.gmail.com>
 <20200921203534.GJ29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921203534.GJ29330@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 01:35:34PM -0700, Paul E. McKenney wrote:
> On Mon, Sep 21, 2020 at 12:46:22PM -0700, Linus Torvalds wrote:
> > On Mon, Sep 21, 2020 at 12:37 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > This bug was reported by Laurent Pinchart (CCed),
> > > who would like it fixed sooner rather than later.
> > 
> > I'm assuming that sentence and me being cc'd means that you'd prefer
> > to get this merged directly rather than go through the usual -tip
> > shenanigans.
> 
> I was good either way, but I have reason to believe that Laurent deeply
> appreciates the direct merge.  ;-)

It fixed a compilation breakage introduced in v5.9 for one of my boards,
so yes :-) Thank you.

> > I've pulled it.
> 
> Thank you!

-- 
Regards,

Laurent Pinchart
