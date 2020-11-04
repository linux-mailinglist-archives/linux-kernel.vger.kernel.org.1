Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD962A5FDE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgKDIvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:51:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbgKDIvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:51:32 -0500
Received: from kernel.org (unknown [87.71.17.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C807207BB;
        Wed,  4 Nov 2020 08:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604479891;
        bh=gEXGeskxV4ls2Pw/EhAXNKpqcy+u23TmpPhn5CkeAuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWzIPcN+v1y8kMjXQtVyIqbsk60GiuOmMibv2svBV34kSD2Ps8DF2j7OfRUqvYy8l
         SsXO8DL+NxA+rQfRHVnfHBKRRUien5lLEhWghVgDk99op09beWHSGwVRg7gRIAVS+i
         dIJW1OCBs4iMRKg8htT/4Vomz/22GNj+K3aonhnU=
Date:   Wed, 4 Nov 2020 10:51:25 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-xtensa@linux-xtensa.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM, xtensa: highmem: avoid clobbering non-page aligned
 memory reservations
Message-ID: <20201104085125.GN4879@kernel.org>
References: <20201031094345.6984-1-rppt@kernel.org>
 <20201031103312.GI1551@shell.armlinux.org.uk>
 <CAMj1kXGPtXsq+26OTr49NXk5uZVt82++-8Ug_E-DYYYJ6WEbWw@mail.gmail.com>
 <20201031110350.GJ1551@shell.armlinux.org.uk>
 <CAMj1kXED+Ry7FEtZm-5tL5ZD2c4+nbYtCWrzQmd158+jXHNqPQ@mail.gmail.com>
 <20201031154528.GA14628@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031154528.GA14628@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Sat, Oct 31, 2020 at 05:45:35PM +0200, Mike Rapoport wrote:
> On Sat, Oct 31, 2020 at 12:21:24PM +0100, Ard Biesheuvel wrote:
> > On Sat, 31 Oct 2020 at 12:04, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > Clearly, I wasn't blunt and stroppy enough to be properly understood.
> > > Sort it out between yourselves and tell me which patch you want me to
> > > apply.
> > >
> > 
> > I would like you to ack this version of the patch, and disregard the
> > one in the patch system, so that Mike can take this one through the
> > memblock tree where the issue originated in the first place.
 
Can I please have your ack and move forward with pushing this via
memblock tree?

-- 
Sincerely yours,
Mike.
