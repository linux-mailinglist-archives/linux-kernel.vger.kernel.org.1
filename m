Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099D82F6E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbhANWQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbhANWQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:16:25 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9099C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:15:45 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c13so4186796pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viLqZ1oTiB1mDCbGax90NixXMd2O9e+6OHhtAzYjF2A=;
        b=oUPemRikyZUvUOElbPoojMzBdbT4dCyMi7+RXYhDRSc68BJxat5t8JS0KfqE8Shzyy
         DGFsxMLewaaVkOzeS1k4hbeQxU/IgHuLA8H3TdlsXJVnA/7f6yAp0QumEqT3CGCr+Veq
         ZX+f8TqwWku2Xwy1pXKFktaCAF0IRlHTmnuUA6+YNrqpqwxDYcVRBOFwnzquB6eBGd8T
         h8aSxfceZt9JLwDHKU10WXXaSI8aEbTNZXFNvWDBMZ2e8EpUhE+uDljRspQbRoBpYrs/
         ZSMx+JnDJqFuZpV45jmNsFcTMSDwUAoby1E3dRrTpkPKIqEi4Aa03l+jxlYW8YEoemXu
         WyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viLqZ1oTiB1mDCbGax90NixXMd2O9e+6OHhtAzYjF2A=;
        b=r6tNmlqp2T9vucao+eNaSANn/E5x6oLNLPzaElZgbTWf4mheAMC0rURZNnnpabSkJp
         zygvHfv7x6fd4BHpiPvT1bpOPFlTAvfgHI+4fyhVwm07QXOrH/abSu4vyDr3uNbO6daA
         vBP1HqbnCV5gfFMKqae/wmvMi6m0TwzHkm0avKEGLyisbRyEAkVNhTl2Vx8q9npmIkHX
         +pm24GwNrYmkvL0oBJOWTI4prqVNEnMb+maQD/7SCp42mS2gfr0xA6DFC4LXbMtUZYQI
         Ie5XrP7PyyPGxT2I5piFc9Fnrzpg7NrmGEqZ1HewHQ9suAKljs6rHkySP2d4QwUFVfvQ
         x2FQ==
X-Gm-Message-State: AOAM532LX+rWI+rLhNECVPKp2jN5sobNBVkhwKs/NIhgR9/AS3LaoIPN
        O4L5U+aMaaUo/TFrQPep4i86o4+VAXYXjP9lWLmpYw==
X-Google-Smtp-Source: ABdhPJx/O4IckZN43RW5D1nuF9e6131V+CBu/dFzC0JBMIbaPCZY2GLHrgngQdSP8Mbx/RJhd0qksgFoV+uJ2FqsFAc=
X-Received: by 2002:a63:c84a:: with SMTP id l10mr9672013pgi.159.1610662545004;
 Thu, 14 Jan 2021 14:15:45 -0800 (PST)
MIME-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com> <20201202190824.1309398-4-dlatypov@google.com>
In-Reply-To: <20201202190824.1309398-4-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 14:15:34 -0800
Message-ID: <CAFd5g45zCc03uR1G1XBBKTfN_84Xdybn6h1N=w_L75uHJiVriA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] minor: kunit: tool: fix unit test so it can run
 from non-root dir
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 11:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Also take this time to rename get_absolute_path() to test_data_path().
>
> 1. the name is currently a lie. It gives relative paths, e.g. if I run
> from the same dir as the test file, it gives './test_data/<file>'
>
> See https://docs.python.org/3/reference/import.html#__file__, which
> doesn't stipulate that implementations provide absolute paths.
>
> 2. it's only used for generating paths to tools/testing/kunit/test_data/
> So we can tersen things by making it less general.
>
> Cache the absolute path to the test data files per suggestion from  [1].
> Using relative paths, the tests break because of this code in kunit.py
>   if get_kernel_root_path():
>           os.chdir(get_kernel_root_path())
>
> [1] https://lore.kernel.org/linux-kselftest/CABVgOSnH0gz7z5JhRCGyG1wg0zDDBTLoSUCoB-gWMeXLgVTo2w@mail.gmail.com/
>
> Fixes: 5578d008d9e0 ("kunit: tool: fix running kunit_tool from outside kernel tree")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
