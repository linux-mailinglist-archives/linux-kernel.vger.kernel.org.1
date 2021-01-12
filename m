Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697522F28A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391812AbhALHD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:03:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:49028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391531AbhALHD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:03:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610434991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ig/BzfwIsrlPajsj3oElCG90RaaTlGpS+pt8s/fcBI=;
        b=A+Jthmoc0Sgvqf0+XpBapP/4WObyv+kjOe4Pvmkz8/5nZ+ThYcTuplMRY6GLP0pVG/nk9q
        42f5VDCS47iJbDbEjiLiCLIM0CL8ZzIV+NWdokvawQw8qg9la3z35ylKMwGd7Ac2Q89wac
        qcBWHO2Nl6TLU+65yFVxNkkpnCtZdAQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4E3AAB92;
        Tue, 12 Jan 2021 07:03:11 +0000 (UTC)
Date:   Tue, 12 Jan 2021 08:03:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: vmscan: support equal reclaim for anon and file pages
Message-ID: <20210112070310.GE22493@dhcp22.suse.cz>
References: <c617a0c6cb2a7e3bc78998ad7e2bceb22df157c2.1610398598.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c617a0c6cb2a7e3bc78998ad7e2bceb22df157c2.1610398598.git.sudaraja@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-01-21 12:58:43, Sudarshan Rajagopalan wrote:
> When performing memory reclaim support treating anonymous and
> file backed pages equally.
> Swapping anonymous pages out to memory can be efficient enough
> to justify treating anonymous and file backed pages equally.

This changelog doesn't explain, what kind of problem you are trying to
address, why the existing code and tunables are insufficient, how it is
supposed to work, what are potential risks, what kind of testing have
you done and more.

Please have a look at Documentation/process/submitting-patches.rst for
more guidance about expectations from a patch when it is submitted.
 
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/vmscan.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 257cba79a96d..ec7585e0d5f5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -169,6 +169,8 @@ struct scan_control {
>   */
>  int vm_swappiness = 60;
>  
> +bool balance_anon_file_reclaim = false;
> +
>  static void set_task_reclaim_state(struct task_struct *task,
>  				   struct reclaim_state *rs)
>  {
> @@ -201,6 +203,13 @@ static DECLARE_RWSEM(shrinker_rwsem);
>  static DEFINE_IDR(shrinker_idr);
>  static int shrinker_nr_max;
>  
> +static int __init cmdline_parse_balance_reclaim(char *p)
> +{
> +	balance_anon_file_reclaim = true;
> +	return 0;
> +}
> +early_param("balance_reclaim", cmdline_parse_balance_reclaim);
> +
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
>  	int id, ret = -ENOMEM;
> @@ -2291,9 +2300,11 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  
>  	/*
>  	 * If there is enough inactive page cache, we do not reclaim
> -	 * anything from the anonymous working right now.
> +	 * anything from the anonymous working right now. But when balancing
> +	 * anon and page cache files for reclaim, allow swapping of anon pages
> +	 * even if there are a number of inactive file cache pages.
>  	 */
> -	if (sc->cache_trim_mode) {
> +	if (!balance_anon_file_reclaim && sc->cache_trim_mode) {
>  		scan_balance = SCAN_FILE;
>  		goto out;
>  	}
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
Michal Hocko
SUSE Labs
