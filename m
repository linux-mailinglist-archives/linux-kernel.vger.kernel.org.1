Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191A42B23EB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgKMSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKMSk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:40:59 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BEAC0613D1;
        Fri, 13 Nov 2020 10:40:58 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f93so7350139qtb.10;
        Fri, 13 Nov 2020 10:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/se03i+00bbqRJRAZ8FjioxlmbCFc/szk4I7VWn1Yq8=;
        b=JSTer/9kXYzBF1e86GeXW00MtON9hukkTRIaaZIv0H2DO7ZTX6J4m9K1Kz8YtBQ6qi
         v1A/lg9n1UjtjKKFYbMSPMi7L/Sg6ZtlXtUGmzWhrMtn2L/u5GVLLs+TcLpHtUmSiSoQ
         HZvCECwzKJjIyZXqhuzO1SoOllbZ0dkFRo0bgpon6eUVPc1/bcfkXYidmsSHMXDCj1G8
         lBE5Sag/+/jTfpg/+ynkvh0PMpP5ekES4CwUPvoAdC+o+562CsHtWcMKNkeQY3FUwarB
         9kCvmee6fyhnT7C2Qv00Ot23VtzI0aPq933bxK6jrhVbb+Xs9BD9eK51I4TdP16szJXm
         oLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/se03i+00bbqRJRAZ8FjioxlmbCFc/szk4I7VWn1Yq8=;
        b=JKweXWJ6e7gW01lMEULue5u5ZjdYtcSFG+p/AmgB8nxXxkZy7M8xOdNVM44l5TKQk3
         HQkFjb0IvqdQT78H3sWIi9hQFfFgdIx6beD0dQNsuOszilETkuecRcons5QjCH2lO7I1
         GbU76JXugt5axoGYT9a9ibD0u39nPMgHjTIu9t3trxKAWIRxy8nv0UPNk/j9gNbFcALJ
         BOibpC571wkWQuwSDL49N8uaOVTZL3OzlQqbo6ZutpUeLPWkUrJFHvmnDxfJms6sMjV3
         ahd4+/+Py4zQyKxSoVNo2MhAMfMO4ufLGXWGTZS+/4nPIFYsxWG9v+hM6IQt4ABLd9RK
         idwg==
X-Gm-Message-State: AOAM533OXXyCkGjED2ihjmdFVtes8/qROrXfIxNHpD7FwmybFgzU2lYc
        P8RWHqdAFt/Zr48h1r/t+VM=
X-Google-Smtp-Source: ABdhPJxecwR1Fx79/lop7qrpKgm37NSUwHSlk3Cr+Md0D2kDGEdOXi0yuHIyXInnbxBnyF1YmS3bGQ==
X-Received: by 2002:ac8:5c05:: with SMTP id i5mr3279411qti.34.1605292858136;
        Fri, 13 Nov 2020 10:40:58 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id o187sm7188030qkb.120.2020.11.13.10.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 10:40:57 -0800 (PST)
Date:   Fri, 13 Nov 2020 11:40:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] futex: remove unused empty compat_exit_robust_list()
Message-ID: <20201113184055.GA1436703@ubuntu-m3-large-x86>
References: <20201113172012.27221-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113172012.27221-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 06:20:12PM +0100, Lukas Bulwahn wrote:
> Commit ba31c1a48538 ("futex: Move futex exit handling into futex code")
> introduced compat_exit_robust_list() with a full-fledged implementation for
> CONFIG_COMPAT, and an empty-body function for !CONFIG_COMPAT.
> However, compat_exit_robust_list() is only used in futex_mm_release() under
> ifdef CONFIG_COMPAT.
> 
> Hence for !CONFIG_COMPAT, make CC=clang W=1 warns:
> 
>   kernel/futex.c:314:20:
>     warning: unused function 'compat_exit_robust_list' [-Wunused-function]
> 
> There is no need to declare the unused empty function for !CONFIG_COMPAT.
> Simply, remove it to address the -Wunused-function warning.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> applies cleanly on current master and next-20201113
> 
> Thomas, please pick this minor non-urgent clean-up patch.
> 
>  kernel/futex.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 00259c7e288e..c47d1015d759 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -310,8 +310,6 @@ static inline bool should_fail_futex(bool fshared)
>  
>  #ifdef CONFIG_COMPAT
>  static void compat_exit_robust_list(struct task_struct *curr);
> -#else
> -static inline void compat_exit_robust_list(struct task_struct *curr) { }
>  #endif
>  
>  /*
> -- 
> 2.17.1
> 
