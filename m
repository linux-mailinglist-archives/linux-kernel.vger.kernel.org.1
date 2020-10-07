Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84FA2866C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgJGSS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJGSS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:18:28 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665D0C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:18:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p11so1413131pld.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LpH0udS+5sZxGKcOCcpSntLVJYC4Z+JELN0EkMDhhP4=;
        b=OLQyg643Twbke4GIl3mcjZAcEQELjp0D7Figkfqp8u/1xiAfvy4hg1AIVPl3jc92Ar
         xzhjjf53uaKXnyuLJlS9ITdMevBOGY6FPvbOZDBplMgu9pUDRP31IbUeUCGIS9Madsaw
         7PYjXCIllM9+cZEgBGlnaldCEzsbb5AFb8WsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LpH0udS+5sZxGKcOCcpSntLVJYC4Z+JELN0EkMDhhP4=;
        b=oikIo+ngNlLXjaNmNo+xXJY9BPY1gcZ+gGzqfubAyblhEiGxCcdvzQGewTtDjVOftA
         AsOUP1gvQEpiLOYeHS0ir1VOl32qEOTusJwFR9Dm8SWPepAWALf8UtEg+4m1rg7yRGow
         X35AT2VSm3BAzsMBdVP23boFKvdP7KOdfnvLRn58PaCkXW45GfLF+tt5EO2XXFjdjc/i
         mEyh+2ho1lsNYCuH8ICaJHwDPPCPNI6/pPyW5Y0bh7j8QzSsU8qR3D+R2jmTWhGJ8WVl
         NwtEd99U6oNA/WoeBiqvlbe47mnwUn/pHPuZjKxt3gjWgy7ywXebeoq41wbtTiVl/OuH
         DFxQ==
X-Gm-Message-State: AOAM532pzdEZjoR0H3hfCI+C8fhIq0GMZPXC/IWrGGPV/sbbWzSxZlEP
        pl7ReUQd5aJaLoHqmFf7O0XrAA==
X-Google-Smtp-Source: ABdhPJz2uwZluN07GtoySh0k6r1mG+ey8lV37M+Wn8f8i+zxmh4WShlTkbIPDzxTcBzHnSQmwk5uKA==
X-Received: by 2002:a17:902:bd83:b029:d3:b3bc:9e7c with SMTP id q3-20020a170902bd83b02900d3b3bc9e7cmr3912824pls.14.1602094707996;
        Wed, 07 Oct 2020 11:18:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c15sm4048937pfb.171.2020.10.07.11.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:18:27 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:18:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] drivers/android/binder: convert stats,
 transaction_log to counter_atomic32
Message-ID: <202010071118.2ADCE5D@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <63482420f221c3483f6526bfc12fc99fe30a567d.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63482420f221c3483f6526bfc12fc99fe30a567d.1602011710.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 02:44:38PM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> stats tracks per-process binder statistics. Unsure if there is a chance
> of this overflowing, other than stats getting reset to 0. Convert it to
> use counter_atomic.
> 
> binder_transaction_log:cur is used to keep track of the current log entry
> location. Overflow is handled in the code. Since it is used as a
> counter, convert it to use counter_atomic32.
> 
> This conversion doesn't change the overflow wrap around behavior.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Yup, seems to be stats-only.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
