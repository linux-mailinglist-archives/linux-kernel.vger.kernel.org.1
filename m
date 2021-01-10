Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60B02F05CC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 08:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAJHI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 02:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbhAJHI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 02:08:56 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D402C061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 23:08:15 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id d9so14413913iob.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 23:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5iAUopsMfrbRifHXOmhMOv9LXElpS70L7sWSW1Ex5k0=;
        b=ndrLTN9p65L1wfAK/3noFMon1rk29cu6i9FcAy+MjBqbxSxG+1+RDyTJ1jaf1/YKG1
         GaU2ivlbEChqBs6eN1CWFcI24/ebavm0b4CtOExNMG8mjW+DwabptlZxKNihAs8N2hyv
         05Nn2iOB51t/zbOJONjLemjgVvstp/yY6mHIxVO2HyJDABlbfqcVBnnEdQQ5VliTG+0u
         hFh9puvRgradywLqTHD46ajoXmfbYY452lGJCkLI9Tz3Ms62H+zOTnbRXXPnhBQdnqkR
         kycHfR60mBnljD8tjG6KK7DFaSJBKETmmiffxOuqTGRSp4xSY37HkT89UQHrxY07UotO
         uBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=5iAUopsMfrbRifHXOmhMOv9LXElpS70L7sWSW1Ex5k0=;
        b=neuWa29kT5omz0IOiQ3q7LnRDXl4dnlrlpbykzyoWJLPZZgbDt1LeEFDgNhEBT6PiA
         lQPevxUMWslMGi7vZiV1ccwNMKZWycOtm4imEJeFw5TLjGP0UTochKLQjg/xhvih7X8C
         HuejGQmHuoGPefKfhm1Rzr3I+jfs19PjtSNB9ZH8xAzOjyw+nNpIbwhpefGAwxsdA1+E
         /6xJfXhsFNZzh+d//4JRuep6rS2LsMV08H8HWOLlQdbkrWvmy+y6AHzO72A0kzJazLG/
         TUWl1pUM6SkEhkrIyT4e2IFUdALaqBRRRzZiUWAYw3+sdjrrZTkIjboEz5cXOLJa/q8g
         lQAg==
X-Gm-Message-State: AOAM5303IIx3laiB8JvrTpn6dIW3meeD9Pfr0RoTFHN+ErQTVOqaiIOt
        tR1PG5+shwe2WQV7gE3wxQq6etv0VO86dA9qhE4=
X-Google-Smtp-Source: ABdhPJy1Zbmip1HVF8/HWQFIljfF6XbpZxo7OolTgXHw7HNcXszm7epfGUe9zq4qXxw/vclmHToqSWlzikj760p+hYs=
X-Received: by 2002:a02:3907:: with SMTP id l7mr10270879jaa.0.1610262494280;
 Sat, 09 Jan 2021 23:08:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6638:d5:0:0:0:0 with HTTP; Sat, 9 Jan 2021 23:08:13
 -0800 (PST)
