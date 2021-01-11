Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0377C2F1300
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 14:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbhAKNCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 08:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbhAKNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:02:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509FDC061381
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 05:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+W/goIrxj27oosZ7ycDNIVN/sr+eGHUpFYptkCE7da8=; b=KdDJ6B5I+PzWR7RCHgFetxMVvL
        83SS8eSRs8vXN1Th3GSeM/BHEN1LpajzK8pmu6OuW9fGOqUpv0On9XmnXXwXkN5Yz+mvsC06n0bFc
        uqSgCNgS6+MnYGl+RDgAKih9FAwNqsmfjlwxg2ohagZiQcSGCYIQCygXQAnJk7tjeFaqzBiSIBbdU
        bDiLhrIDVNTDhw8OJ457xLeIAUcpqSFQOHO2P8a38J8QZI8u3wNop0tH4QCouxaA+0UQsHo9oA4fq
        mY3haacOoYmT2gF7RGBGiWv067uRZYtrmdndpwQV93JO5fAqeJTvR4E6x7by7KpTdl6NOiA2KI4Mz
        iIxmTboQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kywoE-003F82-Uf; Mon, 11 Jan 2021 13:00:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71D5D30015A;
        Mon, 11 Jan 2021 14:00:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D0022BB7DCD1; Mon, 11 Jan 2021 14:00:33 +0100 (CET)
Date:   Mon, 11 Jan 2021 14:00:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     rja_direct@groups.int.hpe.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Liang, Kan" <kan.liang@intel.com>
Subject: Re: [PATCH 2/2] perf/x86/intel/uncore: With > 8 nodes, get pci bus
 die id from NUMA info
Message-ID: <X/xL8d8FXVJHkQUj@hirez.programming.kicks-ass.net>
References: <20210108153549.108989-1-steve.wahl@hpe.com>
 <20210108153549.108989-3-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108153549.108989-3-steve.wahl@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 09:35:49AM -0600, Steve Wahl wrote:


> +		/*
> +		 * The nodeid and idmap registers only contain enough
> +		 * information to handle 8 nodes.  On systems with more
> +		 * than 8 nodes, we need to rely on NUMA information,
> +		 * filled in from BIOS supplied information, to determine
> +		 * the topology.
> +		 */

Egads.. do we realy have to trust BIOS data? BIOS crud tends to be
bonghits qualitee :/

> +		if (nr_node_ids <= 8) {
> +			/* get the Node ID of the local register */
> +			err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
> +			if (err)
> +				break;
> +			nodeid = config & NODE_ID_MASK;
> +			/* get the Node ID mapping */
> +			err = pci_read_config_dword(ubox_dev, idmap_loc, &config);
> +			if (err)
> +				break;
>  
> +			segment = pci_domain_nr(ubox_dev->bus);
> +			raw_spin_lock(&pci2phy_map_lock);
> +			map = __find_pci2phy_map(segment);
> +			if (!map) {
> +				raw_spin_unlock(&pci2phy_map_lock);
> +				err = -ENOMEM;
> +				break;
> +			}
> +
> +			/*
> +			 * every three bits in the Node ID mapping register maps
> +			 * to a particular node.
> +			 */
> +			for (i = 0; i < 8; i++) {
> +				if (nodeid == ((config >> (3 * i)) & 0x7)) {
> +					if (topology_max_die_per_package() > 1)
> +						die_id = i;
> +					else
> +						die_id = topology_phys_to_logical_pkg(i);
> +					map->pbus_to_dieid[bus] = die_id;
> +					break;
> +				}
> +			}
>  			raw_spin_unlock(&pci2phy_map_lock);
> +		} else {
> +			int node = pcibus_to_node(ubox_dev->bus);
> +			int cpu;
> +
> +			segment = pci_domain_nr(ubox_dev->bus);
> +			raw_spin_lock(&pci2phy_map_lock);
> +			map = __find_pci2phy_map(segment);
> +			if (!map) {
> +				raw_spin_unlock(&pci2phy_map_lock);
> +				err = -ENOMEM;
> +				break;
> +			}
> +			die_id = -1;
> +			for_each_cpu(cpu, cpumask_of_pcibus(ubox_dev->bus)) {
> +				struct cpuinfo_x86 *c = &cpu_data(cpu);
> +
> +				if (c->initialized && cpu_to_node(cpu) == node) {
> +					map->pbus_to_dieid[bus] = die_id = c->logical_die_id;
> +					break;
> +				}
> +			}
> +			raw_spin_unlock(&pci2phy_map_lock);
> +
> +			if (WARN_ON_ONCE(die_id == -1)) {
> +				err = -EINVAL;
>  				break;
>  			}

This seems to assume a single die per node; is that fundemantally
correct?

Did you consider malicious BIOS data? I think we're good, but I didn't
look too hard.

>  		}
>  	}
>  
>  	if (!err) {
> -- 
> 2.26.2
> 
