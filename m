Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8E7282BD9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 18:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJDQq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 12:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgJDQq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 12:46:59 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2218206B6;
        Sun,  4 Oct 2020 16:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601830019;
        bh=sVEX0xi2MOLC/1DXKNiNcCpDgAXQI03GADdRHFc9uZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKamgwob7/jlJskOlG4YZ5v6qF71gImkGZeH95aFI/LtSjGTsPI0kdInTGrTGULNf
         EOMLWYHZGoDfq38MqYRzaUVMLd80bhqXRpM3SsqXn/3y8dDxNtQoGo6mS8SOQR6dYS
         /YSh2OwwVGl6JHtT7TKTe5iDR5+g9V5vCUrVjTRQ=
Date:   Sun, 4 Oct 2020 18:47:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     pierre kuo <vichy.kuo@gmail.com>
Cc:     rafael@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] driver core: platform: provide
 devm_platform_iounremap_resource
Message-ID: <20201004164745.GA196660@kroah.com>
References: <20200920113808.22223-1-vichy.kuo@gmail.com>
 <20200920113808.22223-2-vichy.kuo@gmail.com>
 <CAOVJa8F+NZQM4H=1Y683g7DTZQ2z1YSH0pKRCVcN+JmQfEi81g@mail.gmail.com>
 <20201002134532.GA3419175@kroah.com>
 <CAOVJa8HZCmy0s-H7rPVTgi6X1uYZ82YjdPHe3-a4=D+qLgi7Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOVJa8HZCmy0s-H7rPVTgi6X1uYZ82YjdPHe3-a4=D+qLgi7Uw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 12:21:12AM +0800, pierre kuo wrote:
> hi Greg:
> > Please resend, I can't take patches off of a random web site.
> > Now lore.kernel.org I could take them from :)
> 
> Please refer to the attachments and links on lore.kernel.org.
> 
> https://lore.kernel.org/lkml/20200920113808.22223-1-vichy.kuo@gmail.com
> https://lore.kernel.org/lkml/20200920113808.22223-2-vichy.kuo@gmail.com

Why are you adding new functions but not actually calling them anywhere?
We don't like adding infrastructure that no one uses, that's just
wasteful.

Please redo the series and include some conversions as well, so that we
can see if these new functions are even needed or not.

thanks,

greg k-h
