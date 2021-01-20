Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3E2FD57E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403991AbhATQW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403854AbhATQVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:21:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC482C061757;
        Wed, 20 Jan 2021 08:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=6zbXo40IH5Uu71xo0sssuQB6SsVmGWBgsmHqDUPpMXo=; b=phwPCU05NdSG5sT2A2X7d5RMJb
        /k0H3vv3f6ylRPdpA+nQZ11ugPnKPLaGsn35s/PxrMsgDA+aM/TrhjYm8A5rzPfaLBbJ3IkSi+RBF
        /d8wwbUG/RjjH+RMwG25M3KD3SIb0qWp5o0ogqll2xBeg+yDsPaKG/Z2NKydNQycjqKLs1Ob6wYZ9
        fpO0br0ZJcJIuOPMQCA93nkx3553fDKAtkoTPbGXNegeR92noH9QgSXG0YCs8Sp0EJmD/Ya8FUhjU
        XSFHF8n1b0E4AsRdG/6JuheZ7/FHCKtr+y0XI4BPqKlvoYR2yWMA3BFbnMTXSbBzlf5iqzSVo0ODK
        C6m1Eqkw==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2GDR-0007Np-Bj; Wed, 20 Jan 2021 16:20:17 +0000
Subject: Re: [PATCH] arch/alpha: fix typo in a comment in
 arch/alpha/boot/bootpz.c
To:     ChunyouTang <tangchunyou@163.com>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, akpm@linux-foundation.org, rppt@kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangwen@yulong.com, tangchunyou@yulong.com
References: <20210120133410.2182-1-tangchunyou@163.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5e4ed85d-140c-3d85-e4f4-97b27fa37885@infradead.org>
Date:   Wed, 20 Jan 2021 08:20:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210120133410.2182-1-tangchunyou@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 5:34 AM, ChunyouTang wrote:
> From: tangchunyou <tangchunyou@yulong.com>
> 
> "kerne" -> "kernel"
> 
> Signed-off-by: tangchunyou <tangchunyou@yulong.com>
> ---
>  arch/alpha/boot/bootpz.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/alpha/boot/bootpz.c b/arch/alpha/boot/bootpz.c
> index 43af718..61b61be 100644
> --- a/arch/alpha/boot/bootpz.c
> +++ b/arch/alpha/boot/bootpz.c
> @@ -200,7 +200,7 @@ extern int decompress_kernel(void* destination, void *source,
>  	START_ADDR	KSEG address of the entry point of kernel code.
>  
>  	ZERO_PGE	KSEG address of page full of zeroes, but 
> -			upon entry to kerne cvan be expected
> +			upon entry to kernel cvan be expected

s/cvan/can/ also

>  			to hold the parameter list and possible
>  			INTRD information.
>  
> 


-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
