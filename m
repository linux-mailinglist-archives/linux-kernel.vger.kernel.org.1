Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E3C2ED469
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbhAGQfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAGQfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:35:39 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7EBC0612F6;
        Thu,  7 Jan 2021 08:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=r1DkkM634LmbM+8iNum9ry0SlTP4QSLEZKVyMcSDUE8=; b=pkREtNwWgEZG339X0qE+wgQ1eF
        N9UymPXbyG5MYV1N93S6//KKUV8sgkTU+5/T5QHr4fPFUeiQbH3BF+QPDcVfv3tZCuJOyHwZapgMP
        CVEKXDFQqcRmGazWwLtm932MmwHgLH8yYJqXMeoB4wop9zQVuUcbiOwF1rIE9EVS/hHBaSmaUjFxh
        trQp26ZztNnjoipY2KP31JcwY5kMS8GQ394GLKnEPQ/qrnes2Y4Ce5FrC8un1ChS/WuJC7WrMtX52
        U/q1saIHp87MFEvzHms9l0bP+YbW1xwI4GVrNdirESAqDrhB+NYVxP19BXcjoeTF4Bbk8X6pv/vjn
        ZSwTCf6w==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxYFT-0007Dt-L7; Thu, 07 Jan 2021 16:34:55 +0000
Subject: Re: [PATCH] docs: admin-guide: bootconfig: Fix feils to fails
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mhiramat@kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210107125610.1576368-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ee03c134-22f5-0845-de04-6b4d38f00ec2@infradead.org>
Date:   Thu, 7 Jan 2021 08:34:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210107125610.1576368-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 4:56 AM, Bhaskar Chowdhury wrote:
> s/feils/fails/p
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/bootconfig.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index 9b90efcc3a35..452b7dcd7f6b 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -154,7 +154,7 @@ get the boot configuration data.
>  Because of this "piggyback" method, there is no need to change or
>  update the boot loader and the kernel image itself as long as the boot
>  loader passes the correct initrd file size. If by any chance, the boot
> -loader passes a longer size, the kernel feils to find the bootconfig data.
> +loader passes a longer size, the kernel fails to find the bootconfig data.
> 
>  To do this operation, Linux kernel provides "bootconfig" command under
>  tools/bootconfig, which allows admin to apply or delete the config file
> --
> 2.30.0
> 


-- 
~Randy
