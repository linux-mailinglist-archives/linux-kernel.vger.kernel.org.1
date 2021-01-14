Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC4E2F5C66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbhANIaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbhANIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:30:01 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C203DC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:29:20 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d13so4790723wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ib4BJtcuddkHleDbCtGkgX2ywI6EAF47UZTPlA+Ihqk=;
        b=Rgu2g4CVq8DlfQ4VCbU5+IQ83OtiCT2+9DBDvWXL1nI86/mp7KIhjagdfEny5Cwhya
         8AzCvKUBDqgz3VMIyNQbnDFrK4TOYgWCRR3XwafAAj1LgDBm64lJrEZ6kDWbi9P6lOKF
         xrMAvX2jbZLP3XjC2aVq7cz4xWv+yFzcZFlMR3jqHaK8JE17farFL79L647f/aedos+0
         OTrNQv9RdBZZWoNtUL2+lU9D0fkZMVlhBg7rn7cw9Mvm0nCP28kqcX5blnPvRLq24z3J
         ktauWPrwzTAfSU+2i9tfz+E70vhOTUA6ZxhEUp6GOD2xtotShUhsqvru5Fl0bYZO8KOs
         1Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ib4BJtcuddkHleDbCtGkgX2ywI6EAF47UZTPlA+Ihqk=;
        b=ZwmVJ+FdyDagETEEjIjdk0hkJ+vaPBKf7zSeo8yRjNDIOKJFvE3gpfrDXO/mtVNtWI
         Nlk9E61svGvaapaE8M6PKCa9FNbCsMZoA3VLGBJ5nNXPtR1MpHLcuWCzY/Jn9AC0GDc/
         a7I2/u9iwC6s6VAg8gQ3r019dxI8jnb/VFr6CIY2NAS+/5dh8EYrwnLKEgsroUEWjhOv
         4JhBujTtKQSrVKsEYVD21J+l93OZdEaUXaF6xFyunIAb+QxWBSXcgMVIinYaxigDCgXB
         CEjYlLrqlCFBtg4AAhePLyQW9P8jazO6Vp5VUyUo3+/24UMZXFQ7/foLXt2sVTenez43
         seBA==
X-Gm-Message-State: AOAM531Zf0jCjjm52bYHwa1QuSbkcpfsgesT51dkejdo/3QVZuDoDxIC
        4wpSVS7oVMnomko2y9Y7jNA=
X-Google-Smtp-Source: ABdhPJzGgh/9SUVyt6zmGRbGoabZe2hzPdlF/VqDERBKie8BBJg6Wv0YBvUb2wL1q5PXTO1nK/RW+Q==
X-Received: by 2002:adf:b1da:: with SMTP id r26mr1890305wra.198.1610612959514;
        Thu, 14 Jan 2021 00:29:19 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id q6sm6825677wmj.32.2021.01.14.00.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 00:29:18 -0800 (PST)
Subject: Re: [PATCH v2] software_node: Add kernel-doc comments to exported
 symbols
To:     Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, sakari.ailus@linux.intel.com,
        andriy.shevchenko@linux.intel.com
References: <20210113000209.322218-1-djrscally@gmail.com>
 <0c5710f0-88c3-ace5-64c7-e668705b5bf8@infradead.org>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <95f71622-96a2-8ce4-059d-ac4ed7271aa6@gmail.com>
Date:   Thu, 14 Jan 2021 08:29:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0c5710f0-88c3-ace5-64c7-e668705b5bf8@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy

