Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F195296587
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 21:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370433AbgJVTwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 15:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509834AbgJVTw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 15:52:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3311C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 12:52:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j5so1147995plk.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dm/6UU7gzYtewq70pBYmJhrFBt9p+uK9v/LY5XBQe8=;
        b=WdHQm9X1Ao2rROrM/DL9Ob5ETV5dcmcxbbi05C5ioxMtbjEFPu3amCoERC6BHS5ppC
         jUCpJ54iUYioZDSSbRWoRxCclHJU2JtZBbuzhQKlaoGfRi2P3C3aoYELYkdM3Ek82NIg
         /ql2TOC/FiXWF3ne/NQAZ463k3oht0RbEiVAsKFptqY+29o7VcNwnZHW3zobc8msa2X1
         zO5gOJQMcdg6oEVFJShVA7kglwRFhbHPbFKzO/ozeQPE39n/MLVVx9kgdzBxWcAPTbDC
         +1ZEfeuMQ8ZS2WXFxUtATlwTjKv7PedQHfi0mdzi0cs+G6RgmmJ67hNItyrWmZIM4FVf
         /Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dm/6UU7gzYtewq70pBYmJhrFBt9p+uK9v/LY5XBQe8=;
        b=mSDtHe2HT/TDwul4uwfg8nq/JTb70uTnyKITn06hapdmp4mD9cu31GSNT0lP694x4O
         USqWE7wmTeAtFW2Ucl8NQCQPpE9NUg12Wl0Rbk2DijajnKAjEzBvw/QGqZi2lyVBQ723
         QGAkV7F1YnJDOJ4p1UqTKW07wigw5wZdi0q2Uv6M+zdaCoBd1tb6zfVDaXZmwbqs0mko
         osp+ZtM9yzm/0Dnu0O6RkpCaD30lOeTckq9GKgp2UnWvi03W7ixxd15SRD6CeF81R0go
         WRmx0EiyJcVAf7MdDxG+O3loFHd201hc5MLyXDi3Qz7jFeHwyN/4MpU/1oOXHn8NX0MS
         uoCg==
X-Gm-Message-State: AOAM531yVmLU5FY4FemQ8jVXiAGYm1/uzzre5jkk41MRcs+K/CYEKWvw
        3qD4Fn9I/Pvz+t/91zF0z0IGPw==
X-Google-Smtp-Source: ABdhPJzjyClw+3ELYGBsJotUZeOWmDVypimCCUAzTRMpJKmazRpYQ3aDqmDvNYm9l9y12zeiB5Whew==
X-Received: by 2002:a17:902:d697:b029:d6:48f:2974 with SMTP id v23-20020a170902d697b02900d6048f2974mr3724561ply.30.1603396349196;
        Thu, 22 Oct 2020 12:52:29 -0700 (PDT)
Received: from hermes.local (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id b6sm2981568pjq.42.2020.10.22.12.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 12:52:28 -0700 (PDT)
Date:   Thu, 22 Oct 2020 12:52:20 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     David Ahern <dsahern@gmail.com>, Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        vivien.didelot@gmail.com, jiri@mellanox.com, idosch@idosch.org
Subject: Re: [RFC PATCH iproute2] bridge: add support for L2 multicast
 groups
Message-ID: <20201022125220.45c24b30@hermes.local>
In-Reply-To: <20201017184526.2333840-1-vladimir.oltean@nxp.com>
References: <20201017184526.2333840-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Oct 2020 21:45:26 +0300
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> Extend the 'bridge mdb' command for the following syntax:
> bridge mdb add dev br0 port swp0 grp 01:02:03:04:05:06 permanent
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  bridge/mdb.c                   | 54 ++++++++++++++++++++++++++--------
>  include/uapi/linux/if_bridge.h |  2 ++
>  2 files changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/bridge/mdb.c b/bridge/mdb.c
> index 4cd7ca762b78..af160250928e 100644
> --- a/bridge/mdb.c
> +++ b/bridge/mdb.c
> @@ -149,6 +149,7 @@ static void print_mdb_entry(FILE *f, int ifindex, const struct br_mdb_entry *e,
>  			    struct nlmsghdr *n, struct rtattr **tb)
>  {
>  	const void *grp, *src;
> +	const char *addr;
>  	SPRINT_BUF(abuf);
>  	const char *dev;
>  	int af;
> @@ -156,9 +157,16 @@ static void print_mdb_entry(FILE *f, int ifindex, const struct br_mdb_entry *e,
>  	if (filter_vlan && e->vid != filter_vlan)
>  		return;
>  
> -	af = e->addr.proto == htons(ETH_P_IP) ? AF_INET : AF_INET6;
> -	grp = af == AF_INET ? (const void *)&e->addr.u.ip4 :
> -			      (const void *)&e->addr.u.ip6;
> +	if (!e->addr.proto) {
> +		af = AF_PACKET;
> +		grp = (const void *)&e->addr.u.mac_addr;
> +	} else if (e->addr.proto == htons(ETH_P_IP)) {
> +		af = AF_INET;
> +		grp = (const void *)&e->addr.u.ip4;
> +	} else {
> +		af = AF_INET6;
> +		grp = (const void *)&e->addr.u.ip6;
> +	}
>  	dev = ll_index_to_name(ifindex);
>  

In C casts of pointer to void are not necessary.
