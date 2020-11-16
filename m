Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8802B4027
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgKPJrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgKPJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:47:40 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7EC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 01:47:40 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so17919498wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 01:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+si8LH3jhi9EyKVGhLQbwPSv91L15i1+9Oq4Ed8hni4=;
        b=nqdN4uRj5voyOinQdTs1MOSCoiyOPfj8u3NnVEqnwsh89YfCT6AgozfIcjPTqpXfGM
         lBTAsB/8ReuT9cWudKtSXV6Xx6Cu1e9GXcTbBqR1IybviVR9utneYkZK07dnnd2r5fmU
         VjSpPGF3TP6yCGp1bFPcfJeEDazghUqDzEIAeHTMCz4+wDsWLtkUfvGl5yxM2LA4vTkT
         oTCM+tvMjLtGCGwZyEuxP91A5mCccTGGiYO8m6VdU2c7bhQeHi4RE0iuqY0NjzK1QlC9
         wpFZrvXQ9YK0dwFMJzJMKD4kZ42TTfZJ+4hxMdW5ja9gPk9S//eN2Zpx0npfMgnQLBI1
         FCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+si8LH3jhi9EyKVGhLQbwPSv91L15i1+9Oq4Ed8hni4=;
        b=B1vqnCj1IamcsDQR7ghG22AT7XrXuWtnFoQ2XxYdhuZ5g/o+eyqaOubrxozmPmOIe9
         XBE4sDgaGMmL9H5EgOAp/vKO6EomDrnapNKJtERPb43rWLpWv4R6sxcDyQgsKx5I0bff
         FiEIyd7FAjg6+BKtTAbZVT4vbhhTZUSvHqnTrmBK3OKe6WpNJ39gQ0fPHnBwj00Kgox/
         amlaEgn1dUUPOJVwEAXRk7sP4Jj6DlHuLcjbg+DTKJHr80n9CsT0uMZKyGRVBFdh3sJW
         A2b7rwH2SNuvuRUCGPZBzL9jjqs6LSP6l3N+aRoxAAJ+O8RED5OwQxr9JeSjVk6v/UTy
         qk8A==
X-Gm-Message-State: AOAM530Uq/Du0OmGfG9DINWhoxwfA3hmAT7N0SKS0L2GT+CjTrPtU/PL
        ZbyMZY7AwcFtMkuv1uvCI3mA1Q==
X-Google-Smtp-Source: ABdhPJxTb/57HfJkOZ7cB/V/z4dTk0Fhk5LOW+nej7IimYiur/RP+toGkLtmhrPKf82iiC+Ou9db0w==
X-Received: by 2002:a05:6000:1088:: with SMTP id y8mr19995697wrw.207.1605520058932;
        Mon, 16 Nov 2020 01:47:38 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m21sm29402766wmi.3.2020.11.16.01.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 01:47:38 -0800 (PST)
Date:   Mon, 16 Nov 2020 09:47:36 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        kgdb-bugreport@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH] Documentation: kgdb: Fix a typo
Message-ID: <20201116094736.hmqnyl3xezeupzyb@holly.lan>
References: <1605519767-25502-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605519767-25502-1-git-send-email-yangtiezhu@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:42:47PM +0800, Tiezhu Yang wrote:
> "to into" -> "into"
> 
> Reported-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  Documentation/dev-tools/kgdb.rst | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
> index 77b688e..4345624 100644
> --- a/Documentation/dev-tools/kgdb.rst
> +++ b/Documentation/dev-tools/kgdb.rst
> @@ -63,10 +63,9 @@ will want to turn on ``CONFIG_DEBUG_INFO`` which is called
>  It is advised, but not required, that you turn on the
>  ``CONFIG_FRAME_POINTER`` kernel option which is called :menuselection:`Compile
>  the kernel with frame pointers` in the config menu. This option inserts code
> -to into the compiled executable which saves the frame information in
> -registers or on the stack at different points which allows a debugger
> -such as gdb to more accurately construct stack back traces while
> -debugging the kernel.
> +into the compiled executable which saves the frame information in registers
> +or on the stack at different points which allows a debugger such as gdb to
> +more accurately construct stack back traces while debugging the kernel.
>  
>  If the architecture that you are using supports the kernel option
>  ``CONFIG_STRICT_KERNEL_RWX``, you should consider turning it off. This
> -- 
> 2.1.0
> 
