Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C008B255141
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 00:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgH0WnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 18:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0WnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:43:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D6FC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:42:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f26so8241615ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pcU9aUbUl4TsqruqjB25HWTFFDbqp5NR2RTfcoKiZA=;
        b=cUyVtGY4l+LoL3wR2SzxDMdStxapZTbtWykZgqn5aYmKeamYFI4RlnlzwgXxR5ZiLH
         XkzwGUaNNQ/Tfw3G1cY12uZLp2+65yELJ0k6aaVJ4sPiILv8buG5SG5rdmuqhfc/UVRk
         z5i/7gKqZ+EOqd0h0dVCPLG47W+bO5wffx1CCgvcF/QgZ/zX/TvuD99CT8ZNc4DauYjw
         /4dfKgH8Mexvkr/AdVyyu0OGSGUVLc6SYdfd+W9o/p1vee9uuw+cBqoQBOUztk6IlNtO
         5e/fubZ6bQJqatAAPqA8L0o+mkcn8fC6JmyJ8ddOTAx66Iy67QZWJTpI95/YWjtG3FUc
         ZBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pcU9aUbUl4TsqruqjB25HWTFFDbqp5NR2RTfcoKiZA=;
        b=koxZjg5z+KiTdBa68UW7K5TYYqPAYDkDhRnHIAGPGcBzSXaID2i5NzW0Sg4EirIgXM
         KYPM9Pbx4k2mMIAZkIho05YUA66IQOiAY2iBoFFqM/rcXiDkFBoOlXuGx0Sfimv3Zx/h
         0UsPxX7OyFwwQi3fodHG04/J6qACYwAXe0VjOmhy2K8oaEjxpHW7fNpELXX88l4c3jFa
         y9RvYYXLdp0MPW6ZJgE9Iaqzc1eSy7HhRKFaAS20LE9DWgLFF9fhOw+Q82j8ZI/M+QAH
         O6T4dBfIfKLeXffoCXFK3JqKWUff7ZLhV6+WVOaHAYIXH5pNyI/0iZDCRqpH4CQ2lW23
         ZTPA==
X-Gm-Message-State: AOAM533aToIwwRDo+r9EhCGvn2AMy/0GgQ0zCveOuPKQ46WAVc1LvYKy
        g3uYb3jiN0EIh5utdQ7nyyEzHmrOSyY17/CYQOyRhA==
X-Google-Smtp-Source: ABdhPJxuq5HLMjGEaukBGNErQ2RJktB/q1HsZFR2gQYz/fssJ1HSn+vRmpdeaTizzWq+YVLPW97XMnpPvqQGTAjQhjY=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr11284682ljo.286.1598568177595;
 Thu, 27 Aug 2020 15:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200808043512.106865-1-john.stultz@linaro.org>
In-Reply-To: <20200808043512.106865-1-john.stultz@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 00:42:46 +0200
Message-ID: <CACRpkdbyv2=k8RqvH80hb51eH+zjvhjJTuiJtxv5JO47p5ptCg@mail.gmail.com>
Subject: Re: [RFC][PATCH] pinctrl: Rework driver_deferred_probe_check_state()
 evaluation since default timeout has changed
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 8, 2020 at 6:35 AM John Stultz <john.stultz@linaro.org> wrote:

> In commit bec6c0ecb243 ("pinctrl: Remove use of
> driver_deferred_probe_check_state_continue()"), we removed the
> use of driver_deferred_probe_check_state_continue() which
> effectively never returned -ETIMED_OUT, with the
> driver_deferred_probe_check_state() function that had been
> reworked to properly return ETIMED_OUT when the deferred probe
> timeout expired. Along with that change, we set the default
> timeout to 30 seconds.
>
> However, since moving the timeout to 30 seconds caused some
> issues for some users with optional dt links, we set the
> default timeout back to zero - see commit ce68929f07de ("driver
> core: Revert default driver_deferred_probe_timeout value to 0")
>
> This in essence changed the behavior of the pinctrl's usage
> of driver_deferred_probe_check_state(), as it now would return
> ETIMED_OUT by default. Thierry reported this caused problems with
> resume on tegra platforms.
>
> Thus this patch tweaks the pinctrl logic so that it behaves as
> before. If modules are enabled, we'll only return EPROBE_DEFERRED
> while we're missing drivers linked in the DT.
>
> Cc: linux-pm@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Rob Herring <robh@kernel.org>
> Fixes: bec6c0ecb243 ("pinctrl: Remove use of driver_deferred_probe_check_state_continue()")
> Fixes: ce68929f07de ("driver core: Revert default driver_deferred_probe_timeout value to 0")
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

This looks sensible to me, but I'm not the best with the device core.
It'd be good to have some Greg or Rafael stamp on this.

Can we have some comments? Reviewed-by?

Yours,
Linus Walleij
