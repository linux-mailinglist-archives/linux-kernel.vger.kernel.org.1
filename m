Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF84262DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 13:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgIILYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 07:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgIILJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:09:52 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365A7C061798
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 04:08:26 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id u20so1896683ilk.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 04:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRUOfV6+ZqYqfW6xUFOI46xmoCz/PY+Ae+dYUc7wCZk=;
        b=1N+0P+hFuG4Uwy6+7Kh2vXTyvL4DQpoUpLsXxoam8VgSx64eayoD1rarhWhB/mTSys
         pSy+T5Rc3zLwEwkQ+XoEIk52rQUBc7MM5wUxdipsnrslayuiDBVjm35jn1ya5T7oOSp0
         H1YPydcuaeL4dCTtYYCKkEiX97LKU2VVDG+bJOcOWMgKmfZUP/l5U9BNQAs/00FWlmkx
         H/ex/jf8Kgh7hllr3q+yv9obCQ6FKeWl+CMH95BtxFPfXlQmTmWjBpebAdFN3TGIPx6e
         QeLr6cApXGfa7h1OTNFzaTnszrPGbsHOjKOwQ7QHj+5UZZw5Roh9bJWOpU4v8kuxGS3h
         3yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRUOfV6+ZqYqfW6xUFOI46xmoCz/PY+Ae+dYUc7wCZk=;
        b=LYXEZVU5LLQ/tRCpZE9Mebo6yNe5u+5T1WrS0TGl310QIq37DmdG6alCXq2JEgGWd0
         GiasD4VLHi4BZynzYKK7MzF9bAJ0/RZr7yncKdYw9AsyMSD2pP651X6/1eCREFqZvF22
         ovpuuZOuAo+0LBHgUV+Ll+OHcsLqffXBt4Aih/JhvmZRh/vBQjrJTO3mAof7Lv6aIcw+
         aD2+8ebBCTGeQyqTUouOOFhVYzJwiEXY5oT7rWt/Tt3sQQX+6vievWat7OOdCeqJKSUt
         ubEK3oq5PC9hc9ABwLQHLtemMqi9i+0F/sI9jBeSBg0YS2D/0Oko1vne0ZuCRPwO3mwW
         rPAQ==
X-Gm-Message-State: AOAM531uofBGrgSVHJpRprDFdLhbxWsBlMHw+VdxLD4L0W0dpwI6OuKk
        FQcRPJLQqakLlWci5OSjre9E452rvw5piHsud6g00A==
X-Google-Smtp-Source: ABdhPJxDbic+qefGx7meiMSqlNbXappfPb9WHSzF3vDvGMHVTvSzbDpYMJZnpVMw7OleL/TgNt9XkX6rsMJ03h8ERu8=
X-Received: by 2002:a92:c8c4:: with SMTP id c4mr846645ilq.287.1599649705603;
 Wed, 09 Sep 2020 04:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200908130749.9948-1-brgl@bgdev.pl> <20200908134520.GY1891694@smile.fi.intel.com>
In-Reply-To: <20200908134520.GY1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 9 Sep 2020 13:08:14 +0200
Message-ID: <CAMRc=Mfta3PG0Ea7ABchhfL8E2hEtTo1ejBeR8ig7sTJKyZ5Ug@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: fix resource leak in error path
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 3:45 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 08, 2020 at 03:07:49PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > If the module init function fails after creating the debugs directory,
> > it's never removed. Add proper cleanup calls to avoid this resource
> > leak.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks. This is uncontroversial so I queued right away for fixes.

Bartosz
