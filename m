Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31861C28BF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 01:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgEBXFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 19:05:30 -0400
Received: from gentwo.org ([3.19.106.255]:55972 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgEBXF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 19:05:29 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id DC6843E900; Sat,  2 May 2020 23:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id DA7C53E817;
        Sat,  2 May 2020 23:05:28 +0000 (UTC)
Date:   Sat, 2 May 2020 23:05:28 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
In-Reply-To: <20200501031128.19584-4-srikar@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.2005022304190.28355@www.lameter.com>
References: <20200501031128.19584-1-srikar@linux.vnet.ibm.com> <20200501031128.19584-4-srikar@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 May 2020, Srikar Dronamraju wrote:

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -116,8 +116,10 @@ EXPORT_SYMBOL(latent_entropy);
>   */
>  nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
>  	[N_POSSIBLE] = NODE_MASK_ALL,
> +#ifdef CONFIG_NUMA
> +	[N_ONLINE] = NODE_MASK_NONE,

Hmmm.... I would have expected that you would have added something early
in boot that would mark the current node (whatever is is) online instead?
