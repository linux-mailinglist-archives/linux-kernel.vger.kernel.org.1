Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF5A2EB565
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbhAEWbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbhAEWby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:31:54 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB99C061796
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 14:31:14 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 23so2149931lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 14:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgWaHtbTUAeR2bQoeG/I6X+g25dLoH+Ve/eNWw0Mabs=;
        b=L6uJNwRsmyaYznnTWDT+A31utq8iL5LGUf0Z3dojlGv45h4Udyqbama8qRSakwybEs
         gh4l0Yftqio4i0/wsM1FjBBBvWcMBWfWdSNI3fwEqZH8axklBLuRGlRjgyVOMmoJAipR
         CdIbewVoOGVL8CeRN4mYqVyP50+aR0M1NfHHW3dxz11aAoXb4DYNdqp9Pkk0OUFjgmXE
         DfV0S1vVFGd9mvKXBJIovbRn+nikuCq5ZKvMCi6vg8kBfRAS6m7DOQzOLXOZA4SToxsG
         heGmdj46Mn0W7H6YSzjEoNJN2RgKWFKL/eLafV++suT/Owui7mXmTuJCGgb4jlp5UFC/
         Vn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgWaHtbTUAeR2bQoeG/I6X+g25dLoH+Ve/eNWw0Mabs=;
        b=s61Y0fbrbX0UsQIvdM3kzA3J4ae3+ZBIqgGK5Fo8tyZK/m0NHn6TF4k872nUmAMycy
         Sf/TiQj18wcmBQwkIbS6g3aXGf/tA1KgAN5M7FOLFOyEQF7W+gO3DEdT0Kc4xu2Xthfv
         nYXgFlDgqH/lH5OwAH3d5zdlw0MJvOwi2gEP1e98oH5gjJTo0NUUhucstUI/E7G30jD7
         27jxHe9qMNDi4DLAsUgHavljJhaiwcy54z2d1fI+vciv5l1mgD8fIYQQXsL6kzj/yxkU
         yQeHaOiFMihZK+gjM+9H2pL0wjsAcLrs20ClW5LpbtEMXOUCgcmV6Bo65CbRUzMIz13R
         P21A==
X-Gm-Message-State: AOAM531sWfQG9diFNh9tdvOKAHZNaBj/IskeZmtSXhB9Jij2rwBIfc1T
        nWt/A+zlTwq1d5LeGG3ACL0IVgs1jaLyMitJA3z7uA==
X-Google-Smtp-Source: ABdhPJw3DTVMcCy8yC9MZcxKB5U7rWF5RRzcr7NBwVvDjB4RL0LkiQ7+AvfoKBAazUqY3amsZR0MzKTOhKQYpfGR7Z0=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr795059ljj.326.1609885872751;
 Tue, 05 Jan 2021 14:31:12 -0800 (PST)
MIME-Version: 1.0
References: <20210102022949.92304-1-warthog618@gmail.com>
In-Reply-To: <20210102022949.92304-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Jan 2021 23:31:02 +0100
Message-ID: <CACRpkdZ_drnFeaRtxeRT1J6cSLoRy=9r132HBFq3kKP7XQyeHQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] selftests: gpio: rework and port to GPIO uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        shuah@kernel.org, Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 2, 2021 at 3:30 AM Kent Gibson <warthog618@gmail.com> wrote:

> Initially I just wanted to port the selftests to the latest GPIO uAPI,
> but on finding that, due to dependency issues, the selftests are not built
> for the buildroot environments that I do most of my GPIO testing in, I
> decided to take a closer look.

All patches look good to me, I see Andy is helping you to hash out
some shell script, anyway:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
