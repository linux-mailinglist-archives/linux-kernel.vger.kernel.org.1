Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A383F2858F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgJGHCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgJGHCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:02:20 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC0C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:02:19 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o9so518106plx.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XdqKL5aXm7UjHedQ8Kmd06CRP6H67L61WFTIrlc1Gl8=;
        b=YhZGcgkapoHP9n4Y4/REoixTmv+p6U1CAxJTQSggCZTXAjkxJWk+78pBOXvzXtOyZh
         UvIBMEp3Kh5eeLS99uPI9kIU2nQhOFOw8deHsWDIxiMg15a3fsU67DLKtN4+sqBTcsli
         +XK83VQXwqtQCVXEKhicBmRfYT9TCbG6YwSHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XdqKL5aXm7UjHedQ8Kmd06CRP6H67L61WFTIrlc1Gl8=;
        b=pj572MF0N9vjO8WmcLesMciGtOzhcWmKMokaBvYXUo99EjBf8uz6I3+Jw96D9AGAt3
         zeYepOyvQcXvlDV/bPpH/eheq7mnFvUvp4YB/qQph4y++dK29BGhNRkrqf1w1PNlEl7G
         uA3ddCpYIE7YzYe/XTj1tmtcG40lzqiIgbmQAzDecVs9e/9vbC4QKlt2UK87Ojd3B2Qk
         0fVjdZAkiI5gQ6q2tvb68c+0YdLKv65PMu+bZFgfW0+tM2gy4JVuHtLdvfm9D3QAN8mM
         njVz3bOJJzrU8rCXVhkUAHHYRW3tzkD+L8j/PRfOS/nu7ScW3BkKnR7xFJHARBY330XR
         wahQ==
X-Gm-Message-State: AOAM532gSMAjTGzXSarCoH803w2gcIcwiqevhK8XTdO2DI/d3EOqnFyr
        GyOLRklrCYrH0qESZ0hYRjHBAQ==
X-Google-Smtp-Source: ABdhPJzPm6ocfx2VZcP32tBt7qlZ+t7rOxRAk/5oeif+G+AFdGWJADJO8PdoPnrk2iyx8lmasQY7xA==
X-Received: by 2002:a17:90a:3f10:: with SMTP id l16mr1664591pjc.110.1602054139421;
        Wed, 07 Oct 2020 00:02:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h20sm1556665pfo.168.2020.10.07.00.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:02:18 -0700 (PDT)
Date:   Wed, 7 Oct 2020 00:02:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     James Morris <jmorris@namei.org>, KP Singh <kpsingh@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] LSM: Fix type of id parameter in kernel_post_load_data
 prototype
Message-ID: <202010062359.01DD51D3@keescook>
References: <20201006201115.716550-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006201115.716550-1-natechancellor@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 01:11:15PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> security/security.c:1716:59: warning: implicit conversion from
> enumeration type 'enum kernel_load_data_id' to different enumeration
> type 'enum kernel_read_file_id' [-Wenum-conversion]
>         ret = call_int_hook(kernel_post_load_data, 0, buf, size, id,
>               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> security/security.c:715:22: note: expanded from macro 'call_int_hook'
>                         RC = P->hook.FUNC(__VA_ARGS__);         \
>                              ~            ^~~~~~~~~~~
> 1 warning generated.
> 
> There is a mismatch between the id parameter type in
> security_kernel_post_load_data and the function pointer prototype that
> is created by the LSM_HOOK macro in the security_list_options union. Fix
> the type in the LSM_HOOK macro as 'enum kernel_load_data_id' is what is
> expected.
> 
> Fixes: b64fcae74b6d ("LSM: Introduce kernel_post_load_data() hook")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1172
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Ah yes; thank you! Greg, can you add this to your tree?

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index d67cb3502310..32a940117e7a 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -186,7 +186,7 @@ LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
>  LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
>  LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
>  LSM_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
> -	 enum kernel_read_file_id id, char *description)
> +	 enum kernel_load_data_id id, char *description)
>  LSM_HOOK(int, 0, kernel_read_file, struct file *file,
>  	 enum kernel_read_file_id id, bool contents)
>  LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
> 
> base-commit: dba8648dcab90564b8a11c952c06a9e1153506fb
> -- 
> 2.29.0.rc0
> 

-- 
Kees Cook
