Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06082CB096
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgLAW7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgLAW7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:59:05 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4112DC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 14:58:25 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id bj5so2089093plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 14:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fpCkvObUiLFV7i8wi0EFFDp0DlPXOlO+Zd8t9lluHfI=;
        b=j+Q7lTAty3ECkOp2OSuvkZGlS6+RQnAHLLW8l9YFJ7bvLzAsrmXdk0JpYJZIvNCCiA
         VDwPhwLgpl1+MG/wdMrLyW1vGn7T5M3vCMFHvU6ZIhUZvjN4nwhBLfUahBpNL2wiZ5Lo
         YuZsYddycPrOSVCKu7jF9R6urpU0inVCB8Guo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fpCkvObUiLFV7i8wi0EFFDp0DlPXOlO+Zd8t9lluHfI=;
        b=kgk8zJaO+fJ3+jP6I7KC6RO5ejTaKWqE+Yf0fajKi9HqcqqOnhIDM4v3kLAb0V3J8V
         gyz7kJl/aFuoIPfcS5YwL1M01sYypllBxMrt0X1ciwKN5l7X0VVLBTbev6U+RdpDu0Cl
         G8Xigw/zWoUhpcyQ4o9W5nZDuuSdzix+mNwzHKzYdTAaANNZc/LDH3XjfZAycjr4NoIp
         XC5QAOYvrHGApQa56gdGorSYhG01v3jnSJ08GweKhSJEVDai23TuDmy+SI8rglPJLrAl
         eS0FEKuZt6sFaAi6uiW+B43gY7LHiYm+0ve7F4/eqMCcKuRxmTl3RDGyIYLiWz7GVmMu
         Ct2w==
X-Gm-Message-State: AOAM532n/o/koGwfqDnpdCYoYboTTjTc9NK1O84G8T+HF+25lHh7kH4+
        LYFrCbWg638OUXajgjaIUqVTwg==
X-Google-Smtp-Source: ABdhPJwx3tUuiRhlr276G7mU77s853AaUDNvhbvf4OgyooV3aVDoQScF3DiQJG/f5Pz8oSb/g/8haA==
X-Received: by 2002:a17:90a:4d8f:: with SMTP id m15mr5139792pjh.211.1606863504775;
        Tue, 01 Dec 2020 14:58:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y69sm765397pfb.12.2020.12.01.14.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 14:58:23 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:58:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, gofmanp@gmail.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 6/7] selftests: Add benchmark for syscall user dispatch
Message-ID: <202012011458.13B0254D@keescook>
References: <20201127193238.821364-1-krisman@collabora.com>
 <20201127193238.821364-7-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127193238.821364-7-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 02:32:37PM -0500, Gabriel Krisman Bertazi wrote:
> This is the patch I'm using to evaluate the impact syscall user dispatch
> has on native syscall (syscalls not redirected to userspace) when
> enabled for the process and submiting syscalls though the unblocked
> dispatch selector. It works by running a step to define a baseline of
> the cost of executing sysinfo, then enabling SUD, and rerunning that
> step.
> 
> On my test machine, an AMD Ryzen 5 1500X, I have the following results
> with the latest version of syscall user dispatch patches.
> 
> root@olga:~# syscall_user_dispatch/sud_benchmark
>   Calibrating test set to last ~5 seconds...
>   test iterations = 37500000
>   Avg syscall time 134ns.
>   Caught sys_ff00
>   trapped_call_count 1, native_call_count 0.
>   Avg syscall time 147ns.
>   Interception overhead: 9.7% (+13ns).
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
