Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2D829F3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 19:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgJ2SAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 14:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgJ2SAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 14:00:19 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5935C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:00:19 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k27so3893653oij.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxRuOq6f8j/OJClpjygk5Sil7hNP3LLwSpzSQ8AdyIw=;
        b=YgYWiWE7JZt28JrbecJ3RcV+vUGkrnWCMu2zz09AhOgDPRFoxcxkRzZRZIYZFCmYlU
         WelfSscahfL8OzNYoWwJRkryvGoSRoiEzEwmbxgzLIlrQsEkw+8cQNZUSeEajoGXUTL2
         jCF3B2dyfmz+kjVtpp5yyc9Fhe5zKey/CyuysYlk4j/z8ERIfXkVMdl8sJK6PgwvtR2P
         kH93bhE8ipq6xK3TG8duQC4MaaN5xohyYUk9mYVO2K/X39cmPvAFOhDBT1oL1XXeVqQS
         3+JrGtYAfp72Z8D22xDfjs9pDfbN+hikJ2F5+sVNIQOvRYxc0QJMzVkp3+mNERSJv5UD
         alOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxRuOq6f8j/OJClpjygk5Sil7hNP3LLwSpzSQ8AdyIw=;
        b=XsWkTB5octpFPa55OD49G5yjdFH07SjF8vPw4Tqd77w+Vl1jdrrYrs0Y8EhNKD4KB1
         4cwQZX/gyYoBy37q98S1oy0sG6AIJvbF4h8RnvX7dbOumKOBQnDgriXymAlJuf7Nu+8Q
         sc+tSwFR5aBCj5egrh1cReQ4idK8K/A6/0kCmrO4Qed+hOc3pOvoWWXucS3rrnfUtTeq
         0AsxYNpPQouhjvyvwX64AWvxmwM1J9p58z/txWg6vPvJrg1x+u2xeDRHVPFEKSMmZzfN
         sdcLkJdknfwGLI6eEpWvH51/unuNjHr+1PmSMK8cFlVdtplOZd6ZyuSd76pycKiRImrM
         E9ZA==
X-Gm-Message-State: AOAM5307Pdkp/Nlv20pE/F/JNwOUwL6vxl1JM40gh6rj5dsWkyM1N7Qo
        d25FoSIKzmW6Uvo9/KPahIgdtWLiYFIux69AxyLfxA==
X-Google-Smtp-Source: ABdhPJz3mnbcHjmN2y7saCgbvDUKaiY9BdLFyShvD8FLDdQTJYtPNBqIEiyaybFQMidaIPMWOeXim/lHrvti0R/5eDc=
X-Received: by 2002:a54:4812:: with SMTP id j18mr655595oij.70.1603994418860;
 Thu, 29 Oct 2020 11:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201029173620.2121359-1-aleksandrnogikh@gmail.com>
 <20201029173620.2121359-4-aleksandrnogikh@gmail.com> <40e7ef15f3ffd32567c1dd74edae982c53b0fb06.camel@sipsolutions.net>
In-Reply-To: <40e7ef15f3ffd32567c1dd74edae982c53b0fb06.camel@sipsolutions.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 29 Oct 2020 19:00:07 +0100
Message-ID: <CANpmjNP3Jadj3r27Y+GhxUD_cboqn_d2BYKiqM4BzktezgjRYw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mac80211: add KCOV remote annotations to incoming
 frame processing
To:     Dmitry Vyukov <dvyukov@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Aleksandr Nogikh <aleksandrnogikh@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
        willemdebruijn.kernel@gmail.com,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 at 18:44, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Thu, 2020-10-29 at 17:36 +0000, Aleksandr Nogikh wrote:
> > From: Aleksandr Nogikh <nogikh@google.com>
> >
> > Add KCOV remote annotations to ieee80211_iface_work() and
> > ieee80211_rx_list(). This will enable coverage-guided fuzzing of
> > mac80211 code that processes incoming 802.11 frames.
>
> I have no idea how we'll get this merged - Jakub, do you want to take
> the whole series? Or is somebody else responsible for the core kcov
> part?

Typically core kcov changes have been going via the -mm tree.

Andrey has been making most changes to KCOV recently, so if there are
no pending changes that conflict, I don't see it's a problem for this
whole series to go through networking. I think the other series that
Andrey had been working on has been changed to only touch
drivers/usb/, so there should be no conflicts pending.

Dmitry, Andrey, is that reasonable?

> In any case,
>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
>
> johannes
>
