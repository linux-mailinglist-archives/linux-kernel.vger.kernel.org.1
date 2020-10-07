Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA42E286689
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgJGSIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:08:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:47622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727765AbgJGSIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:08:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A84E7AF9C;
        Wed,  7 Oct 2020 18:08:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 07 Oct 2020 20:08:10 +0200
From:   osalvador@suse.de
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com
Subject: Re: [RFC][PATCH 3/9] mm/migrate: update migration order during on
 hotplug events
In-Reply-To: <20201007161741.DDC85648@viggo.jf.intel.com>
References: <20201007161736.ACC6E387@viggo.jf.intel.com>
 <20201007161741.DDC85648@viggo.jf.intel.com>
User-Agent: Roundcube Webmail
Message-ID: <8acf3637996d5c72709a3143f41165f8@suse.de>
X-Sender: osalvador@suse.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-07 18:17, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Reclaim-based migration is attempting to optimize data placement in
> memory based on the system topology.  If the system changes, so must
> the migration ordering.
> 
> The implementation here is pretty simple and entirely unoptimized.  On
> any memory or CPU hotplug events, assume that a node was added or
> removed and recalculate all migration targets.  This ensures that the
> node_demotion[] array is always ready to be used in case the new
> reclaim mode is enabled.
> 
> This recalculation is far from optimal, most glaringly that it does
> not even attempt to figure out if nodes are actually coming or going.
> But, given the expected paucity of hotplug events, this should be
> fine.

Hi Dave,

I am still going through all the details, but just wanted to comment 
early on this one.
Could not you hook into __try_online_node/try_offline_node?

In there we check whether a node should be brought up or removed due to 
lack of cpus and memory.
That is being checked during hot-remove operations.

We also have node_states_check_changes_{offline,online} and their pair 
node_states_{set,clear}_node, that checks during online/offline stages 
which states should be removed from the node, but that is only wrt. 
memory (I guess we would only be interested in N_MEMORY).

Thanks

