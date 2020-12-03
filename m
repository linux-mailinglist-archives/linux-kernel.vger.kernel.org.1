Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592882CD972
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbgLCOlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387666AbgLCOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:41:04 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F58C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 06:40:23 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id y5so2280597iow.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 06:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9G45ZkjSgba/8DWe2/HGegTTTpqJzhrbsxzg42vBcs=;
        b=CVVHlYKVkUuvqh9bfQvPy2zQdBUWgyUHM+qhL0Fh3EUm+Tos2jOqrOs/UW4wYXHECs
         cBpQmFc+/CRk+O1q/TS+Hez05bPUu84G5nTaVVvKVOl2Rzl2ct1FZJKmkvWNJG/nxjeM
         ejlk36Uvewc/BIaayxv36bM6FF9ZBtFz13vWjfzg8XmOwHbn7kZg0op+tUxn/WkpaCq/
         Nihyv7BOMcFpngQhg+SswL+VGR/WCpd3keXSP2WUhRva/Db9tM2QEFNJ9iUnENe8YOsE
         J7BsFkVqZff9BbG51QUcr+BGsUo3Iz/4a5THHymiI6B62Fl+vMerndO5McxTBvzCW5Qa
         wCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9G45ZkjSgba/8DWe2/HGegTTTpqJzhrbsxzg42vBcs=;
        b=po9hMCk/wocMDWlkTrSGrMk5lIIEnxUBCUk9lhkQW01e0py3h36h5gXUedbD5T/nM/
         z7KNzrr6gWv0LJaFpWCdAsl/SFyUePeli9dlTaivRFFO8134eKZkFJamYCiaYDB72WZj
         yw3VyJ5apm+aoMshdNzlKPH64VduhKoxPrvVOVct7Ya0jZGxDR4ls5LVzgtzKbbsY+3H
         8QOlXFLDghQzDISyK4x55ByDnr5mb5uL0WKkqSJBQFtGPHXHi8E5saL+JIzvAzSg6Wvj
         tUlwp85K2ztMWxB7WSwZL9fPUzm0/KEgg0qizWrbVL60+ohaRm4+duQH5ePf4WAbeSu2
         JIAw==
X-Gm-Message-State: AOAM530DUgCAufXe7sJU0Cch7F9wjSZ5i8rJ7vbwzQEdi5IJRqb8qZmz
        Y0N73lKsolwJ7VMOt5ZPUKbCysiDGh253ToqlIQ=
X-Google-Smtp-Source: ABdhPJwpyumKf+74VQrJ3K8qZjhr0J1QStmOrdQAut9BoXn/hDEucd19fbjX4b46twoQz7uylpgzMX/xEeSGDaN17M0=
X-Received: by 2002:a5e:9906:: with SMTP id t6mr3355199ioj.183.1607006423313;
 Thu, 03 Dec 2020 06:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20201107075550.2244055-1-ndesaulniers@google.com>
 <4910042649a4f3ab22fac93191b8c1fa0a2e17c3.camel@perches.com>
 <CAKwvOdn50VP4h7tidMnnFeMA1M-FevykP+Y0ozieisS7Nn4yoQ@mail.gmail.com>
 <26052c5a0a098aa7d9c0c8a1d39cc4a8f7915dd2.camel@perches.com>
 <CAKwvOdkv6W_dTLVowEBu0uV6oSxwW8F+U__qAsmk7vop6U8tpw@mail.gmail.com>
 <7ca84085-f8e1-6792-7d1c-455815986572@redhat.com> <CAKXUXMx0nSZqFfOF63J+awCpkPkgr-kuchUxd2-tuMbA2piD5A@mail.gmail.com>
 <CANiq72=WZwcPcrnpwGzS=vAGBL6KuG49btKMbwOKTt=puC7qwA@mail.gmail.com>
In-Reply-To: <CANiq72=WZwcPcrnpwGzS=vAGBL6KuG49btKMbwOKTt=puC7qwA@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 3 Dec 2020 15:40:12 +0100
Message-ID: <CAKXUXMz4DffG-CW7RZu1X1irw7vpFyuvKyQA4d0C-v0Mq1r81w@mail.gmail.com>
Subject: Re: [PATCH] netfilter: conntrack: fix -Wformat
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 2:44 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 8:26 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > It is not a competition between checkpatch and clang-format, but if it would be:
>
> Please note that clang-tidy is a different tool, it is designed to
> write lints based on the AST rather than formatting.
>
> > But jokes aside: Dwaipayan Ray, a mentee Joe and I are working with,
> > has already submitted a patch to checkpatch that identifies those
> > patterns and provides a fix:
> >
> > https://lore.kernel.org/lkml/20201128200046.78739-1-dwaipayanray1@gmail.com/
>
> That is very good! However, it does not hurt to have it repeated in
> clang-tidy too: it is a very good thing to have a full C parser behind
> when writing lints!
>

Completely agree. A regular expression is only a limited (but quite
powerful) heuristics to a full C parser :)

... and it did a good job in the case here.

Lukas

> Cheers,
> Miguel
