Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713432F04B3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 02:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbhAJBYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 20:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhAJBYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 20:24:23 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C163BC061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 17:23:42 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b26so32361197lff.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 17:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IumjRJ1pkvNLOaocIO/t7RJ2KyYMIIvjOvzcmVtgrmQ=;
        b=H4LtV0o+Xyo3cPEBi1guctN6qp95IQkZ1aPWndFoTe+dbz2nvefJkHbcEQzoRcFmKH
         B8KYrASDjZNBM6KGhxTBg0YP3c12DAEEWZQ9YN6ZROxd8+V3JZtmTyJHSiY31sBH/bFT
         BQHO1SZ1tX2X23C/T6Cry9I4h4E+86771BxaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IumjRJ1pkvNLOaocIO/t7RJ2KyYMIIvjOvzcmVtgrmQ=;
        b=Aa4XASOliuTTErZfFZW8tG4ZCt34eOH9vcFajIPQkSLPlEwCFYz8EK7xy7TEIKQAz6
         +I5iCRLlMSl4Xd+jxu84gLcAExuqTewLIWFTe9+81NJgAS1Krq0qG1JzPleLYodTMJ8l
         +2RO0N622qcNkLsQ5IdaK9DfzM0p12kII7/AX5P7ikHLuXcoXNDGBo3x7e06JfJQcx88
         SmHVVTxM0BoRzcu0pntsgj1MtjlTsisBWHqZ/YLpSzQUFjYyJUWIdkReU5/lFgjL4KxN
         azTidPMaKLFi7XjSSSgsBfFkY+vVse4/L4D1UOy2a6o3HG7UvCp/mDOn+bw2SU/5jSAO
         BLBQ==
X-Gm-Message-State: AOAM532gyWIfQDj9Kh2xF6Q7iBN1GCHOqUSVaKk2G2N6QBo9fnuJJ3fp
        r2BNqnI6HN2dDx7lyELeoZBQTryiK7klWg==
X-Google-Smtp-Source: ABdhPJxbvpB3bpAU8ASwptos38H2UJgjp+5Yr6LcN3OiZpQVSNC2zas1zaYCD8w8xafCHXPw66y5Ww==
X-Received: by 2002:a05:651c:1a9:: with SMTP id c9mr4745056ljn.189.1610241819874;
        Sat, 09 Jan 2021 17:23:39 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id v10sm2816132lji.130.2021.01.09.17.23.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 17:23:39 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id a12so32381888lfl.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 17:23:39 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr4301062lji.48.1610241818737;
 Sat, 09 Jan 2021 17:23:38 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUq9Skdt0ws7uqa3N9P5vwhQX6DrhfNxMvkoKMEbyWE-Q@mail.gmail.com>
In-Reply-To: <CA+icZUUq9Skdt0ws7uqa3N9P5vwhQX6DrhfNxMvkoKMEbyWE-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Jan 2021 17:23:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNpzmU0UQ+dXU-A8tAyiKEzfrX-ax_80UmM77Ehjzy1A@mail.gmail.com>
Message-ID: <CAHk-=whNpzmU0UQ+dXU-A8tAyiKEzfrX-ax_80UmM77Ehjzy1A@mail.gmail.com>
Subject: Re: depmod fixes for linux-stable releases
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ack, I think 436e980e2ed5 ("kbuild: don't hardcode depmod path") is
stable material even if it doesn't fix a bug.

Not only does the fix for that commit not make sense without the
commit in the first place, but any environment that sets depmod
somewhere else might well be an environment that still wants stable
kernels.

It may not be the traditional case, but there's little reason for the
kernel build to force that /sbin/depmod location.

               Linus
