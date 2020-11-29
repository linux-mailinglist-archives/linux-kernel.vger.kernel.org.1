Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E662C79F9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgK2Q2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2Q2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:28:35 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4339AC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 08:27:55 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id j205so15725955lfj.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drummond.us; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tiJRMQRH4q3fKZnXwsXdsiQdiiHWVfi/e30ZlSZ5bA4=;
        b=FpQCN7t3z5sxP2RvrV2gj1PsI8mRtSfsMUenJ0wVzH+8cOLDWD1rUeBjJOq3fiE1Xc
         oX1LsaghcwoEiDq8MADfqR9ld4PT94vE2gbPLURuxqzRF86tQBHu7wPjnOSAs1222xHk
         SB/7sV4kqzybbRItqi20ocuPu5peSzM0PKzGJAa/FXLh83+qTJvFAeCfbvTX9A8J5Q1Y
         B26FvBEa/QYEwfM9Q6Q/VotU7HDNOco8tw4LTDi3gmN4hbsx4bBTpL3/Pn4wztcrM4Ql
         YOA88jClX+ceaev86VmVP9HuMb1dAvfBmpXbOpyKPVEX5rmsVXahI52olSTSpftY/FxM
         wqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tiJRMQRH4q3fKZnXwsXdsiQdiiHWVfi/e30ZlSZ5bA4=;
        b=mWqqwW36INhao7GYfXGBG1EKnJAkFRT9m0wpoeLvU7tZT4BTvYoblpxiL49AezKVow
         c92toT1kishcs4TgPQKruPHb/zF45sWxeYaLsVkAFaGsQEMcYGagNXojzSKwKi5JVaWh
         Tu5ApAevM4VUZ7L+Zeg8DlTDWhFn+gvXe1e2q9CZ6Kb0OUcGpweya8+NC/llqBb9jk/j
         EQtSNuvPuHYOrXZoGfWZG9Wfzjd6WaPMjyygC+wH5o9wUiFKbuQ7oj/RhxrTP5Van0MQ
         cCicWMSAZm+/8eBWLS4xnkY2/pMaC7aNEvnIBD8INP0LUbcW/px35P93M9VCd+ws9R/p
         BMhg==
X-Gm-Message-State: AOAM530c1BYprIYrDez1/uCM8MQbEyJp9+vi40JdugbqNTctfKGaddsl
        +cfy3oyj8BBJNbwEfMhndHr1w12VPvJt2pMJgsSvng==
X-Google-Smtp-Source: ABdhPJynoT0ee6fZ2hfZAEtQtmba84Bu6N9+Myxr9eQiSpf5ahGfldA70FE4iV+AybcUsIRhyBZKi+8g9j1WsGtaOQQ=
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr7027719lfr.418.1606667273429;
 Sun, 29 Nov 2020 08:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20201119221132.1515696-1-walt@drummond.us> <20201128052317.GY3576660@ZenIV.linux.org.uk>
 <CADCN6nyGW0=QS=J+704n-mtAqTxgVrKZC=P8d01NZ_pjssptew@mail.gmail.com> <20201129032823.GA3579531@ZenIV.linux.org.uk>
In-Reply-To: <20201129032823.GA3579531@ZenIV.linux.org.uk>
From:   Walt Drummond <walt@drummond.us>
Date:   Sun, 29 Nov 2020 08:27:42 -0800
Message-ID: <CADCN6nx3oqNcYxa7xCAybK2Aygv1GugTnMxs=EO2bQMStiejzQ@mail.gmail.com>
Subject: Re: [PATCH] x86/signals: Fix save/restore signal stack to correctly
 support sigset_t
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, brgerst@gmail.com, linux@dominikbrodowski.net,
        gustavoars@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it.  Thanks again Al.

On Sat, Nov 28, 2020 at 7:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Nov 28, 2020 at 06:19:31PM -0800, Walt Drummond wrote:
> > Thanks Al.  I want to understand the nuance, so please bear with me as I
> > reason this out.   The cast in stone nature of this is due to both the need
> > to keep userspace and kernel space in sync (ie, you'd have to coordinate
> > libc and kernel changes super tightly to pull this off), and any change in
> > the size of struct rt_sigframe would break backwards compatibility with
> > older binaries, is that correct?
>
> Pretty much so.  I would expect gdb and friends to be very unhappy about
> that, for starters, along with a bunch of fun stuff like JVM, etc.
>
> Ask the userland folks (libc, gdb, etc.) how would they feel about such
> changes.  I'm fairly sure that it's _not_ going to be a matter of
> changing _NSIG, rebuilding the kernel and living happily ever after.
