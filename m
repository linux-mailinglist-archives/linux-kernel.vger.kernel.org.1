Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64F52A0A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgJ3QAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:00:22 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:34631 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbgJ3QAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:00:21 -0400
Received: from [192.168.0.2] (ip5f5af1ae.dynamic.kabel-deutschland.de [95.90.241.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C1CC220646217;
        Fri, 30 Oct 2020 17:00:18 +0100 (CET)
Subject: Re: [PATCH v2 1/2] init/Kconfig: Fix CPU number in
 LOG_CPU_MAX_BUF_SHIFT description
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     "Luis R . Rodriguez" <mcgrof@suse.com>,
        linux-kernel@vger.kernel.org
References: <20200811092924.6256-1-pmenzel@molgen.mpg.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <d7cad0f8-5831-7730-42d5-fa6d8c46edbb@molgen.mpg.de>
Date:   Fri, 30 Oct 2020 17:00:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20200811092924.6256-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Petr,


Am 11.08.20 um 11:29 schrieb Paul Menzel:
> Currently, LOG_BUF_SHIFT defaults to 17, which is 2 ^ 17 bytes = 128 KB,
> and LOG_CPU_MAX_BUF_SHIFT defaults to 12, which is 2 ^ 12 bytes = 4 KB.
> 
> Half of 128 KB is 64 KB, so more than 16 CPUs are required for the value
> to be used, as then the sum of contributions is greater than 64 KB for
> the first time. My guess is, that the description was written with the
> configuration values used in the SUSE in mind.
> 
> Fixes: 23b2899f7f ("printk: allow increasing the ring buffer depending on the number of CPUs")
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v2: Add Reviewed-by tag
> 
>   init/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index d6a0b31b13dc..9dc607e3806f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -718,7 +718,7 @@ config LOG_CPU_MAX_BUF_SHIFT
>   	  with more CPUs. Therefore this value is used only when the sum of
>   	  contributions is greater than the half of the default kernel ring
>   	  buffer as defined by LOG_BUF_SHIFT. The default values are set
> -	  so that more than 64 CPUs are needed to trigger the allocation.
> +	  so that more than 16 CPUs are needed to trigger the allocation.
>   
>   	  Also this option is ignored when "log_buf_len" kernel parameter is
>   	  used as it forces an exact (power of two) size of the ring buffer.

Could you please apply this trivial patch from the two patches already, 
so I do not have to resend it?


Kind regards,

Paul
