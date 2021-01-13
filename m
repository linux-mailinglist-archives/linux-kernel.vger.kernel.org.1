Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A392F4336
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbhAMEer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAMEer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:34:47 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5DCC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 20:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=8XxsXk2CVJdS4meW65Paa86/Y8/zYBRh1TkhkZFJ18A=; b=RhDkW+TEQ8NcoPn8tJIe0xU7Ei
        X5pKWuf8JtIwCpZCZu+SBlH7xIHuLg8Gs95b/8YygDH9q+h92OsuvVVv58NeqBdQhXL1+YcVFH+Wz
        7Nsa+Pt3GfOx+c/eCNZkifG2YIBfkR9arZXOYz6RRjg1p3uV/IjDw0Vj6x8SVSVBz6zXpkaTtXeJN
        cnr1AoOkXl+YFQ3ZoxpFG6pyu6GOmSDUmzUnBOLbjvVpuWgeGuAxjyAqvbBtTI2U4ONE710SqE5n1
        36/vHP3ZxaU5zzGji8U8Bfr6rgONpZxh/aDbswpvILz4XmpYMAAAUVADim0yCHSS1mnzU576yyTnS
        t1zkSiyA==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzXr6-0005F6-9v; Wed, 13 Jan 2021 04:34:00 +0000
Subject: Re: [PATCH] cpuset: fix typos in comments
To:     Aubrey Li <aubrey.li@intel.com>, lizefan@huawei.com, tj@kernel.org,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
References: <1610512661-135383-1-git-send-email-aubrey.li@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <df087a62-ae0d-d7f9-890c-792adabfc77a@infradead.org>
Date:   Tue, 12 Jan 2021 20:33:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1610512661-135383-1-git-send-email-aubrey.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 8:37 PM, Aubrey Li wrote:
> Change hierachy to hierarchy and congifured to configured, no functionality
> changed.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  kernel/cgroup/cpuset.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 57b5b5d..15f4300 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -98,7 +98,7 @@ struct cpuset {
>  	 * and if it ends up empty, it will inherit the parent's mask.
>  	 *
>  	 *
> -	 * On legacy hierachy:
> +	 * On legacy hierarchy:
>  	 *
>  	 * The user-configured masks are always the same with effective masks.
>  	 */
> @@ -1286,10 +1286,10 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
>   * @cs:  the cpuset to consider
>   * @tmp: temp variables for calculating effective_cpus & partition setup
>   *
> - * When congifured cpumask is changed, the effective cpumasks of this cpuset
> + * When configured cpumask is changed, the effective cpumasks of this cpuset
>   * and all its descendants need to be updated.
>   *
> - * On legacy hierachy, effective_cpus will be the same with cpu_allowed.
> + * On legacy hierarchy, effective_cpus will be the same with cpu_allowed.
>   *
>   * Called with cpuset_mutex held
>   */
> 


-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
