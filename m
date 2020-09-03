Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79B325CD93
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 00:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgICW31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 18:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgICW3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:29:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61214C061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 15:29:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c142so3474256pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TORQKLjaztafBoTASZ16yvu7ARDRy50kM4Q1p96biak=;
        b=KHsDbTkWXmQI1RfBgYlEulerevLWOO1sRzFxAKb+aNgp895tLmEdR1w+6sTjCDCZIQ
         EuJ90PfQiTWeI7WLS02zfZZUzAc4XMY1Bk6zzL4EiQ37vuCk2BKlfRTd+vxSIXZp2XCf
         dIa1eEmzbBXCJesqA0svHofYBt8jl9vdhwQP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TORQKLjaztafBoTASZ16yvu7ARDRy50kM4Q1p96biak=;
        b=hUIoCekT/S5sV64uTdFjbSK28eAUH5I2o+5XxXgkqyTfQTh8ejjEIj3kmTe1qyxN+b
         6wM46Yxgd5uK9GwI+VJN4tiXKJB2rC06iY7MkdobaRthRuU6HSUd4fppOmZbolx7+uKC
         CfE8wxc+SqynI5lqMHGuGyvvccMXrxcN2BHF5KEnTNoCsTQEv3C+Afy/Y+G5Nr49M5y4
         EaExA8WKvfJE6k5AyqC2SRs4OKAXSsLs5Cu0YbHrtdhZy0ITqMeq4ZXIM47OE5ndB/Nv
         AfwSd3pySTpqKYKzNrNuyU59gRx80C5GPHwHLXEM2F1qiY3nZmlaAX3/Go6o+Pk7PtfJ
         K/0w==
X-Gm-Message-State: AOAM530HHhCbq29ZPEX9Rd0nUJjtKcyNYcfoYfMYCgYXQ2Mpn9Eam+l3
        cXukso3ub2b04FIY61/n3z29Cg==
X-Google-Smtp-Source: ABdhPJyg38PLw4/4AevyFkWAsUoEy3gRppS9+Cz/SI2Otq8bgnJU/k3kDNd4Q7TVX1+2h1rFxh2rAw==
X-Received: by 2002:a63:344f:: with SMTP id b76mr4554312pga.388.1599172163775;
        Thu, 03 Sep 2020 15:29:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 64sm1588906pfg.98.2020.09.03.15.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:29:22 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:29:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 14/28] kbuild: lto: remove duplicate dependencies from
 .mod files
Message-ID: <202009031529.78A2DE9D8@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-15-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-15-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:39PM -0700, Sami Tolvanen wrote:
> With LTO, llvm-nm prints out symbols for each archive member
> separately, which results in a lot of duplicate dependencies in the
> .mod file when CONFIG_TRIM_UNUSED_SYMS is enabled. When a module
> consists of several compilation units, the output can exceed the
> default xargs command size limit and split the dependency list to
> multiple lines, which results in used symbols getting trimmed.
> 
> This change removes duplicate dependencies, which will reduce the
> probability of this happening and makes .mod files smaller and
> easier to read.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
