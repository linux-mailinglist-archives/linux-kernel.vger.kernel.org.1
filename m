Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673C52D6947
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393891AbgLJVA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 16:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgLJVAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:00:04 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D4C0613CF;
        Thu, 10 Dec 2020 12:59:24 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id o17so7320542lfg.4;
        Thu, 10 Dec 2020 12:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L+2kq/mn/GAqmqkIcbgr9LNeg9Bhva26hFZF9Y+zYOc=;
        b=A2O2xoYnYD6LKvIJNY87qFGg5SGAPNyjXyluJ+/UKQl+J7/ESPcVH+WB+JD6mVL6r8
         BVj8q+zYaJ579OYuL7ociaLxK2FqP7yegH/wjAe4RO6kOtEOpsR/XxV3h1roJrTTc66I
         febq8qYC+GVuJxmZn++rUhIvwGhzMaaMjsGb/KESkDZdHtVLYdqPN6+fMb+iFto9dLLs
         kZR+wYKyJI2vhZcW9MEizjJkdpteOWTLwgRlmuh6/fyzpnaP1OsWd0lMunGNY3ZUT9yl
         KnVIEK0kKhEfFFUN/TTnjASiwwF4bMaAJdVWK0tA7f2pzJO3cPHgX9Iv2guyK3Y87kGE
         DL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L+2kq/mn/GAqmqkIcbgr9LNeg9Bhva26hFZF9Y+zYOc=;
        b=tI9cVhZVLS3XmF50BMIXh+DTrWA5oDEuzRK+PfGHZHbyACqtVfQyCOgmsjNJfs77PL
         tTq7Ul7/cJu9WiPGPHnEbLEE6jKZFZ6roe31tI11ZDsQxz47Ws3E3x6IMvK+5/jH8SYj
         i4W2ZcbU/sRsQ9vpjkx6j4huc6rv8e9EIr2TEnPoeWedZQQNY1DFiEBfxlG9vbM5eSNq
         zQwuPqNAl1qwy9oEshNVlJOt7btloMrFtX1upE6v6NEu/TefyS/+U5vlkGIenSCrDZ7w
         55Z/P8dgnmZHKIzo7iIMT5PKd5j2DcprXOBaLxBEqGD4XZtyN0Tnwvl70n4+fsBkUT5U
         42ag==
X-Gm-Message-State: AOAM531jj73KYXahVel407KwAc6+LRYlAjFmITKqritHIVJoG72YYb1R
        qmxsiW+ox2fkWNAtLnVDMsE=
X-Google-Smtp-Source: ABdhPJyBMknhNz6xYU4ZCi12CSdIk+VQd8R9a0xiFyGovgfVRlVVXl3oi2RWtuH+1Iba/mt/xTj74g==
X-Received: by 2002:a19:3f47:: with SMTP id m68mr3577297lfa.494.1607633962817;
        Thu, 10 Dec 2020 12:59:22 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-205.dynamic.spd-mgts.ru. [109.252.193.205])
        by smtp.googlemail.com with ESMTPSA id w6sm590100lji.74.2020.12.10.12.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:59:22 -0800 (PST)
Subject: Re: [PATCH 1/2] of: property: Get rid of code duplication in port
 getting
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20201210202944.6747-1-semen.protsenko@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f18dea6e-5806-370c-0d83-e56f3dc118b4@gmail.com>
Date:   Thu, 10 Dec 2020 23:59:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201210202944.6747-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2020 23:29, Sam Protsenko пишет:
> Both of_graph_is_present() and of_graph_get_next_endpoint() functions
> share common piece of code for obtaining the graph port. Extract it into
> separate static function to get rid of code duplication and avoid
> possible coding errors in future.
> 
> Fixes: 4ec0a44ba8d7 ("of_graph: add of_graph_is_present()")

The "fixes" tag should be used only for bug-fixes and there is no bug
fixed in this patch.

> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/of/property.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 408a7b5f06a9..da111fcf37ac 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -30,13 +30,13 @@
>  #include "of_private.h"
>  
>  /**
> - * of_graph_is_present() - check graph's presence
> + * of_graph_get_port - find the "port" node in a given node
>   * @node: pointer to device_node containing graph port
>   *
> - * Return: True if @node has a port or ports (with a port) sub-node,
> - * false otherwise.
> + * Return: A 'port' node pointer with refcount incremented if found or NULL
> + * otherwise. The caller has to use of_node_put() on it when done.
>   */
> -bool of_graph_is_present(const struct device_node *node)
> +static struct device_node *of_graph_get_port(const struct device_node *node)
>  {
>  	struct device_node *ports, *port;
>  
> @@ -46,8 +46,22 @@ bool of_graph_is_present(const struct device_node *node)
>  
>  	port = of_get_child_by_name(node, "port");
>  	of_node_put(ports);
> -	of_node_put(port);
>  
> +	return port;
> +}
> +
> +/**
> + * of_graph_is_present() - check graph's presence
> + * @node: pointer to device_node containing graph port
> + *
> + * Return: True if @node has a port or ports (with a port) sub-node,
> + * false otherwise.
> + */
> +bool of_graph_is_present(const struct device_node *node)
> +{
> +	struct device_node *port = of_graph_get_port(node);
> +
> +	of_node_put(port);
>  	return !!port;
>  }
>  EXPORT_SYMBOL(of_graph_is_present);
> @@ -631,15 +645,7 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
>  	 * parent port node.
>  	 */
>  	if (!prev) {
> -		struct device_node *node;
> -
> -		node = of_get_child_by_name(parent, "ports");
> -		if (node)
> -			parent = node;
> -
> -		port = of_get_child_by_name(parent, "port");
> -		of_node_put(node);
> -
> +		port = of_graph_get_port(parent);
>  		if (!port) {
>  			pr_err("graph: no port node found in %pOF\n", parent);
>  			return NULL;
> 

This repeats the problem which was made once before:

https://lore.kernel.org/patchwork/patch/1266028/#1461493
