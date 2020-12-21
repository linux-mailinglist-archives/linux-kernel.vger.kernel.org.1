Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE1A2DFA72
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 10:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgLUJtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 04:49:32 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38223 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgLUJtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 04:49:20 -0500
Received: by mail-oi1-f174.google.com with SMTP id x13so10734516oic.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 01:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MAEcdhR8xhJxkTH5py9dhvbH9xpgK7YSOJAH3krQv0=;
        b=dwUuukA9Vuso8nZj5cPex0D3esu/LkjpQe3saBTKGgGIpO0qFdbbaSeOxVn1oQuYAF
         vwr56vTnoFnt6SpmgQ9yUOfLwBD+TyjXE3NOD3Afxj89CroHFZCbnV5JP/IMKHq8o6un
         9PLU8HGkOU7hoJ6Ak9OE64QKslrcBrYdeEU2zWtHKXmNVySnqlK7QE0vBi6qVa2+zAER
         m/0JhqxgZB24eXgTBEkQYS9bVCGvydbVJgcDkAVaH8a1Th/g0QGzg6vx4eDMvj1DkgGP
         6LfvXiWnHB69YAlfOEBq3ZSJ1eQvNK1XrC2vGf3EQLdgeDjuHzSbGhFvY6RG4u4FUCxE
         7AoA==
X-Gm-Message-State: AOAM533vEDShHYBci+oh7qTpYmaoZycnJgWXUuMoaQ4MfMNP4WV8lfp9
        VQr9x4Tq6FBqdgfUAHKkoeeUUS+b8bCWPHvGbYs=
X-Google-Smtp-Source: ABdhPJwtNKP2A0sku9Zm77WUohTKFlOtIVVI0H1klrPAdAsp3aLVUYmqK5ZIbNaXK0BAFYy4/iH6ESKscx2Cqx5k93c=
X-Received: by 2002:aca:4892:: with SMTP id v140mr10402620oia.71.1608544120040;
 Mon, 21 Dec 2020 01:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
In-Reply-To: <20201218031703.3053753-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Dec 2020 10:48:23 +0100
Message-ID: <CAJZ5v0iGZwhHQ67v_q+fTDj_dU3tzjZRAo4K0k5wKzdhmZ7YtQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 4:17 AM Saravana Kannan <saravanak@google.com> wrote:
>
> As discussed in LPC 2020, cyclic dependencies in firmware that couldn't
> be broken using logic was one of the last remaining reasons
> fw_devlink=on couldn't be set by default.
>
> This series changes fw_devlink so that when a cyclic dependency is found
> in firmware, the links between those devices fallback to permissive mode
> behavior. This way, the rest of the system still benefits from
> fw_devlink, but the ambiguous cases fallback to permissive mode.
>
> Setting fw_devlink=on by default brings a bunch of benefits (currently,
> only for systems with device tree firmware):
> * Significantly cuts down deferred probes.
> * Device probe is effectively attempted in graph order.
> * Makes it much easier to load drivers as modules without having to
>   worry about functional dependencies between modules (depmod is still
>   needed for symbol dependencies).
>
> Greg/Rafael,
>
> Can we get this pulled into 5.11-rc1 or -rc2 soon please?

Honestly, I'd rather not (but it's up to Greg).

This is a new series posted during the merge window, so it should not
be looked at even according to the rules.

Personally, I don't have the time to look at it now.

> I expect to see some issues due to device drivers that aren't following best
> practices (they don't expose the device to driver core). Want to
> identify those early on and try to have them fixed before 5.11 release.
> See [1] for an example of such a case.

So it should be posted right after -rc1 and spend a whole cycle in linux-next.

> If we do end up have to revert anything, it'll just be Patch 5/5 (a one
> liner).

Which totally doesn't matter IMV.
