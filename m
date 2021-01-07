Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05F52ECA93
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 07:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbhAGGji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 01:39:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60108 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbhAGGjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 01:39:37 -0500
Received: from mail-oo1-f72.google.com ([209.85.161.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kxOwh-0000uq-6b
        for linux-kernel@vger.kernel.org; Thu, 07 Jan 2021 06:38:55 +0000
Received: by mail-oo1-f72.google.com with SMTP id z20so3581659ooe.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 22:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gc+fC2uzrPTIv/OjMkzLquFL5H8Wh/2Rm6W4yaQ752c=;
        b=J1xtTu9KcPv+8iYvAMHZd4wW56n1P2tmWm7d56wUSZtnYiE2WdtlaKWTrbKF5DDtk/
         xfDzhzJ5wWvW4ik30lIez/EpgruQfhD7wxmTohbXrH2hMGyP8wDyPX4uIYFlwFD0p6HF
         C/hBIXVaW+jraxbaAfCHENUjzByTjAkMlC8+UXS4bEFU/aZsfcHn57MNcUQYp9J4812c
         VNc1xu90kXluu137Rvc1R5CSjdEDAMyKLkmkJXRjf1NBxZKA4qAc0Kz0wiytesIRHu+Y
         j2Qm33DOgnAaXlPvzU2xNlyWDV9rbsBhbknXRV3KSr+RyWiwOndyUtwLBbgjMa+D6pLA
         Wr5A==
X-Gm-Message-State: AOAM531Qw/arr3FVqQDZudCS/VGRQHNST/SBwBZMmuZmw1gPA2MBIlW+
        re3idujhLR+cnPYK42NrNSbECk5dmmZjtmMF5/CcWPLjD0musu7qzIkfzhdg8tgs4PqCGrbTjsR
        +Svwuq9OUI73oKjC9D0oEDzZbCNM+MnPKWqlrmu9AMUXnxyI0kwx8w4tqCA==
X-Received: by 2002:a9d:4816:: with SMTP id c22mr5539018otf.358.1610001534167;
        Wed, 06 Jan 2021 22:38:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIfDhiYPhS3S5PaeEdW+dFoXwmfFeAUrAJeItJZ9WP8HUWgmpU0R8GvY6EhnjGOtDrahFqtDToLumrSeZxMyQ=
X-Received: by 2002:a9d:4816:: with SMTP id c22mr5539001otf.358.1610001533893;
 Wed, 06 Jan 2021 22:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20200805084559.30092-1-kai.heng.feng@canonical.com>
 <c0c336d806584361992d4b52665fbb82@realtek.com> <9330BBA5-158B-49F1-8B7C-C2733F358AC1@canonical.com>
In-Reply-To: <9330BBA5-158B-49F1-8B7C-C2733F358AC1@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 7 Jan 2021 14:38:42 +0800
Message-ID: <CAAd53p6SA5gG8V27eD1Kh1ik932Kt8KzmYjLy33pOkw=QPKgpA@mail.gmail.com>
Subject: Re: [PATCH] rtw88: 8821c: Add RFE 2 support
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 7:24 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Tony,
>
> > On Aug 5, 2020, at 19:18, Tony Chuang <yhchuang@realtek.com> wrote:
> >
> >> 8821CE with RFE 2 isn't supported:
> >> [   12.404834] rtw_8821ce 0000:02:00.0: rfe 2 isn't supported
> >> [   12.404937] rtw_8821ce 0000:02:00.0: failed to setup chip efuse info
> >> [   12.404939] rtw_8821ce 0000:02:00.0: failed to setup chip information
> >>
> >
> > NACK
> >
> > The RFE type 2 should be working with some additional fixes.
> > Did you tested connecting to AP with BT paired?
>
> No, I only tested WiFi.
>
> > The antenna configuration is different with RFE type 0.
> > I will ask someone else to fix them.
> > Then the RFE type 2 modules can be supported.
>
> Good to know that, I'll be patient and wait for a real fix.

It's been quite some time, is support for RFE type 2 ready now?

Kai-Heng

>
> Kai-Heng
>
> >
> > Yen-Hsuan
>
