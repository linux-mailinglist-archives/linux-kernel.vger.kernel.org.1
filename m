Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5C12B2CFD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 13:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgKNMBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 07:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgKNMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 07:01:17 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA37FC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 04:01:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j5so5792954plk.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 04:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TqmKr/trGB+oWPC9G4LVX5CXgWARSex3JgS0BjL0RV0=;
        b=ASB9K176+BQfgSgMVtnql5QTjOi2izoHzp6JUHtl3a1/0ra0Yprew0MEuLNYAkGSTn
         3WJ8YQn7XG+D6QBUjUUJjqrhCb6Tgem5I3RmjBHWbbU9yUuCSIE5zGTjlODSpvOmp1x5
         t5cNPNoGvXQE3+S50jU5zo2HAq0MZLEFt+wf+PXzkXSl9nWg7p+ycwfouDaiirpIgzBm
         8cn4JoUV52gIRNkInnIBoRclxCiknR8N48C6doGLhUNTVZDAH14rj24picyUOKKq4yae
         RhDf/08lO7qu/gTlGIrCg8983NmeeIbQ9Aagsle+jvlH0L/8jq4V5XtBtui+9UB6SCY4
         4SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=TqmKr/trGB+oWPC9G4LVX5CXgWARSex3JgS0BjL0RV0=;
        b=ucbUGSQFs5mVKpMJwNpk+DfkbXp2hPZBJiRVwImgjDHlntVsBfWiKFJSQe1js8RpNV
         ezLjXWtaBad839m2ANSPumBR8/fmGovtxUImkdjMUcJkX4s8XyZ4Ph09/3Ge6ZRw/tK6
         RjuB5fz3PJyV7qwLxInGQv8Q12Rgt3aK3RuKRCgDOzqsO0MbZugOoDCp5uLcnLyLgWnc
         bwNe7TpVdHcpXtQMv39t457wV2F14FXVmSCNL/Or3o3o8rEAKM6MjWRRxIvCKJyu57v5
         URwcfhti68Hpjy3iPZSRFk1J1iAowUbSxhQGeyfUvUF7YHRA0SxaR/k7sU6CYPJQkmpo
         9lDA==
X-Gm-Message-State: AOAM532MslpbJT7+0dobwd7nwTLFOnuX7ECD7QpkcIg1KkhmTtFLVtUR
        LHoYb6xsY2YyV7X5spTEWmCQ1NTja8CxhTOYy+0=
X-Google-Smtp-Source: ABdhPJxR3OrqFNSxLrm15ALAtZC9Y0CbZ0D3txo+NKt0p6nXgscDG77fyZak8kfBOuR/WFXkwijdEfPdDZcqI96NeEM=
X-Received: by 2002:a17:902:bb81:b029:d5:b437:edb4 with SMTP id
 m1-20020a170902bb81b02900d5b437edb4mr5528774pls.6.1605355275040; Sat, 14 Nov
 2020 04:01:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:6c7:0:0:0:0 with HTTP; Sat, 14 Nov 2020 04:01:14
 -0800 (PST)
