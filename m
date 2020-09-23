Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C488A275EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIWRp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWRpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:45:25 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A866C20665;
        Wed, 23 Sep 2020 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600883125;
        bh=w57gLA/9GdadrUmtXx3y4slqkrBIQ4xrA6PFRXb3JHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5+c02wj9CcexOQDZEP1wD1mXA2n0wV6XuQdMVJ2WCZbm1bBA9VcHtPe+vh4jRQrh
         0LJxvGIJINVFVIq2l7AfuZ6RDHd/vKY4JSM+FT04CPV6Lb4ajrs9pmH3U1vewfOsGW
         kQBnxuvVB9ob9Ml5OtNyMNr8RWkgiwwhabKYLcJI=
Date:   Wed, 23 Sep 2020 19:45:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: Re: [RFC PATCH 5/9] surface_aggregator: Add error injection
 capabilities
Message-ID: <20200923174543.GA102853@kroah.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-6-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923151511.3842150-6-luzmaximilian@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:15:07PM +0200, Maximilian Luz wrote:
> This commit adds error injection hooks to the Surface Serial Hub
> communication protocol implementation, to:
> 
>  - simulate simple serial transmission errors,
> 
>  - drop packets, requests, and responses, simulating communication
>    failures and potentially trigger retransmission timeouts, as well as
> 
>  - inject invalid data into submitted and received packets.
> 
> Together with the trace points introduced in the previous commit, these
> facilities are intended to aid in testing, validation, and debugging of
> the Surface Aggregator communication layer.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Ok, this is ridiculous.

You are dropping a whole new subsystem on us, with full documentation,
correct driver model integration, crazy debugfs interactions (I made fun
of the patch, but the code did work, you just did more work than was
needed), proper auto-loading of modules, tracing, documentation for more
things than is ever expected, and now you are adding error injection
support?

You just made all other code submissions of new subsystems I have gotten
in the past 2 months look like total crud.  Which, to be fair, they
probably were, but wow, you just stepped up the level of professionalism
to a whole new height.

I can only dream that "real Linux companies" take note and try to follow
this example.  I think I will point them all at this in the future and
say, "go do it like this one."

very very very nice work, we owe you the beverage of your choice.

greg k-h
