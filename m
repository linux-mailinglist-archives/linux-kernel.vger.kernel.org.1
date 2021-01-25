Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4CE302D81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbhAYVW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732431AbhAYVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:22:08 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:21:28 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id p185so14707088ybg.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfYv+sVEF3bhw1NrTL/111YRCiFQJbiGpgUEbN5Ud3g=;
        b=vdoywtZsQ04KYGh8y4efLs3tq5e1SzosxigrGdvStf9bM1O0nvApWO3Y9rRfdxm5Q9
         iBOofp4u7ovw3TwqeVBSowBIb7ovyCzPiLP1PNN3GZA9D1GXc1Kti6dvPtotq0FXlZ2T
         TK8IGBt+3DaqiOfXQVW9/bsFCdOjWrPOBcWu9fkjevhJjx/K2c02T4ko67c6zo7Cb7Ww
         x6JNUJiN8QA8CoY8UHtLRdNOyJF6ZK6DnToXZKnErTBwoKtJU9SdFOJcqF3H0h0X+gN5
         frr5LV2Ta9aEnTEogDIVMg8476FzvkjeGSYWawvxPWvzPZl3dD56feqno43CgvXY44MG
         AZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfYv+sVEF3bhw1NrTL/111YRCiFQJbiGpgUEbN5Ud3g=;
        b=gZc0s7l2AiE1kD/pxqLp2ao1n1Iht5fWZYjZxM5/ONw6m35NjcS1f5rwMSFkD2xRr4
         F/UWoKhnlT9+vGoek3fZ+I5GmM9FiW2u/6cpg/7oV3vBLiiOy6BA36yc6LIXn8rTzEr7
         fz9Y4MFpeOeEecDlkDKm83TKgi4Af/eahPdXJO9VUYIuZ2evnjRC0u0iQPXPejIKuE1M
         qhGd2u5h2CvGQNb/E2vlo+lWwquAA/nROBCen0Q3p+Uhi5RmaYP38I2TQBIpZTHolYGq
         AUSx1U3Lk8R4tmYbhPSAIsZM4jdEfCZIzQpkYutRbMX/3UQQu2PRMvmbaWqwl2VyEks6
         xRkw==
X-Gm-Message-State: AOAM530HTbdLDJqJeRl/0kJDbsqCBmFoj+vESjcPuOfMIhuMykYVETUI
        Cfb8VnHvYy/E9uGpj01PCFWJAUi1jJAADp8IfyQ=
X-Google-Smtp-Source: ABdhPJytXOelKtb1GMWyyHCYrEkRMeWpmEba0362qDSgQ5UPwB3bJFpapP9xjNvxXaS+BxK/NP1/h9h31mlppGTKZmU=
X-Received: by 2002:a25:af8c:: with SMTP id g12mr3770009ybh.33.1611609687898;
 Mon, 25 Jan 2021 13:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20210122153940.2874225-1-geert@linux-m68k.org>
In-Reply-To: <20210122153940.2874225-1-geert@linux-m68k.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 25 Jan 2021 22:21:17 +0100
Message-ID: <CANiq72mCatMxsub7HXaKzj+v2o13aNCP-9vUx_UAxPYSt_k0Lg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: ht16k33: Fix refresh rate handling
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 4:39 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Drop the call to msecs_to_jiffies(), as "HZ / fbdev->refresh_rate" is
> already the number of jiffies to wait.

Applied to -next, thanks!

Cheers,
Miguel
