Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138AF2D3329
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbgLHUQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:16:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36494 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730854AbgLHUMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:12:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id t16so2237059wra.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgyQki4FzsYscH5k16Etbh421UMG+JihNWud51/vg7o=;
        b=Kf4+GRG3ICi22fvx5fccY4z9fvoThH7QoV401LvADvCQugMcp6btTNSih+yZOSoZ3j
         a2Q4gyueZSi5BP5D2Zdzf+u2ZyELugu0V4ZSQwUNMWysc21aPXKcL6d9WbJrfWoKkaDM
         5kD8tlsLhmWzjPSFqTPB6Xq+mP/fDQ7RtaM28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgyQki4FzsYscH5k16Etbh421UMG+JihNWud51/vg7o=;
        b=IeSDbIMGcyozTGR41zOKLe3QZLbWAFyEu9MTO+KtkF0AiOY+rRahC2a0HJFXTv+oO9
         OXMyknDf8vJJcdKHMCx3cYnf1OTV30QiQOnY6TVTfYkWfdE4E7L1twDIxi8IjRZHI1vH
         ElM1zDAT0Ac4a2/R/nljw74sFKfx0n+HKsRtL6mM69hKbhy9FqllNYG4kOOj8RrHMiIC
         +tqb8pNx6FfYOV61vHXQFC+eJ2nBhvJ7GGIfTWZZ2nIUjJh1Ufs1o/UE0aGUj2Q5I6eo
         YvFOppq3xzh/8WO0i6nu249RoDQmmKCNaiSSZClZn03PIjTPGxGdXXUPWUOM6xfe+qrW
         y7Iw==
X-Gm-Message-State: AOAM532U9/8zB3BK5b4xAkFfZBRhaNWR1xBIlWwzapLC8Vp8MksHSX14
        5IadklE1lFSG1TV8zpYuWE44dnKwuUPAWA==
X-Google-Smtp-Source: ABdhPJy6X6zMosNU2G+TVH7twn+OsvBfJFlegGULpTRzRdjqDf3Nr0Bm0HRgWfbHcSdf3t0KF5ZcVA==
X-Received: by 2002:a05:651c:1398:: with SMTP id k24mr4659169ljb.30.1607456871262;
        Tue, 08 Dec 2020 11:47:51 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t3sm1170117lfe.263.2020.12.08.11.47.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 11:47:50 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id s11so12911076ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 11:47:50 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr3342315lji.251.1607456869937;
 Tue, 08 Dec 2020 11:47:49 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2012081813310.2680@hadrien>
 <CAHk-=wi=R7uAoaVK9ewDPdCYDn1i3i19uoOzXEW5Nn8UV-1_AA@mail.gmail.com>
 <yq1sg8gunxy.fsf@ca-mkp.ca.oracle.com> <CAHk-=whThuW=OckyeH0rkJ5vbbbpJzMdt3YiMEE7Y5JuU1EkUQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2012082025310.16458@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2012082025310.16458@hadrien>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 11:47:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjVch4Y7wGKRROYCHN9vD0e5YK=KRWhcZMJ2zNQdc+_Jg@mail.gmail.com>
Message-ID: <CAHk-=wjVch4Y7wGKRROYCHN9vD0e5YK=KRWhcZMJ2zNQdc+_Jg@mail.gmail.com>
Subject: Re: problem booting 5.10
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nicolas.palix@univ-grenoble-alpes.fr,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 11:29 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> A dmesg after successfully booting in 5.9 is attached.

Ok, from a quick look it's megaraid_sas.

The only thing I see there is that commit 103fbf8e4020 ("scsi:
megaraid_sas: Added support for shared host tagset for cpuhotplug").

Of course, it could be something entirely unrelated that just triggers
this, but I don't think I've seen any other reports, so at a first
guess I'd blame something specific to that hardware, rather than some
generic problem that just happens to hit Jula.

            Linus
