Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA952A5D2B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgKDDks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgKDDkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:40:47 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA2C061A4D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 19:40:46 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id a12so16785024ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 19:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CutPkBCw+7uDJA6QpNjo52YVpMUSo0YRNrxUbCrl+F4=;
        b=ibjhcStsyAAeTn7eRM8nKeoOdPaXDKm37n8dr0NUhstNK+BIbZnkCTU69WIFUZ0vAi
         IGMhKcAYVVxp5Zn4KGPID33as8QrD4CbPpZUr25tuCSOZg/rd0gL3pzc55vInmwmy8fb
         2RzYXdiL/CK2CDarOQtN8CmCoEGMu1GPczF3ROVIfJxaygR8Vzkh1wfZM72eXvTVv4Vi
         SaoBwghkPesyYel9s/C2ygGi7dcBoMFpEtpyIw+mxJDKxyk8kN0v7EEkXMNZTwjmFIWk
         LQdV25GzyrTx2W2qWcpBoEU0FETUKVfqlJ4NZK5mYtwz516LXK1lKSeNeUTklyQYTD5r
         jE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CutPkBCw+7uDJA6QpNjo52YVpMUSo0YRNrxUbCrl+F4=;
        b=BOT6sWQiTIu6Sj2lfoXMWS71F7oGwKGt2GA/e+vOb2gXaYoVxYxewGD/U1EkUsi8Fs
         4f0rT2X9lzSvasYsQ+FT0o6rCniNaRXeQnXaTvLbPfJWvIUQUq66OOrv0vTfYAVILj/6
         XxWCb7i/DGntBcGqvpTythlDWI1pA/y3mGAPx0U83c+h/huSwBLPx7FrUPDVMSwPJ3CR
         eBws0L1rMcV3sYmc4An5cto+4TiRhndWpnWiRIakWxtpbFfzRW3J199/qudPLmtttbi8
         LWUiIpiFa5VRsTfZQCoRp+TFu8OYXNOewvKFmBgVfzeLbowogLLXvREDVHgNCAIk6nAK
         pacQ==
X-Gm-Message-State: AOAM530VtJ0CdbM0EvEPmkj09GJctk/dDd4ZHEQBfBw3gr5J0Hv1f6NX
        CgBW/awbuYCREzzM9tSO8n8zqpcfb0iJZ/pwoG8=
X-Google-Smtp-Source: ABdhPJwiKffPZkCIA/3XFfIqVhHz4uXPsIGjzmMyDI72XBizRcIz5wUPuk/vax5PXPgI6VRK3OKWfi3tY7sVTRwL5tI=
X-Received: by 2002:a25:491:: with SMTP id 139mr34527341ybe.22.1604461245526;
 Tue, 03 Nov 2020 19:40:45 -0800 (PST)
MIME-Version: 1.0
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
 <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com> <CAKwvOdmnz-DJ-hG5FKJZYF7W-ujPrgfMkrb2hMLhmzhk8Hx6dA@mail.gmail.com>
In-Reply-To: <CAKwvOdmnz-DJ-hG5FKJZYF7W-ujPrgfMkrb2hMLhmzhk8Hx6dA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 4 Nov 2020 04:40:34 +0100
Message-ID: <CANiq72n0FFfH6Uag5yai=tSzzOgVSLpzu5gyUr40d6Gb8GzZpA@mail.gmail.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 2:08 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Miguel,
> Really? :P I'd bet if you picked up this patch no one would notice.
>
> I recommend a simpler approach to multiple version support, which is
> just matching the one version recommended for the rest of LLVM tools.
> Sure, technically you can use older tools, but do so at your own peril
> and don't complain to us if it doesn't work.  Otherwise trying to

Originally, the .clang-format file was made to work with old versions
in order to make it easy for people to use (just install it from your
distro etc.). One of the reasons for that was to help adoption, as
well as because clang-format gives a hard error on encountering an
unknown option :-(

I am not opposed to changing those requirements now and say it is part
of the LLVM toolchain (even if it is independent from building), but
somebody might be annoyed.

> explain different versions and even for different directories gets way
> too complex for anyone to take seriously.

That is just an escape hatch for developers that really need the
latest formatting options (e.g. to minimize the exceptions in fully
formatted files) or temporarily deal with some bits of kernel code
with a different style.

I definitely wouldn't want people adding their own .clang-format files
without good reason...

> It's not like we backport raising the minimum version.

That is a good point. In fact, we can just do it very early in the
cycle and wait to see who complains. If there are too many complaints,
we can always revert it.

Cheers,
Miguel
