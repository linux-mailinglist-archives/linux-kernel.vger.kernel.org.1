Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D2E2B42DD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgKPLdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKPLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:33:12 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1B1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:33:12 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id c129so15333828yba.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGE/8zZSbrMYM1BfuDIYlYWu/KQaD7nuUUEC61XDj5g=;
        b=XHsS+MRqQF7/ddTQTacN4pm7PHH4Krd4KnI7MEHyyNDvd1NVVU39XWuGhqPjBt/FhR
         CGJ6lq2+B20s2uW+B/mC6jj1mqFVaddyiyzNVA7ZOgFHQ1FU+gULjDPkgqeQeIJ9ZQ8K
         gN8O1i6/InM4D/QpNBM+t0f1WsmTLUMD2mbVeeUV7dx9jySxYSw6OSam7ueewWWyj/ud
         kHwkl83D9HFWayss20Adjwg+RKCJY1zC2opGqdbaxgWBeUNdZ1QPZvJvFUwZvGaCjVRa
         dk8SvNYYmajFok3avNPpcPvJbFwPBGcM8LjIhsoWZeIbIbud8esTTfUyN5dFLRfkuAIz
         hzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGE/8zZSbrMYM1BfuDIYlYWu/KQaD7nuUUEC61XDj5g=;
        b=LMs1Ii4AkHEu39nvfZJD4dxa/f/+12JFiwXu0yNbgtX8Z+jkIQ9YgmyuPo64TeB/kg
         4NxGYUGqZ61Ua3dZcDz4dP7H1oujVBhWbsQCfnnYv8jSTeqnXzzF7+jvYnzEUgjNfDnM
         z0SvQVTtKJVmSPZqZQ/NEeLjXCtrrSoVNN19eHCUQYlf9moY567iyBazJk8QjtCCwlA5
         +tPlBhPfDK5ghQoL5/JrkY1vcHocsTWdBtvBWsJ6/i0zu7DznW134EoXwLvMiRh8GRT9
         FeuhrrVpw5Ik5a5EFFeA047imKcYJuWkB+8mhHyIkrJsciGGOzbL2QBsO8H2hOdhEKsX
         TM8w==
X-Gm-Message-State: AOAM532Kzg9YbtecmZ6bQ7nGJwJ/L3CWnoAWguuG7nm+fuurbueRkSud
        kvWCi9mSbjorXpfvtboyhaHnL4KRmmX9R+q3IFc=
X-Google-Smtp-Source: ABdhPJyi8dQ0hwCdbQgZlwbfhe98B1Ei/rMrpJkSgiik4CIVzXdGxmHNcANXDVSHrI0ev71EzKrRfRyA3NHmZKCzDi4=
X-Received: by 2002:a25:2e0d:: with SMTP id u13mr11676325ybu.247.1605526391609;
 Mon, 16 Nov 2020 03:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20201116043532.4032932-1-ndesaulniers@google.com> <20201116043532.4032932-4-ndesaulniers@google.com>
In-Reply-To: <20201116043532.4032932-4-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 Nov 2020 12:33:00 +0100
Message-ID: <CANiq72=nTM9enY2pTm8aoR8grPiiODCif5d7DDnOLkivaY2fsg@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc: fix -Wimplicit-fallthrough
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 5:35 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The "fallthrough" pseudo-keyword was added as a portable way to denote
> intentional fallthrough. Clang will still warn on cases where there is a
> fallthrough to an immediate break. Add explicit breaks for those cases.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/236
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

It makes things clearer having a `break` added, so I like that warning.

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
