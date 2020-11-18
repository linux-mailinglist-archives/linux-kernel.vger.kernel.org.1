Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7932B860B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKRUw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:52:58 -0500
Received: from ms.lwn.net ([45.79.88.28]:46644 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgKRUw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:52:58 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B727550A9;
        Wed, 18 Nov 2020 20:52:57 +0000 (UTC)
Date:   Wed, 18 Nov 2020 13:52:56 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: Re: [RESEND][PATCH] docs/mm: concepts.rst: Correct the threshold to
 low watermark
Message-ID: <20201118135256.07f1a477@lwn.net>
In-Reply-To: <20201114031712.9016-1-wang.yi59@zte.com.cn>
References: <20201114031712.9016-1-wang.yi59@zte.com.cn>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Nov 2020 11:17:12 +0800
Yi Wang <wang.yi59@zte.com.cn> wrote:

> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Actually it should be "low watermark" where we wake up kswapd
> daemon.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  Documentation/admin-guide/mm/concepts.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/concepts.rst b/Documentation/admin-guide/mm/concepts.rst
> index fa0974f..b966fcf 100644
> --- a/Documentation/admin-guide/mm/concepts.rst
> +++ b/Documentation/admin-guide/mm/concepts.rst
> @@ -184,7 +184,7 @@ pages either asynchronously or synchronously, depending on the state
>  of the system. When the system is not loaded, most of the memory is free
>  and allocation requests will be satisfied immediately from the free
>  pages supply. As the load increases, the amount of the free pages goes
> -down and when it reaches a certain threshold (high watermark), an
> +down and when it reaches a certain threshold (low watermark), an
>  allocation request will awaken the ``kswapd`` daemon. It will
>  asynchronously scan memory pages and either just free them if the data
>  they contain is available elsewhere, or evict to the backing storage

This patch still has not made it onto the public mailing lists.  I don't
know what the problem is with your mail setup, but until you can post the
patch publicly I cannot apply it.

When you do work that problem out, please add the linux-mm list like I
asked you to last time.

Thanks,

jon
