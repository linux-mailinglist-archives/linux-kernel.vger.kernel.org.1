Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5647A2B71D6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgKQWwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:52:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:12193 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729377AbgKQWwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:52:36 -0500
IronPort-SDR: hYHoRbsSbCSABdWQO5LHJhpa1B1EAeHMKNveoYbDiVHux//lyeLGTwJ4SnIr5EdyJ8ihs+jw1Q
 HgF6hnAWlb7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="255738589"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="255738589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 14:52:35 -0800
IronPort-SDR: VfEzHyyvJ0e/p97hww3lasn37tddRl29gSgLoHHGVIDaY1ygMr9O4akyGC2lL6RtEC6wbZTJ09
 BAOY2VEpSQKg==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430611760"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.24.101]) ([10.212.24.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 14:52:34 -0800
Subject: Re: [PATCH 08/24] x86/resctrl: Walk the resctrl schema list instead
 of an arch list
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-9-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <cb95b485-4d34-fa88-7c66-2d4d6fc62b5d@intel.com>
Date:   Tue, 17 Nov 2020 14:52:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-9-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/30/2020 9:11 AM, James Morse wrote:
> Now that resctrl has its own list of resources it is using, walk that
> list instead of the architectures list. This means resctrl has somewhere
> to keep schema properties with the resource that is using them.
> 
> Most users of for_each_alloc_enabled_rdt_resource() are per-schema,
> and also want a schema property, like the conf_type. Switch these to
> walk the schema list. Schema were only created for alloc_enabled
> resources so these two lists are currently equivalent.
> 

 From what I understand based on this description the patch will 
essentially change instances of for_each_alloc_enabled_rdt_resource() to 
walking the schema list ....

> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 38 ++++++++++++++---------
>   arch/x86/kernel/cpu/resctrl/internal.h    |  6 ++--
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 34 +++++++++++++-------
>   include/linux/resctrl.h                   |  5 +--
>   4 files changed, 53 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 8ac104c634fe..d3f9d142f58a 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -57,9 +57,10 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>   	return true;
>   }
>   
> -int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
> +int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>   	     struct rdt_domain *d)
>   {
> +	struct rdt_resource *r = s->res;
>   	unsigned long bw_val;
>   
>   	if (d->have_new_ctrl) {

... this change and also the ones to parse_cbm() and 
rdtgroup_cbm_overlaps() are not clear to me because it seems they 
replace the rdt_resource parameter with resctrl_schema, but all in turn 
use that to access rdt_resource again. That seems unnecessary?

> @@ -125,10 +126,11 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>    * Read one cache bit mask (hex). Check that it is valid for the current
>    * resource type.
>    */
> -int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
> +int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>   	      struct rdt_domain *d)
>   {
>   	struct rdtgroup *rdtgrp = data->rdtgrp;
> +	struct rdt_resource *r = s->res;
>   	u32 cbm_val;
>   
>   	if (d->have_new_ctrl) {

Really needed?

> @@ -160,12 +162,12 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
>   	 * The CBM may not overlap with the CBM of another closid if
>   	 * either is exclusive.
>   	 */
> -	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true)) {
> +	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, true)) {
>   		rdt_last_cmd_puts("Overlaps with exclusive group\n");
>   		return -EINVAL;
>   	}
>   
> -	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, false)) {
> +	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, false)) {
>   		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
>   		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>   			rdt_last_cmd_puts("Overlaps with other group\n");

Needed?

> @@ -185,9 +187,10 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
>    * separated by ";". The "id" is in decimal, and must match one of
>    * the "id"s for this resource.
>    */
> -static int parse_line(char *line, struct rdt_resource *r,
> +static int parse_line(char *line, struct resctrl_schema *s,
>   		      struct rdtgroup *rdtgrp)
>   {
> +	struct rdt_resource *r = s->res;
>   	struct rdt_parse_data data;
>   	char *dom = NULL, *id;
>   	struct rdt_domain *d;
> @@ -213,7 +216,8 @@ static int parse_line(char *line, struct rdt_resource *r,
>   		if (d->id == dom_id) {
>   			data.buf = dom;
>   			data.rdtgrp = rdtgrp;
> -			if (r->parse_ctrlval(&data, r, d))
> +
> +			if (r->parse_ctrlval(&data, s, d))
>   				return -EINVAL;
>   			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
>   	

needed?

			/*
> @@ -289,10 +293,12 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
>   	struct resctrl_schema *s;
>   	struct rdt_resource *r;
>   
> +	lockdep_assert_held(&rdtgroup_mutex);
> +

It is not clear how this addition fits into patch.

>   	list_for_each_entry(s, &resctrl_all_schema, list) {
>   		r = s->res;
>   		if (!strcmp(resname, r->name) && rdtgrp->closid < s->num_closid)
> -			return parse_line(tok, r, rdtgrp);
> +			return parse_line(tok, s, rdtgrp);
>   	}


needed? (similar comments to other changes in this patch but I will stop 
here)

>   	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
>   	return -EINVAL;

...


> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 628e5eb4d7a9..592a517afd6a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

...

> @@ -2832,14 +2840,18 @@ static void rdtgroup_init_mba(struct rdt_resource *r)
>   /* Initialize the RDT group's allocations. */
>   static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>   {
> +	struct resctrl_schema *s;
>   	struct rdt_resource *r;
>   	int ret;
>   
> -	for_each_alloc_enabled_rdt_resource(r) {
> +	lockdep_assert_held(&rdtgroup_mutex);
> +

Another addition that does not match patch description.

> +	list_for_each_entry(s, &resctrl_all_schema, list) {
> +		r = s->res;
>   		if (r->rid == RDT_RESOURCE_MBA) {
>   			rdtgroup_init_mba(r);
>   		} else {
> -			ret = rdtgroup_init_cat(r, rdtgrp->closid);
> +			ret = rdtgroup_init_cat(s, rdtgrp->closid);
>   			if (ret < 0)
>   				return ret;
>   		}
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 20d8b6dd4af4..8a12f4128209 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h

...

> @@ -171,7 +172,7 @@ struct rdt_resource {
>   
>   /**
>    * @list:	Member of resctrl's schema list
> - * @cdp_type:	Whether this entry is for code/data/both
> + * @conf_type:	Type of configuration, e.g. code/data/both
>    * @res:	The rdt_resource for this entry
>    * @num_closid	Number of CLOSIDs available for this resource
>    */
> 

This hunk can be merged with previous patch.

Reinette
