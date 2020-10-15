Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEAE28F724
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389920AbgJOQuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388946AbgJOQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:50:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD40C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 09:50:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m16so3853774ljo.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAcK/uz3uKuvMsh9kfadMprX96KfVb2cSRE6Q7xqAIA=;
        b=iMl4IFwGCpOi2UVdYcL6O2RPbnga56eLF2LWGMNltKgLSgluaT3+02FsUDX0jwNtrd
         bIiL+pRnzQAch4aVD97sP2PZV9u5Nnb5iQqbW4XU9t7b6icWJPLfCuLpyr5fGK7Xf7pC
         u9rinty+Y2q+3YZeFDLpw6goZlZ5R+s15VWzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAcK/uz3uKuvMsh9kfadMprX96KfVb2cSRE6Q7xqAIA=;
        b=r7ZcL+vmtxjj1q9LMhKaWqBjAN0hNddWsD4FtwlIRwZ8N4seZuzwUeSpdr4cN41AFt
         vwV0RwT9TI4dMyppC2mhzp1AxxjNuTP6E06h9xj1ODuKieY7rksXtn1+WUIF4htHkwOy
         IxgoKPX5KV2CrCi3BNbvMe4FvaDx5k/bt1gIpTQy84UAkgIJYPsRIDUAtlTmBzIWYl03
         UOfJcgorjnW4sO6hFSDHDxQPbtUhP89AJ6s4QIIsJou6C9xIo6h99QanG6pw9hyvGM/k
         Lmg1AhqTbefYipwWvAC99CQqJ5YRnWlemv5OPNqraZI8P+pllnW2k9GcmJClOvXQwnF7
         aUJA==
X-Gm-Message-State: AOAM530mBKopYz2NXquYJ6VFnvxPQgQvKxIbhKujm+dVCk/NptZzVs//
        gCecJoPkzMdhBUf12RsW/qDd0AzVFgOb5w==
X-Google-Smtp-Source: ABdhPJxT2yJCVusxltkG+xBh3HdwsyJvOI2rDA89RXfjxftG1hv0If3DVy07xd7UA67IyHqEv9eZyw==
X-Received: by 2002:a05:651c:11d2:: with SMTP id z18mr1601133ljo.423.1602780618200;
        Thu, 15 Oct 2020 09:50:18 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id q2sm1227244lfe.50.2020.10.15.09.50.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 09:50:13 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id c21so3814249ljn.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 09:50:13 -0700 (PDT)
X-Received: by 2002:a2e:868b:: with SMTP id l11mr1598002lji.102.1602780612838;
 Thu, 15 Oct 2020 09:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201015122713.GA4021230@kroah.com>
In-Reply-To: <20201015122713.GA4021230@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Oct 2020 09:49:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwi70PmzxNeNUBiGTgQMDnRhHToTkQrhL7GQKdJyUQAw@mail.gmail.com>
Message-ID: <CAHk-=wiwi70PmzxNeNUBiGTgQMDnRhHToTkQrhL7GQKdJyUQAw@mail.gmail.com>
Subject: Re: [GIT PULL] Staging/IIO driver update for 5.10-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 5:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Included in here are:
>         - new IIO drivers
[...]
>         - no new drivers added or removed

So which one is it?

New drivers, or no new drivers, that is the question: Whether 'tis
nobler in the mind to suffer..

I do understand what I think you meant (no _staging_ drivers added or
removed), but it really reads very oddly.

                 Linus
