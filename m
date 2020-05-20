Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317831DB085
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 12:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgETKsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 06:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETKsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:48:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A11A72075F;
        Wed, 20 May 2020 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589971685;
        bh=jKhsmsyLFXoihUbF/B/35L1ZU7aEq2DseqmlMnceMAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPHpQpi0v5x/sevQNKxbaN8EgZ8Ct+om2eRSTLE0IWOhELgIXqp9kpRLB3moL+7mb
         OSaeE3It7I5hHCVpH32Ait3m/boXCuwsoBjbAUekp3ux5kRuynmYzyNaidCXuawLSf
         0JTKWaApZ/1tREXvuwZQzAC5dZjYXuHC/TOYEyUE=
Date:   Wed, 20 May 2020 12:48:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1] drivers property: When no children in primary, try
 secondary
Message-ID: <20200520104802.GB3231313@kroah.com>
References: <20200520102959.34812-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0heg9w=k1yqkECNo9XLP2hZny_WJQv4EJq_Wh0dVT137g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0heg9w=k1yqkECNo9XLP2hZny_WJQv4EJq_Wh0dVT137g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 12:34:06PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 20, 2020 at 12:30 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Software firmware nodes can provide a child node to its parent.
> > Since software node can be secondary, we need a mechanism to access
> > the children. The idea is to list children of the primary node first
> > and when they are finished, continue with secondary node if available.
> 
> Makes sense.
> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Greg, do you want me to apply it?
> 
> If you'd rather take it yourself, please feel free to add
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I can take it, there's other driver core patches in my tree already :)

thanks,

greg k-h
