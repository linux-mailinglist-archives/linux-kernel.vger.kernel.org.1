Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C64303298
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 04:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbhAYJis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:38:48 -0500
Received: from foss.arm.com ([217.140.110.172]:44244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbhAYJ1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:27:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 847D61042;
        Mon, 25 Jan 2021 01:26:28 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66B323F66B;
        Mon, 25 Jan 2021 01:26:27 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "mingo\@kernel.org" <mingo@kernel.org>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann\@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen\@arm.com" <morten.rasmussen@arm.com>,
        "mgorman\@suse.de" <mgorman@suse.de>
Subject: RE: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set for the deduplicating sort
In-Reply-To: <bfb703294b234e1e926a68fcb73dbee3@hisilicon.com>
References: <20210122123943.1217-1-valentin.schneider@arm.com> <20210122123943.1217-2-valentin.schneider@arm.com> <bfb703294b234e1e926a68fcb73dbee3@hisilicon.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Mon, 25 Jan 2021 09:26:25 +0000
Message-ID: <jhj1re92wqm.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/21 02:23, Song Bao Hua (Barry Song) wrote:

> with the below topology:
> qemu-system-aarch64 -M virt -nographic \
>  -smp cpus=8 \
>  -numa node,cpus=0-1,nodeid=0 \
>  -numa node,cpus=2-3,nodeid=1 \
>  -numa node,cpus=4-5,nodeid=2 \
>  -numa node,cpus=6-7,nodeid=3 \
>  -numa dist,src=0,dst=1,val=12 \
>  -numa dist,src=0,dst=2,val=20 \
>  -numa dist,src=0,dst=3,val=22 \
>  -numa dist,src=1,dst=2,val=22 \
>  -numa dist,src=2,dst=3,val=12 \
>  -numa dist,src=1,dst=3,val=24 \
>
>
> The panic address is *1294:
>
>                         if (sdd->sd) {
>     1280:       f9400e61        ldr     x1, [x19, #24]
>     1284:       b4000201        cbz     x1, 12c4 <build_sched_domains+0x414>
>                                 sd = *per_cpu_ptr(sdd->sd, j);
>     1288:       93407eb7        sxtw    x23, w21
>     128c:       aa0103e0        mov     x0, x1
>     1290:       f8777ac2        ldr     x2, [x22, x23, lsl #3]
>     *1294:       f8626800        ldr     x0, [x0, x2]
>                                 if (sd && (sd->flags & SD_OVERLAP))
>     1298:       b4000120        cbz     x0, 12bc <build_sched_domains+0x40c>
>     129c:       b9403803        ldr     w3, [x0, #56]
>     12a0:       365800e3        tbz     w3, #11, 12bc
> <build_sched_domains+0x40c>
>                                         free_sched_groups(sd->groups, 0);
>     12a4:       f9400800        ldr     x0, [x0, #16]
>         if (!sg)
>

Thanks for giving it a shot, let me run that with your topology and see
where I end up.

> Thanks
> Barry
>
>> ---
>>  include/linux/topology.h |  1 +
>>  kernel/sched/topology.c  | 99 +++++++++++++++++++---------------------
>>  2 files changed, 49 insertions(+), 51 deletions(-)
>>
>> diff --git a/include/linux/topology.h b/include/linux/topology.h
>> index ad03df1cc266..7634cd737061 100644
>> --- a/include/linux/topology.h
>> +++ b/include/linux/topology.h
>> @@ -48,6 +48,7 @@ int arch_update_cpu_topology(void);
>>  /* Conform to ACPI 2.0 SLIT distance definitions */
>>  #define LOCAL_DISTANCE		10
>>  #define REMOTE_DISTANCE		20
>> +#define DISTANCE_BITS           8
>>  #ifndef node_distance
>>  #define node_distance(from,to)	((from) == (to) ? LOCAL_DISTANCE :
>> REMOTE_DISTANCE)
>>  #endif
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 5d3675c7a76b..bf5c9bd10bfe 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1596,66 +1596,58 @@ static void init_numa_topology_type(void)
>>      }
>>  }
>>
>> +
>> +#define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
>> +
>>  void sched_init_numa(void)
>>  {
>> -	int next_distance, curr_distance = node_distance(0, 0);
>>      struct sched_domain_topology_level *tl;
>> -	int level = 0;
>> -	int i, j, k;
>> -
>> -	sched_domains_numa_distance = kzalloc(sizeof(int) * (nr_node_ids + 1),
>> GFP_KERNEL);
>> -	if (!sched_domains_numa_distance)
>> -		return;
>> -
>> -	/* Includes NUMA identity node at level 0. */
>> -	sched_domains_numa_distance[level++] = curr_distance;
>> -	sched_domains_numa_levels = level;
>> +	unsigned long *distance_map;
>> +	int nr_levels = 0;
>> +	int i, j;
>>
>>      /*
>>       * O(nr_nodes^2) deduplicating selection sort -- in order to find the
>>       * unique distances in the node_distance() table.
>> -	 *
>> -	 * Assumes node_distance(0,j) includes all distances in
>> -	 * node_distance(i,j) in order to avoid cubic time.
>>       */
>> -	next_distance = curr_distance;
>> +	distance_map = bitmap_alloc(NR_DISTANCE_VALUES, GFP_KERNEL);
>> +	if (!distance_map)
>> +		return;
>> +
>> +	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
>>      for (i = 0; i < nr_node_ids; i++) {
>>              for (j = 0; j < nr_node_ids; j++) {
>> -			for (k = 0; k < nr_node_ids; k++) {
>> -				int distance = node_distance(i, k);
>> -
>> -				if (distance > curr_distance &&
>> -				    (distance < next_distance ||
>> -				     next_distance == curr_distance))
>> -					next_distance = distance;
>> -
>> -				/*
>> -				 * While not a strong assumption it would be nice to know
>> -				 * about cases where if node A is connected to B, B is not
>> -				 * equally connected to A.
>> -				 */
>> -				if (sched_debug() && node_distance(k, i) != distance)
>> -					sched_numa_warn("Node-distance not symmetric");
>> +			int distance = node_distance(i, j);
>>
>> -				if (sched_debug() && i && !find_numa_distance(distance))
>> -					sched_numa_warn("Node-0 not representative");
>> +			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
>> +				sched_numa_warn("Invalid distance value range");
>> +				return;
>>                      }
>> -			if (next_distance != curr_distance) {
>> -				sched_domains_numa_distance[level++] = next_distance;
>> -				sched_domains_numa_levels = level;
>> -				curr_distance = next_distance;
>> -			} else break;
>> +
>> +			bitmap_set(distance_map, distance, 1);
>>              }
>> +	}
>> +	/*
>> +	 * We can now figure out how many unique distance values there are and
>> +	 * allocate memory accordingly.
>> +	 */
>> +	nr_levels = bitmap_weight(distance_map, NR_DISTANCE_VALUES);
>>
>> -		/*
>> -		 * In case of sched_debug() we verify the above assumption.
>> -		 */
>> -		if (!sched_debug())
>> -			break;
>> +	sched_domains_numa_distance = kcalloc(nr_levels, sizeof(int),
>> GFP_KERNEL);
>> +	if (!sched_domains_numa_distance) {
>> +		bitmap_free(distance_map);
>> +		return;
>> +	}
>> +
>> +	for (i = 0, j = 0; i < nr_levels; i++, j++) {
>> +		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
>> +		sched_domains_numa_distance[i] = j;
>>      }
>>
>> +	bitmap_free(distance_map);
>> +
>>      /*
>> -	 * 'level' contains the number of unique distances
>> +	 * 'nr_levels' contains the number of unique distances
>>       *
>>       * The sched_domains_numa_distance[] array includes the actual distance
>>       * numbers.
>> @@ -1664,15 +1656,15 @@ void sched_init_numa(void)
>>      /*
>>       * Here, we should temporarily reset sched_domains_numa_levels to 0.
>>       * If it fails to allocate memory for array sched_domains_numa_masks[][],
>> -	 * the array will contain less then 'level' members. This could be
>> +	 * the array will contain less then 'nr_levels' members. This could be
>>       * dangerous when we use it to iterate array sched_domains_numa_masks[][]
>>       * in other functions.
>>       *
>> -	 * We reset it to 'level' at the end of this function.
>> +	 * We reset it to 'nr_levels' at the end of this function.
>>       */
>>      sched_domains_numa_levels = 0;
>>
>> -	sched_domains_numa_masks = kzalloc(sizeof(void *) * level, GFP_KERNEL);
>> +	sched_domains_numa_masks = kzalloc(sizeof(void *) * nr_levels,
>> GFP_KERNEL);
>>      if (!sched_domains_numa_masks)
>>              return;
>>
>> @@ -1680,7 +1672,7 @@ void sched_init_numa(void)
>>       * Now for each level, construct a mask per node which contains all
>>       * CPUs of nodes that are that many hops away from us.
>>       */
>> -	for (i = 0; i < level; i++) {
>> +	for (i = 0; i < nr_levels; i++) {
>>              sched_domains_numa_masks[i] =
>>                      kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
>>              if (!sched_domains_numa_masks[i])
>> @@ -1688,12 +1680,17 @@ void sched_init_numa(void)
>>
>>              for (j = 0; j < nr_node_ids; j++) {
>>                      struct cpumask *mask = kzalloc(cpumask_size(), GFP_KERNEL);
>> +			int k;
>> +
>>                      if (!mask)
>>                              return;
>>
>>                      sched_domains_numa_masks[i][j] = mask;
>>
>>                      for_each_node(k) {
>> +				if (sched_debug() && (node_distance(j, k) != node_distance(k,
>> j)))
>> +					sched_numa_warn("Node-distance not symmetric");
>> +
>>                              if (node_distance(j, k) > sched_domains_numa_distance[i])
>>                                      continue;
>>
>> @@ -1705,7 +1702,7 @@ void sched_init_numa(void)
>>      /* Compute default topology size */
>>      for (i = 0; sched_domain_topology[i].mask; i++);
>>
>> -	tl = kzalloc((i + level + 1) *
>> +	tl = kzalloc((i + nr_levels) *
>>                      sizeof(struct sched_domain_topology_level), GFP_KERNEL);
>>      if (!tl)
>>              return;
>> @@ -1728,7 +1725,7 @@ void sched_init_numa(void)
>>      /*
>>       * .. and append 'j' levels of NUMA goodness.
>>       */
>> -	for (j = 1; j < level; i++, j++) {
>> +	for (j = 1; j < nr_levels; i++, j++) {
>>              tl[i] = (struct sched_domain_topology_level){
>>                      .mask = sd_numa_mask,
>>                      .sd_flags = cpu_numa_flags,
>> @@ -1740,8 +1737,8 @@ void sched_init_numa(void)
>>
>>      sched_domain_topology = tl;
>>
>> -	sched_domains_numa_levels = level;
>> -	sched_max_numa_distance = sched_domains_numa_distance[level - 1];
>> +	sched_domains_numa_levels = nr_levels;
>> +	sched_max_numa_distance = sched_domains_numa_distance[nr_levels - 1];
>>
>>      init_numa_topology_type();
>>  }
>> --
>> 2.27.0
