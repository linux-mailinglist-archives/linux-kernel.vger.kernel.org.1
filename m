Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734E12B27F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKMWPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMWPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:15:40 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5C7C0613D1;
        Fri, 13 Nov 2020 14:15:39 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2985A4FA;
        Fri, 13 Nov 2020 22:15:39 +0000 (UTC)
Date:   Fri, 13 Nov 2020 15:15:38 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: Re: [PATCH] docs/mm: concepts.rst: Correct the threshold to low
 watermark
Message-ID: <20201113151538.0937ef3c@lwn.net>
In-Reply-To: <20201102032220.30747-1-wang.yi59@zte.com.cn>
References: <20201102032220.30747-1-wang.yi59@zte.com.cn>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Nov 2020 11:22:20 +0800
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

So I tried to apply this, but b4 complains that it's not in the lkml
archive, and indeed it's not.  It seems that your message never actually
went to the mailing list?  Please resend with an actual public copy;
adding the linux-mm list would also be good.

Thanks,

jon
