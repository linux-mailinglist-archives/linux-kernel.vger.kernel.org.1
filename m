Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D432D1EC2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 01:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgLHADb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 19:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgLHADa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:03:30 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B29CC06138C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 16:02:36 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id s85so8632585vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 16:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upb/CqjljGMq0mDhDOTo+ddS28Jk9ogwKt4euX8NQs4=;
        b=FL1MkXJu3M0BAsQbDDwOhOO07lK8vxkNwD3gVvvAFsHzWvAVD4uVocaZxFmag3g/mB
         7wb405alpjK9lwL5NGrDPVV8pPeW0G/kivR+vySa+9Yh+v7vqyALp0zMV8t8RdWciWxT
         Wgy9Q4cy1HuJdqY5aJDn0xcqqodUnwgQ+cBYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upb/CqjljGMq0mDhDOTo+ddS28Jk9ogwKt4euX8NQs4=;
        b=lXhFUF7jzqTY1MA275LTLih5VrKO+zP29yKtsMIb6nBNOoW++KTU1s8mx2qCwj+hV0
         hIIuBvMKGJuNnTQ++JqWiEG0HvRO/vWMESYY8TuwdMbbtfHpTnasmN8D2wyjf1vWmi1/
         i4dhV3PhRQwKhWgrEUeOxQu3qmIpLDcbrEtOLZCP64Ci69M0Hbp7Ld3xgYZGVpgpY4xq
         rB9txnLiGE3hZJF95VohzmgqU4Ha2zszpm3qaIfm8NJMKx3Tm4bM5L5cU6tg8XS8ENL8
         Ow4o+pB3HmRIDsVaJy3p4LPPbGnu51e+bkZ1pdQDZZ0/f0iAi5QUDaVb1kiWIYB3ek5F
         fUzw==
X-Gm-Message-State: AOAM531MqWVjOA0koHi12NOtanw7HgagoKvl6fFQHETPgXpqFZCwMOWc
        U0jzI8v7ac4Np0OlGTz5zpJNasc9lCDt4g==
X-Google-Smtp-Source: ABdhPJzCa1ybOjDYs4CqoQ5J51S1uY6RJ8dd6lk2rAWtXw2/u0MVCNgctk45YAxCddbEuAiZAc5bAg==
X-Received: by 2002:a67:cb0e:: with SMTP id b14mr14771794vsl.60.1607385755254;
        Mon, 07 Dec 2020 16:02:35 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id w15sm1539822uam.6.2020.12.07.16.02.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 16:02:34 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id p2so365966uac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 16:02:34 -0800 (PST)
X-Received: by 2002:ab0:35fa:: with SMTP id w26mr13479881uau.90.1607385753680;
 Mon, 07 Dec 2020 16:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20201207231824.v3.1.Ia6b95087ca566f77423f3802a78b946f7b593ff5@changeid>
In-Reply-To: <20201207231824.v3.1.Ia6b95087ca566f77423f3802a78b946f7b593ff5@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Dec 2020 16:02:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UyCboywA0xG68ZhJB6MZ2ncx478WntD_1iGg=q+G8AmA@mail.gmail.com>
Message-ID: <CAD=FV=UyCboywA0xG68ZhJB6MZ2ncx478WntD_1iGg=q+G8AmA@mail.gmail.com>
Subject: Re: [PATCH v3] ath10k: add option for chip-id based BDF selection
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 7, 2020 at 3:23 PM Abhishek Kumar <kuabhs@chromium.org> wrote:
>
> In some devices difference in chip-id should be enough to pick
> the right BDF. Add another support for chip-id based BDF selection.
> With this new option, ath10k supports 2 fallback options.
>
> The board name with chip-id as option looks as follows
> board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=320'
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2-00696-QCAHLSWMTPL-1
> Tested-on: QCA6174 HW3.2 WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> ---
>
> Changes in v3:
> - Resurreted Patch V1 because as per discussion we do need two
> fallback board names and refactored ath10k_core_create_board_name.
>
>  drivers/net/wireless/ath/ath10k/core.c | 41 +++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 11 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
