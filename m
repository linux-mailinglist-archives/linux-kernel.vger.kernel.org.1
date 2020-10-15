Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3828EDF2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 09:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgJOHxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 03:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgJOHxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:53:42 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEB3C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 00:53:42 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so2506596lfj.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mirJFt/MRyyrhQNtTeCWawOBVU7aK9Zu69rJH+8tsHM=;
        b=XzpAu1EPyEpYbe3z2T7MLHRKoDjzri6OXEg/Rl0Y2HlloeFfTfl+ggUd4m07zBHedp
         +5pGqOdh3838ThV6ZEQye7kd3gF3wFwQatfQ4Bv+dCjImyW29eowx9f5Oph1prkPeZrK
         60bGhh2W1DQg3ia5PL9HHkp8m/DUF7x5E4NZ2ZzTuh+9WTMrX9WCp1KejDAdRD647pPx
         dJcSdTHwDQlAV4w6q9MD9dGIjarIbdCwagV9cmkoNTblm3eT0Rlr+B5ZoQolWnOlg4Au
         J5kJSiwtSbFsgUR3GvH49ACU+PDnoGKvmaveUqPdAfHYUXv1cNFYYoSCBWJYVm+fkfVL
         DJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mirJFt/MRyyrhQNtTeCWawOBVU7aK9Zu69rJH+8tsHM=;
        b=aWjxN5NIOKZkqx2NIJQsjLePua38h1wlLaxNmyFm+6spdo1oe8qVcuJwiknV6EKuX/
         wWj/hoZ9Ci73N/PJ0l2KSb/bZ5OXxDw5krdnokuHlMQV6dtA9JW6y4o9nz4mLaCBoF0H
         zFDYv7ytBBhTzcd6cR9uruXY5OhuX/U8t4dmmsh+U7JwUEmjZYRCivy0dADPh/LrvFxp
         srmBR5XeYadKShOfw+L71+w5z28+VmFOm3G757HzgNgRXrgRmTvJOA5J2y6Vz0ukdGKF
         bKkUQQE+vWBzE8PsLta76mQIrTLohd39Z1WP5MwNacnuWUQeyawplwoW6MzUt8M+kEnb
         mvoA==
X-Gm-Message-State: AOAM5338YvEN/Umb66b0rH8x7A3kb2D/0LGU2xRQsjl2Dqx71iY5YroF
        qTQajkARacaA/gr4z3XdYriTRjVCTiAM0r9rp6NuBg==
X-Google-Smtp-Source: ABdhPJzFgdCK5Br1sXMpV9Xpk9vNS8zx0/k7j2csy+eIoWyecN8XysDyGsYJa950mXb6yj2Py9PxtCU9wX5zh2NKkuE=
X-Received: by 2002:a19:e55:: with SMTP id 82mr599537lfo.571.1602748420692;
 Thu, 15 Oct 2020 00:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154601.1901004-1-arnd@arndb.de> <20201008154601.1901004-4-arnd@arndb.de>
In-Reply-To: <20201008154601.1901004-4-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Oct 2020 09:53:29 +0200
Message-ID: <CACRpkdbc-Y6M+q8f7VEiee41ChUtP_5ygy_YN-wi873a+bN3yQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] timekeeping: remove arch_gettimeoffset
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 5:46 PM Arnd Bergmann <arnd@arndb.de> wrote:

> With Arm EBSA110 gone, nothing uses it any more, so the corresponding
> code and the Kconfig option can be removed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Very nice cleanup.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

At some point we should do a retrospect about how hard it really is for
us to get rid of some really annoying core legacy codepaths and the best
strategy for doing so, even though this took 11+ years as Thomas
says it still looks like a solid path to move over to a generic framework,
only it requires enough gritty people (like you) to hang around and do the
work piece by piece.

Yours,
Linus Walleij
