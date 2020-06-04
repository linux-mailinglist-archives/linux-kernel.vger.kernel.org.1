Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB381EEDD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 00:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgFDWjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 18:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbgFDWjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:39:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9E4C08C5C5
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 15:39:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s88so1845627pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 15:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zP55TDVJhIIf3D70exLW80PJ5Fxq6s8zGifToJ/Z0dc=;
        b=STEhsSBGd7DFiZ3UGgyOyWz0+OZ9/KhsvcAnzAOd8JPwZ+zr9/aF/KViUCztgCBy92
         FatcX4M5pGBoOm8c8fRwdwYT3SzCZxJMA26B6VZq+yhs3wn+33OYZkPO81JIjxz9C4lx
         SscwjwS9vUKhcxU5a1rLbY73RBqedLSon2/zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zP55TDVJhIIf3D70exLW80PJ5Fxq6s8zGifToJ/Z0dc=;
        b=HohSGgKqNyYh45QKZnSwnOsMgtUv1cDAQw34zym8Avy1vqjRCj1bFJs8ft5h1uY7SL
         kwmWFxRMK6tQ6W2Lzv7U7JymJ6IOcf683Ndk7SZxAPt58ylqX4ygnj3TegtLwLkrlDQP
         tLHHYU5oSvTWCaXrzn2XnLo8vIH1/y+i0JpRFXa2HXvYA1EcJRunUFNX3dxoyI23Of9W
         2D+s9867sz873GgjR4OpJ+tWIDK9o4FzWtFJKayNOblrZB61McDxPxuT5DrYGqcsJQmR
         s/gaQ1i4i5p9WLnxhKSdK9NPAiuUEgGoj012dDykjju3Q7Hu6S7yyR0+Jvma5qTtWJd/
         +vEw==
X-Gm-Message-State: AOAM5326o1k4pSDbLpBckx37ztyRlX5c7WLtstjAchY6Kyd1k4Lnxvef
        rnSMgUGuudXsR/LNstvolxAJ7Q==
X-Google-Smtp-Source: ABdhPJz5rSeyZzVAkY37cQQqAUZMY9xHYrA838IOdkb8jskKkK6guA0WdZONNuWfyJeZYfJH5ZIBCw==
X-Received: by 2002:a17:90a:c293:: with SMTP id f19mr8170642pjt.91.1591310370635;
        Thu, 04 Jun 2020 15:39:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nl8sm7407988pjb.13.2020.06.04.15.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 15:39:29 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:39:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 01/10] x86/mm/numa: Remove uninitialized_var() usage
Message-ID: <202006041539.B8C0C768@keescook>
References: <20200603233203.1695403-2-keescook@chromium.org>
 <874krr8dps.fsf@nanos.tec.linutronix.de>
 <202006040728.8797FAA4@keescook>
 <87zh9i7bpi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh9i7bpi.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 11:39:05PM +0200, Thomas Gleixner wrote:
> Kees Cook <keescook@chromium.org> writes:
> >> > -#define NODE_NOT_IN_PAGE_FLAGS
> >> > +#define NODE_NOT_IN_PAGE_FLAGS 1
> >> 
> >> but if we ever lose the 1 then the above will silently compile the code
> >> within the IS_ENABLED() section out.
> >
> > That's true, yes. I considered two other ways to do this:
> >
> > 1) smallest patch, but more #ifdef:
> > 2) medium size, weird style:
> >
> > and 3 is what I sent: biggest, but removes #ifdef
> >
> > Any preference?
> 
> From a readbility POV I surely prefer #3. i"m just wary. Add a big fat
> comment to the define might mitigate that, hmm?

Sure! I'll add it.

-- 
Kees Cook
