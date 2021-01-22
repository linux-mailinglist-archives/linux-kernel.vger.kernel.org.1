Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D936C301058
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbhAVWyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbhAVWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:49:56 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D9EC061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:49:15 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p21so4661450lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFqxITJ/kjeDG2P1yWw2xgXqtJJ5NxGhm9klFI3NBC8=;
        b=KQHnomUVch64dE+lLq+W+ZLldPYPV9dXf0NMuNWCe4vYfRB5rsV6yA0IhuhfWySbin
         +zE8PCFBAhpKFv+rCsFi4JxKdyCJHlCPdp2Eczkwkap+W/FBKjLtoQUJP+cps0By+s8F
         jvZ7EVreZ1rMR9opYmFB/KZqNpZQjwX7NEl9HYQAGjv1rNeO6oQZAXsisPV4XRJsLKJH
         /es5XoIvKS7nfRk8uKUSSMH4qiW/8+BnclKRAILSpSgvVAESqfOYGhIbvBzyeIBZcnrZ
         gHuLjLRbAB2fvdEHK6vV5RGNoVOLKDu25a4BygEc16eLZ3zowgMBbJnlcr9kAg/BFDex
         Nq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFqxITJ/kjeDG2P1yWw2xgXqtJJ5NxGhm9klFI3NBC8=;
        b=k826/GSN7O3JexpC1oXufzvH7F081VFGv3DnvqsW7dUTz+QynmnB390c4zD0cuQExK
         +k5BYXybBhLQiSZSb6MWu8x94eEskh8x9Cifw3+j9bmILeO0OXdkrAItORjfDxnwjzQS
         kTQLx4Vhj5niti77uW+HKYS1p16DuBwZiL07O1o19AhdX8GqfqtwEtLNVoJBqZp+3ZZa
         xsMQPYeYNgNw8jlWqOp4lk7IQKSN9Ao3FNUfyNo1IGpaWmNwRDrc/jCXKg+mqNyl4+bR
         8EL2Xyoq8ZiPnCMeFrjLonH/QMtXt81c0B6MXQkGB+604JoKW09KoUNl7AUbUBmEQNuy
         9CiQ==
X-Gm-Message-State: AOAM533dj2bD0ZzFf1J06zK9urU6BFKDJcx5u9Cn+3gTV/0qGvDs1G9i
        Nxj+ll2BBs40wphmGUWJLQDGXTW3KBlQwkVF/NUc3Q==
X-Google-Smtp-Source: ABdhPJwAU+6Jqx1W24ybS/wG1g9yGkd/VdwBp0lvRWjc4qVAt7I7HgrVnDKDFipxsyfcynMdtoDSnEB24BY9L9kAkAg=
X-Received: by 2002:a19:495d:: with SMTP id l29mr742605lfj.465.1611355753600;
 Fri, 22 Jan 2021 14:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20210121141038.437564-1-warthog618@gmail.com>
In-Reply-To: <20210121141038.437564-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 23:49:02 +0100
Message-ID: <CACRpkdbHYqxjC=GjVeE391Qq5szvtRbP4HAR5bx+XRuL1HmMew@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: clear debounce period if line set to output
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 3:11 PM Kent Gibson <warthog618@gmail.com> wrote:

> When set_config changes a line from input to output debounce is
> implicitly disabled, as debounce makes no sense for outputs, but the
> debounce period is not being cleared and is still reported in the
> line info.
>
> So clear the debounce period when the debouncer is stopped in
> edge_detector_stop().
>
> Fixed: 65cff7047640 ("gpiolib: cdev: support setting debounce")
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
