Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6662FE510
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbhAUIdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbhAUIcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:32:21 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC0C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:31:36 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id n8so1545292ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkUzS22l3yT4wvob1mqKHkY+gLej+PQS8WtEPboZD/g=;
        b=Uq0P5RZInuXnRMF1iS9apD3S7TtaJGz8oezi/WVpjyYghj5/6LGpc4q+b/a5i08bAe
         HOQyg19CRzKSpqItjZhM2lu+2/8d2y4QAyO8Ua9gqZIBeAerTXNmO89cHM7KHB9bQ3vy
         V5oa8w8zyxM+czY/gT8zef1IP0sV1bY82tUi/sYU1if+dtshG46fuFW0evdQDno74LSz
         AWZ4sPuzrZEl56+eIJzA+YWN9R1XudeSRr9r+L7G2zMZq2dc1DEiYqb6IEjwn7Vh/stw
         KTNiV0gMMTtsqZ5PqHkI1Rahz8lICSizTh+b7yexnUkfwQ4Vyse+Dg9Xnqium3VEE5C5
         3w0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkUzS22l3yT4wvob1mqKHkY+gLej+PQS8WtEPboZD/g=;
        b=SPf0zc+48KL6sViW2Mn0sYQQIvIVTpRN2BuIXBVQIEdbR4o5SvkjDrdGf4K9rwygGY
         mADD8LMcisf3P/hxY/OCYdLcugifrintPZ3Qrt2tF8UcSsDtPQ9OYXROqH1V3kn8vYAu
         Aqnx7uXFtaGDKSscJlAz0XL1mFkGiMrewwInqHdQ5mPvevvf8xF6vkvFanzbVTbMCQu2
         owWU52z5j3BXtBPakzL62ycNoRBVxOgJHmpXnftkLT38EkbF89tiH2ssF79qAwm9SeBb
         AqoMZY2mls8CkbzLKn8aB07akcnz34mtcj20XIkQtYmGczt0AIa2kkR8DYpNg9CheP79
         AZ7g==
X-Gm-Message-State: AOAM533pCUdC4OBBLy8u4Kab7OLU9o7cFIF8u4O7wUNM8E93jRFyQSgZ
        slKvwP7rQ4vcoNaWSVpXe0bEguQ+6I+FwiKkeYVruA==
X-Google-Smtp-Source: ABdhPJyfv+B8zbe3ES1yKRt6eO2ubbuNq2b3jKpVOgLF7fkljnuiReGloInJLZ7v+86/vskCjlMHQvE9I9e/x4JPg0Y=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr6079256ljl.467.1611217895269;
 Thu, 21 Jan 2021 00:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20210120093040.1719407-1-lee.jones@linaro.org> <20210120093040.1719407-20-lee.jones@linaro.org>
In-Reply-To: <20210120093040.1719407-20-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 09:31:24 +0100
Message-ID: <CACRpkda-wp1Ja9QCJv-k=zxKd471ac_tp1GGepmO0jdPa9do_Q@mail.gmail.com>
Subject: Re: [PATCH 19/20] clk: versatile: clk-icst: Fix worthy struct
 documentation block
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:31 AM Lee Jones <lee.jones@linaro.org> wrote:

> Also demote non-worthy header to standard comment block.
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/clk/versatile/clk-icst.c:53: warning: Function parameter or member 'map' not described in 'clk_icst'
>  drivers/clk/versatile/clk-icst.c:53: warning: Function parameter or member 'vcoreg_off' not described in 'clk_icst'
>  drivers/clk/versatile/clk-icst.c:53: warning: Function parameter or member 'lockreg_off' not described in 'clk_icst'
>  drivers/clk/versatile/clk-icst.c:435: warning: cannot understand function prototype: 'const struct icst_params icst525_apcp_cm_params = '
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
