Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6BA301578
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 14:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbhAWNol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 08:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbhAWNoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 08:44:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C232C22AAD;
        Sat, 23 Jan 2021 13:43:55 +0000 (UTC)
Date:   Sat, 23 Jan 2021 13:43:52 +0000
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
Subject: Re: [PATCH v4 12/21] arm64: cpufeature: Add an early command-line
 cpufeature override facility
Message-ID: <YAwoGDODQKq3798H@Catalins-MacBook-Air.local>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-13-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-13-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:24AM +0000, Marc Zyngier wrote:
> +struct reg_desc {
> +	const char * const	name;
> +	u64 * const		val;
> +	u64 * const		mask;
> +	struct {
> +		const char * const	name;
> +		u8			 shift;
> +	} 			fields[];
> +};

Sorry, I didn't see this earlier. Do we need to add all these consts
here? So you want the pointers to be const but why is 'shift' special
and not a const then? Is it modified later?

Would this not work:

struct reg_desc {
	const char	*name;
	u64		*val;
	u64		*mask;
	struct {
		const char	*name;
		u8		shift;
	} fields[];
};

> +static const struct reg_desc * const regs[] __initdata = {

as we already declare the whole struct reg_desc pointers here as const.
I may have confused myself...

-- 
Catalin
