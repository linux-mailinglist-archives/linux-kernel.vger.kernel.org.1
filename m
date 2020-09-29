Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D99627DD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 01:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgI2Xx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 19:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbgI2Xx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 19:53:28 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089E5C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:53:28 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id a16so3294vke.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOMvpJf6jnH+JyF4Og6jExEF8H9zHVHC1Jf6qwYVtbM=;
        b=iI8aT1Wp1Gb1k5+bUZubbPKESeO6IaGvH04eyr/FlKisSVUJrSN7sxDr7ZHh6ykQ/k
         p7cNKRYxDABzhCKvmHmHPKiowzooCDlBaAZvhSAf2IiRXIGwzXrOzYmprGqkR3t5zyME
         2T3KDDuBxMrpVIi6xezEVmNob5wdPQLidqukU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOMvpJf6jnH+JyF4Og6jExEF8H9zHVHC1Jf6qwYVtbM=;
        b=MHWE+K+DcTJuzg6gZU1Th7PTDB5qcdHGHMni+XXhCDZWNIxUahKf0BYcUpGXqpTnho
         iqCXjkSmcnwLQ0mic2A9zuduj13ufvLRLvxcO+6VHlss9Dc4nMGpQoCIVTCJcbKOPnh/
         6DjVBKHSaj4qWSJC2DUdSIShhE3W6nMbpFCupoCl2SlxOw8eGcTgOYpDZyPQMHznIlWR
         SMWoi/ZlFtZSDpio2BcYlQm0O5v+YRMF/fA1lX2ipBi0OrsBU6JJzi0dUa5YqXYz9VlL
         78l/T8Bg//XWDst4FegubzXiqDrneEGHV2SGQyOrPmcLzHtWYM+16x1/K2Hh3DicTCXU
         rdNw==
X-Gm-Message-State: AOAM533hNWDzeyA1bLxvX8goU9r6vvfLZX66U8LkwIVdpx6z7j68HB6c
        /LXpac+R0uWtfT0a5y86cSdZLBnbvgxVUw==
X-Google-Smtp-Source: ABdhPJy+182ZPmdnBWmyvSA4hJ0l0et9WC0In7SXS/FL77tVhYWhfT90qsnvKlxHuCxkchjko7P0gg==
X-Received: by 2002:a1f:3a09:: with SMTP id h9mr20286vka.6.1601423606323;
        Tue, 29 Sep 2020 16:53:26 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id j76sm1760534vkc.50.2020.09.29.16.53.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 16:53:25 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id j12so4064630ual.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:53:24 -0700 (PDT)
X-Received: by 2002:ab0:29d7:: with SMTP id i23mr2207uaq.121.1601423604458;
 Tue, 29 Sep 2020 16:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200929121610.16060-1-lukasz.luba@arm.com>
In-Reply-To: <20200929121610.16060-1-lukasz.luba@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 29 Sep 2020 16:53:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UnNkjMiOc0DZE7+OM3-Kr1ZRynxSerdA=ifbyGiRa2Zw@mail.gmail.com>
Message-ID: <CAD=FV=UnNkjMiOc0DZE7+OM3-Kr1ZRynxSerdA=ifbyGiRa2Zw@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: Clarify abstract scale usage for power values
 in Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar.Eggemann@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 29, 2020 at 5:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The Energy Model (EM) can store power values in milli-Watts or in abstract
> scale. This might cause issues in the subsystems which use the EM for
> estimating the device power, such as:
> - mixing of different scales in a subsystem which uses multiple
>   (cooling) devices (e.g. thermal Intelligent Power Allocation (IPA))
> - assuming that energy [milli-Joules] can be derived from the EM power
>   values which might not be possible since the power scale doesn't have to
>   be in milli-Watts
>
> To avoid misconfiguration add the needed documentation to the EM and
> related subsystems: EAS and IPA.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  .../driver-api/thermal/power_allocator.rst          |  8 ++++++++
>  Documentation/power/energy-model.rst                | 13 +++++++++++++
>  Documentation/scheduler/sched-energy.rst            |  5 +++++
>  3 files changed, 26 insertions(+)

I haven't read through these files in massive detail, but the quick
skim makes me believe that your additions seem sane.  In general, I'm
happy with documenting reality, thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I will note: you haven't actually updated the device tree bindings.
Thus, presumably, anyone who is specifying these numbers in the device
tree is still supposed to specify them in a way that mW can be
recovered, right?  Said another way: nothing about your patches makes
it OK to specify numbers in device trees using an "abstract scale",
right?

-Doug
