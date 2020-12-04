Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4102CF61F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 22:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgLDV1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 16:27:25 -0500
Received: from ms.lwn.net ([45.79.88.28]:37032 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbgLDV1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 16:27:25 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B030B735;
        Fri,  4 Dec 2020 21:26:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B030B735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1607117205; bh=6W3sqxU/NqTvoLox5sB3lYweXuF48Ay/zVMtMc+y6oc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kf23UPQm8dY086hMkt+K0XcabWW2eHHGleG5sxmoPbGeBGZMPRnewyfag9M03yNoE
         ORizSj4/o/AYp8EUBRat83eLckOtpWzQk87u910r33WFscjrhW/I9BbeZcWiuEVfeO
         /S5lpdnb0HzBVSxsY+bbWHNqxjj+KppfIb73Uo8b2DEX6y+z2h+9nPmu7LU1gDYen8
         sTpoMNDgos1G/kR8ZVcjsVMk4FuHPUREuxje1W5d1zWQvWXeqs8AoXoSI3H8lOQUrj
         kLrzgAwDrIdV0Qx8ouYcHyIReW7n67rrzcZKJwVn+D7nQ9pjZZGIGQAg2fkluN6x3S
         U6ymVA8dIlv6A==
Date:   Fri, 4 Dec 2020 14:26:43 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 1/3] LICENSES: Add the CC-BY-4.0 license
Message-ID: <20201204142643.0c27f848@lwn.net>
In-Reply-To: <X8oqTyRNKMHChbA7@kroah.com>
References: <cover.1607063223.git.linux@leemhuis.info>
        <7115b6c20ae3e6db0370fe4002dd586011205e1c.1607063223.git.linux@leemhuis.info>
        <X8oqTyRNKMHChbA7@kroah.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 13:23:43 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Dec 04, 2020 at 07:43:48AM +0100, Thorsten Leemhuis wrote:
> > Add the full text of the CC-BY-4.0 license to the kernel tree as well as
> > the required tags for reference and tooling.
> > 
> > The license text was copied directly from the following url, but for
> > clarification a 'Creative Commons' was added before 'Attribution 4.0
> > International' in the first line:
> > https://creativecommons.org/licenses/by/4.0/legalcode.txt
> > 
> > CC-BY-4.0 is GPLv2 compatible, but when for example used for the
> > kernel's documentation it can easily happen that sphinx during
> > processing combines it with text or code from files using a more
> > restrictive license[1]. This bears pitfalls, hence point that risk out
> > and suggest to only use this license in combination with the GPLv2.
> > 
> > [1] https://lkml.kernel.org/r/20201201144314.GA14256@lst.de
> > 
> > Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > CC: Christoph Hellwig <hch@lst.de>
> > ---
> >  LICENSES/dual/CC-BY-4.0 | 410 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 410 insertions(+)
> >  create mode 100644 LICENSES/dual/CC-BY-4.0  
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
Thanks for that.  Unless somebody screams, my intent is to apply these
patches in the near future.

jon
