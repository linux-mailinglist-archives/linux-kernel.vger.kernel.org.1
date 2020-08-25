Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD8251C89
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgHYPpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 11:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgHYPpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:45:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BE0B2067C;
        Tue, 25 Aug 2020 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598370332;
        bh=J9j8I9e1vUqi85jVzVhKCQp3T2bITZExUCsPWzEeIMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gG9TpcopdDPeldxrfc0Zu7ErcQ5JJWy+leFqtjDc70tZWHAi5s+8DFQXXAsjz773L
         wERo5NQnTdjXgOQq98zX+bvyzyTHDrzvasAanvQi8RcWgkc+16TbKS44Kgava5ZhPf
         ZdDKV43+uH7FmJaCWC55FS1sggD3EclaIyA6Urpc=
Date:   Tue, 25 Aug 2020 17:45:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2] kobject: Restore old behaviour of kobject_del(NULL)
Message-ID: <20200825154548.GA1514525@kroah.com>
References: <20200803082706.65347-1-andriy.shevchenko@linux.intel.com>
 <20200803094659.GB635660@kroah.com>
 <20200825144109.GN1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825144109.GN1891694@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 05:41:09PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 03, 2020 at 11:46:59AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Aug 03, 2020 at 11:27:06AM +0300, Andy Shevchenko wrote:
> > > The commit 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in
> > > kobject_cleanup()") inadvertently dropped a possibility to call kobject_del()
> > > with NULL pointer. Restore the old behaviour.
> > > 
> > > Fixes: 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in kobject_cleanup()")
> > > Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
> > > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > v2: replaced ?: with plain conditional (Greg)
> > >  lib/kobject.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > Thanks, much better, will queue up after -rc1 is out.
> 
> Shouldn't be this taken care of?

Yes, will get to it soon, after -rc1 is tough, combined with Plumbers...

greg k-h
