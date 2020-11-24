Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FC02C24F4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbgKXLtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:49:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbgKXLtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:49:40 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E18CD20857
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606218580;
        bh=PUBX3pg96iPTmC+3ajxfCSWd3GB4JF9umJhidh4JYJQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nQfU56ROXDVHIurupdILBePZen1/uVeHEm/0DLxWG2v7+s7F+4eTCATK2V5DhvJZc
         HJNPaOBdZj33efQR7+itzU9K7JxjCZ5MBID2FP6iUJE53q4DuT56zOZrlgXruQOtb/
         ISxeAF36yLCE3PrqLuWeZftLHrHsK4WwkZL5vcgU=
Received: by mail-ot1-f53.google.com with SMTP id n11so19046294ota.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 03:49:39 -0800 (PST)
X-Gm-Message-State: AOAM5337o1wVkOp2RWvVuWtz64RY/1ZtcDj41/1/BtE7nmw1woFN2Qfh
        5ezsn3hGSE4syXRge//7XrfxK+Nv1G9RdFc1Ms8=
X-Google-Smtp-Source: ABdhPJy9c3s/Jeb9nfLEN+BPcVb1IbuR24GoD2eAR6YCiec9vq6xxo/J70frTg0AHuEAYwvM+JTd6bTj8JpwCLoCBXM=
X-Received: by 2002:a05:6830:22d2:: with SMTP id q18mr2674436otc.305.1606218579150;
 Tue, 24 Nov 2020 03:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20201124103242.2971199-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20201124103242.2971199-1-u.kleine-koenig@pengutronix.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 24 Nov 2020 12:49:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0xDQhbzZoZ6qvpQg6zRU20-ZtJRkPq5Gjw0+2LGs71tw@mail.gmail.com>
Message-ID: <CAK8P3a0xDQhbzZoZ6qvpQg6zRU20-ZtJRkPq5Gjw0+2LGs71tw@mail.gmail.com>
Subject: Re: [PATCH 1/4] amba: reorder functions
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:32 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Put helpers (here: amba_get_enable_pclk and amba_put_disable_pclk) at
> the top of the file and then define callbacks directly before the
> structs they are used in; in the same order.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Looks good, I checked the whole series and this seems like a useful
cleanup. All four patches:

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
