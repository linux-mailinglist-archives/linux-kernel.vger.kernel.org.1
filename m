Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180552CCD03
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 04:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgLCDH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 22:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgLCDHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:07:25 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED2CC061A4E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 19:06:39 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id j205so581606lfj.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 19:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4QT6Rgw62DbFRwkl+4o96eZwY9j3Q8i5Y9bbEB2ur8=;
        b=sEscObuHVUeG/B2h90LNy0OMIsrZSv4AbklZsKm0iVkmvH66ybD1szBgIlZe7lcHOW
         y5tZ4ln4YAiiy/EivHRY2SnvIN9oTRYvd+dovtM1HXHQQGm+7a0HhZpTuBJdWNTevXQa
         3Dgki8PsFn/e3FQDVOw6lIukkv1iV3jbsfPoZ9sv3x1GwinJqMP0V3cnYQQiXWCp2VnS
         QnBb+OQDuClMXAuasFUyuRAUUZWCwAqTp2cfCr4GmpsZCXEJhVujh7zhb2huD19mb8Ng
         cD/tFXhLfmLZzxkr9DkI92gHjc/PZsqIL6OKUJZ0O3wF+fNgfa/Ljw4ze7FmAtlNBBCD
         3vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4QT6Rgw62DbFRwkl+4o96eZwY9j3Q8i5Y9bbEB2ur8=;
        b=djgfSPzkKM59EZumrutF6H6PMez62CxURSzoMzTQRVI7WMZAyg+XcaydnxN1aK5cFP
         6yQH9zbzYfk45GwMPHb29Ct6ZxzN45/HbJ2nHobY7OCyPZYana+JNDdLaWgpAeCbrpu4
         Jp6Jv2cM3vc1V4aEdzUbGDowisAlPPwQ7+SFP7yD3ogoLTnyhzxYf7cNS20hoAyw1o5/
         OEGLPiqzkvcVjFmyLQKCiQW2iUZCD7uvg6J42xFLZMZ4iXX+6Q2kVh4qu7UxHIZbzRT9
         ZT5TNC8VsVxzPhQ7jr8hkFKeOvGBkLdq7mo2F4ym3sbe2EhG6bQ7RFiBBVY5l8Qteo1j
         tpJQ==
X-Gm-Message-State: AOAM530RPI6hgHvvgWTzfC42NKBhtAX+iINvRDcSf3vus+Tmf5Vup86r
        R8gfwoWmXxPz5F5eNkc/q2i2xv1fqLGEuZNNmh9W8A==
X-Google-Smtp-Source: ABdhPJzegLl2vCMw4oejNw5RGZOYU8Wum7n2VOt/tD+iy7i7dN7hn0r4ul4EVy8a4FvKXpMg3wSDK7G24YATprsPXI8=
X-Received: by 2002:a19:5e5e:: with SMTP id z30mr424001lfi.277.1606964797974;
 Wed, 02 Dec 2020 19:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com> <20201202190824.1309398-4-dlatypov@google.com>
In-Reply-To: <20201202190824.1309398-4-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 3 Dec 2020 11:06:26 +0800
Message-ID: <CABVgOS=sPxdDLaQ39DwZX5rLVzgb4Fbn5SvhiQxt5S3s+QC56Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] minor: kunit: tool: fix unit test so it can run
 from non-root dir
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
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
> ---

Thanks: I much prefer this to v1. Having it work the same way as
test_tmpdir is a bonus.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
