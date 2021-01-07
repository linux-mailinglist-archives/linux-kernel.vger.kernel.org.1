Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0F2ED1FF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbhAGOV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:21:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:4351 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbhAGOVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:21:22 -0500
IronPort-SDR: wPTAZYM+dwrpEDle/8SEgdSClQuZjItfMNctDuXvsnkI7WZ5663BwnOVXiyPuiJKfXAe5rILKA
 cDZFaIIrNiOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="177580001"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="177580001"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 06:19:36 -0800
IronPort-SDR: YfixWJrWgNYv8tr761IPsUQCwe+V6bkXofZSRYPG1yOiH8/5dqXajnm1QoN2lrPZvJ+HjfJDN4
 6SrV3pu6uZAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="463047740"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jan 2021 06:19:33 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 07 Jan 2021 16:19:32 +0200
Date:   Thu, 7 Jan 2021 16:19:32 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, sakari.ailus@linux.intel.com
Subject: Re: [PATCH] software_node: Add kernel-doc comments to exported
 symbols
Message-ID: <20210107141932.GJ940479@kuha.fi.intel.com>
References: <20210104234736.419493-1-djrscally@gmail.com>
 <20210105145329.GO4077@smile.fi.intel.com>
 <3d92e535-c955-502a-24ac-0655752796fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d92e535-c955-502a-24ac-0655752796fc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 03:39:42PM +0000, Daniel Scally wrote:
> Hi Andy
> 
> On 05/01/2021 14:53, Andy Shevchenko wrote:
> > On Mon, Jan 04, 2021 at 11:47:36PM +0000, Daniel Scally wrote:
> >> A number of functions which are exported via EXPORT_SYMBOL_GPL() lack any
> >> kernel-doc comments; add those in so all exported symbols are documented.
> > Thanks, it's helpful!
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > after addressing few nitpicks
> Thanks for reviewing
> >> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> >> ---
> >> With a view to maybe writing some documentation once the fwnode_graph_*()
> >> functions are also added.
> > FWIW, Heikki used to have a draft patch of swnode documentation, not sure
> > what's the current status of it.
> Oh cool ok; I'll defer to him then.

I actually had a similar patch prepared as part of the series adding
the documentation for software nodes, but your comments are better
than mine. So, after you have addressed Andy's comments:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> >> + * copy of the given array of properties and registers it as a new fwnode_handle.
> >> + * Freeing of the allocated memory when the fwnode_handle is no longer needed is
> >> + * handled via software_node_release() and does not need to be done separately.
> >> + *
> >> + * Returns:
> >> + * * fwnode_handle *	- On success
> >> + * * -EINVAL		- When @parent is not associated with a software_node
> >> + * * -ENOMEM		- When memory allocation fails
> >> + * * -Other		- Propagated errors from sub-functions
> >> + */
> >>  struct fwnode_handle *
> >>  fwnode_create_software_node(const struct property_entry *properties,
> >>  			    const struct fwnode_handle *parent)
> >> @@ -832,6 +875,15 @@ fwnode_create_software_node(const struct property_entry *properties,
> >>  }
> >>  EXPORT_SYMBOL_GPL(fwnode_create_software_node);
> >>  
> >> +/**
> >> + * fwnode_remove_software_node() - Put a reference to a registered software_node
> >> + * @fwnode: The pointer to the &struct fwnode_handle you want to release
> >> + *
> >> + * Release a reference to a registered &struct software_node. This function
> >> + * differs from software_node_put() in that it takes no action if the
> >> + * fwnode_handle passed to @fwnode turns out not to have been created by
> >> + * registering a software_node
> > Period at the end.
> >
> > I'm a bit confused by amount of fwnode_handle in the comments, can you replace
> > them with better approach depending on the case:
> > - &struct fwnode_handle
> > - a parameter as @fwnode or so
> > - a general mention (better to use plain English here, something like firmware
> >   node handle or so)
> Yeah ok, I was trying to do &struct fwnode_handle on the first reference
> (or at least earliest that it would fit) and then fwnode_handle
> thereafter, but I think I like the suggestion to drop to plain English
> at that point instead, so I'll do that (and ditto for software_node /
> software node)

-- 
heikki
