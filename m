Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF47628F263
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgJOMi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbgJOMiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:38:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC5EC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 05:38:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m20so2984164ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jh1aY+47O6ijaqC86FDIidJoI9nLsLE5P2PScZjVVYc=;
        b=AQoXVekiV2SgOwW5jhwFYEpMmlaKGCs+XQecaBElJ8effG1Nu+2U49Ccd4kdtEQy2U
         S+OOH0BxW6QdDeA0hasikyMkK6DX1iW80hExe7zPfnmQXgLXuz0Bp/f/BWcNRsyKPA4d
         XMHaMCkS/Fq25XyC6Ab+xmbBHB4ey94bFFBTGHiMaVVPCgg0OYoOZmo2h+6ndHbbfUt8
         xE49yeAHilYYHeVr0qnA+dFc4lAJ+vEyqCqajVMTrzJwNh8NA0YmSkb+4F+xyXuX0kRR
         /CUicfeusURGqlxEjfHLQunypvKflSsWeh+wqhIPD489Q8Nacr8h2UqxgsD1Tw2096iO
         cZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jh1aY+47O6ijaqC86FDIidJoI9nLsLE5P2PScZjVVYc=;
        b=TgVXln7FnojhjHJaxLxIsMLD9cTEjwAhV8mS/48GLDY9tRdQc1e0mkZj9EY8fomacH
         xSB3hzq5xqUx23evt6wtCq7KH/xppvTf8VEjx+VVbM+qb+WqNQSWC9SXjefZT6stMseF
         itGwlC68tzkUv3XR57wSWWi9tlo6XbkRIJFArT5HF6ci3Ang8bcsbyQmbgO9W+dD1V39
         sdp3Wr4PKjQOckXmLb/2Fzv932Z02oYG1G920AoK4U/xt7saMr6/tAcufstMxHn8n3jz
         OCfM8Ne+hv0OuzHKD6AmEE63LvXECSubRr6ZTHqWcDAWk1h4wZMROO3zMK771+cwlzmj
         zC5Q==
X-Gm-Message-State: AOAM530zIX6ciqseheQJZrhDs4hf9lBRWtoR1GnpcOm1HvITxc0S6ofP
        TkzyytCCmBQBZrhRhpZ7K/LuCfxqTEgehdBMEwnOgQ==
X-Google-Smtp-Source: ABdhPJxvMITtZRdUF7vCkgov96m37F496Q+RbCqUO6UxDlRRW2t1pr04OQAupH8vwGhiQD5mxcK8M5s+Hj+cVW2k+0w=
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr1089670lji.338.1602765499407;
 Thu, 15 Oct 2020 05:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154601.1901004-1-arnd@arndb.de> <20201008154601.1901004-4-arnd@arndb.de>
 <CACRpkdbc-Y6M+q8f7VEiee41ChUtP_5ygy_YN-wi873a+bN3yQ@mail.gmail.com> <20201015095307.GS1551@shell.armlinux.org.uk>
In-Reply-To: <20201015095307.GS1551@shell.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Oct 2020 14:38:07 +0200
Message-ID: <CACRpkdaOuMHfqrToVPRVW1zEYDY6H-gPm1QkR2CydtbLj-7csw@mail.gmail.com>
Subject: Re: [PATCH 3/3] timekeeping: remove arch_gettimeoffset
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Thu, Oct 15, 2020 at 11:53 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:

> Don't be misled. It was not a matter of "enough gritty people", it
> was a matter that EBSA110 was blocking it.

I remember that EBSA110 was quite different in that it had this
especially limited PIT timer, true that. At one point I even read
up on the details of it and then forgot them :/

Yours,
Linus Walleij
