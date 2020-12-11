Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C52D7317
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405706AbgLKJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:50:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405697AbgLKJug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:50:36 -0500
Date:   Fri, 11 Dec 2020 10:51:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607680195;
        bh=KfnnTbyhW9cEnhDdS2A2BabQv9rkQ9R9/uwQ7zQenDU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkvAYD4J//LFYp1f/GASrM/j+6P40EJHY6tR6glxzz5+I6Nre2lKwLsKN+OYge0iX
         FoLPmfybi7SGjtnNj7RS2iklpOMyX8bcSImgwpq+zS9zy861bPAoWPouOqLdKWg5o0
         0LD95q2jJb1Ku1cUz8vYhOWLlLlYT9V3vrym4Ado=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Badhri Jagan Sridharan <badhri@google.com>, linux@roeck-us.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 0/5] USB: typec: various patches
Message-ID: <X9NBC04aLNZG2RWI@kroah.com>
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
 <20201211083010.GD1594451@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211083010.GD1594451@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 10:30:10AM +0200, Heikki Krogerus wrote:
> On Thu, Dec 10, 2020 at 05:05:16PM +0100, Greg Kroah-Hartman wrote:
> > In digging through a large set of proposed typec patches for the Android
> > common kernel, I've picked out 5 "easy" patches that should all go
> > upstream (they all should go upstream, just will take a while to clean
> > them up it seems...)
> 
> Cool. Is there already support for the new Enter_USB message? Badhri,
> maybe you know more about this, if somebody is working on that or not?
> 
> FWIW, for all except the first patch 1/5:
> 
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks, will drop patch 1 from the queue.

greg k-h
