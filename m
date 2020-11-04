Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C122A5FC1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgKDIj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:39:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:36704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgKDIj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:39:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604479194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=syUOeZVis/mCwu8fd3UHVg+xOCzGMKG+bwd8HAGySfQ=;
        b=m0Cd64umG8ekm2e4xzXb1VdFG7hZa8TCyBpftGpns6wGN0PMRrsJ0NBX4AmlpaVZLIv3OH
        NLIWU7sciCIMKrmJWSv+rlmbktjWLPEYtEkk6UYrfeOIuk2qNdziQdGRnGZBx/bzp48hD+
        EYx+lARTS7an1MOFV//1Hfuy5GjM76g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAEA3AC2E;
        Wed,  4 Nov 2020 08:39:54 +0000 (UTC)
Date:   Wed, 4 Nov 2020 09:39:53 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH rfc 2/3] docs: cgroup-v1: reflect the deprecation of the
 non-hierarchical mode
Message-ID: <20201104083953.GD10052@dhcp22.suse.cz>
References: <20201103212725.3716088-1-guro@fb.com>
 <20201103212725.3716088-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103212725.3716088-3-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-11-20 13:27:24, Roman Gushchin wrote:
> Update cgroup v1 docs after the deprecation of the non-hierarchical
> mode of the memory controller.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  .../admin-guide/cgroup-v1/memcg_test.rst      |  8 ++--
>  .../admin-guide/cgroup-v1/memory.rst          | 40 ++++++-------------
>  2 files changed, 16 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
> index 3f7115e07b5d..4f83de2dab6e 100644
> --- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
> @@ -219,13 +219,11 @@ Under below explanation, we assume CONFIG_MEM_RES_CTRL_SWAP=y.
>  
>  	This is an easy way to test page migration, too.
>  
> -9.5 mkdir/rmdir
> ----------------
> +9.5 nested cgroups
> +------------------
>  
> -	When using hierarchy, mkdir/rmdir test should be done.
> -	Use tests like the following::
> +	Use tests like the following for testing nested cgroups::
>  
> -		echo 1 >/opt/cgroup/01/memory/use_hierarchy
>  		mkdir /opt/cgroup/01/child_a
>  		mkdir /opt/cgroup/01/child_b
>  
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index 12757e63b26c..a44cd467d218 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -77,6 +77,8 @@ Brief summary of control files.
>   memory.soft_limit_in_bytes	     set/show soft limit of memory usage
>   memory.stat			     show various statistics
>   memory.use_hierarchy		     set/show hierarchical account enabled
> +                                     This knob is deprecated and shouldn't be
> +                                     used.
>   memory.force_empty		     trigger forced page reclaim
>   memory.pressure_level		     set memory pressure notifications
>   memory.swappiness		     set/show swappiness parameter of vmscan
> @@ -495,16 +497,13 @@ cgroup might have some charge associated with it, even though all
>  tasks have migrated away from it. (because we charge against pages, not
>  against tasks.)
>  
> -We move the stats to root (if use_hierarchy==0) or parent (if
> -use_hierarchy==1), and no change on the charge except uncharging
> +We move the stats to parent, and no change on the charge except uncharging
>  from the child.
>  
>  Charges recorded in swap information is not updated at removal of cgroup.
>  Recorded information is discarded and a cgroup which uses swap (swapcache)
>  will be charged as a new owner of it.
>  
> -About use_hierarchy, see Section 6.
> -
>  5. Misc. interfaces
>  ===================
>  
> @@ -527,8 +526,6 @@ About use_hierarchy, see Section 6.
>    write will still return success. In this case, it is expected that
>    memory.kmem.usage_in_bytes == memory.usage_in_bytes.
>  
> -  About use_hierarchy, see Section 6.
> -
>  5.2 stat file
>  -------------
>  
> @@ -675,31 +672,20 @@ hierarchy::
>  		      d   e
>  
>  In the diagram above, with hierarchical accounting enabled, all memory
> -usage of e, is accounted to its ancestors up until the root (i.e, c and root),
> -that has memory.use_hierarchy enabled. If one of the ancestors goes over its
> -limit, the reclaim algorithm reclaims from the tasks in the ancestor and the
> -children of the ancestor.
> -
> -6.1 Enabling hierarchical accounting and reclaim
> -------------------------------------------------
> -
> -A memory cgroup by default disables the hierarchy feature. Support
> -can be enabled by writing 1 to memory.use_hierarchy file of the root cgroup::
> +usage of e, is accounted to its ancestors up until the root (i.e, c and root).
> +If one of the ancestors goes over its limit, the reclaim algorithm reclaims
> +from the tasks in the ancestor and the children of the ancestor.
>  
> -	# echo 1 > memory.use_hierarchy
> -
> -The feature can be disabled by::
> +6.1 Hierarchical accounting and reclaim
> +---------------------------------------
>  
> -	# echo 0 > memory.use_hierarchy
> +Hierarchical accounting is enabled by default. Disabling the hierarchical
> +accounting is deprecated. An attempt to do it will result in a failure
> +and a warning printed to dmesg.
>  
> -NOTE1:
> -       Enabling/disabling will fail if either the cgroup already has other
> -       cgroups created below it, or if the parent cgroup has use_hierarchy
> -       enabled.
> +For compatibility reasons writing 1 to memory.use_hierarchy will always pass::
>  
> -NOTE2:
> -       When panic_on_oom is set to "2", the whole system will panic in
> -       case of an OOM event in any cgroup.
> +	# echo 1 > memory.use_hierarchy
>  
>  7. Soft limits
>  ==============
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
