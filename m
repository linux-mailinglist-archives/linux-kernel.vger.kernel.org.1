Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DFC2B15E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 07:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKMGjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 01:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgKMGjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:39:52 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE65C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 22:39:41 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i26so6318007pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 22:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fBdbvlXFQzyqe/RetyLdTLSpJsN6xlr7oVFkeGNYL8E=;
        b=wK/n6ptdCYVWY9J0DxMYKBRJdvhY46aaoKnluOTHhB7ZC4++q8bBHLq1dNm2VNPyI/
         dO/P9mjAXtWLqMqJ6y4hAhdJrjGasVyV5SAdSYK2jf12QTzSw7tumwb8UxGFuxmyQF5p
         75dIxIRyIXinfeq+Zz95gTGCRQv1U0W8J7M/XB+lyQEr5X8UC918CYZolQmaZwbbxSxS
         6HJTapPzoDV+Y+Vjq6UK7srpW87sxyc1aIAeHHXV37RaGrHtaUjraX0Z9XFPt46yQN8J
         koN8CWlAPXZng4EqaB7cFCbM//4Z8wAj9UQUNnvq1fOHIka988X3+8arSuXKmlGItaS9
         QXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fBdbvlXFQzyqe/RetyLdTLSpJsN6xlr7oVFkeGNYL8E=;
        b=nzdNdcgLn26JsuTyIltywqRqsrbrK7sLi796AHvV6o7YxnwgveJBrjuji0CyBIJg1e
         WA1R8TOIq/2IcbQzYr6retCMHINqe5eJObxNNeO3X3LRlYadfOpWXJjGNjFJ1wcGhATl
         u+gYS84p3uA6v3kuammP+NqM0CoV7MaNAWx5J3DBxL1rpJ4TW9BiutP6jAJSrkb/gUZB
         mMCcw33hubLIz2uZ5wqDylaLiT9EWrA+ZjMZAgplHNxiBp0eV2RdL+dT+c08tZ39i5BY
         Lz2mjQgX10ZbNSNAJKgpUJuKqcer4EP6f1aBnUbymXb1cpCQ5lCDr4kCvEb1vsHe4OSe
         Yccg==
X-Gm-Message-State: AOAM531cknZ8hCNguS3dYzhmVJ5gL/qipWOWrEzg1BxDlaILQcHLKd6x
        ZrulGXti+T/PKS3V3DDmSX8tkyU6JslskQ==
X-Google-Smtp-Source: ABdhPJywSABAJEM3p2Mw87QiOmTgAww+KbLyxWYNVFW8gwZz+654heI9thbF1zEb3FyDgnLWYy+nLA==
X-Received: by 2002:a17:90a:a609:: with SMTP id c9mr1324145pjq.124.1605249580402;
        Thu, 12 Nov 2020 22:39:40 -0800 (PST)
Received: from [192.168.10.88] (124-171-134-245.dyn.iinet.net.au. [124.171.134.245])
        by smtp.gmail.com with UTF8SMTPSA id w10sm7729027pgj.91.2020.11.12.22.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 22:39:39 -0800 (PST)
Subject: Re: [PATCH] panic: Avoid dump_stack() twice
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20201113054747.177919-1-wangkefeng.wang@huawei.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <40b1b70f-16d9-01c4-c045-508cde14f4c2@ozlabs.ru>
Date:   Fri, 13 Nov 2020 17:39:35 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201113054747.177919-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed already

https://ozlabs.org/~akpm/mmots/broken-out/panic-dont-dump-stack-twice-on-warn.patch

Sorry for breaking this :(


On 13/11/2020 16:47, Kefeng Wang wrote:
> stacktrace will be dumped twice on ARM64 after commit 3f388f28639f
> ("panic: dump registers on panic_on_warn"), will not dump_stack
> when no regs as before.
> 
> Fixes: 3f388f28639f ("panic: dump registers on panic_on_warn")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   kernel/panic.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 396142ee43fd..332736a72a58 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -605,7 +605,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>   		panic("panic_on_warn set ...\n");
>   	}
>   
> -	dump_stack();
> +	if (!regs)
> +		dump_stack();
>   
>   	print_irqtrace_events(current);
>   
> 

-- 
Alexey
