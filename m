Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E401F2FCFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbhATLmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbhATLMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:12:30 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2B3C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 03:11:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c128so2477952wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 03:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BvLBV8u1dCvrxz5GjCK03328U1uu5vASd43HItfBWt0=;
        b=eQHnDaidniQ88xvWMbt8CBsMTHCC56RNwOSZP4m0+9vp0gzvFDNyAX4KU0rH3FhV/q
         BiFUYGxuMJoIPLAPVLw5vGOVGXaod+Zvx7P/QE3UVNJ6G287LyJ5soLvVyBCEiS/5vvS
         9AAZn6mk0xkW5nMkde1kGqkihUlsQlN9e3B+hVmMVzcb9vcEhAQLOqzBQu7K+1EZZAMv
         eUkZKu9bC4gRzKaRUfxsrDYesQ3sV5tqyzK8w+viQ4DTqQoEanJlE6tYrKwhjO9G+3tk
         iNFXu7XwEDSFLTXWD1lL7WtD+NCWcKiafbPX2a0Lmnx4NaRTeWdOZgjrHlxCIMNv7Gc7
         bkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BvLBV8u1dCvrxz5GjCK03328U1uu5vASd43HItfBWt0=;
        b=Z1+/Zbp3lFW4v9CtFnNTmaZnT0HDp8UV4+DGchitoegCr32zOEc564YQ4VNuM0mWKm
         Gqi+vYMqbD7M4dGu3ebta7duNmBloTaGxjz36rKSwQCvwAYDgoKQw99fS5Mk/4jjchVj
         yPknlEB8VS6+BbMV43kiklmVqgiaRRVtq5rJYilbumPBlIgAltNeR+DpJaS3GcUn3Wi3
         IvTzsjF+ugqh1QfHx2qbrE8mh/5Yp002WnL0MEMLsId6LNywPubjDnvyaVpyZUgAjKhu
         9aKKaDN0xZhnJ3yBctYxTFtjSl7+xpxUY57t8MfEtSj6ss4rEf9ajeS5HJ7gUZBMGZ3a
         0VFw==
X-Gm-Message-State: AOAM5300NXnMNfjCV8nzPV2rhdexCSyfVGRkCh6CIEzQzEadSvwuA0zP
        4fTYcH0BwuSm8ZN8/cHa90Q=
X-Google-Smtp-Source: ABdhPJwNrctZ0T9uQO+K5YQyaXc6x2X5uggqjVRalC37WbZu1EnQAxQ+Uo7dC0I6os3dBbGel5Dj0w==
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr4017018wmj.48.1611141108368;
        Wed, 20 Jan 2021 03:11:48 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id q15sm3261552wrw.75.2021.01.20.03.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 03:11:47 -0800 (PST)
Subject: Re: [PATCH v3] software_node: Add kernel-doc comments to exported
 symbols
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, rdunlap@infradead.org
References: <20210120000339.471117-1-djrscally@gmail.com>
 <20210120103504.GH11878@paasikivi.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <c4578b2a-c9a3-bf9d-8c5a-1ea3b1afedb2@gmail.com>
Date:   Wed, 20 Jan 2021 11:11:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210120103504.GH11878@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari

On 20/01/2021 10:35, Sakari Ailus wrote:
> Hi Dan,
>
> On Wed, Jan 20, 2021 at 12:03:39AM +0000, Daniel Scally wrote:
>> A number of functions which are exported via EXPORT_SYMBOL_GPL() lack any
>> kernel-doc comments; add those in so all exported symbols are documented.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>> ---
>> Changelog for v3:
>>
>> 	- s/passed to @parent/passed as @parent
>> 	- Wrapped a long summary line - TIL that you can do that, thanks
>> 	  Sakari
>>
>>  drivers/base/swnode.c | 54 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>
>> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
>> index 4a4b2008fbc2..39fbb653c58a 100644
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
>> @@ -71,6 +78,15 @@ software_node_to_swnode(const struct software_node *node)
>>  	return swnode;
>>  }
>>  
>> +/**
>> + * to_software_node() - Fetch the software node used to create a firmware
>> + *			node handle
>> + * @fwnode: The pointer to a &struct fwnode_handle to parse
>> + *
>> + * This function attempts to fetch a pointer to the &struct software_node which
>> + * was used to create the given @fwnode. Note that this will only work if the
>> + * software node has **not** been released.
>> + */
>>  const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
>>  {
>>  	const struct swnode *swnode = to_swnode(fwnode);
>> @@ -79,6 +95,14 @@ const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
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
>> @@ -800,6 +824,27 @@ void software_node_unregister(const struct software_node *node)
>>  }
>>  EXPORT_SYMBOL_GPL(software_node_unregister);
>>  
>> +/**
>> + * fwnode_create_software_node() - Create and register a new software_node
>> + * @properties: NULL terminated array of properties to assign to the new node
>> + * @parent: Pointer to a &struct fwnode_handle to assign as parent to the new
>> + *	    node
>> + *
>> + * NOTE: The pointer passed as @parent **must** be to a firmware node handle
>> + * that was created by registering a software node, meaning is_software_node()
>> + * must return true when passed that pointer.
>> + *
>> + * This function creates a new instance of &struct software_node, assigns it a
>> + * copy of the given array of properties and registers it as a new fwnode_handle.
>> + * Freeing of the allocated memory when the fwnode_handle is no longer needed is
>> + * handled via software_node_release() and does not need to be done separately.
> Please wrap all lines over 80 unless there's a reason to keep them longer.


Apologies; I'll cat | awk for lines over the limit from now on rather
than half-arsing it.

>
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
>> @@ -832,6 +877,15 @@ fwnode_create_software_node(const struct property_entry *properties,
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
>> -- 
>> 2.25.1
>>
