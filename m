Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1154E23FCD5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 07:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHIFGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 01:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgHIFGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 01:06:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD6FC061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 22:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=KFpMew5MWdx4OVueRAZxSP2lNfAyRK8h36VA6KMljLY=; b=KOP7sa4NFIfTImV6xf9GxdSg7E
        T+CkJvw548uZCmDd+a0LRpprZj8CeU2eEguGKNEEjZMKMJaOpfwIHzaetwxojgsVoPSCIX1k35wI9
        hSL8S4XIWIcHJuqMD4x5aMSP+OtPC4+pr3vdzWk7/FQQwiOvXjPSSUDwd2ouITUZCIzPj9MWBgGl/
        jOyP1t9XmW4Oq4h84K4x4eVfR89qRBIqcLH9wu6QS6Q2uE4PT1dKwPfLeQZSlICJ5wqck/oaCYyNy
        ltXbtTQ9y3RnDIDj3tMFrc/zkA5gPqhSwW5YaAFIwXMz1lD3722hn3I5Gf0dNXOlp9yqI8LjU6IpO
        oZmHf95g==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4dWw-0002ST-Em; Sun, 09 Aug 2020 05:05:59 +0000
Subject: Re: [PATCH 3/7] dyndbg: select ZPOOL in Kconfig.debug
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20200807200957.1269454-1-jim.cromie@gmail.com>
 <20200807200957.1269454-4-jim.cromie@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7e5c90bf-eb04-4b63-2990-7be18e22664f@infradead.org>
Date:   Sat, 8 Aug 2020 22:05:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807200957.1269454-4-jim.cromie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 1:09 PM, Jim Cromie wrote:
> dyndbg will next need zs_malloc and friends, so add config reqs now,
> to avoid touching make-deps late in a patch-set.
> 
> I used select in order not to hide dyndbg inadvertently.
> I want to say recommends, since it could be an optional feature.
> Whats the best way ?

Hi Jim,
Can you elaborate on what/why/when it could be an optional feature?

> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ad9210d70a1..a7973063baf0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -100,6 +100,7 @@ config DYNAMIC_DEBUG
>  	depends on PRINTK
>  	depends on (DEBUG_FS || PROC_FS)
>  	select DYNAMIC_DEBUG_CORE
> +	select ZPOOL
>  	help
>  
>  	  Compiles debug level messages into the kernel, which would not
> 


-- 
~Randy

