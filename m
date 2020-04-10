Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868A01A49F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 20:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDJSme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 14:42:34 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5676 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJSme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 14:42:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e90bde30000>; Fri, 10 Apr 2020 11:41:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Apr 2020 11:42:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Apr 2020 11:42:34 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 18:42:34 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 18:42:33 +0000
Subject: Re: [PATCH] mm/hugetlb: Fix a typo in comment
 "manitained"->"maintained"
To:     Ethon Paul <ethp@qq.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200410163714.14085-1-ethp@qq.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <6757f060-01c4-0537-4f65-bee8d976c674@nvidia.com>
Date:   Fri, 10 Apr 2020 11:42:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200410163714.14085-1-ethp@qq.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586544099; bh=alXjR5apJ6IGBNMLipRDOXvMLkGDAqFY11Nil4Xo2iY=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MlIBNK2d+MDf9Qaqr5ZTB05BXejOF3xyre3rK7X6015ItpkQEzMVxjFJtAftTeQJ5
         P+0kbskZSWl/QbyB3Gkszn90PzFh+YAp9M9Ydouhzdf8aXubfuqjO8H6FeYsQvBDU3
         BzczDBuKcz2DMJB/n5gADEL2v2JsBSOzFlEDX3vcJHH5HDMoo8PoSXJXuLFMInwaIx
         Btb96gi62DZSfTkTWVdGeBUevwxUKPmFcDMlLVkB/r+Nf/dqkh+x7i2uoLvQP084/W
         UHau4Kgq2wVS9VSVvEyRzmI4P20z0BLlzdDwT1hpZDj/Y1CkBxmUz+Ya/HN1PgOOyy
         6QEz988bVs/uA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/20 9:37 AM, Ethon Paul wrote:
> There is a typo in comment, fix it.
> 
> Signed-off-by: Ethon Paul <ethp@qq.com>

Looks good but you could add a few more fixes for typos below.
Either way,
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/hugetlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f5fb53fdfa02..8c979854c0a0 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -129,7 +129,7 @@ void hugepage_put_subpool(struct hugepage_subpool *spool)
>    * the request.  Otherwise, return the number of pages by which the
>    * global pools must be adjusted (upward).  The returned value may
>    * only be different than the passed value (delta) in the case where
> - * a subpool minimum size must be manitained.
> + * a subpool minimum size must be maintained.
>    */
>   static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
>   				      long delta)
> 

line 83, s/mased on/based on
line 472, s/ruturns/returns
line 987, s/reverves/reserves
line 1489, s/ Otherwse/Otherwise,
line 4431, s/a active/an active