On 13/01/2021 01:01, Randy Dunlap wrote:
> On 1/12/21 4:02 PM, Daniel Scally wrote:
>> A number of functions which are exported via EXPORT_SYMBOL_GPL() lack any
>> kernel-doc comments; add those in so all exported symbols are documented.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>> ---
>> Changes in version 2:
>> 	- Replaced "fwnode_handle" with either @fwnode or natural language
>> 	reference to a firmware node handle as appropriate.
>>
>>  drivers/base/swnode.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
>> index 4a4b2008fbc2..e98018aa8b2f 100644
>> --- a/drivers/base/swnode.c
>> +++ b/drivers/base/swnode.c
>> @@ -33,6 +33,13 @@ static struct kset *swnode_kset;
>>  
>>  static const struct fwnode_operations software_node_ops;
>>  
>> +/**
>> + * is_software_node() - check if given fwnode was created from a software_node
>> + * @fwnode: The &struct fwnode_handle to check
>> + *
>> + * This function is used to check whether a given firmware node handle was
>> + * created by registering a &struct software_node or not.
>> + */
>>  bool is_software_node(const struct fwnode_handle *fwnode)
>>  {
>>  	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &software_node_ops;
>> @@ -71,6 +78,14 @@ software_node_to_swnode(const struct software_node *node)
>>  	return swnode;
>>  }
>>  
>> +/**
>> + * to_software_node() - Fetch software node associated with a firmware node handle
>> + * @fwnode: The pointer to a &struct fwnode_handle to parse
>> + *
>> + * This function attempts to fetch a pointer to the &struct software_node which
>> + * was used to create the given @fwnode. Note that this will only work if the
>> + * software node has **not** been released.
>> + */
>>  const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
>>  {
>>  	const struct swnode *swnode = to_swnode(fwnode);
>> @@ -79,6 +94,14 @@ const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
>>  }
>>  EXPORT_SYMBOL_GPL(to_software_node);
>>  
>> +/**
>> + * software_node_fwnode() - Fetch firmware node associated with a given software node
>> + * @node: The pointer to a &struct software_node to parse
>> + *
>> + * This function attempts to fetch a pointer to the &struct fwnode_handle which
>> + * was created from the given @node. Note that this will only work after the
>> + * software node has been registered.
>> + */
>>  struct fwnode_handle *software_node_fwnode(const struct software_node *node)
>>  {
>>  	struct swnode *swnode = software_node_to_swnode(node);
>> @@ -800,6 +823,27 @@ void software_node_unregister(const struct software_node *node)
>>  }
>>  EXPORT_SYMBOL_GPL(software_node_unregister);
>>  
>> +/**
>> + * fwnode_create_software_node() - Create and register a new software_node
>> + * @properties: NULL terminated array of properties to assign to the new node
>> + * @parent: Pointer to a &struct fwnode_handle to assign as parent to the new
>> + *	    node
>> + *
>> + * NOTE: The pointer passed to @parent **must** be to a firmware node handle
> maybe:                  passed as @parent
> ?
Sure, I'll make that change.
> Otherwise, LGTM.  Thanks for doing this.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks!
>
>> + * that was created by registering a software node, meaning is_software_node()
>> + * must return true when passed that pointer.
>> + *
>> + * This function creates a new instance of &struct software_node, assigns it a
>> + * copy of the given array of properties and registers it as a new fwnode_handle.
>> + * Freeing of the allocated memory when the fwnode_handle is no longer needed is
>> + * handled via software_node_release() and does not need to be done separately.
>> + *
>> + * Returns:
>> + * * fwnode_handle *	- On success
>> + * * -EINVAL		- When @parent is not associated with a software_node
>> + * * -ENOMEM		- When memory allocation fails
>> + * * -Other		- Propagated errors from sub-functions
>> + */
>>  struct fwnode_handle *
>>  fwnode_create_software_node(const struct property_entry *properties,
>>  			    const struct fwnode_handle *parent)
>> @@ -832,6 +876,15 @@ fwnode_create_software_node(const struct property_entry *properties,
>>  }
>>  EXPORT_SYMBOL_GPL(fwnode_create_software_node);
>>  
>> +/**
>> + * fwnode_remove_software_node() - Put a reference to a registered software_node
>> + * @fwnode: The pointer to the &struct fwnode_handle you want to release
>> + *
>> + * Release a reference to a registered &struct software_node. This function
>> + * differs from software_node_put() in that it takes no action if the
>> + * firmware node handle passed to @fwnode turns out not to have been created by
>> + * registering a software_node.
>> + */
>>  void fwnode_remove_software_node(struct fwnode_handle *fwnode)
>>  {
>>  	struct swnode *swnode = to_swnode(fwnode);
>>
>
