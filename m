Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7791CC7BE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 09:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEJHvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 03:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgEJHvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 03:51:47 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76EF320801;
        Sun, 10 May 2020 07:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589097107;
        bh=QeiNgRGdID9E8lmK2vcuFGA2DpwjF0oVx0ddur4mzjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kMOTj0jnzyiNLGLuF6rzJFQU6Kks4kSY+DTLWXTIII2znJrvyv5XZafTTkAt1oVR/
         zyLsIlEx1Ynv5jzv1B0KilMGLSYK3vJivUPC7o0vEDn7kPX7SXTqOL43AKT+/q8qaO
         cWomhqiYAVW3un6dw8UrbweVU3o8PfEY1MTFSTag=
Date:   Sun, 10 May 2020 16:51:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     <linux-kernel@vger.kernel.org>, Jiri Kosina <trivial@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH trivial] bootconfig: Fixup one typo
Message-Id: <20200510165142.f3b37689aa1b5ee1c5a5e414@kernel.org>
In-Reply-To: <1589013235-56363-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1589013235-56363-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020 16:33:55 +0800
Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:

> Fix up one typo: CONFIG_BOOTCONFIG -> CONFIG_BOOT_CONFIG
> 
> Cc: Jiri Kosina <trivial@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Good catch! Thanks!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> ---
>  init/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 1a5da2c2660c..8369ba173ad8 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -460,7 +460,7 @@ static void __init setup_boot_config(const char *cmdline)
>  
>  static int __init warn_bootconfig(char *str)
>  {
> -	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOTCONFIG is not set.\n");
> +	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOT_CONFIG is not set.\n");
>  	return 0;
>  }
>  early_param("bootconfig", warn_bootconfig);
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
