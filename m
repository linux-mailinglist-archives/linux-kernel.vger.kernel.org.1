Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42D27B1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI1Qd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgI1Qd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:33:26 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 712F1207F7;
        Mon, 28 Sep 2020 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601310805;
        bh=gAqWnV60z9fCHss8CVsCaQXBsU3keWe8VAqss8ujHqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DG3A2KkPKu9nJD0qXfGxpqnxT0amW9GlO2emXpugknSsbLSMdoqgjCtv2HxwPX9CO
         u8mJVQOSgswJYImXKvH8cK1AdMcPhvRaaOcdPPLe/459hLwFPEBU10Z1PV/mb6n9Ew
         g8Tc7TbkM9GFUdHKV/kq+C1+Op9nHhfVKWUaYwGA=
Date:   Mon, 28 Sep 2020 09:33:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: KASAN vs RCU vs RT
Message-ID: <20200928093323.06c82fdc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CACT4Y+bK+0aeJb_2ULmouuH3+_OPOqMTtv1UOp2td73cqcZL-w@mail.gmail.com>
References: <20200925184327.7257b6bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <CACT4Y+bK+0aeJb_2ULmouuH3+_OPOqMTtv1UOp2td73cqcZL-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 08:57:32 +0200 Dmitry Vyukov wrote:
> On Sat, Sep 26, 2020 at 3:43 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Hi!
> >
> > I couldn't find this being reported in a quick search, so let me ask.
> >
> > With 5.9 I'm seeing a lot (well, once a boot) splats like the one below.
> >
> > Is there a fix?  
> 
> Hi Jakub,
> 
> FWIW this is the first time I see this BUG. I don't remember it was
> mentioned on kasan-dev before.
> 
> The commit that added this BUG was added in March 2020, so is not new...

Talking to Paul McKenney - it appears to be a known and hard to fix
issue inside RCU, KASAN is not to blame. Sorry for the noise :)
