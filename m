Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEB9286D01
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 05:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgJHDGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 23:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgJHDGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 23:06:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D0AC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 20:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=3AjzqtRcwvSiJW2QxFTWdSmOmP7b9unbrKUDTbWTrtM=; b=VMugKjCMbcH4d1jqf3dCfL4AXA
        jNbXiA5XqGv5XHIdU5/5y8Ix99PhqoVcIYyytS57koWg3io6PqVI4KQsz0STfR4viOjPzcRspXxv+
        xMGw04ined0DUCIXOl1N4a3jx1HlRktNDmv7Rq4t8ZUy2pTNmZzS/fNjKMVPNZb0Wri5+ERwelelC
        n1Omtud46kf/E39JfQMNG1rBHo3h9QhwxJIhDvlFoc/2lo0pAOZ+r/R2HlpCAW8nwh7fu25mfOVDb
        /Qp5jRXGj63OD9u1NSxfMr6wshQ8vvN19NElaY7nyESspg8PYSS5lMjhM3k7M042Zw24shN2ySlEM
        0zlWXX6g==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQMFk-0005V9-5n; Thu, 08 Oct 2020 03:06:00 +0000
Subject: Re: [PATCH] kprobes: Correct a type error in function
 kprobes_module_callback
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org
References: <1602125965-31698-1-git-send-email-zhouzhouyi@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1e7d9b9a-b90b-48c5-1fd9-51244b843507@infradead.org>
Date:   Wed, 7 Oct 2020 20:05:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1602125965-31698-1-git-send-email-zhouzhouyi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/20 7:59 PM, Zhouyi Zhou wrote:
> There is a tiny type error in comment of function kprobes_module_callback.

Preferable
                  typo
and same in $Subject.

'type' usually means data type or maybe typedef, or even
font or typeface.

I suppose you could say a "typing" error (as in using a typewriter
or keyboard).

> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
>  kernel/kprobes.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index e995541..9d2042b 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2432,7 +2432,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
>  			     within_module_core((unsigned long)p->addr, mod))) {
>  				/*
>  				 * The vaddr this probe is installed will soon
> -				 * be vfreed buy not synced to disk. Hence,
> +				 * be vfreed but not synced to disk. Hence,
>  				 * disarming the breakpoint isn't needed.
>  				 *
>  				 * Note, this will also move any optimized probes
> 

thanks.
-- 
~Randy

