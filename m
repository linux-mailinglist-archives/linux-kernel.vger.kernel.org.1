Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EB12EC486
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 21:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbhAFULZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbhAFULY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:11:24 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20118C06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 12:10:44 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b26so9350021lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 12:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fTYl7dFnUNDY76/N/FBKgt5PJcqYVGl1YeIAp29Cb4=;
        b=Qbc+93ieH0Q8qihFPzMggAa8SmXbcWkUTomxAJiIG6B/pDM/RLyfRbEoarG3AzELxh
         ac30doK/+KYIllKtltVEdgGmnZKW+ZjWJxWDXlbsBugbUU+UuX0QC0rY29Z+787Ph3CT
         U2kc1mjPOoxCMRFPNVPNkm5RwMWfF/QpOMoLuBo2IiKQFv8qyOqizq+T7yCZ1urOntmR
         ri1Az6AjLSp3G98+YHSP07VY0oSRQyOJvzCOLyHehs4ef5aALgU1KwDLwVNHdP6u0yVy
         4UzmdtSmfQD/5+7pA36yDyzmXqYw3DhndSkgqu3YcYcWmAJRv+tanx03kFiRManEoxja
         YH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fTYl7dFnUNDY76/N/FBKgt5PJcqYVGl1YeIAp29Cb4=;
        b=UxXOZdIk2qNSXWsC1+qWk9WEoIivmBu1EahOAP3T3KsbFw2XhW1UDRUK76jHDj4Dr7
         z8b+0PRbRd2ZkeXXaBHXlY10VvCszoSUxrVNrNMI3mgvoLdU5Bo5vFh9Shf/j98gC23p
         oS50CMPoknSZTMfN1HmyWqqJM2dPCKlqOT4WNvrCjk8xaJeQNti1F+gDl8BvOfGUyVWJ
         KqPH0ILgvY8Y0CCrLhiN8+K7cXKnPj7y+6OMATRxTX9PGrOzuskeA72UdihOtW4OiZJi
         tjvneu98ew25jKDaC9fwSM+E14+PjCcWQ0wDpqPTo4F6118WbyB/q8tcg7M52qBT1xmG
         7+tw==
X-Gm-Message-State: AOAM530UFNOSr21PkbUGawZFVddyOC4fJsUm/6YQhDBr7+EBoUvh2inW
        2fNfVmxsGye7qvWnH7uPZdTjdFaoqxputFYXgAYL0w==
X-Google-Smtp-Source: ABdhPJyMV/qRlwhsED4wqR63/+mBwb2d/XZZAMB8W7cpRjr16ansOu5Csx6k8LuW95AIPpjuzVysr5H9Fl1Aln+7iaU=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr2776550ljo.368.1609963842431;
 Wed, 06 Jan 2021 12:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20210103100007.32867-1-samuel@sholland.org> <20210103100007.32867-3-samuel@sholland.org>
In-Reply-To: <20210103100007.32867-3-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Jan 2021 21:10:31 +0100
Message-ID: <CACRpkdagu9Sj9AEcGQYrnAAxUJWZKGZ2zina4XWubQ7WXYU-0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pinctrl: sunxi: h6-r: Add s_rsb pin functions
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andre Przywara <andre.przywara@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 11:00 AM Samuel Holland <samuel@sholland.org> wrote:

> As there is an RSB controller in the H6 SoC, there should be some pin
> configuration for it. While no such configuration is documented, the
> "s_i2c" pins are suspiciously on the "alternate" function 3, with no
> primary function 2 given. This suggests the primary function for these
> pins is actually RSB, and that is indeed the case.
>
> Add the "s_rsb" pin functions so the RSB controller can be used.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

This patch applied to the pinctrl tree.

Yours,
Linus Walleij
