Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31192AB83B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgKIM3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgKIM3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:29:22 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234AAC0613CF;
        Mon,  9 Nov 2020 04:29:22 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id l5so2058928edq.11;
        Mon, 09 Nov 2020 04:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sBZbWUxDMUiyYBK2i/wIs4N3TmP5EGJ2g+czRfeZnk=;
        b=ofPKahEWQLUVFy3gaLTARErx1qoLWGpYHgmHkdYjKFW9AWN1owI6TB/47LXMjJu5rU
         KPwh68O7AO6W10zVyVeEiQFBmGfwYshFWcutA7BrnUCc3gRA3M/4AixBckejiisgYNX5
         EJ/1SdMKpWYrAW7qkOXRQjS8TNLO5gWVTtyw/QR0WlFYT0Epvv6Xt8pDtpbHlFbLhmPt
         7E8mi8wD+zkFKYAYisCnzU4/4eC1bNExSfJfe03Cf31vdTZ/axneUTX5BEwvksh5pff7
         chl5mHc1EIxh4br4UfgpQT3YOf5ERpm6zuByrarBhQAAi68xSVb+HKiPrU2G1DAdAtLP
         HUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sBZbWUxDMUiyYBK2i/wIs4N3TmP5EGJ2g+czRfeZnk=;
        b=Fm8nPM756Ug4yq9L27sT1qkNHVLSE4b7OB6f6t1kL6qqOdeAAD8DiS5v/YeOcMWrzO
         aocI8an72Kj0ffjEmJShBOC7n8rufPchBsHOdVE+0J/vNzKGgUYBd3jCb0dUuthJEJqv
         vP5+r60dfAu7aTNdKuJ+wOFj7MOmj0FMYhKTBuedOZdH0r5mG4aYv2dOGKjvdwXT0ROK
         VXP1aX6s5ZaLIeDtI604r6Gm9d3XlalSQAzLj68ckrTwzRAilGw2wMpfjdL/dZrOOBjM
         uLWdeJSfmaS/OPtBZ3KIuF3TXU2nT0jf/6i8p1Bp3FzkwGs0gg7KKL3r6RJXuc/JoozW
         oe4Q==
X-Gm-Message-State: AOAM533If9FwAGq/00+5LkLAr43B3onXHl0xLf+Sn/wqyVucAkne3Epo
        LDI9CDvO5SfqM/0ygzOvZZ59KYrsfp7Zy2gbwTCQYhfM3aE=
X-Google-Smtp-Source: ABdhPJz6wR5v06ibCl/alCt9TPdal/lf7KGCBn8/vH8+TFiYJjAQB8GrbCBcygZgFjdx2NLtQ0YR+jqFx7gJSbwLHdA=
X-Received: by 2002:a50:f604:: with SMTP id c4mr2366256edn.117.1604924960003;
 Mon, 09 Nov 2020 04:29:20 -0800 (PST)
MIME-Version: 1.0
References: <20200715115412.2544-1-frank@allwinnertech.com>
 <20200717160727.e6y5htg4sjd7bezi@gilmour.lan> <db1908ae-817c-f30d-7b88-f4afa593b258@sholland.org>
 <20200729130637.5md3tr6zg7s4wrmh@gilmour.lan> <CAEExFWstKV_uMbh5iQ9ULX7=24aj0_6Ge+4uFe07WmwiyDDRMA@mail.gmail.com>
In-Reply-To: <CAEExFWstKV_uMbh5iQ9ULX7=24aj0_6Ge+4uFe07WmwiyDDRMA@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 9 Nov 2020 20:29:08 +0800
Message-ID: <CAEExFWv1_mCYtgQui-L3kki6X3vtrYXQFswYmCE9CZbd2ta9pg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_1=2F3=5D_dt=2Dbindings=3A_gpio=3A_sunxi=EF=BC=9Acreate_a_?=
        =?UTF-8?Q?DT_header_for_Allwinner_pin_controller?=
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Samuel Holland <samuel@sholland.org>,
        Frank Lee <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Maxime,

Maybe let's convert to use something like SUN4I_PA?

Yangtao
