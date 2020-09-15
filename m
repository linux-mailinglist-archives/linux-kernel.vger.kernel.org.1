Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ADB26B296
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgIOWu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgIOPns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:43:48 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19868C061356
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:34:55 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id z18so1912279qvp.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jVIX31GM5OzuiYwy1qDVu4nYwPXpIvipqpPe/D5Y2c=;
        b=UvKHSOmupikGcEZR6eMV5XwM7v47cWXDW6Bi9HV3skxooR9FE3AMXz6SoYNdF42JDj
         S+F9oN0Yc/o2jjj/iiU83PDfBZN6xOxy+xsa4esg2d0QPsqyxaKJDpnraW3jdR9B0wjP
         iowBL7c2/rm6mUR2CF3JX5LL65AO+lyvG0qfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jVIX31GM5OzuiYwy1qDVu4nYwPXpIvipqpPe/D5Y2c=;
        b=VlAsPIRgkvcw63YonguKWeIF9kQ1ps/IPWItmCFKXCwxqadQWzeUkFZL1vjsALr6Cc
         cY6LvGeRpvqkS1qZh96s192QVo7FmBIeVX+rpfwbB/ocwwQIxmrMltpnp6ZI+EjJTmfP
         ANnYgxN9j/jLroYC08mowhLaF7jgRPigycN4+wEu+RYIv9NTPM2jstFm5vhsLQ1aDtfN
         NqB7UIQtT97qenlb9+K/SLrQ2w4dFFa7fOG0OHEO/zNhKRMAU+ZjHegGTKo6jxLcSY6x
         uZNiuOMoj0co4dFMLsFwsP7vYlCL9SIEYINwgnnR5OaVw2TlrFoVxwuzHhXGn8Hf/bKI
         aHcw==
X-Gm-Message-State: AOAM530kd1SBPipDNb1aO9mef4P6XWc5Nz/rsHQ4LVXC+CP8elvh10lB
        WQpNdz4zNlbfNbsbw84b1lYMDha5fb4H7oDT5hU/uw==
X-Google-Smtp-Source: ABdhPJwkC4hm7BcxmhV5CDSmUFQNZ2hdNWaW5YlfLwuZujsNFQKpTZ3kga7ew9IG1JhkM/FRuINPna4b3fe+DUjZOKw=
X-Received: by 2002:ad4:43e5:: with SMTP id f5mr17990138qvu.12.1600184094258;
 Tue, 15 Sep 2020 08:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200909040400.908217-1-swboyd@chromium.org> <720fcfbb-3f3a-9679-bd33-56d7f65651a5@collabora.com>
In-Reply-To: <720fcfbb-3f3a-9679-bd33-56d7f65651a5@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 15 Sep 2020 08:34:41 -0700
Message-ID: <CACeCKacudCkMoT40UJaf8PKUQu9G0csBmhih8cBO2Y3TAhV-0Q@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_debugfs: Support pd_info v2 format
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Enric,

On Tue, Sep 15, 2020 at 5:48 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Stephen, Prashant,
>
> On 9/9/20 6:04, Stephen Boyd wrote:
> > Let's try to read more information out of more modern cros_ec devices by
> > using the v2 format first and then fall back to the v1 format. This
> > gives us more information about things such as DP mode of the typec pins
> > and the CC state, along with some more things.
> >
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Prashant Malani <pmalani@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
>
> I saw some discussion going on in gerrit (a pity the discussion didn't happen in
> mainline) Did you end with a conclusion? Can I remove this patch from my backlog?

My apologies for not posting the comment here.
To summarize: the userspace EC utility ectool [1] can offer the
equivalent output, but with better formatting. So I believe the
decision is to use that instead of this patch.
I also posed a counter-question: can we remove this debugfs pdinfo
file entirely, since we can pull this information using ectool?

[1]: https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/util/ectool.c

Best regards,
