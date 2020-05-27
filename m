Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1579C1E4ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 22:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgE0UHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 16:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0UHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:07:32 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344A0C05BD1E;
        Wed, 27 May 2020 13:07:32 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g9so21329200edw.10;
        Wed, 27 May 2020 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9Y1R6h6DQE2/rRX48OYyaXQnQUWwp5Xf+j2aGf7gqg=;
        b=s7vxinaEYjtzfrgWsA897RFKnul98c2LtsGm2X5fTEzJJ8s8ox+RVpNgDiCR0uwNJL
         UUQn1hd9ILlYH2C/rLNPOqG4c9LpnAlvLP1ueUJSdlpedy/UMsmCsNwnJgm3fl7J2nlJ
         wb8jTmxugLUPoz31SYsMS9VJgREP81GDO+UH3kzWWAXvYVy5S/SwmINCQ7RpYLcav8Hm
         OLGzMGKNdjbCLR0PiaMJ9HlKqUh3jB1b0segRmfiXzdOQeGYrnSl1oId90IGe/lRygXG
         p2Rls31nIr100yTQ6MmVM3gmCAjetS9ZUVA0z3pmnNkMOusbF3WtFrqk1M/p7vWbi2/4
         mMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9Y1R6h6DQE2/rRX48OYyaXQnQUWwp5Xf+j2aGf7gqg=;
        b=HSnkqkWef84klg83FURmx/dIAjrmAVPfrtFD/FIISCDFj2N6Izb3plX5tfcyB6BqlF
         Qodo1kPXcdgXvQaXf54RMq8EuU9wdGQqwKG0cAl6BgbUp82I+CdZaKfH8Yvx1zAgRPuM
         dDQv5eB6UYRdqrRNd6P8oXc6gN1pOA+T25cEjR4yADbV9oj8Rw0daNx5+IZBSevm6w/X
         gzfU7a10HYzqKcH/HpWGfas9m8/yEccT5GpPANtbI/HhxzsRFQF6qeSKbDlhSQIqwOQs
         hXQ0JU2Ev4GEJkWk6gzvrEg5w/xTOgO54uvL1KZxUNiSs2y4F1Z0bmsapMY5hPSrhawQ
         xsow==
X-Gm-Message-State: AOAM53085J2KHPnkzrT06rrimIqz83Iq3/YL9EA9x976R00PSY+7Znqt
        o6WJzNXhBCB4Ym50+0oGhZbVNy/eyItXS50am6c=
X-Google-Smtp-Source: ABdhPJyqwKfqj/ZsK6VxnjlHRRAbKxb2lAkRclrEAbzJjpz55OWtedJWwYD1IMRCvlPlhHeTBS0ql+qxc5LESffBOh0=
X-Received: by 2002:a50:c014:: with SMTP id r20mr24517567edb.110.1590610050817;
 Wed, 27 May 2020 13:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200519170440.294601-1-jbrunet@baylibre.com>
In-Reply-To: <20200519170440.294601-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 27 May 2020 22:07:20 +0200
Message-ID: <CAFBinCBXTwKz81bQK3U1bv7vGiryhShijqh2hqaypPvLopvwNA@mail.gmail.com>
Subject: Re: [PATCH] clk: add api to get clk consummer from clk_hw
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, May 19, 2020 at 7:09 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
[...]
> + * Calls to this function must be balanced with calls clk_put()
> + */
> +struct clk *clk_hw_get_clk(struct clk_hw *hw)
I haven't looked at it myself yet, but would it be hard to have a
devm_ variant of this function as well?
a non-devm managed function would add boilerplate to the meson-mx-sdhc-mmc code

also this may or may not simplify how to fetch the struct device
pointer for this use-case.
(that said, I only know about drivers for Amlogic related IP and there
the devm_ variant can be used, but I don't know about other potential
consumers of this new API)


Thank you!
Martin
