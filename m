Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674CA27CE22
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgI2Mxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI2Mxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:53:52 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BEEC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:53:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a22so3905338ljp.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHwuPtC/WQ7pDTrQP7WICMQS4xbohiD8X+J/4tqHmVs=;
        b=SScj7iKswgMLk8PHt3ULYRQ70PT1uuUxmB7RKSr52jm6TodNbLThsAHdFO3rFHnqQA
         oT4i2CKd/jQW6g40FOkUwfAu0oZHLO+tPbO/CRTDpc2e0oOQjmYy3ELuKkSiHUlPw0lb
         GGHdLGpTPC/7XOCdK4Hg8GYRIVrcHiYNvIPGUkE8wV5mgeLKzjNDxNwF/4+xVZYy8lFn
         PkSbZ0dQLWJj4lTGWPs4225uaqtTu122afSD/LWCJyiMKWPfXWAhkHk1WxcvgWjBSGKi
         0/QzLwYQfpmWMH+UvQCTknUheNLebrWUiBtfijLIM6LBJ08UBMAVSszhl22mCBRnTLxG
         blsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHwuPtC/WQ7pDTrQP7WICMQS4xbohiD8X+J/4tqHmVs=;
        b=RL4uCWcPf0ScHIxWPxH5O9KB2q6I5STGS9kPE+yraTafosO1m2g4DsvW8A+qi4HioH
         SXMIIjMghUBj0NF6LOgQgjafq+B99RyLC3GiS2TUdsXhZyYfxR5juepMmudNzqKSj+0W
         W3eSSUc03pH1wyNgCK9YzGCdx2s0LDc2tokY3m2kFoz+V3f95qiyPJ1YlnIG42Q0IXUc
         GNy/18FEVQVrdQKPtaTWJgTJReI8nfbLJ3cb+2wvsTXdyUXYWGoKTK6g7bpm40KXhyAl
         yj71TTiQZVt1nfL8jxVT/L6F+B/HuaMUtrazcpYQnjb9yb+xOSiGB37IicXDVDadYMY4
         Cc2A==
X-Gm-Message-State: AOAM532Y5Zx7KZQLJy4Hy5DtWVGCyXAGoIXds/o0wFUbjaoV5LOhyCgl
        igK6umZQi+1zFcabqzBnnf3JyysPWsyKx+RsESeiew==
X-Google-Smtp-Source: ABdhPJy9hUABt6HyDZ8eMUhqUVFoUVNmWh4nkSqagGp6tYeml/6ltjf2YqMbjHLgvucofUxG0N3RHx6WdvA9x0bXsXs=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr1192840ljo.293.1601384030152;
 Tue, 29 Sep 2020 05:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200914065402.3726408-1-liushixin2@huawei.com>
In-Reply-To: <20200914065402.3726408-1-liushixin2@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 14:53:39 +0200
Message-ID: <CACRpkdYDuKV_2KO9y+6uCUR4v757v4aBEceJJOeS_f_SxF8xzA@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: sprd: use module_platform_driver to
 simplify the code
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 8:31 AM Liu Shixin <liushixin2@huawei.com> wrote:

> module_platform_driver() makes the code simpler by eliminating
> boilerplate code.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Patch applied!

Yours,
Linus Walleij
