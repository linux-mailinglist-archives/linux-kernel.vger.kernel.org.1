Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7821A33BF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 14:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDIMFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 08:05:20 -0400
Received: from foss.arm.com ([217.140.110.172]:49394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgDIMFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:05:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61FD730E;
        Thu,  9 Apr 2020 05:05:20 -0700 (PDT)
Received: from [192.168.1.172] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BEE83F73D;
        Thu,  9 Apr 2020 05:05:19 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] arm64: enable time namespace support
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200225073731.465270-1-avagin@gmail.com>
 <20200225073731.465270-7-avagin@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <71ccd3ac-0357-10f6-6e37-a3380e46ff33@arm.com>
Date:   Thu, 9 Apr 2020 13:06:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200225073731.465270-7-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 7:37 AM, Andrei Vagin wrote:
> CONFIG_TIME_NS is dependes on GENERIC_VDSO_TIME_NS.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c6c32fb7f546..660ad0b0e6bb 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -110,6 +110,7 @@ config ARM64
>  	select GENERIC_STRNLEN_USER
>  	select GENERIC_TIME_VSYSCALL
>  	select GENERIC_GETTIMEOFDAY
> +	select GENERIC_VDSO_TIME_NS
>  	select HANDLE_DOMAIN_IRQ
>  	select HARDIRQS_SW_RESEND
>  	select HAVE_PCI
> 

-- 
Regards,
Vincenzo
