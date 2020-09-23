Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BABD2762A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIWU6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgIWU6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:58:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F2C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 13:58:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u24so485187pgi.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 13:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HTWiHb6gAj8Z8llT/G3EhR3u0c6leg5SleJXuet+BB8=;
        b=kkJi2xE9F6GNVPSdOt/CDrDavOwemWgU8pgHsYleCWQ9ay7rAZwnIjKoU2qKUlVpgz
         eFdUMRympKM8I0L49ut8Q/ioCijl1kSTPIz+hRTFEjtUtdo1ctsv5rwKE++2QBRgTHYW
         CvK2KaUAe1N5R6jzztmvnt7PLRCfqDX6fRFus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HTWiHb6gAj8Z8llT/G3EhR3u0c6leg5SleJXuet+BB8=;
        b=dPEaHDfCsd3tBMtZTBpeq1YoBk2ziGaAsGfvkJlflUf/VX9PKsFfXYZl2T3LJgzYYg
         96L0konS4QJCVY2afwTg/QWGdH1sMa8SviBEZt1sEAlJh1qBcK4lQbD1vgvfXDGZi9W0
         zLJgJYFNax0HkWscY0rjq72aoXmywDcZehRN/6eEFv2TY4wCBq8VGQtE8hnfUbAnvE5H
         mlhWGS6YkOwfSP2J2T/ed5lJehid98aJpuxvjPZuXIxUgKhsU3xVQVCxca4LF8odzzJY
         u9jB7Nbjm3zmZQHqTvDvK+HdcPNG41pvN3ngpA5bJQ+DOGCq36+ND+Kx3o/0rOeyhUm4
         gp0g==
X-Gm-Message-State: AOAM532ie22MLi26DIk4KoRQ5wh5dev79fMOa4HtEpg/EyaAa5IIhbGQ
        TO5WyOEuU/2i1kY9EXDfNupCWA==
X-Google-Smtp-Source: ABdhPJyhYRkdhdAP+zcAthdKp5UM/HYFmn/Q1GmM+HLMtobEh6R/yGHM3nomGFFs2mIjEEFjiu+sRw==
X-Received: by 2002:a63:d242:: with SMTP id t2mr1339749pgi.47.1600894715692;
        Wed, 23 Sep 2020 13:58:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i2sm532018pfq.89.2020.09.23.13.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:58:34 -0700 (PDT)
Date:   Wed, 23 Sep 2020 13:58:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/11] counters: Introduce counter and counter_atomic
Message-ID: <202009231354.3456CB141@keescook>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <e57eb89132000b255b5a7952cb82725ec2f3e4e0.1600816121.git.skhan@linuxfoundation.org>
 <202009231152.5023C4656F@keescook>
 <599e3faa-4228-f867-46f1-66566297256b@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <599e3faa-4228-f867-46f1-66566297256b@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 02:48:22PM -0600, Shuah Khan wrote:
> On 9/23/20 1:04 PM, Kees Cook wrote:
> > On Tue, Sep 22, 2020 at 07:43:30PM -0600, Shuah Khan wrote:
> > I would really like these APIs to be _impossible_ to use for object
> > lifetime management. To that end, I would like to have all of the
> > *_return() functions removed. It should be strictly init, inc, dec,
> > read.
> > 
> 
> Yes. I am with you on making this API as small as possible so it won't
> be used for lifetime mgmt. That means no support for:
> 
> *_test, add_negative etc.
> 
> I started out with just init, inc, dec, read. As I started looking
> for candidates that can be converted to counters, I found inc_return()
> usages. I think we need inc_return() for sure. I haven't come across
> atomic_dec_return() yet.

What are the inc_return() cases? If they're not "safe" to use inc() and
then read(), then those likely need a closer look at what they're doing.

> > > +There are a number of atomic_t usages in the kernel where atomic_t api
> > > +is used strictly for counting and not for managing object lifetime. In
> > > +some cases, atomic_t might not even be needed.
> > 
> > Why even force the distinction? I think all the counters should be
> > atomic and then there is no chance they will get accidentally used in
> > places where someone *thinks* it's safe to use a non-atomic. So,
> > "_atomic" can be removed from the name and the non-atomic implementation
> > can get removed. Anyone already using non-atomic counters is just using
> > "int" and "long" anyway. Let's please only create APIs that are always
> > safe to use, and provide some benefit over a native time.
> > 
> 
> I am with Greg on this. I think we will find several atomic_t usages
> that don't need atomicity.

If you want to distinguish from atomic and create a wrapping "int", how
about making "counter" be the atomic and name the other "counter_unsafe"
(or "counter_best_effort", "counter_simple", ...) etc?

> > > +	end_val = counter_long_dec_return(&acnt);
> > > +	pr_info("Test read decrement and return: %ld to %ld - %s\n",
> > > +		start_val, end_val,
> > > +		((start_val-1 == end_val) ? "PASS" : "FAIL"));
> > 
> > I also see a lot of copy/paste patterns here. These should all use a
> > common helper.
> 
> I knew you would ask for helpers. :)

Heh. inlines for everyone! ;)

> Yeah will do.

Awesome!

-- 
Kees Cook
