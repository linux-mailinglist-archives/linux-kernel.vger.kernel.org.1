Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075352E207C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 19:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgLWSil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 13:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgLWSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 13:38:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2357C061794;
        Wed, 23 Dec 2020 10:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=2/PotIte2uF8Rp7Cxfp8eiOJ3+42/nTavyU1PczDiAY=; b=hJlntF1PVWHo/AFsU4PjBe0Axn
        5dl2/TaR8pr6w/owzLDYXGOIiipRHHvQb7P7328s0OziQDAF5kthOlgP3RTG1EzFfMbTes/n1C8EC
        rJbLJh1VWaobbTUUt+Gm1XBLDYycB1PK3Zk5kP42MmGFPMoAi+QsRHW34XRw5vDqoQ9JyumAd0+nr
        XGo49aha8fL3+IiFOoQkMBGuSsp7bTiWarMnCKee4iKJOXBK6xZamgWm/sEI+JS2TZkntq2+ZpWqI
        3xg/1aMmUy/4qKY/C1az2IJliNqFsEuVKBAyNmYdwABJ9JESgPF5mU3Z7uuLfSX4ADi75syOoy0ts
        ehfI1Lsw==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ks91J-0003Mc-HD; Wed, 23 Dec 2020 18:37:57 +0000
Subject: Re: [PATCH v3 21/21] x86/fpu/xstate: Introduce boot-parameters to
 control some state component support
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-22-chang.seok.bae@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <64c67e40-ecba-5d9b-7c4b-4c64ea62906a@infradead.org>
Date:   Wed, 23 Dec 2020 10:37:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201223155717.19556-22-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/20 7:57 AM, Chang S. Bae wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 44fde25bb221..a67ae04d43c5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6002,6 +6002,21 @@
>  			which allow the hypervisor to 'idle' the guest on lock
>  			contention.
>  
> +	xstate.enable=	[X86-64]
> +	xstate.disable=	[X86-64]
> +			The kernel is compiled with a default xstate bitmask --
> +			enabling it to use the XSAVE hardware to efficiently
> +			save and restore thread states on context switch.
> +			xstate.enable allows adding to that default mask at
> +			boot-time without recompiling the kernel just to support
> +			the new thread state. (Note that the kernel will ignore
> +			any bits in the mask that do not correspond to features
> +			that are actually available in CPUID)  xstate.disable

			                               CPUID.)

> +			allows clearing bits in the default mask, forcing the
> +			kernel to forget that it supports the specified thread
> +			state. When a bit set for both, the kernel takes
> +			xstate.disable in a priority.

			               as a priority.
?


thanks.
-- 
~Randy

