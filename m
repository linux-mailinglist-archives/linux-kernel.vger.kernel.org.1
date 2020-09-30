Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A250827EF29
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbgI3Q20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730363AbgI3Q20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:28:26 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 115F52072E;
        Wed, 30 Sep 2020 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601483304;
        bh=JjKg2I0hYcPIldpZf/kHOqjf7nZZ2qgb+LHtENL2XEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBQzOzMgpYj5ULrUHhDOv+jJ2xJjH8S4GCZOQkWEjNdXstghTlejRBwiPMUes2zdL
         qd+gonByAZ+7umLSyiW+ZOCwjEYUiMG1GCJy2ML632Gf5B8oO/kfI838L5ggtNPQlQ
         ayBfGHuLwakdgOytpuyFxVd34m1BVVYkOaR4tTDQ=
Date:   Wed, 30 Sep 2020 18:28:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] MAINTAINERS: exclude char maintainers from things they
 do not maintain
Message-ID: <20200930162828.GA1672130@kroah.com>
References: <20200930121007.GA1615300@kroah.com>
 <20200930133656.GY3674@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930133656.GY3674@minyard.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 08:36:56AM -0500, Corey Minyard wrote:
> On Wed, Sep 30, 2020 at 02:10:07PM +0200, Greg Kroah-Hartman wrote:
> > There are a number of subdirectories and files in drivers/char/ that
> > have their own maintainers and developers and ways of getting patches to
> > Linus.  This includes random.c, IPMI, hardware random drivers, TPM
> > drivers, and agp drivers.  Instead of sending those patches to Arnd and
> > myself, who can't do anything with them, send them to the proper
> > developers instead.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Yes, please do.  No reason for you to get all the noise from these.
> 
> Acked-by: Corey Minyard <cminyard@mvista.com>

Thanks!

greg k-h
