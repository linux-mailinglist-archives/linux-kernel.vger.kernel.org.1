Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723B727BBD9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 06:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgI2ER4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 00:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgI2ER4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 00:17:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C7FC208FE;
        Tue, 29 Sep 2020 04:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601353076;
        bh=7bfNpcX+LA5Pezx72Caql+dIn3BgrRM2ce9YzW68Szw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBM8EzXaGkeLASCga2WQKgv4NnNVSNGQjq80CrjPSyO+WwJZoZnjFuEdLo04Zs9Ce
         NLi6Rfj0FfqqQvlOX7RrIz1dW2tU6LaDxAd/nrxctgTVgXDhLS+4xHWHCDTp8unmnL
         HFwJAOOAGxKITRyuwfFcd8NiMw+y8Wip1eU2P3Y8=
Date:   Tue, 29 Sep 2020 06:17:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V3 6/8] mm: and drivers core: Convert
 hugetlb_report_node_meminfo to sysfs_emit
Message-ID: <20200929041751.GA5477@kroah.com>
References: <cover.1600285923.git.joe@perches.com>
 <894b351b82da6013cde7f36ff4b5493cd0ec30d0.1600285923.git.joe@perches.com>
 <20200919062228.GA438957@kroah.com>
 <881a8842817f94162a34531306512f8481e9b7fb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <881a8842817f94162a34531306512f8481e9b7fb.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:53:07PM -0700, Joe Perches wrote:
> On Sat, 2020-09-19 at 08:22 +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 16, 2020 at 01:40:43PM -0700, Joe Perches wrote:
> > > Convert the unbound sprintf in hugetlb_report_node_meminfo to use
> > > sysfs_emit_at so that no possible overrun of a PAGE_SIZE buf can occur.
> []
> > I'll take a look at it on Monday...
> 
> (noting that you didn't say _which_ Monday...)

True :)

> Greg are you going to take this or should I ask someone else?
> 
> The first sysfs_emit addition patch was first posted about a month
> ago without much change.
> 
> I think it'd be useful to get it into -next before 5.9 is released.

I'll dig into this today...
