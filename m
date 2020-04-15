Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A72B1AB0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 20:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438068AbgDOSax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 14:30:53 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15525 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405377AbgDOSaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:30:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9752670002>; Wed, 15 Apr 2020 11:28:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 11:30:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 Apr 2020 11:30:44 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 18:30:44 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 15 Apr 2020 18:30:44 +0000
Subject: Re: [PATCH] mm/list_lru: Fix a typo in comment "numbesr"->"numbers"
To:     Ethon Paul <ethp@qq.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200411071041.16161-1-ethp@qq.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <26e00d36-1745-fdc4-14b2-c190fc9d7d8f@nvidia.com>
Date:   Wed, 15 Apr 2020 11:30:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200411071041.16161-1-ethp@qq.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586975335; bh=pyrf/yGITMuGDCWqp198q+4VK0n1pJc2Po2TKT0z9uw=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lT/jSRY3utdgd4OmQhs69ibQDKkP1ogCZRq5yCB3Pln33ny4X7WsNVkKxfBY5c5kZ
         P7rjpuQ2uKNNIRr3ZxNIXPbjckm1iZqimLf/pU4ZG4QCf6fcZ/+DlJIIee2v9Yphlw
         8QmWVfHOWZBcf5nyhzZ2lMXqm25X3vYGMZa6JseFR3o7IQfBtX+oP1giA8ijkw/L+M
         m9x8aL8rkHgAfCxetXkI7DH/tREsfUkKjVWINmGVHepbd07P+IHJ1zmu72ZFEsJgZG
         C38Si68Intra4X9p0w30zsX1uV/dhT4KnL4tX+SmGVUyRQLHLoL0VvfAHS2snZD3Ry
         wj668LhUlA7vQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/20 12:10 AM, Ethon Paul wrote:
> There is a typo in comment, fix it.
> 
> Signed-off-by: Ethon Paul <ethp@qq.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/list_lru.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 4d5294c39bba..9222910ab1cb 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -213,7 +213,7 @@ __list_lru_walk_one(struct list_lru_node *nlru, int memcg_idx,
>   
>   		/*
>   		 * decrement nr_to_walk first so that we don't livelock if we
> -		 * get stuck on large numbesr of LRU_RETRY items
> +		 * get stuck on large numbers of LRU_RETRY items
>   		 */
>   		if (!*nr_to_walk)
>   			break;
> 
