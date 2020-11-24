Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA82C1FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbgKXI2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbgKXI2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:28:41 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56044C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:28:41 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u18so27637002lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76ixO5CUxxnke5hcHoMKuBGHklO16fYsnp2OoEmVY9I=;
        b=G8leHYlsEU5n6pd6cInmCXAoFm6XND5O4pdrrsippB2b/hSgqZUq13wmCTOGN2pDLy
         0ZvAYGUIfc4uyHL34B8QqHnISCrh8M70dupuPPWYAtGfvXMBw/1cf6zpWHCFw6O+OK2G
         krv1FyneNA3Y0jR2u/1rVEJcAu/ld4TMQwCgD7hJskxey0PEeUh6uR+2oiI3uEeYU4sL
         ZmkzsW9ZR7D/e1RjV2b4sXysHEpEFI0pkKwruTz9hbSKYN5nJbbKaxOj97sjf7PMBB4+
         +jQlRVnus2nmkTYuiJdr9WAEMqesS9FihYhzQrkemhiK3zU/mSBggEyBs6/1uAwu9NeR
         CaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76ixO5CUxxnke5hcHoMKuBGHklO16fYsnp2OoEmVY9I=;
        b=ukXzldfBLyFzj8ZjXj/9tS7loQD9iTy3azmMWLrMLb78FkJz5mDhxJ4cy9xSOerRNj
         giW7YsyppCJQBMh4xkZ1pfZvnVOgJTG7KcOG3Dlo3aBLFPqDbxT+HAvF4TpvHqhTUVF0
         P4Ea3lO8WBMnZHAbGvBQ+r9pDG176F+Uy6XFiZ3CrexNV0inIyVSYJyiI2/3QpK7a113
         8UAGX09OIFQHIo+tq4NFRud/VdI1GF/XJerzU+9SYOAXhKDHFoZ95O54P8MjrEthU1WT
         aCpXc49HYfyQp9E/itIFpX6sya3L7G9KpxnrHMikGufztVg7RfSPIz9MV9gRAqsZmg+T
         asug==
X-Gm-Message-State: AOAM532dJm6C2BMmb12KlLOkLqjoxMTw0EchbUSUH60575BfOUV6I7ZE
        GxN6ISZEo/4eqDeZE4BCHe0FammA+PYaXJPecf4mMg==
X-Google-Smtp-Source: ABdhPJz3m9CR00BmIKNF6LAsWT4dz49Cwq7LJkOtP9XV8CKRYiYZYBE3k32TMZ0OuYePMZmd6DcgVibwKqVVmoHDgEQ=
X-Received: by 2002:a19:7b06:: with SMTP id w6mr1409605lfc.260.1606206519702;
 Tue, 24 Nov 2020 00:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20201123160139.1.I2702919afc253e2a451bebc3b701b462b2d22344@changeid>
In-Reply-To: <20201123160139.1.I2702919afc253e2a451bebc3b701b462b2d22344@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Nov 2020 09:28:28 +0100
Message-ID: <CACRpkdamdXCqZa4=qb5MsJtQMw1v53z5HZVv5SHJv84dtVACqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] irqchip: qcom-pdc: Fix phantom irq when changing
 between rising/falling
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Maulik Shah <mkshah@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 1:02 AM Douglas Anderson <dianders@chromium.org> wrote:

> We have a problem if we use gpio-keys and configure wakeups such that
> we only want one edge to wake us up.  AKA:
>   wakeup-event-action = <EV_ACT_DEASSERTED>;
>   wakeup-source;

I would need Marc's ACK to apply this with the other patches
to the pinctrl tree, but I can't really see if maybe it is OK to
apply it separately?

Also are these patches supposed to all go in as fixes or
for v5.11?

Yours,
Linus Walleij
