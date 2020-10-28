Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D9329D8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389115AbgJ1WlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389104AbgJ1WlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:41:15 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75617C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:41:14 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id g7so1105181ilr.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5SZQmdLgSMsTMh5N7wjZ9t5e4jwQtmWIGdj3rhKdzHk=;
        b=EaN3bw4M7PDWoIeh9EpkmAWfVk8iVyUhbgz3NbSC3lZ8kKmgZpNjF8qJSTSdkJ1deY
         wDgIxrsKtnYUuXSIR/k22QBQa+S+yFfgNBxtYXyZUhnb8WG3PEFpQhdKZL8SteLKmGu7
         hN1SPMfJV2jtdUctvNg1zHABkShaFyFPjdAg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5SZQmdLgSMsTMh5N7wjZ9t5e4jwQtmWIGdj3rhKdzHk=;
        b=pzFvEwfYYjUoxAMn2aDBx00rCHb4z0h75mowJxqUXbts1R/aHEHhIHVtykGXfL8sDp
         GoQUfbVyYpJ/3mrlponnUqM6ewwvl8nLcmCF4gY5vjZucN0225NTvBCQrDiJujCKoYSp
         XORzZX6ktNRQTJKveHQRMhV8xUaM9X4r6vHX2OAxYrm5WfOWGGGOOwRgaN4+Z1UdDCbQ
         6zgOJunAU8OOR75gFanbz+NMiqgzsgBd6Ycr6/TNsxraUitm8nfXCghf0GsxvvXlw300
         NICunB0loqYQuabnqMPo4XtBIcvj4FJNVceyGSa/7rSHaUPWti5aRWJfQVHfkraspvLW
         g5TA==
X-Gm-Message-State: AOAM530t7zBn8tDqCgyE3G2Sb9eXbXLzr8Mc9ZFuNytw+f7q/nvpgNEs
        V8u/pE2uSLaC7DCjna//SoPxpooJsd/R+A==
X-Google-Smtp-Source: ABdhPJzfG6Uc9rVXeToUMyajHEvo8Jx0sQcS1JMQi8JtOOb+M+mA02qMPg93pnFfnLg/Eerx/cOkLg==
X-Received: by 2002:a65:4386:: with SMTP id m6mr26076pgp.319.1603900774513;
        Wed, 28 Oct 2020 08:59:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d26sm32423pfo.82.2020.10.28.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:59:33 -0700 (PDT)
Date:   Wed, 28 Oct 2020 08:59:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Meyer <thomas@m3y3r.de>
Subject: Re: [PATCH 4/9] pstore/ftrace: Add recursion protection to the
 ftrace callback
Message-ID: <202010280859.4AF923236@keescook>
References: <20201028115244.995788961@goodmis.org>
 <20201028115612.990886844@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028115612.990886844@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 07:52:48AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> If a ftrace callback does not supply its own recursion protection and
> does not set the RECURSION_SAFE flag in its ftrace_ops, then ftrace will
> make a helper trampoline to do so before calling the callback instead of
> just calling the callback directly.
> 
> The default for ftrace_ops is going to assume recursion protection unless
> otherwise specified.
> 
> Cc: Thomas Meyer <thomas@m3y3r.de>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
