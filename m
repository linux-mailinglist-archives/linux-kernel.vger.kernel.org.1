Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359262FBFF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbhASTX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390099AbhASTQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:16:15 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B4EC061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:15:34 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 36so9364112otp.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5M/xwriCvZ1ehbhOrKqRjMwNoC7bFrlBY9OQlV4JhBQ=;
        b=VWO3o72xi9hscdAVyxdDSmzYIRxLsgi6uCN7en9qrfVE7711O7MAhTXDHS/7XGm9hh
         p91gsGfWQTBnBlIWrIJqmzr00hP935pwO4oe/C03aHZJ8kvKLi5B1mqsOQccAf+U7kgI
         xH3t0UJRWdDdIeUH5fZvbFR/tFgWEBfJGkrPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5M/xwriCvZ1ehbhOrKqRjMwNoC7bFrlBY9OQlV4JhBQ=;
        b=OVRuxnw5/Zmu/YyvHUHkKRetWLzQ4GnLhxbUc+uttZ48BDEKNRaS77btSuok3pFWfd
         2VN9sydrdNaGhNpyjXBDJG0vARxudGSQmLLAbbMrCsXKN5eQR7ewi0ExUhuNRQOZW8TR
         TwcAYQzaPcQ+BL73vaNaZ0F0tPPtwhCW8cm8GJtwojuUUaqRCEI3lhD9/ubim30+IUvj
         sV/H/iHsU1zbZvK5YdkLLwt/5z3XyFd1RoJUvCLPWzCrF055J2CEL39d6pZzljBnaptx
         yWU3kpt0lM/E4wUWHYg7KiSv9IyBxIuf0G85NEHkeJkVqc2rqxhy8myrk3+48bvVIjP2
         hFbg==
X-Gm-Message-State: AOAM532yRK9EJ9GBrJ2/DXTFUPl/bqyw3ys4jon7OnVlIjz6MRap1Gi4
        U9Y5c8eNMqwzSGGzw9I/rjUlLf8q1H6kHQ==
X-Google-Smtp-Source: ABdhPJzazH2vkql7vFBVP9WvqxWj0qt9QmEyu0u1HpF00qY4MYXiRN23A1YOprUrxZtDLOxonPtFug==
X-Received: by 2002:a9d:774b:: with SMTP id t11mr4484933otl.337.1611083732571;
        Tue, 19 Jan 2021 11:15:32 -0800 (PST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id k65sm2633490oia.19.2021.01.19.11.15.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 11:15:31 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id r189so12724018oih.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:15:31 -0800 (PST)
X-Received: by 2002:aca:df02:: with SMTP id w2mr766754oig.77.1611083731008;
 Tue, 19 Jan 2021 11:15:31 -0800 (PST)
MIME-Version: 1.0
References: <1610703513-933-1-git-send-email-abaci-bugfix@linux.alibaba.com> <CA+ASDXPCcgfXQNGRQThKHSRcxZ7i6=1GM0+sZL+ZAid8e=+sRQ@mail.gmail.com>
In-Reply-To: <CA+ASDXPCcgfXQNGRQThKHSRcxZ7i6=1GM0+sZL+ZAid8e=+sRQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 19 Jan 2021 11:15:19 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPFGxKBBMU1ZKO6oSTNeSKMeZktfbDWndEqXJ1_6ojTcQ@mail.gmail.com>
Message-ID: <CA+ASDXPFGxKBBMU1ZKO6oSTNeSKMeZktfbDWndEqXJ1_6ojTcQ@mail.gmail.com>
Subject: Re: [PATCH] marvell/mwifiex: replace one-element array with
 flexible-array member.
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One more thing, for context:

On Tue, Jan 19, 2021 at 11:11 AM Brian Norris <briannorris@chromium.org> wrote:
> On Fri, Jan 15, 2021 at 1:39 AM Jiapeng Zhong
> <abaci-bugfix@linux.alibaba.com> wrote:
> >
> > Fix the follow coccicheck warnings:
> >
> > ./drivers/net/wireless/marvell/mwifiex/fw.h: WARNING use flexible-array
> > member instead(https://www.kernel.org/doc/html/latest/process/
> > deprecated.html#zero-length-and-one-element-arrays)
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
>
> Past experience unfortunately requires me to ask: did you test your
> changes? I understand that's a mostly legit warning, and a good
> deprecation notice, but that doesn't mean this is the right fix. One
> probably should instead audit the usage sites to see if they *are*
> already making proper sizeof (or other) comparisons, and if not, fix
> those first. And if any sites *are* doing correct sizeof computations
> using the existing struct layouts, then you are probably breaking
> them.
>
> Or if you have audited the usage of these structs, it's nice to make a
> small explanation of why this is correct, so I (and other readers)
> don't have to ask these questions :)

FYI, there are others who I believe are making similar blind changes
to this code:

[PATCH 1/1] mwifiex: Fix possible buffer overflows in mwifiex_config_scan
https://lore.kernel.org/linux-wireless/CA+ASDXPkLg2GGFJTt25YO7wae==YAHftf8JXu520pL_vZaT3ug@mail.gmail.com/

For that particular case (the 'ssid' field in
mwifiex_ie_types_wildcard_ssid_params), the previous patch-er was
incorrect, and I believe your change is a better one. But neither of
you provided useful analysis.

Brian
