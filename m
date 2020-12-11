Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B821A2D7EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbgLKS5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbgLKS4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:56:41 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B32C0613D3;
        Fri, 11 Dec 2020 10:56:01 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id g1so9739142ilk.7;
        Fri, 11 Dec 2020 10:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3JIqd3VgqewKlHZM6tzMlpEMTcnPyfODQAc8wyzPew=;
        b=DLQ5nY8COzu/4PrdsvhACosOqtuecoDrWLZTt9oj5rueoZQFtvUyCvArbjw9renmHH
         xAOHRgwFX1JOJruJxHLR4ylqgd8qEy85p3lxt3yw6fbjGyXS1ZiNOVKcjxw5TDhserfD
         XQmaqXEYG5DErm60nDwZC5x1JQ0iLcH4fbszoZ64c8VQ5Lf1SqnouocxMdKPYbqSRHBG
         3Jnd1ucmKT12s40PTkPV+pejiGvytHsMln7fmCRNomhbL08BC95Lu6mTV8xSdU8aEM1h
         0jjnQ+dYI1zEFFD720oYBMBOV8KDMIV43oc4chlB0ZxitENBgw+DWlGLDoZLY2nGzoHW
         klmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3JIqd3VgqewKlHZM6tzMlpEMTcnPyfODQAc8wyzPew=;
        b=k+Lz1fpVC1trjsd6QIvHYmomlJ9j+yQbkox8Kth9/tRj/j1HX0KTngoEdJOtTpuae4
         Fbr69lYT22sozXMYx9rOFqiReGvk08KG1AlZA6Jv/ZphsMuLcApHcjBPoJuCDoh/CPR5
         RjqG/P6pg3RU1KU48AshHNFd2xxaelooN3j7M9fDK9b6+xIeHtTK5K31b9Q6eypu7HN/
         b+wSVpwh/1G4YElfZ4Yo/FhYEt+rS7nUNUOac1qR7x15528RL5BKCRh2pPhSPXnkyQSP
         t1Rk+7a2DChAN/dr602hjKz02tMEWpwm5jdhRJWNOAHskYa2ZAYMke/S39X6eozckfyD
         8r5A==
X-Gm-Message-State: AOAM530+6CsB5lBlupCtrIwWErYf6niF97qWQmwR0Ie8D0HL+YV9WiIH
        wFwbQC/iIjoBhbna8E8t3D2ISw3uaqkQtW0KdJU=
X-Google-Smtp-Source: ABdhPJywYmd6DB/U6CuCiry05M7A8s458wz4gy74dtYaFHpwLWBUVh9RTtSO2d/YB2sNPjyrlQBf0t8SbYHNiV+L1uw=
X-Received: by 2002:a92:cd8c:: with SMTP id r12mr16786086ilb.221.1607712960988;
 Fri, 11 Dec 2020 10:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20201207124141.21859-1-lukas.bulwahn@gmail.com> <20201211184715.GE25974@zn.tnic>
In-Reply-To: <20201211184715.GE25974@zn.tnic>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 11 Dec 2020 19:55:50 +0100
Message-ID: <CAKXUXMzZ7ejn1JrznDP6d7dk8tSsTznBO+423NAwf_nYsix=_w@mail.gmail.com>
Subject: Re: [PATCH] x86: ia32_setup_rt_frame(): propagate __user annotations properly
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 7:47 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Dec 07, 2020 at 01:41:41PM +0100, Lukas Bulwahn wrote:
> > Thomas, Ingo, Boris, please pick this minor non-urgent clean-up patch.
>
> Why?
>
> Isn't it obvious that when you send a patch to us, the final goal is for
> it to be applied. Eventually.
>

Yes, agree. Other maintainers noted that I should point out that the
patch is only a minor clean-up and it is not urgent to be considered.

So, I add this remark to make clear that it is not top priority to
apply just that the maintainers know.

You will sure review it eventually, and hopefully accept it then.

If that comment disturbs you, please ignore it.

Lukas
