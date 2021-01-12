Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CECB2F260D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 03:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbhALCHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 21:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbhALCHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 21:07:34 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11DFC061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 18:06:53 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p12so645148pju.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 18:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=GIDoXKYlEAG3wJcmSh2QD6Dl+3tRhU7sh26TJCJiovU=;
        b=fZSrlQE5Czl6y24R37175v/ad/BWklRKIjVXH4w+C35U0KKt/WnmwSfBI7jJNBu0qJ
         Td2sXj1BPeuugnPFaiSe/XgbV7FRoo9U//Ji0TpjGBr4Ahv6DAyVOC3MAZ9y8UiRNZyu
         0w3HdvwlSIdphY5qKtZLMg0INCL11FTk3OffU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=GIDoXKYlEAG3wJcmSh2QD6Dl+3tRhU7sh26TJCJiovU=;
        b=uS/4viYnoEVODfcEm5br6l1m46WhRNDhZeZml7aUCr7tNOz03kV+ATvS4JXCULlGNh
         +FI7cjdl+iSwXux+qWzr1E6tN48mCq3NicUjspBstBy1o7Qciz3rOXr+edgTviGbib/s
         CeFGMIc4c9PSKyLguim/9pUy7tqd1CY/QQ1bcmCUTM2Ig20FYfcURE8pmJI3jcnOO0F7
         dD4uihU8KW2Ha8Hd4aEWKQ/VBBvD6SjWc2C+o8DCGKMXKAKCDwl8Q6EZOxhHe4UzjRud
         5cQPMygsu0VAxq/BhMMMUSqOs91IVfwyiSxEWsS9E+d6zyhT7xSH0GOjwBGSR396rc28
         A6+A==
X-Gm-Message-State: AOAM5321NOTW7936nz0PBaXslUHHF1KjYZLAOmPJNbpe5tV9Xz+KJuPk
        gU1+RPs8+/kX17z9NgI5ldHDMw==
X-Google-Smtp-Source: ABdhPJz8G0WHssT6pGTKBVu6ir2bZ5ULf2huQlGToUEv6IpvhCTE0xdj9eGku0Qjg8e4A4ploQPW6A==
X-Received: by 2002:a17:902:9a86:b029:dc:104:1902 with SMTP id w6-20020a1709029a86b02900dc01041902mr2346259plp.50.1610417213356;
        Mon, 11 Jan 2021 18:06:53 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 7sm954053pfh.142.2021.01.11.18.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 18:06:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210108172316.v4.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
References: <20210108172316.v4.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
Subject: Re: [PATCH v4 1/2] dt-bindings: input: Create macros for cros-ec keymap
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dianders@chromium.org, Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>,
        dmitry.torokhov@gmail.com
Date:   Mon, 11 Jan 2021 18:06:50 -0800
Message-ID: <161041721050.3661239.13956511794723234229@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-01-08 17:23:31)
> In Chrome OS, the keyboard matrix can be split to two groups:
>=20
> The keymap for the top row keys can be customized based on OEM
> preference, while the keymap for the other keys is generic/fixed
> across boards.
>=20
> This patch creates marcos for the keymaps of these two groups, making
> it easier to reuse the generic portion of keymap when we override the
> keymap in the board-specific dts for custom top row design.
>=20
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
