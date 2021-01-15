Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FF62F7C43
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbhAONOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731646AbhAONOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:14:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E77C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:13:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u14so3370725wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2g4u3xNSMK8ghZXqKFL1R16HFSl2YerHraRE1h1ytpo=;
        b=NJnjEoGtqvon0egRK9YDpRFtOVbouVzaWgRbvYfVii+pcX8Ains4e8W1vQK2TqkAOX
         yJ+CaqAjsp/dYPpBhRRVqsJ50qnOF64iyVZz5gsAoZiYdsB7AJsJ86Dk/jIiH9jdAW7u
         S2lpxb2tRpaTTc94ebf7nepCVudFXT9rCksZcU/vPJ4mU/wq06zc03tPavGYoFzj48OD
         mf090vFhbR24JxJnLVx/wcDpnu4RWfAArLaMzN5z0plP5un+8hjwky/AjLPZrND5ddd6
         hdqWlLONDBuo3ylfSdJ1j/zS/5DgBHxK/D1fJlkWcQIlg6TjqIfMSzGRac6mDARTo+FP
         h/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2g4u3xNSMK8ghZXqKFL1R16HFSl2YerHraRE1h1ytpo=;
        b=CCT6aaK6WTA+ibke0vK4bYp9cq2Cr/4z+5VOi1jgXml2WA4FtVLgt/NVgo2Ob8oQEz
         9u/oo9+aOa/mOiHxotYmRN9TkiqvebCebCQCQD4yeJqBiC9UixaENuNObEvtUfdIb+5U
         9PMEPRmLHJ2ELkc2kuTOMLt7VRbeGk8pw+ZLo51P2o7deStg7vT3PKGs3hEKuF6wFF1t
         UJw+8Xo3/eq2A4nK4J+Mi9AhVMry+kc+HXCvPEYy9VSNyb+HGqDGUHjjJ5J/R65Tc5Io
         Rxrr/pxuf2NYl+E00crC1KQihew7pHptEKsrsHxkXFqXRnmIJ/k2r9mokObNSM+7386Z
         lKsQ==
X-Gm-Message-State: AOAM530sDM9sTB1KYwrqCWAWsSKdT5CzBmM2dUjdy8/LMseuW5JEWuwv
        NIqT2/mMAM5lxhX+BSZXsy0h9Q==
X-Google-Smtp-Source: ABdhPJxfOZhdwQYrDchMipN1IZpHmQWkJDk+mAZz8JHVlnN1ck11zGlbUHx0lY6QrlOT4n4wgqVJvA==
X-Received: by 2002:a1c:9acb:: with SMTP id c194mr8510839wme.43.1610716433539;
        Fri, 15 Jan 2021 05:13:53 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id x17sm14605648wro.40.2021.01.15.05.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 05:13:52 -0800 (PST)
Date:   Fri, 15 Jan 2021 14:13:47 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/15] kasan: don't run tests when KASAN is not enabled
Message-ID: <YAGVCxWTBlv4ZITG@elver.google.com>
References: <cover.1610652890.git.andreyknvl@google.com>
 <da60f1848b42dd04a4977e156715c8d0382a1ecd.1610652890.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da60f1848b42dd04a4977e156715c8d0382a1ecd.1610652890.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 08:36PM +0100, Andrey Konovalov wrote:
> Don't run KASAN tests when it's disabled with kasan.mode=off to avoid
> corrupting kernel memory.
> 
> Link: https://linux-review.googlesource.com/id/I6447af436a69a94bfc35477f6bf4e2122948355e
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  lib/test_kasan.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index a96376aa7293..6238b56127f8 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -47,6 +47,11 @@ static bool multishot;
>   */
>  static int kasan_test_init(struct kunit *test)
>  {
> +	if (!kasan_enabled()) {
> +		kunit_err(test, "can't run KASAN tests with KASAN disabled");
> +		return -1;
> +	}
> +
>  	multishot = kasan_save_enable_multi_shot();
>  	hw_set_tagging_report_once(false);
>  	return 0;
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
