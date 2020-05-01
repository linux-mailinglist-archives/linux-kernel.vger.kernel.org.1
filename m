Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBEE1C0F18
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 10:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgEAIEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 04:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgEAIEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 04:04:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B02B208C3;
        Fri,  1 May 2020 08:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588320284;
        bh=lamkafcb9ifi0CkloDrVZk+9/LKsm77P4Ce9z/TkKZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdhnMAdBJ2aX7UhxdGvolxXe6kFB6/uOZUZeFFRBF2CLtG/+Ec/0FMSAdrSbHMvhr
         75o17SVYdowHgoR4J3F+MPUXSXldG3MYxqu8dbPWxkUuDK1igDERkZVzfP0wl1e5/S
         h8wVSFWO+hM+nEV9VmNf6snwnJnHzNz9Huw/rWmU=
Date:   Fri, 1 May 2020 10:04:42 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/1] Add IMR driver for Keem Bay
Message-ID: <20200501080442.GA1055655@kroah.com>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
 <d3f045b05c83d0eca1d5498587493ca485e0a1a0.camel@intel.com>
 <20200501070930.GA892454@kroah.com>
 <c6c51b93978b95cc1ca5b03909f0766bc4bc2638.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6c51b93978b95cc1ca5b03909f0766bc4bc2638.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 08:53:34AM +0100, Daniele Alessandrelli wrote:
> On Fri, 2020-05-01 at 09:09 +0200, gregkh@linuxfoundation.org wrote:
> > On Thu, Apr 30, 2020 at 07:49:36PM +0000, Alessandrelli, Daniele
> > wrote:
> > > This e-mail and any attachments may contain confidential material
> > > for the sole
> > > use of the intended recipient(s). Any review or distribution by
> > > others is
> > > strictly prohibited. If you are not the intended recipient, please
> > > contact the
> > > sender and delete all copies.
> > 
> > This footer means I delete all of your emails...
> 
> My bad, I replied using the wrong email address (i.e., the one that
> adds the footer automatically). Sorry about that :/
> I'll be more careful the next time.
> 
> The original emails (the ones with the cover letter and the patch) were
> fine though (unless I did something else wrong). Any advice on how to
> have the patch reviewed and eventually merged?
> 
> 
> 
> 
> 
> 
> 

Ok, let me go look at the code...
