Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9513E3015C6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 15:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbhAWOUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 09:20:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbhAWOUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 09:20:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA3F722D5A;
        Sat, 23 Jan 2021 14:19:55 +0000 (UTC)
Date:   Sat, 23 Jan 2021 14:19:53 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 18/21] arm64: Move "nokaslr" over to the early
 cpufeature infrastructure
Message-ID: <YAwwiRF4QnIoPS20@Catalins-MacBook-Air.local>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-19-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-19-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:30AM +0000, Marc Zyngier wrote:
> Given that the early cpufeature infrastructure has borrowed quite
> a lot of code from the kaslr implementation, let's reimplement
> the matching of the "nokaslr" option with it.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kernel/idreg-override.c | 17 ++++++++++++++
>  arch/arm64/kernel/kaslr.c          | 37 +++---------------------------
>  2 files changed, 20 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> index 1db54878b2c4..143fe7b8e3ce 100644
> --- a/arch/arm64/kernel/idreg-override.c
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -33,8 +33,24 @@ static const struct reg_desc mmfr1 __initdata = {
>  	},
>  };
>  
> +extern u64 kaslr_feature_val;
> +extern u64 kaslr_feature_mask;
> +
> +static const struct reg_desc kaslr __initdata = {
> +	.name		= "kaslr",

We might as well rename this ftr_override or something more generic as
we no longer describe registers here. Otherwise:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