Reply-To: cristinacampeell@outlook.com
From:   "Mrs. Cristina Campbell" <look6532@gmail.com>
Date:   Sat, 14 Nov 2020 04:01:14 -0800
Message-ID: <CAJ3bDB750tu0=HPFJOnqhuZbFGoORoZdMqUzXHod3RFOPu1j=w@mail.gmail.com>
Subject: =?UTF-8?B?2YfZhCDZitmF2YPZhtmDINmF2LPYp9i52K/YqtmK?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2LnYstmK2LLZiiDYp9mE2K3YqNmK2Kgg2IwNCg0K2YrYsdis2Ykg2YLYsdin2KHYqSDZh9iw2Kcg
2KjYqNi32KEg2YjYqNi52YbYp9mK2Kkg2Iwg2YHZgtivINmK2YPZiNmGINij2K3YryDYo9mH2YUg
2LHYs9in2KbZhCDYp9mE2KjYsdmK2K8g2KfZhNil2YTZg9iq2LHZiNmG2YoNCtin2YTYqtmKINiq
2KrZhNmC2KfZh9inINi52YTZiSDYp9mE2KXYt9mE2KfZgiDYjCDYo9mG2Kcg2KfZhNiz2YrYr9ip
INmD2LHZitiz2KrZitmG2Kcg2YPYp9mF2KjZhCDYjCDZg9mG2Kog2YXYqtiy2YjYrNipINmF2YYN
Ctin2YTYsdin2K3ZhCDYpdiv2YjYp9ix2K8g2YPYp9mF2KjZhCDYjCDZiNmD2KfZhiDZiti52YXZ
hCDZgdmKINi02LHZg9ipINi02YQg2YTYqti32YjZitixINin2YTYqNiq2LHZiNmEINio2YTZhtiv
2YYg2YjZg9in2YYNCtij2YrYttmL2Kcg2YXZgtin2YjZhCDZhdiq2YXYsdizINmB2Yog2YXZhti3
2YLYqSDYtNix2YIg2KLYs9mK2Kcg2Iwg2KrZiNmB2Yog2YrZiNmFINin2YTYp9ir2YbZitmGIDMx
INmK2YjZhNmK2YggMjAwMw0K2YHZiiDYqNin2LHZitizLiDYqtiy2YjYrNmG2Kcg2YTZhdiv2Kkg
2LPYqNi5INiz2YbZiNin2Kog2KjYr9mI2YYg2LfZgdmELg0KDQrYqNmK2YbZhdinINiq2YLYsdij
INmH2LDYpyDYjCDZhNinINij2LHZitiv2YMg2KPZhiDYqti02LnYsSDYqNin2YTYo9iz2YEg2YXZ
hiDYo9is2YTZiiDYjCDZhNij2YbZhtmKINij2LnYqtmC2K8g2KPZhg0K2KfZhNis2YXZiti5INiz
2YrZhdmI2KrZiNmGINmK2YjZhdmL2Kcg2YXYpy4g2YTZgtivINiq2YUg2KrYtNiu2YrYtdmKINio
2LPYsdi32KfZhiDYp9mE2YXYsdmK2KEg2YjYo9iu2KjYsdmG2Yog2LfYqNmK2KjZig0K2KPZhtmG
2Yog2YTZhiDYo9iz2KrZhdixINi32YjZitmE2KfZiyDYqNiz2KjYqCDZhdi02KfZg9mE2Yog2KfZ
hNi12K3ZitipINin2YTZhdi52YLYr9ipLg0KDQrYo9ix2YrYryDZhdmGINin2YTZhNmHINij2YYg
2YrYsdit2YXZhtmKINmI2YrZgtio2YQg2LHZiNit2Yog2Iwg2YTYsNmE2YMg2YLYsdix2Kog2KPZ
hiDYo9mC2K/ZhSDYp9mE2LXYr9mC2KfYqiDZhNmE2YXZhti42YXYp9iqDQrYp9mE2K7Zitix2YrY
qSAvINin2YTZhdiz2KfYrNivIC8g2KfZhNmD2YbYp9im2LMgLyDYp9mE2KPYt9mB2KfZhCDYqNmE
2Kcg2KPZhSAvINin2YTZhdi52KfYqNivIC8g2KfZhNij2LHYp9mF2YQg2KfZhNij2YLZhA0K2KfZ
hdiq2YrYp9iy2YvYpyDZhNij2YbZhtmKINij2LHZitivINij2YYg2YrZg9mI2YYg2YfYsNinINmF
2YYg2KLYrtixINin2YTYo9i52YXYp9mEINin2YTYtdin2YTYrdipLiDYp9mB2LnZhNmH2Kcg2LnZ
hNmJDQrYp9mE2KPYsdi2INmC2KjZhCDYo9mGINij2YXZiNiqLiDZhNmC2K8g2YLZhdiqINit2KrZ
iSDYp9mE2KLZhiDYqNiq2YjYstmK2Lkg2KfZhNij2YXZiNin2YQg2LnZhNmJINio2LnYtiDYp9mE
2YXZhti42YXYp9iqDQrYp9mE2K7Zitix2YrYqSDZgdmKINij2YHYutin2YbYs9iq2KfZhiDZiNin
2YTYudix2KfZgiDZiNin2YTZitmF2YYg2YjYrNiy2LEg2KfZhNmC2YXYsS4g2KfZhNii2YYg2YjZ
gtivINiq2K/Zh9mI2LHYqiDYtdit2KrZig0K2KjYtNmD2YQg2LPZitihINmE2YTYutin2YrYqSDY
jCDZhNinINmK2YXZg9mG2YbZiiDYp9mE2YLZitin2YUg2KjYsNmE2YMg2KjZhtmB2LPZiiDYqNi5
2K8g2KfZhNii2YYuDQoNCti32YTYqNiqINiw2KfYqiDZhdix2Kkg2YXZhiDYo9mB2LHYp9ivINi5
2KfYptmE2KrZiiDYpdi62YTYp9mCINij2K3YryDYrdiz2KfYqNin2KrZiiDZiNiq2YjYstmK2Lkg
2KfZhNij2YXZiNin2YQg2KfZhNiq2YoNCtij2YXZhNmD2YfYpyDZh9mG2KfZgyDYudmE2Ykg2YXZ
hti42YXYqSDYrtmK2LHZitipINmB2Yog2KfZhNmD2YjZitiqINmI2YLYt9ixINmI2YXYtdixINmI
2KjYp9mD2LPYqtin2YYg2YjYs9mI2LHZitinINiMDQrZhNmD2YbZh9mFINix2YHYttmI2Kcg2YjY
p9it2KrZgdi42YjYpyDYqNin2YTZhdin2YQg2YTYo9mG2YHYs9mH2YUg2Iwg2YjYqNin2YTYqtin
2YTZiiDZgdij2YbYpyDZhNinINij2KvZgiDZhNmH2YUg2KjYudivDQrYp9mE2KLZhiDYjCDYrdmK
2Ksg2YrYqNiv2Ygg2KPZhtmH2YUg2YTYpyDZitmG2KfYsti52YjZhiDZhdinINiq2LHZg9iq2Ycg
2YTZh9mFLiDYotiu2LEg2KPZhdmI2KfZhNmKINin2YTYqtmKINmE2KcNCtmK2LnYsdmB2YfYpyDY
o9it2K8g2YfZiCDYp9mE2KXZitiv2KfYuSDYp9mE2YbZgtiv2Yog2KfZhNi22K7ZhSDYp9mE2KjY
p9mE2Log2LPYqtipINmF2YTYp9mK2YrZhiDYr9mI2YTYp9ixINij2YXYsdmK2YPZig0KNtiMMDAw
2IwwMDAuMDAg2YTYr9mK2ZEg2YTYr9mJINij2K3YryDYp9mE2KjZhtmI2YMg2YHZiiDYqtin2YrZ
hNin2YbYryDYrdmK2Ksg2KPZiNiv2LnYqiDYp9mE2LXZhtiv2YjZgi4g2KPYsdi62Kgg2YHZig0K
2KfYs9iq2K7Yr9in2YUg2YfYsNinINin2YTYtdmG2K/ZiNmCINmE2YTYqNix2KfZhdisINin2YTY
rtmK2LHZitipINmI2K/YudmFINin2YTYpdmG2LPYp9mG2YrYqSDZgdmKINio2YTYr9mDINmB2YLY
tyDYpdiw2Kcg2YPZhtiqDQrZhdiu2YTYtdmL2KcuDQoNCtmE2YLYryDYp9iq2K7YsNiqINmH2LDY
pyDYp9mE2YLYsdin2LEg2YTYo9mG2Ycg2YTZitizINmE2K/ZiiDYo9mKINi32YHZhCDZitix2Ksg
2YfYsNinINin2YTZhdin2YQg2Iwg2YjZhNinINij2K7Yp9mBINmF2YYNCtin2YTZhdmI2Kog2Iwg
2YTYsNmE2YMg2KPYudix2YEg2KXZhNmJINij2YrZhiDYo9mG2Kcg2LDYp9mH2Kgg2Iwg2YjYo9i5
2YTZhSDYo9mG2YbZiiDYs9ij2YPZiNmGINmB2Yog2K3YttmGINin2YTYsdioLg0K2KjZhdis2LHY
ryDYo9mGINij2KrZhNmC2Ykg2LHYr9mDINiMINiz2KPYudi32YrZgyDYrNmH2Kkg2KfZhNin2KrY
tdin2YQg2KjYp9mE2KjZhtmDINmI2KPYtdiv2LEg2YTZgyDYrti32KfYqCDYqtmB2YjZiti2DQrY
s9mK2YXZg9mG2YMg2KjYtdmB2KrZgyDYp9mE2YXYs9iq2YHZitivINin2YTYo9i12YTZiiDZhdmG
INmH2LDYpyDYp9mE2LXZhtiv2YjZgiDZhNio2K/YoSDZh9iw2Kcg2KfZhNio2LHZhtin2YXYrCDY
p9mE2K7Zitix2YoNCti52YTZiSDYp9mE2YHZiNixINmB2Yog2KjZhNiv2YMuDQoNCtij2LHZitiv
2YMg2KPZhiDYqti12YTZiiDYr9in2KbZhdmL2Kcg2YXZhiDYo9is2YTZiiDYjCDYo9mKINiq2KPY
rtmK2LEg2YHZiiDYsdiv2YMg2LPZitmF2YbYrdmG2Yog2YXYs9in2K3YqSDZgdmKINin2YTYqNit
2KsNCti52YYg2LTYrti1INii2K7YsSDZhNmG2YHYsyDYp9mE2LrYsdi2LiDYpdiw2Kcg2YTZhSDY
qtmD2YYg2YXZh9iq2YXZi9inINiMINmB2YrYsdis2Ykg2KfZhNi52YHZiCDYudmGINiq2YjYp9i1
2YTZgyDZhdi52YbYpy4NCtmK2YXZg9mG2YMg2KfZhNiq2YjYp9i12YQg2YXYudmKINij2Ygg2KfZ
hNix2K8g2LnZhNmJINio2LHZitiv2Yog2KfZhNil2YTZg9iq2LHZiNmG2Yog2KfZhNiu2KfYtToN
CihjcmlzdGluYWNhbXBlZWxsQG91dGxvb2suY29tKS4NCg0K2LTZg9ix2IwNCtiq2YHYttmE2YjY
pyDYqNmC2KjZiNmEINmB2KfYptmCINin2YTYp9it2KrYsdin2YXYjA0K2KfZhNiz2YrYr9ipINmD
2LHZitiz2KrZitmG2Kcg2YPYp9mF2KjZhA0K2KfZhNio2LHZitivINin2YTYpdmE2YPYqtix2YjZ
htmK2JsgY3Jpc3RpbmFjYW1wZWVsbEBvdXRsb29rLmNvbQ0K
