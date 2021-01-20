Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6A62FD60B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbhATQub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404029AbhATQuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:50:03 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A15C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=6IKRRpDmWrGXsWeUjOwmWUHp9M/DtWs3IFQqC64UYeA=; b=PQskdU2m1NvteqWZSDkWe2A4ti
        XBEqGuQ4Aw3E0+iInGPtPEeH96q4F/8OqjkhzNncIXoVggiBQLd35N0QWUxtKyybfmxdZGgE2NGs+
        5TGuY2bsrB0o0woToh7UHogF8FGmQGEjDcCXVxKa6KR7KlurTgEoAsABAzkTwtNWBSM56GpjizIGX
        NnUycYErMRc1uq/Icqdg+urbary8pBZfL8LQDyM99NfqAia8jlR6bwHkCYEM4yUfrL1g/8wHODZRO
        3Uys85xEqJf70g8SeCTRhgIb+sUHjYbUFepqhkuvQUiLL56PBNDM8vW+WTNgOEeAxFeRFm5IeDfQc
        oViXPOCw==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2GfX-0005mG-NP; Wed, 20 Jan 2021 16:49:20 +0000
Subject: Re: [PATCH] include: linux: Fix in two lines in the file list_lru.sh
 ,resposible -> responsible
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org
References: <20210120144628.3864652-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <937748e5-db00-eca4-2778-6acdeb73647b@infradead.org>
Date:   Wed, 20 Jan 2021 08:49:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210120144628.3864652-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 6:46 AM, Bhaskar Chowdhury wrote:
> s/resposible/responsible/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/list_lru.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index 9dcaa3e582c9..1b5fceb565df 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -146,7 +146,7 @@ typedef enum lru_status (*list_lru_walk_cb)(struct list_head *item,
>   * @lru: the lru pointer.
>   * @nid: the node id to scan from.
>   * @memcg: the cgroup to scan from.
> - * @isolate: callback function that is resposible for deciding what to do with
> + * @isolate: callback function that is responsible for deciding what to do with
>   *  the item currently being scanned
>   * @cb_arg: opaque type that will be passed to @isolate
>   * @nr_to_walk: how many items to scan.
> @@ -172,7 +172,7 @@ unsigned long list_lru_walk_one(struct list_lru *lru,
>   * @lru: the lru pointer.
>   * @nid: the node id to scan from.
>   * @memcg: the cgroup to scan from.
> - * @isolate: callback function that is resposible for deciding what to do with
> + * @isolate: callback function that is responsible for deciding what to do with
>   *  the item currently being scanned
>   * @cb_arg: opaque type that will be passed to @isolate
>   * @nr_to_walk: how many items to scan.
> --
> 2.30.0
> 


-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
