Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CDD283A85
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgJEPfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbgJEPew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:34:52 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF7BB20B80;
        Mon,  5 Oct 2020 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601912084;
        bh=fKLXgwm3LHWHIxJxnwafWEJkhesZL6/HdkDbmJryTU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QM4qIb4X5wsjzEYikI4dwMyLWoa47EKfJtYhzyXQibZrJrH9GyFfA3pfbILZe6HJQ
         hKWLWS/MqCuXurtpSf7xSMAJ/B/B2H+1inoPdI495wcUVdMPUmZiJNKVuWWpx5Nu1v
         rirAyUKp3kDeeoL414RV65mz+yVVPfCS7ReeifJY=
Date:   Mon, 5 Oct 2020 17:31:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     pierre kuo <vichy.kuo@gmail.com>
Cc:     rafael@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] driver core: platform: provide
 devm_platform_iounremap_resource
Message-ID: <20201005153143.GB2372768@kroah.com>
References: <20200920113808.22223-1-vichy.kuo@gmail.com>
 <20200920113808.22223-2-vichy.kuo@gmail.com>
 <CAOVJa8F+NZQM4H=1Y683g7DTZQ2z1YSH0pKRCVcN+JmQfEi81g@mail.gmail.com>
 <20201002134532.GA3419175@kroah.com>
 <CAOVJa8HZCmy0s-H7rPVTgi6X1uYZ82YjdPHe3-a4=D+qLgi7Uw@mail.gmail.com>
 <20201004164745.GA196660@kroah.com>
 <CAOVJa8G+RMYvV6hU1cuJStRBM=7BbA7s1sXZavKs9OhHY8kaZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOVJa8G+RMYvV6hU1cuJStRBM=7BbA7s1sXZavKs9OhHY8kaZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 11:23:18PM +0800, pierre kuo wrote:
> hi Greg:
> > Why are you adding new functions but not actually calling them anywhere?
> 
> Below patch introduce a single helper, devm_platform_ioremap_resource,
> which combines
> platform_get_resource() and devm_ioremap_resource(). But there is no
> single helper to release
> those resources in driver removing stage.
> 
> https://lore.kernel.org/lkml/20190215152507.31066-2-brgl@bgdev.pl/
> 
> That means driver owner still need to call below (*) and (**) for
> releasing resource.
> Therefore, this patch adds a single release helper that can be paired with
> devm_platform_ioremap_resource.
> 
> Appreciate ur kind help,
> 
> foo_probe(pdev)
> {
>     iomem = devm_platform_ioremap_resource(pdev, 0);
>     ....
> }
> 
> 
> foo_remove(pdev)
> {
>     devm_iounmap(iomem);   (*)
>     devm_release_mem_region(dev, res->start, size); (**)
>    ........................
> }

I don't understand this at all, sorry.  Please submit your patch series,
with some drivers converted to use the new functions.  Otherwise we can
not properly review it.

thanks,

greg k-h
