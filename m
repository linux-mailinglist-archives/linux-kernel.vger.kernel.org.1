Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2472B2227
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKMRZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgKMRZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:25:42 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38823C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:25:56 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d17so14973645lfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtwsBTxcH0hJIQcFMOiObiT6d7rNSt5i2qlH/gTuMWE=;
        b=V2+kCbh54UeSxo9yDFdtMqLQb0VmsfVldOxrOmBM9PZhj1QDRerF/pvZon0ZX3J75J
         tCpvPZPBQFC1r9CHUfta4HPp9R0OR73Js9PL5yDn4+u5UmYE8N2QP4Ybryfl29L1B23W
         rzntaDTxbI3T+hI02fTxY9ZiKaJhr73e415+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtwsBTxcH0hJIQcFMOiObiT6d7rNSt5i2qlH/gTuMWE=;
        b=Bzr/yEvcJniUYrfCnh+Q/vbDi5IGPGT98oBsIb7M/qA7JPNIuzD9PTKUyp1gfpGJUD
         wPsjZWDNSsjtW+gBu98EkQ5+6KBUbYlCcLLrf7wslCuBUIFEZmq1kXoMgNsyNurwLMAx
         HabqAGTNOjgyG2h7K/PagRVL+Dw/8YMjqWNBGz/bCg0O/N/sLgDDvTGtm7Dxg3GXJlX9
         yxklJqCU7WtJ2hrS6ZMik7POqWSF6GcTLofjZhGMlG77nkK9ivUJJdPkUEpAX/oJL4Rs
         RusNBubu1Di+Ce4NhgwWe7+VSbla+ihS9f3PnT+EGuIL20q14gUYpCRTHsdpOWJ7wf8b
         uaGw==
X-Gm-Message-State: AOAM532TsRkz+X+FbM/CkV0G8Mybhym2XZSm/+rWLlJQLhlVNczWGxPf
        +PAz+8tVcjnvNn0SOvaKWdYV3hgFwoql4g==
X-Google-Smtp-Source: ABdhPJzoEgSaD3iWzo7bPAQ3yK/GwUq4aqwLxQ6R8qPZ7OY8FJlRB4eS2cBR4eqhbcfzIwPOHGe2jQ==
X-Received: by 2002:ac2:4ac7:: with SMTP id m7mr1256079lfp.572.1605288349456;
        Fri, 13 Nov 2020 09:25:49 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id o206sm1615410lfa.278.2020.11.13.09.25.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 09:25:49 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id l10so11621104lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:25:49 -0800 (PST)
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr508412ljk.102.1605288346909;
 Fri, 13 Nov 2020 09:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20201113123934.GA22014@willie-the-truck> <20201113124440.GB22014@willie-the-truck>
In-Reply-To: <20201113124440.GB22014@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Nov 2020 09:25:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh-0QaFqp63MtnfSORWCOLg0zFCasqZ9X7y0LBcZG_ihQ@mail.gmail.com>
Message-ID: <CAHk-=wh-0QaFqp63MtnfSORWCOLg0zFCasqZ9X7y0LBcZG_ihQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fixes for -rc4
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 4:44 AM Will Deacon <will@kernel.org> wrote:
>
> Looks like I managed to munge the subject for this (somehow dropped the
> leading '['); I've fixed it here in the hope that it gets past whatever
> filters you may have, but I'll resend if I haven't heard anything by
> tomorrow afternoon.

It doesn't affect *my* workflow (my filters aren't that exact), but
you may find that the pr-tracker-bot might be ignoring your pull
request.

Anyway, it's pulled in my tree, but I'll do a few more before I push out,

              Linus
