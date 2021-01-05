Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FDF2EAEE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbhAEPk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbhAEPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:40:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D0EC061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 07:39:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 190so3411331wmz.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 07:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OzJaxmEksYbA5fRfeUrfz1TmvdKkY+GGXO8cOihx70I=;
        b=YQjGJRq6lN7IOaW8XMrIoC5Xc5v2O3B8X8FNG8HYAelmPRH4vXHr7Ru4tOlG6i8cbM
         XuKNBAQ6LTkVBw11lyLdLj1CRX/r7i7+Uq6/6eZ/sqlfvfv7NxVyzYRMmGF0Wo6fVRnQ
         BJxRH6mnPoYvUmIEwjTaf/NZUgreOXI6MYRflwg0o1YFJqau3Pak5vSy+Dkbkz/thxxW
         3dA3F6AI9Go8Mcy4ZJvcaCifoHbthULuz91LWR1VAAc5wGwESrXEtmM8avLxYPuUgpwb
         LZyHiXRiOwTsTnEhsBAUkKi3nAfaHyDNJq0V5453M+smsMURAsSSvuYSPaAsFwjso797
         ymRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OzJaxmEksYbA5fRfeUrfz1TmvdKkY+GGXO8cOihx70I=;
        b=Hf2//EpfqdnIHJdQnuxhgVLwB2XHPE7MqZbuWQzwrdLWmm1Sh+lazM9Jl/DKnWIf0q
         cGwr5t8ZXbtT7dV9pCjn54+upxYOiyABk2ixLbbS4RVktb3dQnQ0DSKzF8VQRdWhrBaY
         E7n+DJv4Q67+jfj5yLUbUIewGOpQc2R8UTzPH1m84nV2ZiiqLoCJwPneLRKcOWbv6jEw
         u8GKQVufo/zJBKPdGltnjociBrXZ2NcGuuAcJW3ia5EOK6DUFIo+BudwUWPha/tIgJGi
         9qV5/YwDngNH+FJD5SvLU5nlN2ZkH0bVNEUfTsqlg0erZNrpfMjG4WViu1k9ZUjQm1bc
         yAHQ==
X-Gm-Message-State: AOAM531kXx7vrxIzcDEMAnpAyi7QQVdlVEl9KNGCIujp/4l22BX61SKQ
        fvOoVIMEZPfqXKCWW2qTB5YDvwAMgrYFTVPW
X-Google-Smtp-Source: ABdhPJwTWsBESsV81VSBlNm3rzWLnaYUzfW8YvuLYGhAv+kFOFWkLZNTgCVfWH0Jad9PuNqT2Ch2vw==
X-Received: by 2002:a1c:9dd8:: with SMTP id g207mr4003144wme.15.1609861184289;
        Tue, 05 Jan 2021 07:39:44 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id b12sm5214211wmj.2.2021.01.05.07.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:39:43 -0800 (PST)
Subject: Re: [PATCH] software_node: Add kernel-doc comments to exported
 symbols
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, sakari.ailus@linux.intel.com,
        heikki.krogerus@linux.intel.com
References: <20210104234736.419493-1-djrscally@gmail.com>
 <20210105145329.GO4077@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <3d92e535-c955-502a-24ac-0655752796fc@gmail.com>
Date:   Tue, 5 Jan 2021 15:39:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210105145329.GO4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On 05/01/2021 14:53, Andy Shevchenko wrote:
> On Mon, Jan 04, 2021 at 11:47:36PM +0000, Daniel Scally wrote:
>> A number of functions which are exported via EXPORT_SYMBOL_GPL() lack any
>> kernel-doc comments; add those in so all exported symbols are documented.
> Thanks, it's helpful!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> after addressing few nitpicks
Thanks for reviewing
>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>> ---
>> With a view to maybe writing some documentation once the fwnode_graph_*()
>> functions are also added.
> FWIW, Heikki used to have a draft patch of swnode documentation, not sure
> what's the current status of it.
Oh cool ok; I'll defer to him then.
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
>> @@ -832,6 +875,15 @@ fwnode_create_software_node(const struct property_entry *properties,
>>  }
>>  EXPORT_SYMBOL_GPL(fwnode_create_software_node);
>>  
>> +/**
>> + * fwnode_remove_software_node() - Put a reference to a registered software_node
>> + * @fwnode: The pointer to the &struct fwnode_handle you want to release
>> + *
>> + * Release a reference to a registered &struct software_node. This function
>> + * differs from software_node_put() in that it takes no action if the
>> + * fwnode_handle passed to @fwnode turns out not to have been created by
>> + * registering a software_node
> Period at the end.
>
> I'm a bit confused by amount of fwnode_handle in the comments, can you replace
> them with better approach depending on the case:
> - &struct fwnode_handle
> - a parameter as @fwnode or so
> - a general mention (better to use plain English here, something like firmware
>   node handle or so)
Yeah ok, I was trying to do &struct fwnode_handle on the first reference
(or at least earliest that it would fit) and then fwnode_handle
thereafter, but I think I like the suggestion to drop to plain English
at that point instead, so I'll do that (and ditto for software_node /
software node)
