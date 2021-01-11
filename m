Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34B32F1F52
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403822AbhAKT3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbhAKT3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:29:25 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AD3C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:28:44 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id a12so1207299lfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Tp1CGhJDFL4hgGIL8xslWOihsjK3eOprCj/WLppzps=;
        b=ML0r1fT+wR7NtNVlMdlZHIe4UissEnqDL34cuvHaQ+q+iwfYKsU56CdvfQBzd/0p3f
         MCOhQ9UBhoSfNFNie8airMQbLkuQDkCUkzF81CH/QJ4XpMormgfvf9DcLurK0xxgbmG0
         I/9zNWGUYDW7Z56YICFkYCWMwOC8lIFw23Vbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Tp1CGhJDFL4hgGIL8xslWOihsjK3eOprCj/WLppzps=;
        b=sfmLgk25E8F2mYSYoLp9URjfqP2JFTRgHXTtHmnkRgkZWxZh0FLS4M4AZMyMtbXzAh
         EpHlvFnxOKT1AbezfjINWto+7j35orPvFo8EapleR/XqXYq+1ASC35EzGVWYU0LBCsbc
         QtYAxXDrIP2UxKdHRV79SM5vPscWJ8W4Czpy7MyIktk5aCFFHo5+Y3kXoLcqVQBp4n90
         Q6kOY1+buLDic9rXy88a4FldntCmLKPv9mGoGRHeiGWaI6OvNbIOUJyxBDJbemKxAO53
         IfW7GdXlQ1Rbl8U6SUOCZP9bRZdCZf8x7W3rUrFWHjjBP58+wwiGgxaUEONa6m9jhUFI
         EWcg==
X-Gm-Message-State: AOAM531CBBYgaQhwGP95RPxTtbMjQLwrRe/WT5ZWxdXCQzaa0MAYeHs4
        K45Mx/nMtN+WnF1wuZe3OOxratR/6T4ifQ==
X-Google-Smtp-Source: ABdhPJwpIzOHXDiG0RKpCym3HlE17J7PctToLLuWOPfKjSDFqsJTIbBOPNEp7UVlk8SKoacWh3n6tA==
X-Received: by 2002:ac2:5086:: with SMTP id f6mr426030lfm.593.1610393322793;
        Mon, 11 Jan 2021 11:28:42 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id r135sm85278lff.240.2021.01.11.11.28.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 11:28:42 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id u21so199730lja.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:28:41 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr464710ljj.220.1610393321545;
 Mon, 11 Jan 2021 11:28:41 -0800 (PST)
MIME-Version: 1.0
References: <fd68dae71cbc1df1bd4f8705732f53e292be8859.1610343153.git.viresh.kumar@linaro.org>
In-Reply-To: <fd68dae71cbc1df1bd4f8705732f53e292be8859.1610343153.git.viresh.kumar@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jan 2021 11:28:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi6ri9S7Nj1VZuA_pKOV3mEfH=-magLf_J_F=qhiFcKdw@mail.gmail.com>
Message-ID: <CAHk-=wi6ri9S7Nj1VZuA_pKOV3mEfH=-magLf_J_F=qhiFcKdw@mail.gmail.com>
Subject: Re: [PATCH V1 resend] dcookies: Make dcookies depend on CONFIG_OPROFILE
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 10:02 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The dcookies stuff is used only with OPROFILE and there is no need to
> build it if CONFIG_OPROFILE isn't enabled. Build it depending on
> CONFIG_OPROFILE instead of CONFIG_PROFILING.

Umm. I think we should remove CONFIG_OPROFILE entirely, and then
dcookies as part of it.

We discussed removing CONFIG_OPROFILE for 5.9 (I htink) already - the
oprofile user land tools don't use the kernel OPROFILE support any
more, and haven't in a long time. User land has been converted to the
perf interfaces.

             Linus
