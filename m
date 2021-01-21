Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B296C2FF61D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbhAUUkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbhAUUk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:40:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF65AC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:39:42 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y187so2616465wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xayxyu0fFQJrTg31QncwBsdYtRLwkVs0VoYzDdqVhX4=;
        b=o0sMq3fT9e4YSTYIY2l5VuqpueCXe0rnYJvOmqtdyrcRS9/cB2D3Ns6ENbWbFKsLer
         +hAiH+We4B2gizqtx6LxbfSJslYevSZzgbZoIRxeNGIjWtT70bIp0DAk80Q43vvSQdwd
         7dneBNgcZHjF5PXR9/81BtHoCd8dPHTO6ht8VgkUlPJy9E/iE92MYRrgnt1CPvVQyFX3
         gT7ps41pFrRruheAooxE+HMU1M7fgf0GJk8KEcwNlTGAvh0dxrudAeTgghVCKkYpdZIA
         UTWQXZjNVumz0YHHt+aVpS4XF6B5FclaX6VCmetG0+h7cuKrviw7gwu6FuKQwMz6S3j0
         6G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xayxyu0fFQJrTg31QncwBsdYtRLwkVs0VoYzDdqVhX4=;
        b=scsZMNKExz6USUPkQTjCQheg18m2nwVWtwIH1GQDp4gIXlNEY0ZuorRed6TnKVh7hW
         CutGf9hRf9/uGbR7IMvujzGyblHs8W69dZ3cT3IAn11hDh3A7u10xVJz07svJ0uNCCMp
         RcUAfDgQ9cYjGm9wyrU0aC5oQeVpYpMjhOkHEw6DNLtHQ8xzxOb49w0RsbHDh+yGmAMi
         0FDYvbeFNtyE8k2EChHbPuVwVhNa4YU8Q/PCSVJWzUYmxIDbyDcWaCOBOAOsbp4QIvWl
         0cgHryLG5+X6DADw6sIfsHuT5YVPA3xzGz3tI4DC43vw/d5SXrYc8pDtuLophj4OCMZ+
         a10g==
X-Gm-Message-State: AOAM532qMS5Ow8PC36ZEUPCicDK67ec0wEt9G2lllTFNQjkJ3bzZBbMq
        aIhiyg1uSEgSv0IVLr0OZqNoUg6/wp4=
X-Google-Smtp-Source: ABdhPJwAvjvv7mqDZ3SsZ3LCUqrKyOah2ikRyjvnwEOfHPcnOK1XtxlUJHi2e05Q1JAo0XillVwxzw==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr1013794wmj.148.1611261581596;
        Thu, 21 Jan 2021 12:39:41 -0800 (PST)
Received: from [192.168.0.160] ([170.253.49.0])
        by smtp.gmail.com with ESMTPSA id l5sm9479286wrv.44.2021.01.21.12.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 12:39:41 -0800 (PST)
Subject: Re: [PATCH -V9 2/3] NOT kernel/man2/set_mempolicy.2: Add mode flag
 MPOL_F_NUMA_BALANCING
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210120061235.148637-1-ying.huang@intel.com>
 <20210120061235.148637-3-ying.huang@intel.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <99b71573-714f-5ec6-37e5-3e6e080432fc@gmail.com>
Date:   Thu, 21 Jan 2021 21:39:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120061235.148637-3-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang Ying,

On 1/20/21 7:12 AM, Huang Ying wrote:
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: "Alejandro Colomar" <alx.mailinglists@gmail.com>

Sorry, for the confusion.
I have a different email for reading lists.
I use alx.manpages@ for everything,
and alx.mailinglists@ just for reading lists, but sometimes,
when I answer emails not sent to me,
I forget to change the reply address,
and you see that address (which I intended to be readonly).

Please, use alx.manpages@gmail.com,
or your mail might get lost between many list emails ;)

> ---
>  man2/set_mempolicy.2 | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
> index 68011eecb..fa64a1820 100644
> --- a/man2/set_mempolicy.2
> +++ b/man2/set_mempolicy.2
> @@ -113,6 +113,22 @@ A nonempty
>  .I nodemask
>  specifies node IDs that are relative to the set of
>  node IDs allowed by the process's current cpuset.
> +.TP
> +.BR MPOL_F_NUMA_BALANCING " (since Linux 5.12)"
> +When
> +.I mode
> +is
> +.BR MPOL_BIND ,
> +enable the kernel NUMA balancing for the task if it is supported by
> +the kernel.
> +If the flag isn't supported by the kernel, or is used with
> +.I mode
> +other than
> +.BR MPOL_BIND ,
> +return \-1 and
> +.I errno
> +is set to
> +.BR EINVAL .

The wording here is a bit weird:
[return // is set].  It would be better as
[return // set] or [returns // sets] or [is returned // is set].

The same page, has:

[
RETURN VALUE
       On success, set_mempolicy() returns 0; on error, -1 is  re‐
       turned and errno is set to indicate the error.
]

so I'd use the latter for consistency.

>  .PP
>  .I nodemask
>  points to a bit mask of node IDs that contains up to
> @@ -293,6 +309,12 @@ argument specified both
>  .B MPOL_F_STATIC_NODES
>  and
>  .BR MPOL_F_RELATIVE_NODES .
> +Or, the
> +.B MPOL_F_NUMA_BALANCING
> +isn't supported by the kernel, or is used with
> +.I mode
> +other than
> +.BR MPOL_BIND .
>  .TP
>  .B ENOMEM
>  Insufficient kernel memory was available.
> 

Other than that, it's good for me.

Thanks,

Alex

Just a reminder for myself (please ignore it):
- Break EINVAL into multiple paragraphs.
- (Maybe) reorder lists to be in alphabetical order.

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
