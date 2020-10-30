Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8391E2A0EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgJ3TYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbgJ3TYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:24:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3B7C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 12:24:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 184so9285060lfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abdnn1aLwrD2IENap20k3wTn5YnXWcerHLaxedFloWs=;
        b=pzahXt25ftmIlECCNdzBGRH9RP5/phCMd9ilpAa5PAECfwsYXVeY0DSmhD68iGqYPZ
         NgFp0fW27VDKAarsqPlRaGlDExh1uKLxViCss4yRzvI0RvdJuDbwJxy3MiMSmrfb2lf4
         UJ2l0E7MBLpT4mf1Qo8a800BcMFWbk7E/vIBURoS1zMqzZ+7LaGEnRa+g52I2Zgq2Lfp
         SBsGeG66UACfIfh/Sl158f5JmueCza5B/WvSzkUGttF3AIC6g9r95SY04P6DGjd1/r46
         DB4290ojIyQbmI7tBjqYsDYz5YrvWM8H4kzPAdEe7ShWGdTqNylA35SI7lZ3gCugE0Uv
         QABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abdnn1aLwrD2IENap20k3wTn5YnXWcerHLaxedFloWs=;
        b=VMfWDOmxap7pUJ6cp9FFOZBwafcW8bc+Jpk7ikHshQdJs1ijjDA52RIwJOuX1aRr/P
         Zru06dGSxDjmxGbTS6PAjDpx6YzexEfPDW62jDnH/m3HO4yirSyCf9YoXG0uiM/Qm8j7
         5WnTKXdn8kDdYWu/s9QJRsHn07mUliJa6TiUzwaJS/wYmN15bbX6+N/NuHwPPjJjpHPq
         g8VJaIyT8gcjfiYMde9KDcjieoTca33TC+KjLbCdaaVP7dDjAPx1G1HP3Xun9QCgQ7hH
         s4tye382cdv4FZhG4bRZeuqctC0h9o5kut6aj5UzN0dB5W17rCtGeXqoZsliZJKqQ1JO
         PcJQ==
X-Gm-Message-State: AOAM531JUVqKvOJ0bf2gNWtMPQfLLfyO/VB8gULH2t0UjiUZGlh4BIv0
        pa6x/LfDL0Lbb86ZwnASz34yhl4mkYZKpE5M7Vjicw==
X-Google-Smtp-Source: ABdhPJztV7eDIdpjXuwWdsQQHK9/EMBt9Y0h0rMl3PMT3/K3SOLSbQwh6j3ZsZyUYuUwItLlGKBUIS59RQSVLDYi5zo=
X-Received: by 2002:a05:6512:1182:: with SMTP id g2mr1454663lfr.198.1604085884817;
 Fri, 30 Oct 2020 12:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <20201029152609.k3urvzjocf3s7uml@gmail.com> <91b74ce1-de95-2b92-c62e-e2715d6071d3@gmail.com>
In-Reply-To: <91b74ce1-de95-2b92-c62e-e2715d6071d3@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 20:24:18 +0100
Message-ID: <CAG48ez0TZrwBoEi4d6n+FUN19hq6Pc+DOGNrRb-zHDSZVm9kfw@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian.brauner@canonical.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-man <linux-man@vger.kernel.org>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 8:53 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 10/29/20 4:26 PM, Christian Brauner wrote:
> > I like this manpage. I think this is the most comprehensive explanation
> > of any seccomp feature
>
> Thanks (at least, I think so...)
>
> > and somewhat understandable.
>       ^^^^^^^^
>
> (... but I'm not sure ;-).)

Relevant: http://tinefetz.net/files/gimgs/78_78_17.jpg
