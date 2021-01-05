Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58652EB4E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbhAEVeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAEVeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:34:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1655BC061574;
        Tue,  5 Jan 2021 13:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=nYVjMqbRLfBVIUStOapE6efMR2BK+1HUPqAiQNNoYmg=; b=pPkvq68X9pysO9znCOq+4c8zfb
        jUx0+IENwAsq8jGo3QxZY/Kx4UEJPYdkHSLzlJm6eLsz5eG9Qzqr92YSXj0E3kyZzdXwWXiLWoyQd
        nxvYue8Jhq9Dz9xLurOwMhl4G9gHIQJZZ5PLdtJl6y4NY/C7EcvJyqIXjZBqYQhcmeE7iW5Tgvyr3
        PABBWC61P45MPDYVDPgyaJcJlHHK8pPh2Y/S3+woztuJbzGs1BOU1A5IjMYpKV6Nh3Car+t3V62ab
        VJdAlP8GVFZioSxJoHprpSwsGnnqOfRj3ZwkyESGA6JkLAZVdQexL+qn7Irbj+FUFNTC2e9Welk24
        eHCzFwGw==;
Received: from [2601:1c0:6280:3f0::64ea]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwtxJ-0002vc-HA; Tue, 05 Jan 2021 21:33:29 +0000
Subject: Re: [PATCH] csky: Fix a typo in Kconfig
To:     Masanari Iida <standby24x7@gmail.com>, guoren@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210105134107.217920-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ae3672c0-84d1-7ee5-1858-33d119544906@infradead.org>
Date:   Tue, 5 Jan 2021 13:33:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210105134107.217920-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
There's a lot more to do here.  Please see below.

On 1/5/21 5:41 AM, Masanari Iida wrote:
> This patch fixes a spelling typo in Kconfig.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  arch/csky/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 7f1721101ea0..ce680f6e3b4b 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -243,7 +243,7 @@ menuconfig HAVE_TCM
>  	bool "Tightly-Coupled/Sram Memory"
>  	select GENERIC_ALLOCATOR
>  	help
> -	  The implementation are not only used by TCM (Tightly-Coupled Meory)
> +	  The implementation are not only used by TCM (Tightly-Coupled Memory)

	                     is not

>  	  but also used by sram on SOC bus. It follow existed linux tcm

	                   SRAM                follows the existing Linux TCM

>  	  software interface, so that old tcm application codes could be

	                                  TCM

>  	  re-used directly.
> 


-- 
~Randy

