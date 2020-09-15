Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5243A269F97
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgIOHYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgIOHY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:24:29 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF02C2080C;
        Tue, 15 Sep 2020 07:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600154669;
        bh=lmjngYh7GkGxScGYSERfmVDd4/xBELC3JZvwsqs9C3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PkKnTTTv3w9GFzkaUDzMcdHecq7ssNK9tMwzIJ9YPrOyQ6z6tgVXECEHXc3wYJV8+
         e9ctxR3+/LMeC1mTVWRiCq8Q7wvc5Vy8SzZ4E6tDLs0yALhEUnHpFLCVIUOSl7Rplw
         PoTFS+WkAR9P7eCCtad3p9CfolnnDndEz1YJ0Owc=
Date:   Tue, 15 Sep 2020 16:24:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] bootconfig: init: make xbc_namebuf static
Message-Id: <20200915162424.a947b5d51695f726db2af2a9@kernel.org>
In-Reply-To: <20200915070324.2239473-1-yanaijie@huawei.com>
References: <20200915070324.2239473-1-yanaijie@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 15:03:24 +0800
Jason Yan <yanaijie@huawei.com> wrote:

> This eliminates the following sparse warning:
> 
> init/main.c:306:6: warning: symbol 'xbc_namebuf' was not declared.
> Should it be static?


Yes, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  init/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 92773a5daf8d..5ac07eb4a300 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -303,7 +303,7 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
>  
>  #ifdef CONFIG_BOOT_CONFIG
>  
> -char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
> +static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
>  
>  #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
>  
> -- 
> 2.25.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
