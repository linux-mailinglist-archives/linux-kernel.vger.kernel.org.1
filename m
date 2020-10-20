Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D3F2941EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437305AbgJTSJn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Oct 2020 14:09:43 -0400
Received: from foss.arm.com ([217.140.110.172]:54862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388059AbgJTSJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:09:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E179231B;
        Tue, 20 Oct 2020 11:09:41 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FE8F3F719;
        Tue, 20 Oct 2020 11:09:41 -0700 (PDT)
References: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, patches@amperecomputing.com,
        linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
Subject: Re: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
In-reply-to: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
Date:   Tue, 20 Oct 2020 19:09:36 +0100
Message-ID: <jhj7drkrcpr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Nit on the subject: this only increases the default, the max is still 2¹⁰.

On 20/10/20 18:34, Vanshidhar Konda wrote:
> The current arm64 max NUMA nodes default to 4. Today's arm64 systems can
> reach or exceed 16. Increase the number to 64 (matching x86_64).
>
> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 893130ce1626..3e69d3c981be 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -980,7 +980,7 @@ config NUMA
>  config NODES_SHIFT
>       int "Maximum NUMA Nodes (as a power of 2)"
>       range 1 10
> -	default "2"
> +	default "6"

This leads to more statically allocated memory for things like node to CPU
maps (see uses of MAX_NUMNODES), but that shouldn't be too much of an
issue.

AIUI this also directly correlates to how many more page->flags bits are
required: are we sure the max 10 works on any aarch64 platform? I'm
genuinely asking here, given that I'm mostly a stranger to the mm
world. The default should be something we're somewhat confident works
everywhere.

>       depends on NEED_MULTIPLE_NODES
>       help
>         Specify the maximum number of NUMA Nodes available on the target