Reply-To: cristinacampeell@outlook.com
From:   "Mrs. Cristina Campbell" <smith76544@gmail.com>
Date:   Sat, 9 Jan 2021 23:08:13 -0800
Message-ID: <CAAYzYtOuED1nYJyKXztZ8RmnbT5vVpQtR6PYOHH7PcWGc0TKFA@mail.gmail.com>
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
hNi12K3ZitipINin2YTZhdi52YLYr9ipLg0KDQrYo9ix2YrYryDYo9mGINmK2LHYrdmF2YbZiiDY
p9mE2YTZhyDZiNmK2YLYqNmEINix2YjYrdmKINiMINmE2LDZhNmDINmC2LHYsdiqINij2YYg2KPY
udi32Yog2KfZhNi12K/Zgtin2Kog2YTZhNmF2YbYuNmF2KfYqg0K2KfZhNiu2YrYsdmK2KkgLyDY
p9mE2YXYs9in2KzYryAvINin2YTZhdi52KfYqNivINin2YTYqNmI2LDZitipIC8g2KfZhNmD2YbY
p9im2LMgLyDYp9mE2KPYt9mB2KfZhCDYqNmE2Kcg2KPZhSAvINij2YLZhA0K2KfZhdiq2YrYp9iy
2YvYpyDYjCDYo9ix2KfZhdmEINmE2KPZhtmG2Yog2KPYsdmK2K8g2KPZhiDZitmD2YjZhiDZh9iw
2Kcg2YXZhiDYotiu2LEg2KfZhNij2LnZhdin2YQg2KfZhNi12KfZhNit2Kkg2KPZgdi52YQNCti5
2YTZiSDYp9mE2KPYsdi2INmC2KjZhCDYo9mGINij2YXZiNiqLiDZhNmC2K8g2YLZhdiqINit2KrZ
iSDYp9mE2KLZhiDYqNiq2YjYstmK2Lkg2KfZhNij2YXZiNin2YQg2LnZhNmJINio2LnYtg0K2KfZ
hNmF2YbYuNmF2KfYqiDYp9mE2K7Zitix2YrYqSDZgdmKINmB2YTYs9i32YrZhiDZiNmD2YXYqNmI
2K/ZitinINmI2LPZiNmK2LPYsdinINmI2KfZhNi52LHYp9mCLiDYp9mE2KLZhiDZiNmC2K8g2KrY
r9mH2YjYsdiqDQrYtdit2KrZiiDYqNi02YPZhCDYs9mK2KEg2YTZhNi62KfZitipINiMINmE2Kcg
2YrZhdmD2YbZhtmKINin2YTZgtmK2KfZhSDYqNiw2YTZgyDYqNmG2YHYs9mKINio2LnYryDYp9mE
2KLZhi4NCg0K2LfZhNio2Kog2LDYp9iqINmF2LHYqSDZhdmGINij2YHYsdin2K8g2LnYp9im2YTY
qtmKINil2LrZhNin2YIg2KPYrdivINit2LPYp9io2KfYqtmKINmI2KrZiNiy2YrYuSDYp9mE2KPZ
hdmI2KfZhCDYp9mE2KrZig0K2KPZhdmE2YPZh9inINmH2YbYp9mDINi52YTZiSDZhdmG2LjZhdip
INiu2YrYsdmK2Kkg2YHZiiDYp9mE2KPYsdiv2YYg2YjYp9mE2YPZiNmK2Kog2YjZgti32LEg2YjY
p9mE2KXZhdin2LHYp9iqINin2YTYudix2KjZitipDQrYp9mE2YXYqtit2K/YqSDZiNin2YTZh9mG
2K8g2Iwg2YTZg9mG2YfZhSDYsdmB2LbZiNinINmI2KfYrdiq2YHYuNmI2Kcg2KjYp9mE2YXYp9mE
INmE2KPZhtmB2LPZh9mFLiDZhNinINiq2KvZgiDYqNmH2YUg2KjYudivDQrYp9mE2KLZhiDYjCDY
rdmK2Ksg2YrYqNiv2Ygg2KPZhtmH2YUg2YTYpyDZitmG2KfYsti52YjZhiDZhdinINiq2LHZg9iq
2Ycg2YTZh9mFLiDYotiu2LEg2KPZhdmI2KfZhNmKINin2YTYqtmKINmE2KcNCtmK2LnYsdmB2YfY
pyDYo9it2K8g2YfZiCDYp9mE2KXZitiv2KfYuSDYp9mE2YbZgtiv2Yog2KfZhNi22K7ZhSDYp9mE
2KjYp9mE2Log2LPYqtipINmF2YTYp9mK2YrZhiDYr9mI2YTYp9ixINij2YXYsdmK2YPZig0KNtiM
MDAw2IwwMDAuMDAg2YTYr9mK2ZEg2YTYr9mJINio2YbZgyDZgdmKINiq2KfZitmE2KfZhtivINit
2YrYqyDYo9mI2K/YudiqINin2YTYtdmG2K/ZiNmCLiDYo9ix2LrYqCDZgdmKDQrYp9iz2KrYrtiv
2KfZhSDZh9iw2Kcg2KfZhNi12YbYr9mI2YIg2YTZhNio2LHYp9mF2Kwg2KfZhNiu2YrYsdmK2Kkg
2YjYr9i52YUg2KfZhNil2YbYs9in2YbZitipINmB2Yog2KjZhNiv2YMg2YHZgti3INil2LDYpyDZ
g9mG2KoNCtmF2K7ZhNi12YvYpy4NCg0K2YTZgtivINin2KrYrtiw2Kog2YfYsNinINin2YTZgtix
2KfYsSDZhNij2YbZhyDZhNmK2LMg2YTYr9mKINij2Yog2LfZgdmEINmK2LHYqyDZh9iw2Kcg2KfZ
hNmF2KfZhCDYjCDZiNmE2Kcg2KPYrtin2YEg2YXZhg0K2KfZhNmF2YjYqiDYjCDZiNmF2YYg2KvZ
hSDYo9i52LHZgSDYpdmE2Ykg2KPZitmGINiz2KPYsNmH2Kgg2Iwg2YjYo9i52YTZhSDYo9mG2YbZ
iiDYs9ij2YPZiNmGINmB2Yog2K3YttmGINin2YTYsdioLg0K2KjZhdis2LHYryDYo9mGINij2KrZ
hNmC2Ykg2LHYr9mDINiMINiz2KPYudi32YrZgyDYp9mE2KfYqti12KfZhCDYqNin2YTYqNmG2YMg
2YjYo9i12K/YsSDZhNmDINiu2LfYp9ioINiq2YHZiNmK2LYg2YXZhiDYtNij2YbZhw0K2KrZhdmD
2YrZhtmDINio2LXZgdiq2YMg2KfZhNmF2LPYqtmB2YrYryDYp9mE2KPYtdmE2Yog2YXZhiDZh9iw
2Kcg2KfZhNi12YbYr9mI2YIg2YTYqNiv2KEg2YfYsNinINin2YTYqNix2YbYp9mF2Kwg2KfZhNiu
2YrYsdmKDQrYudmE2Ykg2KfZhNmB2YjYsSDZgdmKINio2YTYr9mDLg0KDQrYo9ix2YrYr9mDINij
2YYg2KrYtdmE2Yog2K/Yp9im2YXZi9inINmF2YYg2KPYrNmE2Yog2Iwg2KPZiiDYqtij2K7Zitix
INmB2Yog2LHYr9mDINiz2YrZhdmG2K3ZhtmKINmF2LPYp9it2Kkg2YHZiiDYp9mE2KjYrdirDQrY
udmGINi02K7YtSDYotiu2LEg2YTZhtmB2LMg2KfZhNi62LHYti4g2KXYsNinINmE2YUg2KrZg9mG
INmF2YfYqtmF2YvYpyDYjCDZgdmK2LHYrNmJINin2YTYudmB2Ygg2LnZhiDYqtmI2KfYtdmE2YMg
2YXYudmG2KcuDQrZitmF2YPZhtmDINin2YTYqtmI2KfYtdmEINmF2LnZiiDYo9mIINin2YTYsdiv
INi52YTZiSDYqNix2YrYr9mKINin2YTYpdmE2YPYqtix2YjZhtmKINin2YTYrtin2LU6DQooY3Jp
c3RpbmFjYW1wZWVsbEBvdXRsb29rLmNvbSkuDQoNCti02YPYsdiMDQrYqtmB2LbZhNmI2Kcg2KjZ
gtio2YjZhCDZgdin2KbZgiDYp9mE2KfYrdiq2LHYp9mF2IwNCtin2YTYs9mK2K/YqSDZg9ix2YrY
s9iq2YrZhtinINmD2KfZhdio2YQNCtin2YTYqNix2YrYryDYp9mE2KXZhNmD2KrYsdmI2YbZitib
IGNyaXN0aW5hY2FtcGVlbGxAb3V0bG9vay5jb20NCg==
