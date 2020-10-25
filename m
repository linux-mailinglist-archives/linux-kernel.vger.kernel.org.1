Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118EF298318
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418099AbgJYSed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375821AbgJYSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:34:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FC1C061755
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 11:34:32 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d24so9016355lfa.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w45ysQ8dlqQbKJXQaONZDFky6DEkoeFeiSIPqaku49k=;
        b=NI/MQwQcRFRn4uV0Ew9kx4VxChPI3RwoL0b7b0nzjHuD6l1lkj/lgYvMZdPh8d34hm
         RSW5E8FB9bl1DsnIwe4jspEZNb4BhdSU9COJLtrdy/YKIi/uckLF2Wf1QVGzZWd2yWT+
         oPu2qMISUMNjh2j5OgqSdnipbLkWLAw4iiFCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w45ysQ8dlqQbKJXQaONZDFky6DEkoeFeiSIPqaku49k=;
        b=i7/oy4XTuiXX8CdiWUSPZMYmdFBjwlo5smpLsWGfdI9TXEtnHsQu10MOaRw+eQY9Md
         of1RFqMQL/KCQYq2Ly11J5KEFO3za8v3kjIsT4I621hmTaSaY3l34YUIlDPK+EOuSjkZ
         c2RL7Jc5szeiXEYR2MgIKf9Y2sbc0sc1wVzOH43rWyoJ0CWsCGFaVNwG327Azyeel407
         aq9Q7YT8AnR0hFyrz3xszhFOWhQL1nPGm0SihDEwU3jnN0mEIYcKIcEmANYZMn/JD6Kx
         yb/h7mD5MD48MQkhGOL+NeupQJtb6Loi7eRFBQacWlxcllB+kMphjx/0HSePoW1m/QSC
         E2Rw==
X-Gm-Message-State: AOAM530rMqM3RYnzElCJvuK0yGaVvTnEJf78RHtrsmAa6ocXmKRTgKoK
        DrxugfyenVSbvkRhfUA0WM8fNnswvcpdPQ==
X-Google-Smtp-Source: ABdhPJzOAGyjrBcv/dOwrD+JQ5MYNwRh22vf+NG7CxGztHyC4K+C7GiP4O0pG5ucPvJGKrWE2omo+w==
X-Received: by 2002:ac2:5982:: with SMTP id w2mr3655333lfn.392.1603650870980;
        Sun, 25 Oct 2020 11:34:30 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c131sm810590lfg.48.2020.10.25.11.34.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2020 11:34:30 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id l28so9018772lfp.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 11:34:29 -0700 (PDT)
X-Received: by 2002:a19:83c9:: with SMTP id f192mr3580063lfd.148.1603650869359;
 Sun, 25 Oct 2020 11:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <160363590465.1234.11586095980767794789.tglx@nanos> <160363590947.1234.141731936248952516.tglx@nanos>
In-Reply-To: <160363590947.1234.141731936248952516.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Oct 2020 11:34:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYsdbVzNdPPFKNY1R0d79jdDv442qx1DwLT=RRq6xxcw@mail.gmail.com>
Message-ID: <CAHk-=whYsdbVzNdPPFKNY1R0d79jdDv442qx1DwLT=RRq6xxcw@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for 5.10-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 7:25 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Restore the original #DE Oops message so tools which parse crash or dmesg
> find what they expect.

Hmm. I already got this one from Borislav as a different commit
(5f1ec1fd3225: "x86/traps: Fix #DE Oops message regression"), so I'm
skipping this pull request as unnecessary.

I'm assuming nobody has based any work on top of it, and if they have,
it's not the end of the world to get the duplicate commit, but it
seems pointless to do a pull that ends up with no code changes at all
for me.

             Linus
