Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649BB2E290A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 23:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgLXW3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 17:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgLXW3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 17:29:07 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92C5C061573
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 14:28:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 23so7100019lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 14:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVgMIe6f2x4NkzIsowkEU5VbeVfG+KlVYzro8vABtIM=;
        b=NdHD/MMFyljQPE+PPWLewgCWLzpbm6c4NlPaMatyjNaGyF2AEH8Su97p86MebNW14h
         ydm4/y81NkkFvapcqo1DICsysejvjE3Ao+251ZzZnPUmsaqTy5kp+HdKJQe0oJGCkU/l
         HI0AEMLAxASH3RBX4w2TuPqez8l8rlA55cgF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVgMIe6f2x4NkzIsowkEU5VbeVfG+KlVYzro8vABtIM=;
        b=nzRXM5mA3TVmMu+aKWlHLuzSDYAKIrVoRYVd1PQs4nuq2iuQ3Acag1+KEuk8bYxRtP
         TpCy9oVrwZyop+AP5YSMScHzZpISAyr5c3S8E5B4EATK6vFXIdj2415GpSRC2QuvrNi5
         xhxSWFafK3VmYPOEpWrT3Qo5JoOZKDOS1M/SiVvSS/Z9jpFP1T8+j7xj0rHvOleuUm1e
         d6Z7SYV6GJ2JRwCtpklYkpmZtOZ+ZGIp1AKybOiwodgsSkujBrGshr7pPG6+WmxfdJUU
         XVo12vKFBUS27uE4Ox9OBc5uWn0VBvr18bo32VFP7oL4z6CT1cjbqPCqJozsLlICSEuL
         5gIQ==
X-Gm-Message-State: AOAM532US/Oar4WIpAxKOlAcq79cfcbpFXwzM1eeqtgYRj2CTFr0OYs1
        sosJ4XKnl8+ovE6eMjExvIArzh8uqu6Nyg==
X-Google-Smtp-Source: ABdhPJwrpbACZ8ukqW+GLNk3BJiV92qSTt4IAG8kQzNc4Sgy0c0RGkicoJTOeXnkHAjCd7zOH8jrGw==
X-Received: by 2002:a19:5e03:: with SMTP id s3mr12756224lfb.186.1608848904798;
        Thu, 24 Dec 2020 14:28:24 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id l22sm2671029lfc.303.2020.12.24.14.28.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Dec 2020 14:28:24 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id m25so7084496lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 14:28:23 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr13773066lfb.421.1608848903361;
 Thu, 24 Dec 2020 14:28:23 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9twrkJdUqTLXXsNygtzkrc4P2iyw4kwU1T83D4_+-gdpDA@mail.gmail.com>
In-Reply-To: <CAPM=9twrkJdUqTLXXsNygtzkrc4P2iyw4kwU1T83D4_+-gdpDA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Dec 2020 14:28:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whf+kw=YSDbmvgiSvNL9ckHc8EpkTgZzMXu-bMw941GYQ@mail.gmail.com>
Message-ID: <CAHk-=whf+kw=YSDbmvgiSvNL9ckHc8EpkTgZzMXu-bMw941GYQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.11-rc1
To:     Dave Airlie <airlied@gmail.com>, Josip Pavic <Josip.Pavic@amd.com>,
        Bindu Ramamurthy <bindu.r@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 6:29 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Xmas eve pull request present. Just some fixes that trickled in this
> past week. Mostly amdgpu fixes, with a dma-buf/mips build fix and some
> misc komeda fixes.

Well, I already pulled and pushed out my merge, but only noticed
afterwards that clang complains about this, and I think it's a real
bug:

  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_mpc.c:475:6: warning:
     variable 'val' is used uninitialized whenever 'if' condition is
false [-Wsometimes-uninitialized]

and it sure is true: the code literally does

        uint32_t val;

        if (opp_id < MAX_OPP && REG(MUX[opp_id]))
                REG_GET(MUX[opp_id], MPC_OUT_MUX, &val);

        return val;

so clearly 'val' isn't initialized if that if-statement isn't true.

I assume 'opp_id' is always presumed to be valid, but that code really
is disgusting.

Just make it return 0 (or whatever) for invalid, possibly together
with a WARN_ON_ONCE(). Ok?

             Linus
