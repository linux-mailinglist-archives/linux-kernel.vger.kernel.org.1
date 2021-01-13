Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F632F40E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 02:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbhAMBCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 20:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbhAMBCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 20:02:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920B9C061795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wnYzjTfj+0CVGKioX4F3f2Rr2TE6YgQbb5/kGOsgyiM=; b=Kyvh2i86LAY7d/OHvkygqKltvh
        fwr9ODYbvcQs/yMz9MRhIjoAwIkm8BsuVIkOBBqAUe6r3GYbLNqNPCYrr7YLGPGU2MjK+wQAChyrg
        6XaBESrBO7bZBzHeSaV2tHOvlSUWHWTOmUQo2ibDaPj803hM9wDzG8uUIKqrZF9wkGFZA4rSBZwGn
        KgKVQ31ETPPrWf/ZFjJiJg1oMDD4isq+tevQC9H0R4Aa5NlSD9bylTq/RJSKJhfH8L77y2yQ0O9q6
        xmtLIDErl/FyRAfrUNrZGXb3CdmqD+kfWXtm1IbjDZEYXxHWUoov/vDrINkBe1QYG5v1rW6IXYPOH
        UZixV/BA==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzUXT-0005UF-5E; Wed, 13 Jan 2021 01:01:32 +0000
Subject: Re: [PATCH v2] software_node: Add kernel-doc comments to exported
 symbols
To:     Daniel Scally <djrscally@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, sakari.ailus@linux.intel.com,
        andriy.shevchenko@linux.intel.com
References: <20210113000209.322218-1-djrscally@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0c5710f0-88c3-ace5-64c7-e668705b5bf8@infradead.org>
Date:   Tue, 12 Jan 2021 17:01:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210113000209.322218-1-djrscally@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 4:02 PM, Daniel Scally wrote:
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

maybe:                  passed as @parent
?

Otherwise, LGTM.  Thanks for doing this.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


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
> 


-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
