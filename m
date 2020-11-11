Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F368B2AF937
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgKKTmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgKKTmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:42:15 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124CBC0613D4;
        Wed, 11 Nov 2020 11:42:15 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id ay21so3591415edb.2;
        Wed, 11 Nov 2020 11:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcqgsA1C03N+sBAIpewIwQ5iiWf5Tl1aifp7Xa5kwsU=;
        b=hxxN1bsVIxKHJ2u+OGXh4vbrnNxJtt03MwyFm3BYAAY+F8QzijYemQF0oYHQjHHp57
         l7OyLE/flv2yXl8Q+5Nxs63NVYrl+pfl/o/J7qP8/ChFENuCl79FnQe6EL8rBb7TgAvC
         YhYGzxeZsqT4vTASOaiX7Jk+C6jKE0rs731aj41UbiXSUYsitZiPWR3V79ddeMlupYVD
         C+jONWN/Y+OLtKwwKUq9bwhLr4oqQducG6fdodCglTQAEW8rEhwDgnzxP+nIGVRER5dE
         c87D1e3UbG/7ZwVeH0irqZvbi8i5Ug1enHf6zE1J05nvfuFzgXVp/Q1vYPPqBrf9HKKy
         AF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcqgsA1C03N+sBAIpewIwQ5iiWf5Tl1aifp7Xa5kwsU=;
        b=hwXlNbhrvn3NE164Pqx2eaMhYDPCCMent7qEqutP94yP/tR6hQoTu8PhqVAyogz4tf
         13Qyhp0BPmP2k/quYKJvR5EV9N0btDFBsDCIg0JG809LtRhbB8FdJOnauSoRQdfPoblH
         Qz5C0soT4L/8EuDccnOSAT+1Z1HPkW3LdeLz+U/fWBCYzWav/iDkvP5lq5novVzv3HEA
         /CNpDVgtbhkmKOwX9L7EyCur4lK/bMkyHeRJagGm9g+/OWt/kNaY3mAZZwYQAWhgrnTV
         OSGd34+0zHDwVHEPhujhKH94PYZJ3Vpn457nziyItCOTHzEWwWGxabDZ3Cm8qyNzPZR2
         2URA==
X-Gm-Message-State: AOAM533YGg5zPf+WROgR/IkXcAtzcZYnXeaO3Gy445o5TC03qRuEzSK/
        3p5EaS6yKBZHDNWwVPmc4Pw+QawPGR3YrTwHUQQ=
X-Google-Smtp-Source: ABdhPJwGxN7mIplXBb44OlVVKoTUN4OC9QCZpvNJmOTEXLHPRh4R7PNPAI5YZU21uteEXmjaSHXn4o2dFfeqxiEvHt0=
X-Received: by 2002:a05:6402:2059:: with SMTP id bc25mr1241699edb.13.1605123733810;
 Wed, 11 Nov 2020 11:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20201111095256.10477-1-zhengzengkai@huawei.com>
In-Reply-To: <20201111095256.10477-1-zhengzengkai@huawei.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 11 Nov 2020 20:42:02 +0100
Message-ID: <CAFBinCANr3zC4VxeGFTXhz1ZmTiOJ44r7DX8EmPwOjezyFAmhQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: meson-g12a: disable clk on error handling path
 in probe
To:     Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, khilman@baylibre.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 10:48 AM Zheng Zengkai <zhengzengkai@huawei.com> wrote:
>
> dwc3_meson_g12a_probe() does not invoke clk_bulk_disable_unprepare()
> on one error handling path. This patch fixes that.
>
> Fixes: 347052e3bf1b ("usb: dwc3: meson-g12a: fix USB2 PHY initialization on G12A and A1 SoCs")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

many thanks for this fix!


Best regards
Martin
