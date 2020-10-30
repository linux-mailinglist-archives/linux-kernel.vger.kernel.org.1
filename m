Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3492A02C0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgJ3KZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgJ3KZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:25:13 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA8B420825;
        Fri, 30 Oct 2020 10:25:10 +0000 (UTC)
Date:   Fri, 30 Oct 2020 10:25:08 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, patches@amperecomputing.com,
        linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com,
        Valentin.Schneider@arm.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] arm64: NUMA: Kconfig: Increase NODES_SHIFT to 4
Message-ID: <20201030102507.GB23196@gaia>
References: <20201029203752.1114948-1-vanshikonda@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029203752.1114948-1-vanshikonda@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 01:37:52PM -0700, Vanshidhar Konda wrote:
> The current arm64 default config limits max NUMA nodes available on
> system to 4 (NODES_SHIFT = 2). Today's arm64 systems can reach or
> exceed 16 NUMA nodes. To accomodate current hardware and to fit
> NODES_SHIFT within page flags on arm64, increase NODES_SHIFT to 4.
> 
> Discussion on v1 of the patch:
> https://lkml.org/lkml/2020/10/20/767

Better use a stable link to refer to the past discussion:

Link: https://lore.kernel.org/r/20201020173409.1266576-1-vanshikonda@os.amperecomputing.com

> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f858c352f72a..cffcc677011f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -982,7 +982,7 @@ config NUMA
>  config NODES_SHIFT
>  	int "Maximum NUMA Nodes (as a power of 2)"
>  	range 1 10
> -	default "2"
> +	default "4"
>  	depends on NEED_MULTIPLE_NODES
>  	help
>  	  Specify the maximum number of NUMA Nodes available on the target

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
