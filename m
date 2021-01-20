Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5302FDBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbhATVZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 16:25:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbhATUy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:54:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4BF5235F9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611176020;
        bh=i2d5Zc9HUAVyYlrskonowpJniHVwj2kCBz32yTZACtM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SYsag/CpQhxB5sg0C32OG88lVxZeOyzbAIT1oXugQuwa0XsK5H8E8T3U+/DDQ0d8A
         P6bjIaI7LcScpB64T9gx3rwwapnk5ko9fC1cPN4qjlqfjUlD6NW6jtI8BTJ0OCwt1H
         s+lKMjMnCIut5ClALdmhsRRMvqxZn818Y9yTNviMrihBH3anT+L7YVkWZ3at4WUzSA
         I+imxJ6W7IGGJhph2QYO57WRic/fzvdzKR0XIV+2/2zaXLJElHOWQWJGHeDLHu6UHh
         j2DZ0o8zDsI/UsV0RIVS6QlMRjQAdT2tJlN59rmLLskxsiNpWGRNFCyXSxKfhb8yHW
         0j1Vg4Fygsq2g==
Received: by mail-oo1-f54.google.com with SMTP id x203so6106013ooa.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:53:40 -0800 (PST)
X-Gm-Message-State: AOAM532Pa0iyO7PmMqXYgpIf4WctZ53fZJt/Ra3Xc3NhR3Js/J7EXjpE
        zESdEThpKMHwvZ0iQr2K8huiPkvJJjZj/TDJ+Xc=
X-Google-Smtp-Source: ABdhPJyKlJpGC1IH5urvh6Ztvg3w36z7l3VC5L82KSiRllAABL9k1hPOPoT7H1hJSlMUGfFyJnvKU/JcOcM748O9RPM=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr7283583ooj.15.1611176019971;
 Wed, 20 Jan 2021 12:53:39 -0800 (PST)
MIME-Version: 1.0
References: <20210120131559.1971359-1-arnd@kernel.org> <20210120131559.1971359-5-arnd@kernel.org>
 <2399eb7ae01ff8b9134ac170e709e39b58bda441.camel@perches.com>
In-Reply-To: <2399eb7ae01ff8b9134ac170e709e39b58bda441.camel@perches.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 20 Jan 2021 21:53:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0syaRTroAZB4PnNBCECreDuYwzfAo9AXwrs8rmUoQukw@mail.gmail.com>
Message-ID: <CAK8P3a0syaRTroAZB4PnNBCECreDuYwzfAo9AXwrs8rmUoQukw@mail.gmail.com>
Subject: Re: [PATCH 4/4] timer: remove sirf prima driver
To:     Joe Perches <joe@perches.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 6:50 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2021-01-20 at 14:15 +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The CSR SiRF prima2/atlas platforms are getting removed, so this driver
> > is no longer needed.
>
> Should this platform really be removed?
>
> While I followed the removal thread just a little,
> isn't prima still in use in various GPS handhelds?

I'm not aware of anyone running mainline Linux on those, as I said
in the platform removal patch[1] description, there have not been any
contributions to third-party machine support, the only boards that
ever booted a mainline kernel were the evaluation boards.

If you have any information on hobbyist users of this platform, let
me know.

       Arnd

[1] https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-3-arnd@kernel.org/T/#u
