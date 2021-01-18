Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59F92F9CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbhARKIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:08:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:9145 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389322AbhARJvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:51:52 -0500
IronPort-SDR: zX3kYUY33QTvE8uGEqnKL8reP7WjovyE+n61OJ3p1RO4W0bW2HSlkHhqTYcqtAeraR7Qrpdeg2
 08HaipJJmAPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="165871720"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="165871720"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 01:49:50 -0800
IronPort-SDR: SEHtBiNJfeMVTQhmkmgfD7QUQLwYfbqwlXQXPclFmNjEPArVt8Tikm9Nq3AimFBL7j9tWJ9b2+
 IP1LyOQ4Xshw==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="466311715"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 01:49:48 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 340A3208D7; Mon, 18 Jan 2021 11:49:46 +0200 (EET)
Date:   Mon, 18 Jan 2021 11:49:46 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v2] software_node: Add kernel-doc comments to exported
 symbols
Message-ID: <20210118094945.GX11878@paasikivi.fi.intel.com>
References: <20210113000209.322218-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113000209.322218-1-djrscally@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Jan 13, 2021 at 12:02:09AM +0000, Daniel Scally wrote:
> A number of functions which are exported via EXPORT_SYMBOL_GPL() lack any
> kernel-doc comments; add those in so all exported symbols are documented.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in version 2:
> 	- Replaced "fwnode_handle" with either @fwnode or natural language
> 	reference to a firmware node handle as appropriate.
> 
>  drivers/base/swnode.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 4a4b2008fbc2..e98018aa8b2f 100644
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
> + * This function is used to check whether a given firmware node handle was
> + * created by registering a &struct software_node or not.
> + */
>  bool is_software_node(const struct fwnode_handle *fwnode)
>  {
>  	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &software_node_ops;
> @@ -71,6 +78,14 @@ software_node_to_swnode(const struct software_node *node)
>  	return swnode;
>  }
>  
> +/**
> + * to_software_node() - Fetch software node associated with a firmware node handle

Please wrap lines over 80 (unless there's a reason to keep them longer).

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> + * @fwnode: The pointer to a &struct fwnode_handle to parse
> + *
> + * This function attempts to fetch a pointer to the &struct software_node which
> + * was used to create the given @fwnode. Note that this will only work if the
> + * software node has **not** been released.
> + */
>  const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
>  {
>  	const struct swnode *swnode = to_swnode(fwnode);
> @@ -79,6 +94,14 @@ const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(to_software_node);
>  
> +/**
> + * software_node_fwnode() - Fetch firmware node associated with a given software node
> + * @node: The pointer to a &struct software_node to parse
> + *
> + * This function attempts to fetch a pointer to the &struct fwnode_handle which
> + * was created from the given @node. Note that this will only work after the
> + * software node has been registered.
> + */
>  struct fwnode_handle *software_node_fwnode(const struct software_node *node)
>  {
>  	struct swnode *swnode = software_node_to_swnode(node);
> @@ -800,6 +823,27 @@ void software_node_unregister(const struct software_node *node)
>  }
>  EXPORT_SYMBOL_GPL(software_node_unregister);
>  
> +/**
> + * fwnode_create_software_node() - Create and register a new software_node
> + * @properties: NULL terminated array of properties to assign to the new node
> + * @parent: Pointer to a &struct fwnode_handle to assign as parent to the new
> + *	    node
> + *
> + * NOTE: The pointer passed to @parent **must** be to a firmware node handle
> + * that was created by registering a software node, meaning is_software_node()
> + * must return true when passed that pointer.
> + *
> + * This function creates a new instance of &struct software_node, assigns it a
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
> @@ -832,6 +876,15 @@ fwnode_create_software_node(const struct property_entry *properties,
>  }
>  EXPORT_SYMBOL_GPL(fwnode_create_software_node);
>  
> +/**
> + * fwnode_remove_software_node() - Put a reference to a registered software_node
> + * @fwnode: The pointer to the &struct fwnode_handle you want to release
> + *
> + * Release a reference to a registered &struct software_node. This function
> + * differs from software_node_put() in that it takes no action if the
> + * firmware node handle passed to @fwnode turns out not to have been created by
> + * registering a software_node.
> + */
>  void fwnode_remove_software_node(struct fwnode_handle *fwnode)
>  {
>  	struct swnode *swnode = to_swnode(fwnode);
> -- 
> 2.25.1
> 

-- 
Sakari Ailus
