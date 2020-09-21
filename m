Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C17927339A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgIUUff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgIUUff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:35:35 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A739A218AC;
        Mon, 21 Sep 2020 20:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600720534;
        bh=5T3c6AwdaMwQUhAWpYtqPJtIQhrVT9q27xIICwtGiAU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vA8T+5Ful/99xlfyOkGQ7YtnWKtjVfFLeypo03q/j4NM1Eccay1hYgzsQoCkC1eRC
         /0bFJuK5QidCm7C7HR2cmrryHCw3wbr9V99/FuWUdZwADmFL8hIKZyL7oTGM1cIFQ3
         7tLtZH3szQVJJD8gEJmRdQK8cpfZQki1a9nU6W3k=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5E80535226C1; Mon, 21 Sep 2020 13:35:34 -0700 (PDT)
Date:   Mon, 21 Sep 2020 13:35:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [GIT RFC PULL rcu/urgent] Fix rcu-tasks compilation warning
Message-ID: <20200921203534.GJ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921193703.GA20208@paulmck-ThinkPad-P72>
 <CAHk-=wh52SXRqz9CndHZqjuA1GO7MDdNusQ7CgDOpLkD8ocZaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh52SXRqz9CndHZqjuA1GO7MDdNusQ7CgDOpLkD8ocZaA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 12:46:22PM -0700, Linus Torvalds wrote:
> On Mon, Sep 21, 2020 at 12:37 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > This bug was reported by Laurent Pinchart (CCed),
> > who would like it fixed sooner rather than later.
> 
> I'm assuming that sentence and me being cc'd means that you'd prefer
> to get this merged directly rather than go through the usual -tip
> shenanigans.

I was good either way, but I have reason to believe that Laurent deeply
appreciates the direct merge.  ;-)

> I've pulled it.

Thank you!

							Thanx, Paul
