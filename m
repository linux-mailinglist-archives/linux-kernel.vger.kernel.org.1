Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6052E2D3EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgLIJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgLIJ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:29:52 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0823C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 01:28:37 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id m12so2155393lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 01:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPBiqiG0+OPNjKKwNHWnGemZ1swbMpEOyi2mDu7HemI=;
        b=us9RvDd6QQubaexTYMj32UCvXmezTaru7m/gt8qIEVQnCUShV040sO5qvAWwELFzv6
         2CsjSx1G23bt27kfSrgY00FjXeAl+c0EVSzZtmY90iVC2c/QYfjknMq0RhYpQ392MJUe
         p1eQsiIqPB565pSwPjtPQbYD/L/FayJtSZ2lQYv5gpMwqMIwq8ZNE6eA74h6NMcR8EXG
         Qh8hd4KJkLh2N1xUDqBwGgI6nfXQmaBoUsjeVGeBac5cuIRXxUEi7BLZQYz8LDYJ/drP
         BaeyUtU9KvDLVcqzxFFcNZcaQMmmnO23l8SuWB3ixRpLcg7qRI+WQ9zuVDtaWIVyCsJ4
         ZsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPBiqiG0+OPNjKKwNHWnGemZ1swbMpEOyi2mDu7HemI=;
        b=DvyGhkqVje6+/A+CMLu9u6Rqm8pQ0tc2UPqfIA08KGXwFgb492qI8mop43TbPniw50
         xbB5CuowXBTJ1J5613SM4QudDTpEPsvQtpHeg9HW/znkfm2GZKkxrx7H/9HnKW9bMN3N
         cquE4Kz90haCB3HFWgoyC0GK4yVM9lKtMCRipZpHYrOQFLwI7GaYDJUA5J3isStsD/Kh
         A/1A5zkupMAQ6TK3ZRJ8R2eDpRbhB4gT4mUip1eBaerr8CiX2jp3qgduHt4KbHa5R6SU
         O+ZtqoMe84eR1TDdmDpYHB3TBqJeUnkItfUm6DlaEaa/zVWoR2qlWTapQdXpMlssygQH
         AMKA==
X-Gm-Message-State: AOAM531DPhyZFbPDfHcImdgcXAgFvJJq8yJx5+S/4jjsZEh/SCPg1Q7n
        l2vZG7KXm+JyVXWW8obj4AJkbuHGxn+GP+y6WgFUzu+EElcfgQ==
X-Google-Smtp-Source: ABdhPJwhwlHBlbTQF1U3MZGgVD7bKekQd7ucodES1SBhT33AOLWm0peJOvE9+cvnFgO2Ro4ID5f1bVil/4Qtp/Egw+U=
X-Received: by 2002:a19:7d84:: with SMTP id y126mr711294lfc.586.1607506116141;
 Wed, 09 Dec 2020 01:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20201204164739.781812-1-maz@kernel.org> <20201204164739.781812-3-maz@kernel.org>
In-Reply-To: <20201204164739.781812-3-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Dec 2020 10:28:25 +0100
Message-ID: <CACRpkdbJUa9G_OtwM9YnNB84wUfT7hLpw8c=RQxdjaUvRST4dg@mail.gmail.com>
Subject: Re: [PATCH 2/4] USB: serial: ftdi_sio: Report the valid GPIO lines to gpiolib
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 5:47 PM Marc Zyngier <maz@kernel.org> wrote:

> Since it is pretty common for only some of the CBUS lines to be
> valid as GPIO lines, let's report such validity to the rest of
> the kernel.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
