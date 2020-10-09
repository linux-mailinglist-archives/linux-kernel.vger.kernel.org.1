Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19794289077
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 20:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390309AbgJISCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 14:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390311AbgJISCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:02:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72792C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 11:02:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so7491920pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=82tc9bijY7eYHUiBR7/+7S4+ke1Xx3gSAVnH9YUL39A=;
        b=bwNwZI67i20FYMbRpq2yggOakGtsdUUDue21HOpNiARLfBWCRHrwuSL9qbGsMrLoBp
         SGRwjyrN7lk7cf5nePY6B6mxhwgt9EzzuUDnena2Mt8O6fHSW1xQ5WXSIaPoztiZHCJl
         XrJ4n7BAqKlIpvMIF++Ivyrdh7wo7iV9eUAD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=82tc9bijY7eYHUiBR7/+7S4+ke1Xx3gSAVnH9YUL39A=;
        b=A2CsnyQWiXyTzz+B6gQtAK0P4xWtsKZJzSGPpwwdMOBet+gm2WUACaCR9F16ekUzEv
         9wfSWm4itPw9OPzZPjKJTOyFzSUWk9O8lXu9g5/KAFAML1aBtFoZ/t8M+Z6myYtHxRgn
         Q9im7uiYPt8CkPDYTROyq6lLN9Xz6N34hpmKd0uUasBXCbqmQwEbBvDjOOIQWgvN1juZ
         vuQbuVvJ8QC8lUA2H4KzHJAInYO6QIrHziGiSnuQ/RHI0bYiBwx5a0a1e0zhBt4+t+HW
         Cvam7LMmnUzYHiRgHZuSaV32iZcFXjBgCi2/obZNAeYTOaEDBwViVmcUDyoV5RBbNzZo
         rcZg==
X-Gm-Message-State: AOAM531HtoSGdCpOZvltR7hfWpYb1+cjnUUnAsZktyfnY1I4h2IowzHl
        J91eeGvf2FUvH8rJIu5/cC4UCA==
X-Google-Smtp-Source: ABdhPJzL58yvwVxzzxLJLp+x1MlHhgmKyjYbSJmKsJFFoEYKnWBWftN/hNW+ep505ny+Iw1sXPCo/g==
X-Received: by 2002:aa7:97ba:0:b029:152:879f:4789 with SMTP id d26-20020aa797ba0000b0290152879f4789mr13378225pfq.81.1602266553024;
        Fri, 09 Oct 2020 11:02:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1sm8452178pjv.2.2020.10.09.11.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 11:02:32 -0700 (PDT)
Date:   Fri, 9 Oct 2020 11:02:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] drivers/base/devcoredump: convert devcd_count
 to counter_atomic32
Message-ID: <202010091102.2E1886F8FD@keescook>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
 <9eee4448ec53e3a875e6785fa63bcda211e09d23.1602209970.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eee4448ec53e3a875e6785fa63bcda211e09d23.1602209970.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 09:55:59AM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables wrap around to INT_MIN when it overflows
> and should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> devcd_count is used to track dev_coredumpm device count and used in
> device name string. It doesn't guard object lifetimes, device usage
> counts, device open counts, and pm states. There is very little chance
> of this counter overflowing. Convert it to use counter_atomic32.
> 
> This conversion doesn't change the overflow wrap around behavior.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
