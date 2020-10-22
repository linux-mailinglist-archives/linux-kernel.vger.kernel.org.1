Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E820296767
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 00:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372979AbgJVWit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 18:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372972AbgJVWis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 18:38:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8343EC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 15:38:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f38so1630751pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sM7T5skUjFddu7eojter1UkXlJtl9na/jTfvt1eFjX4=;
        b=ShZntCW6z+yuAjiKM489Xf4bVq4gZd/uIr6PBtb5oCN0fAX0jHAoObwg327SZDHjOG
         QEub7P91eoFYGtPLI8y59rU+L131ItpM/Dk1n+qan1tw7v1rCcm8YIlnLhZM9o2vcpg3
         Ek730Y16mUiORVzJ9dGGPZUBroU7w4PGMt8oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sM7T5skUjFddu7eojter1UkXlJtl9na/jTfvt1eFjX4=;
        b=DSDUOM1P58DZfjSmTR1tZkkPIVDCTnsNPSQkNoN8ugImhsb1+g6C0o5YUCnxSX4mr6
         BCPSPo9TpUK05QikDn1h0j3Hw9V6coOIhH3N7o1DmGUIncxc3rbq7kAhw+oAK3El0ko6
         Trj4W8rhtSHN3Nvwd4tAzBw9XSf4Fydy5f4VrGbDSad6ZQzMn74oH6AvHAs4n/vRMr6Y
         ROvx8E07vSjdQY8EP/MoAPeXZnMaEkdWjAMYyoGSqpcTEmIlXKwuIym7ibCqSfEhT+JX
         Sh7PALl0hkCmQcc+RTKPuIUea2NRzoBR+uuZlZeGPxui45VMpsu/OcHjymcLPxouv9kO
         NTZg==
X-Gm-Message-State: AOAM531iFOUp3D7ryvD1lKul9iknOdKqpDsCDVC+VSgHPzsXybx6NPnU
        +8kqK6VHQKVLtxpzzgHaBsYB/w==
X-Google-Smtp-Source: ABdhPJwRP0IOyYmm6D74/zs+c9wVZx6GWt+/ixSaQyDtwiP5gp72p1nNZjB7fXxPG6ccqpGwt9KjKg==
X-Received: by 2002:a63:190e:: with SMTP id z14mr3892459pgl.272.1603406328086;
        Thu, 22 Oct 2020 15:38:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q24sm3125113pgb.12.2020.10.22.15.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 15:38:47 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:38:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: scs: use vmapped IRQ and SDEI shadow stacks
Message-ID: <202010221538.92E6C83@keescook>
References: <20201022202355.3529836-1-samitolvanen@google.com>
 <20201022202355.3529836-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022202355.3529836-3-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 01:23:55PM -0700, Sami Tolvanen wrote:
> Use scs_alloc() to allocate also IRQ and SDEI shadow stacks instead of
> using statically allocated stacks.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
