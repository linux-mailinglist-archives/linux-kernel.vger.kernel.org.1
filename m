Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BEB2D498E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbgLISz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbgLISzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:55:21 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887B9C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:54:41 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id m5so1481027pjv.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 10:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6rcG5E2ND0M3zVFvR91c2KDlufplbmx+6aVT4b7pfH4=;
        b=amGZUB2QmzFAhQXEDLL5G3+GDkgkdz/1yh0NULCac6CqNYJy00PQGkrBCQjOVzYUYn
         vBRd7xM6sq69QWZmLjDi27cAlrPIecWYqdxzzxluIN+YVwBBqEdWnl7RpmGaSqc6Vcwl
         gq4CBqRsDYvJ8E0xmaBh5UG4nnXiIkmDPo7EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6rcG5E2ND0M3zVFvR91c2KDlufplbmx+6aVT4b7pfH4=;
        b=FdfurRVXl++SJMFGWcXuoErAt8CKh/O9ZAzkastTNF0F30S1OQcsBxM+1HRbgccli8
         bhXsMZU2i4LSX+amWUWirNrEzbF9MEI9J0WADYaHdkiimS27YZhZggkmAJrcUMxiDB55
         SHgAqr/XqjjdqB/Ts8aH3Ctq1uWEoixYko/OKcv9xRoGsD0aG75d785E//z5f6jacKVn
         GWnZOGIchX50+CVITP/vseXlcO8EO9+ar8DL5Y2mYAMgpRIkOhOUr1QumMpuGHX3PkWl
         gteGGY5gqv/nK1auZjhiqN/hIdgFd42K94zLmQpGOjvmugDDZNu+vh/l4jGxL2LAEBFA
         grpA==
X-Gm-Message-State: AOAM532fDQ9oCVgsfAUf8t8eBXZ2hrAFtoc0xGKctzNNRIYiabiGzjV2
        AFtOuQH0y2YFyu1REcxdAHfCuA==
X-Google-Smtp-Source: ABdhPJwwvwTi17NFslAusMjt8S/vlWSt6gsHPux53PRLMtr1AO4Xg672fCr3Z6ZLeeqyK/4dymrCCg==
X-Received: by 2002:a17:902:ee11:b029:db:c0d6:581a with SMTP id z17-20020a170902ee11b02900dbc0d6581amr3244470plb.54.1607540081165;
        Wed, 09 Dec 2020 10:54:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v8sm2900365pjk.39.2020.12.09.10.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 10:54:40 -0800 (PST)
Date:   Wed, 9 Dec 2020 10:54:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     akpm@linux-foundation.org, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] kcov: don't instrument with UBSAN
Message-ID: <202012091054.08D70D4F@keescook>
References: <20201209100152.2492072-1-dvyukov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209100152.2492072-1-dvyukov@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 11:01:52AM +0100, Dmitry Vyukov wrote:
> Both KCOV and UBSAN use compiler instrumentation. If UBSAN detects a bug
> in KCOV, it may cause infinite recursion via printk and other common
> functions. We already don't instrument KCOV with KASAN/KCSAN for this
> reason, don't instrument it with UBSAN as well.
> 
> As a side effect this also resolves the following gcc warning:
> 
> conflicting types for built-in function '__sanitizer_cov_trace_switch';
> expected 'void(long unsigned int,  void *)' [-Wbuiltin-declaration-mismatch]
> 
> It's only reported when kcov.c is compiled with any of the sanitizers
> enabled. Size of the arguments is correct, it's just that gcc uses 'long'
> on 64-bit arches and 'long long' on 32-bit arches, while kernel type is
> always 'long long'.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for chasing this down!

Andrew, can you add this to the stack of ubsan patches you're carrying,
please?

-- 
Kees Cook
