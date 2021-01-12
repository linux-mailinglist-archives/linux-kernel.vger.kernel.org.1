Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE32F31D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbhALNf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbhALNf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:35:28 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA60C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:34:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t16so2538195wra.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z9FwHUycumOs6t3SGrgS7cCKPT7xvNasenz8IWyWKdE=;
        b=W+nxBakCaB7ynwGYftYLRdP83y1GTuxctzs44VzPtCtmSubuMVopEKdrenyngQtkEu
         V7P22CcfpoY+/Gn+4UtErhSHZXc7+8zeF6bSccwaJ1VPrTpV9pzT2btHTmIDR+8MomWa
         yuu5VMsycC/+yIIdCfzf11BkdzD4vdiLu4uWhAXGP3YmRoTpVsuhX2hEpFWK73RAJ37l
         P3dNktzINSGrOdq+QJrvOu+t9lGusgUz/2+dZiOZP6eKsPvQCqK28cxb9XxfFB2e0i0X
         WN5K1OvfuFbjh429mqP+FXlm0TscIb3gtLKQyc8hPIDJry3r8FcZDc48D3zDDiHzmXyl
         rEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z9FwHUycumOs6t3SGrgS7cCKPT7xvNasenz8IWyWKdE=;
        b=dQOCL3eSxJAXVT3ywnOmyG1I1OcphuVl5mB+9HGfQgXRbrFtRE212xQ15UPwIG5G9A
         8JhtjUQxHnqUzdD8VbVlegp7FVOGyw1QkNGmem08JEXisvUKzalqEW0O/nQbLYIPCeAl
         btCc15ztqBmrKCj67HcLZ2N8a7vYeMwVg0XZyNBx+3gTCEjG6JlPhWwNmrwTqXGxAYEY
         HjKPXQjS+nTqMD6xtUMa7Xqtdsu951yqrlcVldSOLVdaRxtwKv5kuUu7z8twmiOh6fov
         EB3Rrj2+CrUHShnWfoGz/lMcBNybG8MNS0oClWyT3qEGkkjXBFgJL61UMOgcqe/WJcy1
         glog==
X-Gm-Message-State: AOAM5337b6ToO0Uqe6pYz9rrwGt8vyB+OxgB9HWO3sPGpl6Tr4LT8axT
        2Gc4kcknZqCsqK8jxoObKSBnIA==
X-Google-Smtp-Source: ABdhPJyKyV9ETptwrtpI2ynczocJJyRkdU4fVd84RpDQb6jfsamTI8Mh/WaitaK3csy42ynajTMGag==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr4508931wru.118.1610458486541;
        Tue, 12 Jan 2021 05:34:46 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id h184sm4218719wmh.23.2021.01.12.05.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 05:34:45 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:34:40 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] kasan: add compiler barriers to
 KUNIT_EXPECT_KASAN_FAIL
Message-ID: <X/2lcAQE4ia21uRj@elver.google.com>
References: <cover.1609871239.git.andreyknvl@google.com>
 <a37dab02f89ad93cc986a87866da74fb8be1850d.1609871239.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a37dab02f89ad93cc986a87866da74fb8be1850d.1609871239.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:27PM +0100, Andrey Konovalov wrote:
> It might not be obvious to the compiler that the expression must be
> executed between writing and reading to fail_data. In this case, the
> compiler might reorder or optimize away some of the accesses, and
> the tests will fail.
> 
> Add compiler barriers around the expression in KUNIT_EXPECT_KASAN_FAIL.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I046079f48641a1d36fe627fc8827a9249102fd50

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  lib/test_kasan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index dd3d2f95c24e..b5077a47b95a 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -79,7 +79,9 @@ static void kasan_test_exit(struct kunit *test)
>  				NULL,				\
>  				&resource,			\
>  				"kasan_data", &fail_data);	\
> +	barrier();						\
>  	expression;						\
> +	barrier();						\
>  	KUNIT_EXPECT_EQ(test,					\
>  			fail_data.report_expected,		\
>  			fail_data.report_found);		\
> -- 
> 2.29.2.729.g45daf8777d-goog
> 
