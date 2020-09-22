Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C8E27493D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIVTfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVTfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:35:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F265C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:35:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z19so13385588pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sqo10I328LeM2dGrmAMbMDjHGHNfY3AhrHLzAaG7Zcc=;
        b=SbYZH3mSnGlVgEsFBRoL6JaNbinBFwv3MKZkfeP6QtPh9H7MfyP0AJW8GxXvXyh7oS
         rB2MZP6qWoEmVuRs7JlfEwiBbgK4lZ23Vz2hvbf2mKPSWCpyTVqeghNS5302lcgAU1Ot
         3V8jL6xUcHt55VvzDvDGK3RdK/gVmXzdyxNNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sqo10I328LeM2dGrmAMbMDjHGHNfY3AhrHLzAaG7Zcc=;
        b=ZHHGunmxP8G0uks72/b6ULjT2Za4XZ93K5oMIVEO8VL30VSJz8xosoPXKfAr1g53fp
         yYTLyARLSuNvuZy1r57Tq6M6G9wk5kluI5eWhPx59Q75A1AwgwR/60nLQ9TvYHyOuvYg
         KUsMAYHQiQ/F8hd89IINOX4WWnG+CAhPkST1olNr61yHmgQ4dOcttjonvTIS/fFv5Gbj
         Gj7byLwdUz2SRm1BmfaEQI9rB0eCx/yeOHiFyS8Lqo44ZnJHGgrCLs/8znArDV5ZsMIW
         cTr4ZZx0hjcER6oPSDZkZ5WlZBwVgcykmMCw8Ckus9D1kb8bKjy9RqcCfMivmLtRDRki
         QTow==
X-Gm-Message-State: AOAM532/g6Mr5FU93ao6oERapj6HFkMxqanrk3zSvtLRcdlgE+5u0LKn
        jFDhyzROZ+yDAwUI2VVuNaRWkw==
X-Google-Smtp-Source: ABdhPJwJXWR+YYhKJY5dfjikhbiB5OtlnQmdHcgPbPiQaDOduurUwJgYHZOyXscbN5iibVyCq0TsTQ==
X-Received: by 2002:a65:6917:: with SMTP id s23mr4517004pgq.389.1600803316089;
        Tue, 22 Sep 2020 12:35:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm3378542pjl.9.2020.09.22.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:35:14 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:35:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 8/9] selftests: Add kselftest for syscall user dispatch
Message-ID: <202009221234.C0189A8F@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-9-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-9-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:46PM -0400, Gabriel Krisman Bertazi wrote:
> Implement functionality tests for syscall user dispatch.  In order to
> make the test portable, refrain from open coding syscall dispatchers and
> calculating glibc memory ranges.
> 
> Changes since v4:
>   - Update bad selector test to reflect change in API
> 
> Changes since v3:
>   - Sort entry in Makefile
>   - Add SPDX header
>   - Use __NR_syscalls if available
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

This passes, looks good. Thank you again for the self tests!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
