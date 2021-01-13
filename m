Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86C2F5820
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbhANCOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbhAMV3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:29:00 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A0CC0617A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 13:28:04 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id z11so4185737qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 13:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fo3y+efetGU21S8u5xUthjy+UehxaJWMKhJu6/vk5zs=;
        b=cDtjUkBwGz9iTE+JyvdjwgTp48CQsaom7+Tk4M0HTOE9vvmBRtWGl8OfrBrLRjVAJ3
         KYGL0D2RuTl+rLXN1fK6gzEShYg5orEprNxfzrlutC+yPjdXCpyT7mmh6tsBbqMBnu/k
         NPgCee5zjbiJOHp1tNT0gpsP+kgOYG2R/LYIdLBcxWifbV32xs/V1vG1LKQHeOm8Buo1
         YLuOYSNpz10kWatkG6nnT/f6wscD6YLgE2BGh957140VEwu0Jznlciu0RNN8UAnYg6Ut
         xn0DMAfBrGTeqtTw5knf1+I4V2fh7HRLME1xWsnXoz76Rv4ngUrhXWE0AYCFxN4M60Ok
         4Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fo3y+efetGU21S8u5xUthjy+UehxaJWMKhJu6/vk5zs=;
        b=fiorhtikhtEUmuJ5qawwbydkn+0Ghm4cS02Mm3VsRUxfITi+y53yg/VGMmM3te4Rni
         vMIvyvDjrHfEsE00PYKj71kuaWdyJXfmD13xTcwPY+9p7sjpiWdinR84O+qYyhXKpMT1
         hajKdje+DxFhOc/zSplmPJ3pWni+XU2yFQjZysah1eqmjIsnLZL9lAG1MiEO8dm3QEO9
         frevFcAeX47hu6VpeBPlIib05+LyOR09ledrUChj5Un76tCLqGyIgXvl1wujwO8meDlV
         zENXT2/Pv74LxP+XOVcX6iOBXyKe721/FU2bg4PZHGpMbCedSpg04DzkHHOzZeSMjRH6
         ssvA==
X-Gm-Message-State: AOAM530weu+xpXA6RWy7DtPEi4B2IGAXM+qrKjx91Jo26+BqwW1E+gQg
        DTTFY4bJ1Vv2uwm8ZUcLc58wapgsuzyTtmptMXWgpA==
X-Google-Smtp-Source: ABdhPJzHNCq+SoIy3s/OpIZXd9EdydPSdX51AAwxQCr0Q6HKFXWd3nzIkO0QCcaCYY4XwDyrekXRkCZ8nfnqbh1KKhU=
X-Received: by 2002:a25:8b8b:: with SMTP id j11mr3400929ybl.310.1610573283724;
 Wed, 13 Jan 2021 13:28:03 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <712cb4237f1dbb8d1104736e20713ba457444650.camel@suse.de> <44201af052a70efd42f7ff5a2125316c@kernel.org>
In-Reply-To: <44201af052a70efd42f7ff5a2125316c@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 13 Jan 2021 13:27:27 -0800
Message-ID: <CAGETcx_2vOrMy-kdbHkK0UiybYda83bVSznNTuAECmKXHhKOSw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
To:     Marc Zyngier <maz@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 3:48 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2021-01-13 11:44, Nicolas Saenz Julienne wrote:
> > On Thu, 2020-12-17 at 19:16 -0800, Saravana Kannan wrote:
> >> As discussed in LPC 2020, cyclic dependencies in firmware that
> >> couldn't
> >> be broken using logic was one of the last remaining reasons
> >> fw_devlink=on couldn't be set by default.
> >>
> >> This series changes fw_devlink so that when a cyclic dependency is
> >> found
> >> in firmware, the links between those devices fallback to permissive
> >> mode
> >> behavior. This way, the rest of the system still benefits from
> >> fw_devlink, but the ambiguous cases fallback to permissive mode.
> >>
> >> Setting fw_devlink=on by default brings a bunch of benefits
> >> (currently,
> >> only for systems with device tree firmware):
> >> * Significantly cuts down deferred probes.
> >> * Device probe is effectively attempted in graph order.
> >> * Makes it much easier to load drivers as modules without having to
> >>   worry about functional dependencies between modules (depmod is still
> >>   needed for symbol dependencies).
> >
> > FWIW I don't see any issues with this on Raspberry Pi 4 :).
>
> Keep bragging! ;-)
>

Yay! Thanks for confirming Nicolas.

-Saravana
