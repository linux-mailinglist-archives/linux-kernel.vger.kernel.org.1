Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD85A1AB111
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436722AbgDOTJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 15:09:30 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15686 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416827AbgDOSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:34:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9753550000>; Wed, 15 Apr 2020 11:32:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 11:34:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 Apr 2020 11:34:43 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 18:34:42 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 15 Apr 2020 18:34:42 +0000
Subject: Re: [PATCH] mm/compaction: Fix a typo in comment
 "pessemistic"->"pessimistic"
To:     Ethon Paul <ethp@qq.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200411070307.16021-1-ethp@qq.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <9e306efd-73e3-7ccd-f970-e2044200d2a2@nvidia.com>
Date:   Wed, 15 Apr 2020 11:34:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200411070307.16021-1-ethp@qq.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586975573; bh=Vtu8bQjFKjMQLAGC8dbeG50/F5cJomR9NAcc1xjXS4s=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qt6TN8I+U8mxhBhzkOJSdUtb2XTVsKUCkY3OckV/dvIkogluli7+F/nBxZZnu6+50
         7UL6gQ8FYD091s3SGYHQFR/iqL8/DbqZKBveSkNxSeZdBFChMC2j/Nz255snfIsHJN
         VoTk2ewMGDOx6xym9BRiYiBcbDR5/WL9o991YthkXGsB/yvOqVGdUmvmRdV16eycWP
         gIKZCNewbFVax1MO04zbpuLyJ9tTK8RIamxbRR5at9p91m6+m+/2uRSe/LLtaARnzE
         nKOwaaAJRvLGb/Y1nnkW8NIZyvttWWb6AIcqbbX5+Qt9NTABPwvkPtqXH9yIaYwlta
         A5bNRAzpf9xaw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/20 12:03 AM, Ethon Paul wrote:
> There is a typo in comment, fix it.
> 
> Signed-off-by: Ethon Paul <ethp@qq.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/compaction.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 46f0fcc93081..17e41b43db4f 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1401,7 +1401,7 @@ fast_isolate_freepages(struct compact_control *cc)
>   		if (scan_start) {
>   			/*
>   			 * Use the highest PFN found above min. If one was
> -			 * not found, be pessemistic for direct compaction
> +			 * not found, be pessimistic for direct compaction
>   			 * and use the min mark.
>   			 */
>   			if (highest) {
> 
