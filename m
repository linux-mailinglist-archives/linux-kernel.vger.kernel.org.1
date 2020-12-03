Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9D52CD81B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgLCNov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgLCNot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:44:49 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF556C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 05:44:09 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id x17so2049294ybr.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 05:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfby8i2KpiZBIetG9ciMHISiPc06IgVPZEII0RJ/6to=;
        b=hkGfBp5oI9yow9KFIMHmmAfc7ITcw25+GRJv4dizSFN2ShgRXKzpwZXdxP3uUuYy/l
         Jq0ut9Xrwu5QGyUUVuB4SHo/wdZaRI0z5V84xhqFmJ8ORRSdYw5cy5ljiZPaBN0Oa8Ey
         Ml7kCAWLdZE7So+/Bgmx5pycsgSzkL2BWLmjj7F1sYQKDfB2MVeWmGITc5y329hZ+Gp7
         CI4LnZlCnVfwdRxgNK/XPDAATQmUfJKGwvEA3Xckw9BjWdOKdPmpmCGeWFrWQHa1aoVZ
         k1hWMFh1GQEyDFH5/SN7xA7xh7qHOXNj7XVMWX2uv8b7kOZsS9Usv7s+RnFxLF9kXOU1
         CIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfby8i2KpiZBIetG9ciMHISiPc06IgVPZEII0RJ/6to=;
        b=k6vrfXYqK+VjyLOxf26rHF+EyxYshaql5Mv8/1Hwyvdmhh8WwmteKCsXP/fyQ97X+X
         F2CTJxv4kAbOEqG3mlh4R6a8h4/hQuLerm3LiVZn0fns2x4osU2vO5Yox6Kgk6u5RpN7
         En7XKDXekYk1L/FPIHubazVUmaZts0NOJv5d98GkB218ew/wyMQY5RPNq0yBxYvV3GWq
         eoC0J4h3d3izXbyIKl53bzZZlMUAQ/iLeYocf/wAs2LZgMngtHfQ2jw1lMznolDqapc+
         i3sfobBlHfIFYKRk+E/To88D3Yd8qW84y232UoJ8TrncCu9mkQFijLOGfRw1rJC6qys/
         TDGg==
X-Gm-Message-State: AOAM533ZuRMDxYZcnXtMhVCbXhTgtaHQcSCtUDOstrQfejoMPr77U00m
        YngJIic8X0HeUag8rY+tjEPcI/hK8Mm6ceX5AtY=
X-Google-Smtp-Source: ABdhPJwae9N22cy+MNFmRpIY7VZ0vMkXdbv5QeFOJDNn+HyoUVbwoInwVD/On43bE/g8NqGW/FKJDg+ILeNeFmVsoho=
X-Received: by 2002:a25:df55:: with SMTP id w82mr4255342ybg.135.1607003049039;
 Thu, 03 Dec 2020 05:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20201107075550.2244055-1-ndesaulniers@google.com>
 <4910042649a4f3ab22fac93191b8c1fa0a2e17c3.camel@perches.com>
 <CAKwvOdn50VP4h7tidMnnFeMA1M-FevykP+Y0ozieisS7Nn4yoQ@mail.gmail.com>
 <26052c5a0a098aa7d9c0c8a1d39cc4a8f7915dd2.camel@perches.com>
 <CAKwvOdkv6W_dTLVowEBu0uV6oSxwW8F+U__qAsmk7vop6U8tpw@mail.gmail.com>
 <7ca84085-f8e1-6792-7d1c-455815986572@redhat.com> <CAKXUXMx0nSZqFfOF63J+awCpkPkgr-kuchUxd2-tuMbA2piD5A@mail.gmail.com>
In-Reply-To: <CAKXUXMx0nSZqFfOF63J+awCpkPkgr-kuchUxd2-tuMbA2piD5A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Dec 2020 14:43:58 +0100
Message-ID: <CANiq72=WZwcPcrnpwGzS=vAGBL6KuG49btKMbwOKTt=puC7qwA@mail.gmail.com>
Subject: Re: [PATCH] netfilter: conntrack: fix -Wformat
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
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

On Thu, Dec 3, 2020 at 8:26 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> It is not a competition between checkpatch and clang-format, but if it would be:

Please note that clang-tidy is a different tool, it is designed to
write lints based on the AST rather than formatting.

> But jokes aside: Dwaipayan Ray, a mentee Joe and I are working with,
> has already submitted a patch to checkpatch that identifies those
> patterns and provides a fix:
>
> https://lore.kernel.org/lkml/20201128200046.78739-1-dwaipayanray1@gmail.com/

That is very good! However, it does not hurt to have it repeated in
clang-tidy too: it is a very good thing to have a full C parser behind
when writing lints!

Cheers,
Miguel
