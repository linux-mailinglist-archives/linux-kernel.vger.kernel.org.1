Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69517302563
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbhAYNPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbhAYNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:10:31 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D87C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:09:49 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id q12so17602946lfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YeRHqNmrouDWJP/xkxDkX2LI+peKn9k+q09qI8S2TU8=;
        b=dRVZmgfvGhNAzk/IwBG53sc+pQ/aIk70Exr8NAd5htfE7TJ870KtfGQJ+l+P6uCCE4
         /+B0cXnGctt84l20uGzfNPBJctSj8oXCYK+wGlTIm0yzims6GZ1aOY7iNP8cXqxVn5Bt
         jXJt0MLcwgi7Ydvx8am7ngO0e0b9WElQkR3hWotojQqRyoejRV6WtXULC3bAAdJwve1A
         bqiBs7ugsUPTjkQVNzh8sz7+33Nou6rMmH1/l7u8jRQJyKighLL3qfSN9b7yPSnzmrwH
         n+vgIoKr4txjpEO3dmQA3FAz3acdb2P/vnz+sIwaKxlc4YoW5iRw+/n4iO6+KnF5+i0b
         LXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YeRHqNmrouDWJP/xkxDkX2LI+peKn9k+q09qI8S2TU8=;
        b=MGINLCKI0shWNWW2z/bmN7Uh74syHirHsUXWzw32Ergq7DQAi9Ze8mOc9hD93K3jit
         sINPO+9ftw7LzkHFj7TZT0TCV1icINYXrgcfGbOnU7593jcUNKD3tjMTZbl3NtY+MsWJ
         HlYcVlpo7n2mhMXR9trVlL6BaeBbMaafV2tcztrV3+aypHawLJyUdt8bWsWB/MXMfJF8
         pcjNbTrx8xV+ToPf1H5G5ognxjbGfibfnvYhz5x5WtRx1gkMhUHnyQz8ERl3NUKxTYzf
         eGxoXCFYSJxpwyw3tglutzEgbYU2E9SJvBEVD4yVXJFlEGvTigqFen14jMdZ1oAZSsz6
         9eaQ==
X-Gm-Message-State: AOAM532p8MsKo4ZVXoVKmkWi2AiRocGxr7XKrEA5yBySUvJjBRCtIfQj
        DxRUHUS7Cgt7ln5ZQrSbkyOz3bcBc+wvackkNyX4lA==
X-Google-Smtp-Source: ABdhPJzro6MMf5skyu/xHZKuqomtw3z3XDeraz1uFn6qnVK7gkFAUnggvPcpKtvVQmySxqcXpRINt7L7FwdHXrWZ3HA=
X-Received: by 2002:a19:b8e:: with SMTP id 136mr249156lfl.29.1611580188141;
 Mon, 25 Jan 2021 05:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20210125031946.1882-1-hailong.fan@mediatek.com>
In-Reply-To: <20210125031946.1882-1-hailong.fan@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Jan 2021 14:09:37 +0100
Message-ID: <CACRpkdZV0dgqsCn1Ke+fy8W4eA0Eg9ksW-NJLp2AbLv8_j37qg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: mediatek: Fix trigger type setting follow for
 unexpected interrupt
To:     Hailong Fan <hailong.fan@mediatek.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chentsung@chromium.org,
        gtk_pangao@mediatek.com, Hanks Chen <hanks.chen@mediatek.com>,
        yong.wu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 4:19 AM Hailong Fan <hailong.fan@mediatek.com> wrote:

> When flipping the polarity will be generated interrupt under certain
> circumstances, but GPIO external signal has not changed.
> Then, mask the interrupt before polarity setting, and clear the
> unexpected interrupt after trigger type setting completed.
>
> Signed-off-by: Hailong Fan <hailong.fan@mediatek.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

Patch applied for fixes.

Yours,
Linus Walleij
