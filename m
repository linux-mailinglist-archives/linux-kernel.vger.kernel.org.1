Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A812EADBC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 15:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbhAEOyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 09:54:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:8991 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbhAEOyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:54:14 -0500
IronPort-SDR: Y3LNszeyAxcrO+aS7BLTI8uQr3qb+WRaCBmoX9XbeHA8SaHdETcvBMgcWpcSHHHXcJXGBrSKXt
 lhFf8blfjS6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156309117"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="156309117"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 06:52:28 -0800
IronPort-SDR: PZ84fUTd4mS42DB5R2XAniIW82dPvy4hWcHT/Ribtw74p2jNCzfj4Bw3JOY8H/ddxzSA+UvWGb
 lCPDzFTCMKnQ==
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="462318746"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 06:52:27 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kwniD-002D4Q-66; Tue, 05 Jan 2021 16:53:29 +0200
Date:   Tue, 5 Jan 2021 16:53:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, sakari.ailus@linux.intel.com,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH] software_node: Add kernel-doc comments to exported
 symbols
Message-ID: <20210105145329.GO4077@smile.fi.intel.com>
References: <20210104234736.419493-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104234736.419493-1-djrscally@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 11:47:36PM +0000, Daniel Scally wrote:
> A number of functions which are exported via EXPORT_SYMBOL_GPL() lack any
> kernel-doc comments; add those in so all exported symbols are documented.

Thanks, it's helpful!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
after addressing few nitpicks

> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> With a view to maybe writing some documentation once the fwnode_graph_*()
> functions are also added.

FWIW, Heikki used to have a draft patch of swnode documentation, not sure
what's the current status of it.

>  drivers/base/swnode.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 4a4b2008fbc2..ea52e5e9af92 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -33,6 +33,13 @@ static struct kset *swnode_kset;
>  
>  static const struct fwnode_operations software_node_ops;
>  
> +/**
> + * is_software_node() - check if given fwnode was created from a software_node
> + * @fwnode: The &struct fwnode_handle to check
> + *
> + * This function is used to check whether a given fwnode_handle was created by

fwnode_handle -> @fwnode

> + * registering a &struct software_node or not.
> + */
>  bool is_software_node(const struct fwnode_handle *fwnode)
>  {
>  	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &software_node_ops;
> @@ -71,6 +78,14 @@ software_node_to_swnode(const struct software_node *node)
>  	return swnode;
>  }
>  
> +/**
> + * to_software_node() - Fetch software_node associated with a given fwnode_handle
> + * @fwnode: The pointer to a &struct fwnode_handle to parse
> + *
> + * This function attempts to fetch a pointer to the &struct software_node which
> + * was used to create a given fwnode_handle. Note that this will only work if

Ditto.

> + * the software_node has **not** been released.
> + */
>  const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
>  {
>  	const struct swnode *swnode = to_swnode(fwnode);
> @@ -79,6 +94,14 @@ const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(to_software_node);
>  
> +/**
> + * software_node_fwnode() - Fetch fwnode_handle associated with a given software_node
> + * @node: The pointer to a &struct software_node to parse
> + *
> + * This function attempts to fetch a pointer to the &struct fwnode_handle which
> + * was created from a given software_node. Note that this will only work after

software_node -> @node

> + * the software_node has been registered.
> + */
>  struct fwnode_handle *software_node_fwnode(const struct software_node *node)
>  {
>  	struct swnode *swnode = software_node_to_swnode(node);
> @@ -800,6 +823,26 @@ void software_node_unregister(const struct software_node *node)
>  }
>  EXPORT_SYMBOL_GPL(software_node_unregister);
>  
> +/**
> + * fwnode_create_software_node() - Create and register a new software_node
> + * @properties: NULL terminated array of properties to assign to the new node
> + * @parent: Pointer to a fwnode_handle to assign as parent to the new node

fwnode_handle -> &struct fwnode_handle ?

> + * NOTE: The pointer passed to @parent **must** be to a fwnode_handle that was

Ditto ?

> + * created by registering a &struct software_node, meaning is_software_node()
> + * must return true when passed that pointer.
> + *
> + * This function creates a new instance of struct software_node, assigns it a

struct -> &struct

> + * copy of the given array of properties and registers it as a new fwnode_handle.
> + * Freeing of the allocated memory when the fwnode_handle is no longer needed is
> + * handled via software_node_release() and does not need to be done separately.
> + *
> + * Returns:
> + * * fwnode_handle *	- On success
> + * * -EINVAL		- When @parent is not associated with a software_node
> + * * -ENOMEM		- When memory allocation fails
> + * * -Other		- Propagated errors from sub-functions
> + */
>  struct fwnode_handle *
>  fwnode_create_software_node(const struct property_entry *properties,
>  			    const struct fwnode_handle *parent)
> @@ -832,6 +875,15 @@ fwnode_create_software_node(const struct property_entry *properties,
>  }
>  EXPORT_SYMBOL_GPL(fwnode_create_software_node);
>  
> +/**
> + * fwnode_remove_software_node() - Put a reference to a registered software_node
> + * @fwnode: The pointer to the &struct fwnode_handle you want to release
> + *
> + * Release a reference to a registered &struct software_node. This function
> + * differs from software_node_put() in that it takes no action if the
> + * fwnode_handle passed to @fwnode turns out not to have been created by
> + * registering a software_node

Period at the end.

I'm a bit confused by amount of fwnode_handle in the comments, can you replace
them with better approach depending on the case:
- &struct fwnode_handle
- a parameter as @fwnode or so
- a general mention (better to use plain English here, something like firmware
  node handle or so)

> + */
>  void fwnode_remove_software_node(struct fwnode_handle *fwnode)
>  {
>  	struct swnode *swnode = to_swnode(fwnode);
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


