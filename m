Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9CF212078
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgGBKBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 06:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgGBKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:01:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC07FC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 03:01:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so26083539wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=P8VRDASVxiHXInnBJtuHCeHYaC40885qiMW2neBVGgE=;
        b=QS1Ajp3cV7aOZj2W/e8M7r19JKqzcKjR9Nbbui47IRXJsgYLKZYFd18KBNAHM/1Xh6
         kKAurfe2x5ZGNsjp8VGOXf+rzXBnax/oYbBY3V1KXhHZ/Ay6pwqSM9xwHMcsAE2ii8FD
         7mScoEd8ZomV9oC0vYU/2nLHjjQ9QMnePWuo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P8VRDASVxiHXInnBJtuHCeHYaC40885qiMW2neBVGgE=;
        b=FnUYFXRUXyhA1Qpl93guK/P4ABM7/An19hg2wsEKrY3GMmCVVHrZPuzTUVu3KX0Tf+
         mvWkrZ8etds4t7sQDfdff/3Tc/K1CiiyvY67TZkGacWR3F60jLeLQB3sOTGYclJeKJiY
         j7ZL1tyxqLcB13+AyNLL9kj9IRzYgWHvCLZcVvAC93dfrdnzNb0bclseQSXkp38jrukN
         Y5oZInJ+RW/faoBFm+1MfLjFiQbkAYjhMT87TDIPSJXiVhK2AlRSwlrlVTuJk6uTTYnY
         M+IzXv31cUDIf5E5pnHq63gNlnlFaZF6DRYvBrq+iACznNIT/Jli0lf5pSMj3WyakO/4
         2xgQ==
X-Gm-Message-State: AOAM5331FKJFBwPC9amJQru7PM5ZtQb7ZIbtEi+NLqUVWEkHrEfaZMXo
        qyHudgQLZYH6qFltVUmNt10FkQ==
X-Google-Smtp-Source: ABdhPJzhkVTUIaRQdXBalg5IODovnlwavdJDf81WJwJeMaH242RWoZQ3g+wpVdJ5oER726YW8k2Egg==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr23750275wml.120.1593684090438;
        Thu, 02 Jul 2020 03:01:30 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id g195sm10340168wme.38.2020.07.02.03.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 03:01:27 -0700 (PDT)
Subject: Re: [PATCH net-next v3 1/3] bridge: uapi: mrp: Extend MRP attributes
 to get the status
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        jiri@mellanox.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
        UNGLinuxDriver@microchip.com
References: <20200702081307.933471-1-horatiu.vultur@microchip.com>
 <20200702081307.933471-2-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <4b46f59a-2676-6efd-fddf-c0fcbebdce0f@cumulusnetworks.com>
Date:   Thu, 2 Jul 2020 13:01:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702081307.933471-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2020 11:13, Horatiu Vultur wrote:
> Add MRP attribute IFLA_BRIDGE_MRP_INFO to allow the userspace to get the
> current state of the MRP instances. This is a nested attribute that
> contains other attributes like, ring id, index of primary and secondary
> port, priority, ring state, ring role.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/uapi/linux/if_bridge.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index caa6914a3e53a..c114c1c2bd533 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -166,6 +166,7 @@ enum {
>  	IFLA_BRIDGE_MRP_RING_STATE,
>  	IFLA_BRIDGE_MRP_RING_ROLE,
>  	IFLA_BRIDGE_MRP_START_TEST,
> +	IFLA_BRIDGE_MRP_INFO,
>  	__IFLA_BRIDGE_MRP_MAX,
>  };
>  
> @@ -228,6 +229,22 @@ enum {
>  
>  #define IFLA_BRIDGE_MRP_START_TEST_MAX (__IFLA_BRIDGE_MRP_START_TEST_MAX - 1)
>  
> +enum {
> +	IFLA_BRIDGE_MRP_INFO_UNSPEC,
> +	IFLA_BRIDGE_MRP_INFO_RING_ID,
> +	IFLA_BRIDGE_MRP_INFO_P_IFINDEX,
> +	IFLA_BRIDGE_MRP_INFO_S_IFINDEX,
> +	IFLA_BRIDGE_MRP_INFO_PRIO,
> +	IFLA_BRIDGE_MRP_INFO_RING_STATE,
> +	IFLA_BRIDGE_MRP_INFO_RING_ROLE,
> +	IFLA_BRIDGE_MRP_INFO_TEST_INTERVAL,
> +	IFLA_BRIDGE_MRP_INFO_TEST_MAX_MISS,
> +	IFLA_BRIDGE_MRP_INFO_TEST_MONITOR,
> +	__IFLA_BRIDGE_MRP_INFO_MAX,
> +};
> +
> +#define IFLA_BRIDGE_MRP_INFO_MAX (__IFLA_BRIDGE_MRP_INFO_MAX - 1)
> +
>  struct br_mrp_instance {
>  	__u32 ring_id;
>  	__u32 p_ifindex;
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

