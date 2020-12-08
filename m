Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABFA2D345A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgLHUhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:37:35 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45321 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgLHUfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:35:40 -0500
Received: by mail-yb1-f195.google.com with SMTP id k78so8401439ybf.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKT1xt1SMzgu41xYl1MW3Jng/80RbPWksOKFLv9tJCk=;
        b=MWgn465K5rtATb1PfG2SxloG0m4QVpJGVn4pSNU3oB6bvKQLTTrBzn+Ezpgkhbq9T+
         kLGWWWR6DzaMi5841XjObOcXqSRNxYEuI7lIl6gh1wWD6KVTKIQsgqvQuXcdzKSPDZPa
         bwR4rG48okWAr+eUxLOXmYl7eLf0RkBp3WJ85t4nCAfDe9KmMwaHuaULOS6M+gcpQbH5
         HVx1XjIcfh66Mp0kWz5nGlB8qlqkCHr/+r1rPN8Rw5cv3iFPHiOPd+vQs3FEKbt/kB1Q
         SQ+16eA56pIWF4oEd175WDw7+WrvNguJNq5d/1YXy38dXxmjCsn31Niag6cEHpjHpRyF
         jw/Q==
X-Gm-Message-State: AOAM533+zxzHdu34oE6g4rzR4QlpPYs5U3pP+bqdcIqboHLGeZ0HPf8E
        r0cgQ5YeIg/2paTQNGPHpgG1NVh7qaCElEv/9Iq/UB+/
X-Google-Smtp-Source: ABdhPJxmoCXQmrabfSNNrBVKAsAl7RBFcTJxhg9kRju58cMl8ohotUGeMmtj8fg+FiCAyv6LqJXkOS3cTaQrV4YFnOo=
X-Received: by 2002:a9d:3982:: with SMTP id y2mr17818754otb.260.1607455215857;
 Tue, 08 Dec 2020 11:20:15 -0800 (PST)
MIME-Version: 1.0
References: <20201208190326.27531-1-tiwai@suse.de>
In-Reply-To: <20201208190326.27531-1-tiwai@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Dec 2020 20:20:04 +0100
Message-ID: <CAJZ5v0ggQL-poyY8tz14GhZCQLshfsQB58m3Z2iafsiUttkgRw@mail.gmail.com>
Subject: Re: [PATCH] driver: core: Fix list corruption after device_del()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 8:03 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> The device_links_purge() function (called from device_del()) tries to
> remove the links.needs_suppliers list entry, but it's using
> list_del(), hence it doesn't initialize after the removal.  This is OK
> for normal cases where device_del() is called via device_destroy().
> However, it's not guaranteed that the device object will be really
> deleted soon after device_del().  In a minor case like HD-audio codec
> reconfiguration that re-initializes the device after device_del(), it
> may lead to a crash by the corrupted list entry.
>
> As a simple fix, replace list_del() with list_del_init() in order to
> make the list intact after the device_del() call.
>
> Fixes: e2ae9bcc4aaa ("driver core: Add support for linking devices during device addition")
> Cc: <stable@vger.kernel.org>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209207
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d661ada1518f..e8cb66093f21 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1386,7 +1386,7 @@ static void device_links_purge(struct device *dev)
>                 return;
>
>         mutex_lock(&wfs_lock);
> -       list_del(&dev->links.needs_suppliers);
> +       list_del_init(&dev->links.needs_suppliers);
>         mutex_unlock(&wfs_lock);
>
>         /*
> --
> 2.26.2
>
