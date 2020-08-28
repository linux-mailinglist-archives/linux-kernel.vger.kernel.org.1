Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA23255BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgH1OFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 10:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgH1OFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:05:01 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BC6C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:05:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t6so1427032ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=laQRo0IXBoxlRUsr9rNJ2izAqPaxJoclO77g1cLJXao=;
        b=uD4QSdK6hO5ieBLz6ebVFwPy3jNa6V9k7enpVeXEEsKLFgH9aua6aN8wr2dAW5QEPY
         2L91KzVAzOjc+tpBpt101DQmX3P5eO/ngLJFTjUVELwsmhDDyuB1Q5/IHtQiKQgPNNGT
         ndkMmRk/qQiJMs0npYgVuZ8Qlbd98UU7JB/tgNadTn0zUtmcucr52jvRJYoFxQikIcyB
         7F1Dnr//0Nfe/JUw+3hUTZNURDYaSSA4V586hhcFYSZoE5RuB/bSo+IfupSpmyINg8mE
         D1VIkQyJqvm+oUnJDfQ/sq2uZ7AV2yMX4ro2xucZ7/2kQyrvi+dml/tkDuGl1pECxbwK
         rDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=laQRo0IXBoxlRUsr9rNJ2izAqPaxJoclO77g1cLJXao=;
        b=Wq7Mgg7/6D4WvGgmUxH+b45lV/AfHLD7a8lzunG410jTbIa49FU+TKZgeIHPJ8QIPF
         LiYD7uHPhGWISBjhJWn+K0vP3Eegnvlr5pt11FQjwThpu9i86cNvpd3konU434OoBUgR
         h1NKChSX3cWdkwisDF/CQtbV0AUqecAJBtweDZKXo9DXOG+AEuESiXPOaDHcwEA+ViTA
         zQ2gjzwCvbI4PMJFYv8SPBxqHnM7DggdJzGMLL8SKSiNmUTIUs2vL7W6gFRoikGh+l5y
         nd9WRI4tjRD+kbld78eu5AgfzvTMcw6YTjrdVuUcMJTSAFXdF0XQswcGmQhQYdc1rgvp
         wcww==
X-Gm-Message-State: AOAM530nI9EHA3SFJNqFD4mXFGgY8BKAeeRLi/u/fCg1/cGZwf/+hlqM
        W//ciovCYY24gl8VUPaLSQstGjxqNsbFnUim5yAL3KMMRGw=
X-Google-Smtp-Source: ABdhPJyyJ624adHJmQkytow4DYDghT/t6aR0J3mHhUm27rjibPXnfdnqsNPV1YMqF5OlX+vZJV1NgSgZ6OJ+x+2c9KI=
X-Received: by 2002:a2e:6a17:: with SMTP id f23mr883960ljc.338.1598623499763;
 Fri, 28 Aug 2020 07:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200827071107.27429-1-krzk@kernel.org>
In-Reply-To: <20200827071107.27429-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:04:48 +0200
Message-ID: <CACRpkdZ+qLRVpjaYKTjnXLLheTjaSKABEWJhvDvEcSOLgFJVaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mcde: Fix handling of platform_get_irq() error
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Eric Anholt <eric@anholt.net>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 9:11 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> platform_get_irq() returns -ERRNO on error.  In such case comparison
> to 0 would pass the check.
>
> Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
