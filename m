Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE9428B36F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgJLLJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbgJLLJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:09:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BBEC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:09:32 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l28so2655673lfp.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqgITv96uhiv4tofG7Br6oqHFWwVzpRiMDnXO3YpWUI=;
        b=NJyW1X11l/8YE3lcet1d8uDYVJHpfNSozuqht7/8fJJpKf/T6gCVsrg0OPtWE48REw
         5OXh4tLZ6TGy240WI10hT85+TF9B6HlbiU5O0ZDMmEzu4ahdfhC16ea1KRhFuZ7/XGFq
         iYX/Q+uSRteqi3fZloshE84BWvmI6kqYGCTxPWW+WtUALJOugCWNBfp+EA4mLQqdE+BS
         k89ktqjvslSNgy3wqP1MPNolzPgCthGNABwIgNFLN9TjM7qNgygzliOT78gtLSj4OR13
         dw8F/kEyEjzhNpMYUS8P6pqKCiMLplqtckcZs4psLIp4U2PR+CggS2dpmrLOPT/Pq8Nd
         ahEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqgITv96uhiv4tofG7Br6oqHFWwVzpRiMDnXO3YpWUI=;
        b=uWI3QWBJ1totb8lBI4y9PAkWF4SQDBfz0nsSpl7aJFXQcfugB5n/A+DDhQOcI5UERB
         yglPaJ//hiILoEocXNKm7q7spwMoF/EqiZrc7bD0DJ5lk+mkeATEdyg418cfs2NVJMQH
         IhlloPK4D64G44zvoIivwW/O7FnCuRqxfnjzDGDLbb54NcTypc5pAidt+INBe8+2fMM7
         Xjen4jn2+3xjBRuu5hm/3MDO8zL9ZvuyqjJWi61N8Zjs5/yd9u1v3I5dalAquu8bhhlJ
         voFbW12l+ES+SDEx77bKy7oK/kZTU/qb2i0ARLEEEh/Bd0myaZrCM/NgpT1zr2wHWf1H
         X0xA==
X-Gm-Message-State: AOAM532On3k9aou5UwVRWPKren8wJXmscJM48iYS3ZKQHHKQqRmNKhnU
        hrjNbMf/q/HOFcVtgr6nCVu9QVPDjUKKfMCeSs69BmXrLPk=
X-Google-Smtp-Source: ABdhPJxfK9Y94Lgk1SW9hfdCv2UjuQ7XhgGr512P35REzwk83kwFHDJnIpg9DcITri9+MzaITvkmYEDHce1dpy80Yy0=
X-Received: by 2002:a19:7018:: with SMTP id h24mr8643526lfc.252.1602500970781;
 Mon, 12 Oct 2020 04:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2009031605190.2496@hadrien>
 <jhj7dtaokxe.mognet@arm.com> <alpine.DEB.2.22.394.2010101740290.2691@hadrien>
 <CAKfTPtCPapkwS7B5X3XQsQFx7GXa-RSzRWO1e6n5JzLT7nTvrA@mail.gmail.com> <alpine.DEB.2.22.394.2010121232410.2901@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2010121232410.2901@hadrien>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 12 Oct 2020 13:09:19 +0200
Message-ID: <CAKfTPtDqKqoLg9OOYMy5bVVnQKGNb3Z9hL6tWaxqKzv2+NdFXw@mail.gmail.com>
Subject: Re: SD_LOAD_BALANCE
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gilles Muller <Gilles.Muller@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 at 12:34, Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > > Would it be useful to always check whether prev is idle, perhaps in
> > > wake_affine_idle or perhaps in select_idle_sibling?
> >
> > Yes, that would make sense to add a condition in  wake_affine_idle to
> > return prev if this cpu is not idle (or about to become idle)
>
> The case where this cpu is idle would be in the interrupt case.  If both
> prev cpu and this cpu are idle, is it more desirable to move the thread to
> this cpu or to leave it where it was?

I think that we should keep the current behavior regarding this cpu
and the shared cache case and add one more test before the last return
of the function.

right now, we select this_cpu:
-if this cpu is idle,  it shares cache with prev and previous is not idle.
-if it's a sync wake up because we expect the task to use local data
of the current running task on this cpu.

Then we add a new case to return prev cpu if it is idle which is your case


>
> julia
