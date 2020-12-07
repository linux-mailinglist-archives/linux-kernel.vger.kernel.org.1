Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD862D1CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgLGWJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGWJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:09:16 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA53C061794;
        Mon,  7 Dec 2020 14:08:35 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id r127so14288406yba.10;
        Mon, 07 Dec 2020 14:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ore45+R2dgdcoUemqYY1WWu++vm7sZbg3Yx7TiVEZtc=;
        b=SoFolo5ySwToGT3PzECzqIw+MwFmcutA+haZ5AIvzkbKh0QlYGa/bqiUFV8gbF5RAn
         Q2ZzSVe5kAb/ueiFIdaoY7TDKgRzu8vsRePekyCdw15ODbj9urXrIVzdt2RSEzoJgLac
         C/NpwEJPSaCf1WcTlpVcv2dM2sob1M28pdSdgFhiMVZPW7P5TBpWxSa6Xa5uDmSTdq2i
         L/3IW7f+Qf2HJUUAvzF6UCubyLjQjFX3KFDBj5LKJSEc3KkHULCu3B05YorIZRi9IzYy
         y7sl5E7+aVKnNwtEAalK1HrZShjgkY5RDmfoI6Lxy9QMKMGJfFpD1Hya1dOiRKU4rCfp
         W4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ore45+R2dgdcoUemqYY1WWu++vm7sZbg3Yx7TiVEZtc=;
        b=RJb8Gtm7/hIYfvCpKe9ik8IDiSHfEiQgXwH7Y0UGy5oE5emrXs8qSJwqODn4O+vHIG
         5d8TcBFSfD2ASHYEbAJmp6QxGkcBnwVLmaivdFhFvIhRyGqivYRN+FDetH+B06LwJk8W
         WzTluVotFVFi2I8jcjqefrRR1o58h1XkU2s13SGxQ4fS4gyY0LseC5FtZNTJrLJZeWxx
         Xe6H+6deFIRiMHzho4hnCVV/gaSfsHI3oFl2FkGWQc/jr8dcKjJWWldCBLpWgwl6l8Xc
         S0+25h3GlOJWhUbPkPu5UxQVC5jX9N85csekeqTaDR0cwPClUJcWCh/dnVQ3I+cL3CZU
         7poA==
X-Gm-Message-State: AOAM533DpewxwraiDlPdDno0NBGSZzKFpHuUZWh5E6FPZF8LbQoCMDaX
        +IMBWnZf7f6nN8IrTsZ+17fLnVttGuxPAV+QP/Q=
X-Google-Smtp-Source: ABdhPJxhuuMlbdq1DIxm7H+lh3LgQqT8+7Ip3cdq3l9JYFe6DXYU2+et+VjGWllPCO0nVUxqwd3mdI8mEI/U8cycgKo=
X-Received: by 2002:a5b:4d2:: with SMTP id u18mr14575636ybp.71.1607378915344;
 Mon, 07 Dec 2020 14:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20201202204649.25314-1-zajec5@gmail.com>
In-Reply-To: <20201202204649.25314-1-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Mon, 7 Dec 2020 23:08:24 +0100
Message-ID: <CACna6rxAz+WXUSqu9dm2uuQg+Pz_irH-HghHh_4e-pndeRkk9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add binding for BCM4908 USB PHYs
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Simon Arlott <simon@octiron.net>,
        =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 at 21:48, Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wro=
te:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> BCM4908 SoCs have USB 2.0 PHY and USB 3.0 PHY attached to the MDIO bus.
> Those bindings allow describing them.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Please drop this patchset for now as Florian pointed that the existing
driver may be adapted / reused for those PHYs.
