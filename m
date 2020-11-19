Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296E92B99FE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgKSRto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbgKSRtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:49:43 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1059C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:49:43 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id l14so6007110ybq.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOr6koQF+IBLIVc9r3QuKU141fh3NjeHnysl+nNQ1mY=;
        b=ZdNkW2Ed0WCu+MUenjPzGWiCfRrssAbsJEhfH/B1GsUNDozZ7I7BNQwSSXKGiZf2wr
         PgFtyPDEAQnJpmztTEReCK8hab3fa9qJxBWKYb9ijJ+UDQWvAVYjY0YYCwJwCDcKkr4f
         1IvEqbXg23tng7tyq/8ELY0xA8H3PwsjAx215RHzTkiMJyIatPmD3gnm0VRcBCM+SKPn
         eQLQ4N/iI3MPabzYOKeqJWgKLNVTTwQHy/P6RhZLFG1wBieupzW8WLd7M+/qRNtfhUri
         C9xH607KUhIj3u+t4OU3/se96SoP9s0Gr2ZTWFHYOcx7ahkiGXWjLkLMROZQVnjptq6r
         4AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOr6koQF+IBLIVc9r3QuKU141fh3NjeHnysl+nNQ1mY=;
        b=Kcqnm78l5Xx9oCuC7xWsG7Bq9sVeNHWPrMwpQ0CzIv6kAkLCbokAiRW+APamiX4RBl
         0XiZZwk7fwXx4FywzhkZ2en7RQtyFunW2kDLzW5xoyZJmC1eEasG4PHL8LTwLItXq3yZ
         3hZPTlWzm03qJe1D8O8WyA/DQI7nsYkxcQiI1p4qolWKA/AOdt8AFxYxoBu6XksB38F+
         dKlmZCNpU3ipdKS9zSKLZEI89KdZwawx/mBwEbB1wJj6AUeX+/TjPKhMddjk2ZiYemmn
         AvqgVuLg7eFlCH2q4HHXcN8YG6bFo5kD9lQ1fIKIuA9jmlutBn3Uy/pzKkfJ1hrQLzcE
         SQSw==
X-Gm-Message-State: AOAM531QP3czeBnwgAEXn2Uw8hTN4RZ0RWZybg2uSkxzytv73nAPdIZC
        nulnc72U9sttbHqf3oRbxS0QCd1s32MNWxPesBWlJ4VbzwCRR143
X-Google-Smtp-Source: ABdhPJw2i3gwQRDyzO6sOhaflWBk70JDyjkMq6XWSXLGIdeAMir9vPqqb/V0cCaciPoIK4W5YNfbLEEx9xSJG5MXLp0=
X-Received: by 2002:a25:8401:: with SMTP id u1mr24460099ybk.96.1605808182804;
 Thu, 19 Nov 2020 09:49:42 -0800 (PST)
MIME-Version: 1.0
References: <20201119110036.19959-1-aisheng.dong@nxp.com> <20201119110036.19959-3-aisheng.dong@nxp.com>
In-Reply-To: <20201119110036.19959-3-aisheng.dong@nxp.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 19 Nov 2020 09:49:06 -0800
Message-ID: <CAGETcx_vHdZ0TwSj+Qbgoe1nEwKkQO=TJd7XKZ+nO0iLjMEUJw@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: property: fix document of of_get_next_parent_dev
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Dong Aisheng <dongas86@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 3:18 AM Dong Aisheng <aisheng.dong@nxp.com> wrote:
>
> Fix document of of_get_next_parent_dev.
>
> Cc: devicetree@vger.kernel.org
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 21a854e85234..5bd4a9bead47 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1038,7 +1038,7 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
>  }
>
>  /**
> - * of_get_next_parent_dev - Add device link to supplier from supplier phandle
> + * of_get_next_parent_dev - Get the closest ancestor device of a device node
>   * @np: device tree node
>   *
>   * Given a device tree node (@np), this function finds its closest ancestor

All of this is going away[1].
So, Nack.

-Saravana
[1] - https://lore.kernel.org/lkml/20201104232356.4038506-1-saravanak@google.com/
