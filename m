Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0862C33A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 23:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbgKXWEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 17:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731800AbgKXWEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 17:04:08 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936A9C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 14:04:07 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 18so11383502pli.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mprkldjb7CjnHozwqyjj+Jl9qcuDOi72QFxjdMqMlao=;
        b=mMLjin9xvm7UjvLFOvfEmfJpDOC7c85RswKHc8n121a3BqSZ429co2QEMkq09h7PGD
         /pnHcRwf9Yq7g07bYgg2AV8/2vndniTYuQlEM0X0PKI6Yfy3FvpLfdwPZSS7j/jxp4vd
         LOeKHavDBHSg6VuZ+W191jH1sHCsHkaBVq9IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mprkldjb7CjnHozwqyjj+Jl9qcuDOi72QFxjdMqMlao=;
        b=LyJHlFX1V2AiQR1smeK4Khb4s/2myUSDqYRQU/JLEc4Gk5Bgyctlpkiwi4CaGJTAM3
         cTOGTfxrKF88G7m+abGOc4Mua6y9Mg8N/ldizR6M4FIdPGUDkIHUGLd9y3dPCgBLxLEl
         wroC9xAmoj6nlU1gQiGAmL+8p91kRmOQ3/hnrpSxblNaqzEeG40WjsX+PbMeRsLJjV2A
         eLBPAB0Xrr4ykqBhFFcPvi6Ni3emRfcQeaqniIHOXcuTq37v9gSXp+8HqaBWy/Y1vJrb
         wZXTyUSPPOMMqUI7uViiEnutTt5Z7mb57mFWyzJLUmWp/stqLqJxvSo/mF6Hl1MBSowO
         UKow==
X-Gm-Message-State: AOAM532Wa5iuTTvx7oNlUwBGTiYDlHBuC440pVVzxBTMM/MsMpJaiRpE
        CAFubCSTfJEAWSM62xFMCjhbIg==
X-Google-Smtp-Source: ABdhPJwWsNzP3VcgbsHBRHePZyiD5EvmfBK/FQikTLooHtKWBj3ykTgPDCTI0MdKcQzupXKJ75E4ZQ==
X-Received: by 2002:a17:902:bc46:b029:d6:d98a:1a68 with SMTP id t6-20020a170902bc46b02900d6d98a1a68mr276371plz.63.1606255447027;
        Tue, 24 Nov 2020 14:04:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ne22sm184262pjb.45.2020.11.24.14.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 14:04:06 -0800 (PST)
Date:   Tue, 24 Nov 2020 14:04:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] scs: switch to vmapped shadow stacks
Message-ID: <202011241404.9EA7F5F@keescook>
References: <20201124195940.27061-1-samitolvanen@google.com>
 <20201124195940.27061-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124195940.27061-2-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:59:39AM -0800, Sami Tolvanen wrote:
> The kernel currently uses kmem_cache to allocate shadow call stacks,
> which means an overflows may not be immediately detected and can
> potentially result in another task's shadow stack to be overwritten.
> 
> This change switches SCS to use virtually mapped shadow stacks for
> tasks, which increases shadow stack size to a full page and provides
> more robust overflow detection, similarly to VMAP_STACK.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
