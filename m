Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E662C584B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391392AbgKZPbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:31:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391261AbgKZPbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:31:48 -0500
Received: from gaia (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E652087C;
        Thu, 26 Nov 2020 15:31:47 +0000 (UTC)
Date:   Thu, 26 Nov 2020 15:31:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Janghyuck Kim <janghyuck.kim@samsung.com>
Cc:     hyesoo.yu@samsung.com, pullip.cho@samsung.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: arm64: Kconfig: support for nodes spanning other nodes
Message-ID: <20201126153144.GB6722@gaia>
References: <CGME20201029060015epcas2p2c9969a6782d8214bcbefa36ffad8e10c@epcas2p2.samsung.com>
 <20201029061950.4217-1-janghyuck.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029061950.4217-1-janghyuck.kim@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:19:50PM +0900, Janghyuck Kim wrote:
> To support NUMA systems whose physical address layout is not continuous
> on one node, nodes spanning other nodes feature is required.
> 
> Signed-off-by: Janghyuck Kim <janghyuck.kim@samsung.com>
> ---
>  arch/arm64/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 49b8d017cba6..18ff7ce9dd60 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1004,6 +1004,14 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>  config HOLES_IN_ZONE
>  	def_bool y
>  
> +# Some NUMA nodes have memory ranges that span
> +# other nodes.  Even though a pfn is valid and
> +# between a node's start and end pfns, it may not
> +# reside on that node.  See memmap_init_zone()
> +# for details.
> +config NODES_SPAN_OTHER_NODES
> +	depends on NUMA

I guess this patch no longer makes sense after commit acd3f5c441e9 ("mm:
remove early_pfn_in_nid() and CONFIG_NODES_SPAN_OTHER_NODES").

-- 
Catalin
