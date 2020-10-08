Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7E2287A70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbgJHQ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 12:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbgJHQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:59:38 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D1FC0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 09:59:37 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b10so1184603qvf.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDfxYtvvuUlHPjp/UryiR3z82AL5IMXxGc4N8yJFAH8=;
        b=dYafy2qhKL78nC90MkoOQZOk+KZv8xX0vL3ui37u6gtvf/zKI9wulZSzgWi5ji1GmY
         a7nobnXmZfuwHwETk+vS6on4VEdCUGVIznSBIZaHzxEg1TMkIwWGLzSgXG/zNk20pzfg
         KZ6lrabGTTvEEj9X7Im975xG+yrv1otXkZUksk86V5haQO4VonW0O6Jzn+0jI5eeInsc
         /k+I2eAUAV8nlm8RqMIN/E3WAn+v7VeeQ39IqSqxgZSVZqANarF2Cff4HywSepe7kdSb
         FlxjAHkdXTB/8cDp7azuueiu++naSRfNeqozHMwVfRxkBcPXTr4CT/LfPVtHTamMwnhM
         K+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDfxYtvvuUlHPjp/UryiR3z82AL5IMXxGc4N8yJFAH8=;
        b=N2fWK62vYCGvIRUcx1EwjEXYl2EWLXK7pCzb7mvMZ62qBUPaRzySmA08U+3MWuV+BM
         j02/R9828aOF9UOf/Jm8ctbwtyr8qa/E5AOdiJ3crFrypOPcrzjgxjFctaZKZcWNEki1
         Z+SbEvbYSrNdGKer9GYQ3+dcStySju5iru0ph6B//6tgTfDzKZEeI57aAGYlonfYR7he
         G5B6jOZ6Ab9Vsik3d8d3c9Ur3niAu9OPKMQRloRb+v4DWQemQoOAvfPWL6MkbK6DygFU
         NP4QkL8p7mUG39Xim0c31dtjIkQOV8tWlmKZ/l0GKog5pSb9gV7HmTcMqO+IXIez4J6A
         o4KQ==
X-Gm-Message-State: AOAM5306P8C/SXnRAwHYM1s0twWJbL4EMKb4N4zXMztDd1ThG7eTMB95
        5D/n+Rm7n2ulaq4iEsPRD9uODY/Yzpfd9A9ra0cjrw==
X-Google-Smtp-Source: ABdhPJxVvJE8adLq7/QRWgtibNwolccI0QK0yhgp6S5zvzns9wUWgUouwgUdqK3UIR09BIuRSUwe7A4Fwb4/xzdvMxw=
X-Received: by 2002:a0c:e5cf:: with SMTP id u15mr9219809qvm.14.1602176377192;
 Thu, 08 Oct 2020 09:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <160197822988.7002.13716982099938468868.tip-bot2@tip-bot2>
 <20201007111447.GA23257@zn.tnic> <20201007164536.GJ5607@zn.tnic>
 <20201007170305.GK5607@zn.tnic> <CAPcyv4jgLRzDzXkbdHwA-XUwWuSoA1tZfVqgvFQ5jxq=m2P_Bg@mail.gmail.com>
 <20201007192528.GL5607@zn.tnic>
In-Reply-To: <20201007192528.GL5607@zn.tnic>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 8 Oct 2020 09:59:26 -0700
Message-ID: <CAPcyv4j=EfGKO6nNBggQunxmkOQqxAMX1M5kQDr68uU+ZQnRLA@mail.gmail.com>
Subject: Re: [tip: ras/core] x86, powerpc: Rename memcpy_mcsafe() to
 copy_mc_to_{user, kernel}()
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        stable <stable@vger.kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 12:54 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 07, 2020 at 11:53:15AM -0700, Dan Williams wrote:
> > Oh nice! I just sent a patch [1] to fix this up as well,
>
> Yeah, for some reason it took you a while to see it - wondering if your
> mail servers are slow again.
>
> > but mine goes
> > after minimizing when it is exported, I think perhaps both are needed.
> >
> > http://lore.kernel.org/r/160209507277.2768223.9933672492157583642.stgit@dwillia2-desk3.amr.corp.intel.com
>
> Looks like it.
>
> Why not rip out COPY_MC_TEST altogether though? Or you wanna do that
> after the merge window?
>
> It would be good to not have that export in 5.10 final if it is not
> really needed.

I'll draft a patch to rip it out. If you have a chance to grab it
before the merge window, great, if not I can funnel it through
nvdimm.git since the bulk of it will be touching
tools/testing/nvdimm/.
