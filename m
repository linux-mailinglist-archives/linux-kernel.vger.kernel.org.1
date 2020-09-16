Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B290226C897
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgIPSxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgIPSIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:08:42 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4981CC025267
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:16:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e23so10031858eja.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkEKY9veHTwPibIHFpbD04kPDOQlB3REzNn2vqHPLEE=;
        b=Me3fWKlBz/bqv1qyH6RCJiLuuY/IJw7XNFXLrVrwKYKHruhMxmGWqHk9uy41rfgEVY
         LZqjwAG/jqihFG/PL/OHw5RvGAFiWrp4Hy/kLOSYPdzzZrN7Vcygd82ikdCqFLFyRcCr
         CCaE+kAbk3zaBPabqbIojCrQ5S54k+tX8KPbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkEKY9veHTwPibIHFpbD04kPDOQlB3REzNn2vqHPLEE=;
        b=DbP1XkJrl5FR4T47wKxTpTFw6+iKoeHJXTCZmlR1qVE4tJWYLu+kLIZvnuZ/lADFd3
         c/3T/HgUG5Pd9l6dUuH7OWQ8U0rVsWb8wSBwW3Uz/xyNw4qv4K/rPoi3Lp24AyKwXOQl
         gExK8gm3A3O9dV7OcKtnE6+hjPfE5SK1K7yoR14cB34wwFO9QAkkssiVXAQTlSZFYJfP
         PuX9bFk3Sq7dUh/R7sILZVz4EwP9nw69S19YwCpp43BUdsjDKyr1uAufTQCXg+m+q0Ax
         bCTz5Yc8WpYD7YLDSeVDkTbWsQarEyjEKUKK0OoYtKB25cbxmvfbnHiTCR5N0MvT7HeQ
         qkfg==
X-Gm-Message-State: AOAM531vs1kRT3TL8KdmSj7fJCPXBGWN9Ysh5jh8a9UQ/R+rNmAQtQxC
        LTizxArC+dNS9BLFx7GjKSgnBx+kyafWLn/6rugqRQ==
X-Google-Smtp-Source: ABdhPJyA99M6JuluYGiUPYdhAAyel9XALtRQxBmx8btvP1d+cDssH7Igzx6HlNtOGtIsFZ4JDWuY/U+IkJrWfmIyos8=
X-Received: by 2002:a17:906:46d5:: with SMTP id k21mr24564281ejs.247.1600258577984;
 Wed, 16 Sep 2020 05:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200831161436.134186-1-jagan@amarulasolutions.com>
 <6d3de17f-1922-e565-6a6d-b11b2f4be04b@rock-chips.com> <8e9567e3-cb75-7d74-1e50-728658a1b0e0@rock-chips.com>
In-Reply-To: <8e9567e3-cb75-7d74-1e50-728658a1b0e0@rock-chips.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 16 Sep 2020 17:46:06 +0530
Message-ID: <CAMty3ZAtZr_OoEVQxP-YdqLeT4SUbz6BqBGd9fZmrsVROS+xxw@mail.gmail.com>
Subject: Re: [PATCH] clk: rockchip: Fix overflow rate during fractional approximation
To:     "elaine.zhang" <zhangqing@rock-chips.com>
Cc:     Finley Xiao <finley.xiao@rock-chips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?B?5byg5pm0?= <elaine.zhang@rock-chips.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 15, 2020 at 7:10 AM elaine.zhang <zhangqing@rock-chips.com> wrote:
>
> hi,
>
> We have two submissions which I hope will be helpful to you.
>
> https://patchwork.kernel.org/patch/11272465/
> https://patchwork.kernel.org/patch/11272471/

I can see this, I have reconstructed the fractional divider handling
for px30 instead of all rockchiip platforms, is it okay to send
px30-alone fractional div handling support?


>
>
> A few more notes:
> 1. DCLK does not recommend the use of fractional frequency divider.
> Generally, DCLK will monopolize a PLL, and the relationship between DCLK
> frequency and PLL frequency is 1:1.
> 2, half-div, not all SOC support, detailed need to see TRM.

Can you point me the Page number on TRM?

Jagan.
