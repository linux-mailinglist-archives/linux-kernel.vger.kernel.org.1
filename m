Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0827D2C39E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgKYHQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:16:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgKYHQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:16:54 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61925208B8;
        Wed, 25 Nov 2020 07:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606288606;
        bh=gUkyGSpZPzozZHqhwoqFTigIg2G04BKThv9/K6m/Mhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WofC9uB4axUAU+F4T3jQi1jeNLbCInez1DEgfDag10sFVJl5/HEtUwZZQInKZbobo
         eAoOmQyS5UPL+Mz2kwXqMKuOth+Km5W481wazbrcMChouMXxww/lhO5kgSPEGLxa6U
         zGFvfebJ34BivXSwv1sMuXVr7+84G3U/6IIHBqYE=
Date:   Wed, 25 Nov 2020 08:17:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH RESEND] checkpatch: Do not check git commit description
 style when backport the upstream commit
Message-ID: <X74FIJqhOgRrEGYv@kroah.com>
References: <1606275347-19297-1-git-send-email-yangtiezhu@loongson.cn>
 <dddb87a6ffb94b6b8046eb2eca1480a7ca37f962.camel@perches.com>
 <995e0acb-c219-ea00-f078-7582516e25de@loongson.cn>
 <a102bb51a8ebde2e22d9527fb00a2c1f64c6e69f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a102bb51a8ebde2e22d9527fb00a2c1f64c6e69f.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 08:24:15PM -0800, Joe Perches wrote:
> On Wed, 2020-11-25 at 12:08 +0800, Tiezhu Yang wrote:
> > On 11/25/2020 11:51 AM, Joe Perches wrote:
> > > On Wed, 2020-11-25 at 11:35 +0800, Tiezhu Yang wrote:
> > > > When backport the upstream commit to the internal LTS kernel version,
> > > > we usually use the following description [1] [2]:
> > > > 
> > > > [ Upstream commit cc6528bc9a0c901c83b8220a2e2617f3354d6dd9 ]
> > > > or
> > > > commit c51f8f88d705e06bd696d7510aff22b33eb8e638 upstream.
> > > Internal to what?
> > > 
> > > If it's your own internal build system, I think you should
> > > keep your own local patch to checkpatch.
> > > 
> > > I don't see why the kernel version should accept it.
> > > 
> > > Is this style used by anyone else?
> > 
> > AFAIK, this style is only used in the stable tree, for example:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.9.y&id=c68a9ca7ca33f1020cca97e4e935c2154bec37c7
> 
> Greg?/Sasha?
> 
> https://lore.kernel.org/lkml/995e0acb-c219-ea00-f078-7582516e25de@loongson.cn/T/#m2f3d87bd985bf3d4d7b63f1fa4f0490baa01119b
> 
> Is this in your scripts?

My scripts put this into a patch when applying it to the stable tree,
and so do Sasha's.  I don't know why checkpatch would care about this as
that's not used for this workflow at all.

> Is this something you want/use?

I wouldn't use it, and I doubt anyone else would.

thanks,

greg k-h
