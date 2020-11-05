Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63952A82FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgKEQGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgKEQGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:06:04 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC86C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 08:06:04 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t14so1705508pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ovikxo5/mCGDynhuLKWYnfoRnCYgUGKva9i9tEWv1a8=;
        b=EdukGTkEV/UUSaIBNvoE9CM3nPrhkwXNUgIkCvYzGU0VXtYPQHBJpXLD3x6fJ4a9Qz
         sYOjmpLHcZfbS3iesTi4Y4tbT5H7lGvuGO2X8rTKMqV3MQmg80zvA38HlIG6ToEyqzcy
         Qbtt6XGtANWh3vpIDLlJyg5PHKGMxL+9bpc5lwm/mD02+zj1JbjLJyIjjWI6pwH4TWgM
         a+1Qv9WFfHO5mSay7f3dUi7/05jAdoWXxdOiSK1ybGn4OLLigjf6+qTiNcWYQlTCPLVF
         C0vHyU8mjsH3y2NVokK0nfjhiDGYXRSH9Tf1bJ+xuW6mREPmopu/7C1j0h6hq5VJrKwC
         Fzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ovikxo5/mCGDynhuLKWYnfoRnCYgUGKva9i9tEWv1a8=;
        b=J4ZYVyw90GJMp1M3HgbBP0D4cCa/01LlM6KX/Lj/eH8PDt3kqwtcn+zn7mlDVkjrTV
         8tMgWRUfvvWQUqKc11umx0pLAFHjrmSFJN+aRgJbpK5brHcdqYqUydgb+FE8td5VIiLd
         ogeoaNaYfL8ATNiNMj3SpWJxr9128givIDKI0hD61G7kXtaLYHo1LBN7ZJ1iUnXQ+XDy
         ff+xw839uVeGzM9ovTVyUNyUFdEGUQ5FDgDK+xAvB7Z2D0wH4jK3iO/pzQtmTnQIEaDC
         ttJiFz1CGhqwGUkNNQEosyE3dFNZ13TT45zb/G9563JJnlRy++n+54twJYaWW6ro3R+i
         CIJQ==
X-Gm-Message-State: AOAM531CFl92hedRtVHoergLZ08XKS3F9z5p51DFV/ECtzot/TfAF4nj
        vuG1dQ808uFqXhhs9VCTp2vVJRh9z7pZTAdhnEb7fA==
X-Google-Smtp-Source: ABdhPJw7XeP0zBLiCad13iVrNNx/nweI/6exBCIWAlXy75ifcsZStyxYB7vo1jWnclPs0cEx6zaCYK9+QPFCzDvmGus=
X-Received: by 2002:a62:cd85:0:b029:18b:36c7:382d with SMTP id
 o127-20020a62cd850000b029018b36c7382dmr2838489pfg.14.1604592363377; Thu, 05
 Nov 2020 08:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20201102232304.2735187-1-dlatypov@google.com>
In-Reply-To: <20201102232304.2735187-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 5 Nov 2020 08:05:51 -0800
Message-ID: <CAFd5g45+XbduCH4oE8dBd-uBR2MZg7-w5tf7DghqGrvMyydPUQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix display of failed expectations for strings
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

On Mon, Nov 2, 2020 at 3:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently the following expectation
>   KUNIT_EXPECT_STREQ(test, "hi", "bye");
> will produce:
>   Expected "hi" == "bye", but
>       "hi" == 1625079497
>       "bye" == 1625079500
>
> After this patch:
>   Expected "hi" == "bye", but
>       "hi" == hi
>       "bye" == bye
>
> KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() was written but just mistakenly
> not actually used by KUNIT_EXPECT_STREQ() and friends.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
