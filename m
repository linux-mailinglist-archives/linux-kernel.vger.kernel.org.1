Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54FF240F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgHJTUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 15:20:49 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:52446 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbgHJTUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:20:44 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQQm942yLz2d;
        Mon, 10 Aug 2020 21:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597087241; bh=YLrczSTpxaAEdZF2sFqyeYjJHh21BF1+BJLgLP42RYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BS3dTf9k+eUTG+Iyz20i9CmwY9+CAkUNv3QtK9AxWqyBer4s4mNCsCQ/ygaziFRTl
         uU/xgcRb+lQXj+1FEKGxfHGc4+PvM/SaSyF40+e7McxLdA/CYDOhYgVaZjztz60HXC
         V217CJ2uqIJG0M1ij7rD6kY4wVhHm1Gp0Z1brqcV9B091WmjUCu2f+XG+eCf86dR6O
         ELgwcOKcVFwFijr0OzEylckoMCj+UBZCqAw7iOkf2Sh/590c1udb2m7FJV+bXf3Mmi
         gqE4LLBEJfNRGvZ6O2irmY0mgc/kOhKKtxGadLUtXk9cqEk+dHMk0RWgWU/OQe/am1
         MFns/7F+AMSqg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 21:20:39 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: fix pointer table overallocation
Message-ID: <20200810192039.GA26750@qmqm.qmqm.pl>
References: <407fbd06a02caf038a9ba3baa51c7d6d47cd6517.1597000795.git.mirq-linux@rere.qmqm.pl>
 <5ef51b56-c533-46c8-621d-7907129594e9@gmail.com>
 <20200810123747.GC6438@sirena.org.uk>
 <20200810162556.GA3394@qmqm.qmqm.pl>
 <20200810173337.GG6438@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200810173337.GG6438@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 06:33:37PM +0100, Mark Brown wrote:
> On Mon, Aug 10, 2020 at 06:25:56PM +0200, Micha� Miros�aw wrote:
> > On Mon, Aug 10, 2020 at 01:37:47PM +0100, Mark Brown wrote:
> > > Yeah, this is more a performance improvement than a fix.
> > Should I resend without Cc: stable?
> I've already queued it to be applied to -next with that removed and an
> edited subject line.

Ok, thanks!
