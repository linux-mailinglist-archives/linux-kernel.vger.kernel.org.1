Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2AF27EF00
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbgI3QWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgI3QWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:22:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12999C061755;
        Wed, 30 Sep 2020 09:22:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d23so1329933pll.7;
        Wed, 30 Sep 2020 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XgJ15fC621DrnHIQ5oj1JA6FQX1Stjqg9GgjlEH66cQ=;
        b=DQEUbrCq8FqMK3blYCbs60fKcnel9hXASFerSfhD5sv4lvf2A8lXsG1XeuA15MppVD
         srm1oOG31OoqcF0P0/dLfFG79TMiBgHzI5jTcU1WFyPzHMyjmVKy6JBfu4a83fDRGA5w
         ZP9l01bGaiRSu9Y34vVPXDz44Z/fkfU00yyV5ZtAeBxzcom/54kNKjPCr+vZxaorvKaM
         8PzwWIDSEv8Pq3QUbHGSLuyVa9JBK0035cQma5n0nKeNU1recG9B3j8C0s3f+gsGXsFR
         VNF1p4eWjnIcWdIcYC+zutm0I26bxpaijomIxAHtZzu4uulkJ8vLmB3R8GITl1x8oS5L
         pw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XgJ15fC621DrnHIQ5oj1JA6FQX1Stjqg9GgjlEH66cQ=;
        b=hL8HBHLwx5M/1pylwDG9eom73Cq4Qsa9e5a705nSxkDetHxrfAdAUNjBDSWpKepFh9
         XaUV7DU9E6EtwSSsv2C2aVBxpsKE7/khBudQAUvuvOG1UgpR0uCeald/00V7Dx6zir/5
         sXtQIXTW38hKKHIVATzD7qhxWGWP/8hhkS69YhDMHDJxFMXru/zZM3roCHWyhBCV42tm
         E9moMulQkXgYIZXJtnpO1HaBu7FvEGxorH+Nbu47p3qE+QD7Kba9VlAZh2jslDOFJL6j
         rNNtlLpF13RnG8zt+8HuypOwLi6jnOWx3St669287xeY+EZS6LUuyV4QTZ0jRnVGE8mv
         5oPQ==
X-Gm-Message-State: AOAM530s+K+2u8RUzjR12bVWiNu7EM72KR2mAd/S/4SQJuoUvKWZVYUJ
        oeJ92Fq4+fgiahFooTdg9nA=
X-Google-Smtp-Source: ABdhPJw+SqUXNtC6oBvfgjRZsj4LSOB5DNRL8L0BAwEXk49cwXY0A2sRjztxjLnMZ4T+gwBuxOTg3A==
X-Received: by 2002:a17:902:eb03:b029:d1:8c50:aafb with SMTP id l3-20020a170902eb03b02900d18c50aafbmr371147plb.29.1601482919393;
        Wed, 30 Sep 2020 09:21:59 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id ca6sm2852452pjb.53.2020.09.30.09.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 09:21:58 -0700 (PDT)
Date:   Wed, 30 Sep 2020 09:21:57 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] docs: programming-languages: refresh blurb on clang
 support
Message-ID: <20200930162157.GA236767@ubuntu-m3-large-x86>
References: <20200929211936.580805-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929211936.580805-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 02:19:35PM -0700, Nick Desaulniers wrote:
> Building the kernel with Clang doesn't rely on third party patches, and
> has not for a few years now.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

Modulo Randy's nit:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

>  Documentation/process/programming-language.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/process/programming-language.rst b/Documentation/process/programming-language.rst
> index e5f5f065dc24..63af142d64ec 100644
> --- a/Documentation/process/programming-language.rst
> +++ b/Documentation/process/programming-language.rst
> @@ -6,14 +6,15 @@ Programming Language
>  The kernel is written in the C programming language [c-language]_.
>  More precisely, the kernel is typically compiled with ``gcc`` [gcc]_
>  under ``-std=gnu89`` [gcc-c-dialect-options]_: the GNU dialect of ISO C90
> -(including some C99 features).
> +(including some C99 features). ``clang`` [clang]_ is also supported, see docs
> +docs on :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
>  
>  This dialect contains many extensions to the language [gnu-extensions]_,
>  and many of them are used within the kernel as a matter of course.
>  
> -There is some support for compiling the kernel with ``clang`` [clang]_
> -and ``icc`` [icc]_ for several of the architectures, although at the time
> -of writing it is not completed, requiring third-party patches.
> +There is some support for compiling the kernel with ``icc`` [icc]_ for several
> +of the architectures, although at the time of writing it is not completed,
> +requiring third-party patches.
>  
>  Attributes
>  ----------
> -- 
> 2.28.0.709.gb0816b6eb0-goog
> 
