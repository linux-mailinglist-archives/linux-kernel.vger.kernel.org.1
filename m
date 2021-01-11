Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866442F0D83
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbhAKHuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbhAKHue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:50:34 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE8BC061794
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 23:49:53 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id dk8so17844865edb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 23:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=JSBjPN1Cw1JWGk/I3Wc9LEi3OTZyaIXALrsAcCbQ4Oc=;
        b=m2Nwut6B1USQuIaLEfVoMff5e6C1/Ica4ME48ztX4Z7WdE0oju6792maoNgfQPE15o
         Vc4Qb5YYCvbYtRNNRpQRWwbDOaPHnqy4/W42Ib8TG9i9nhIw/RUVYxzT8Lfs7C+iLRmP
         9UCHBqr6b9gO5HQNtLLJ1MwwbZoHA7+RWRk1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=JSBjPN1Cw1JWGk/I3Wc9LEi3OTZyaIXALrsAcCbQ4Oc=;
        b=Y7XNPI2tsqfDne0YaUMNaIuqW7j0wvmh1G3cmzxQA/HN0C8tea6nU6SvHq2UGyD1J+
         KIZ4iSLaXbvKosxgDn7R9rQCSTHQmHNvUe6+wyNOWZUs+rnLRrVDO00AfJ9/u0qVx4aj
         PpAQMghbiaSDzUB4csVRYd530eWXM3WNKNB+GWVS/9ULpuVSUrSbY6YgXJWUJiSKwYDQ
         VMgUTNRpDr3cIAJzGjLH9u6FtR66qfeCOBQfU+B5DrvXygifJ6tVzBX+RYXc+Ltjv+n9
         DUddvfo0qC/2aYq2MxHZA+xuIKGScBus1ta6/q15BlSeRPNadp2AN8ep6uiIjFwkGW82
         pLKA==
X-Gm-Message-State: AOAM531XpnMuWX2pLF2/m9/72PLrxrE046UTUzJLecBCNMAYoYR/snVD
        zAzC8eg/i7cwFH1vy/Xf8Ak3zrRJT/o3tcJkfmiiAA==
X-Received: by 2002:aa7:cb16:: with SMTP id s22mt12240018edt.53.1610351392598;
 Sun, 10 Jan 2021 23:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20201221041231.14516-1-pihsun@chromium.org> <20201221041231.14516-2-pihsun@chromium.org>
In-Reply-To: <20201221041231.14516-2-pihsun@chromium.org>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 11 Jan 2021 15:49:16 +0800
Message-ID: <CANdKZ0f=StCCe9T96ZbGcoTAF2io1xx68=nEzVpudJCr8of-KA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_sysfs: Add cold-ap-off to
 sysfs reboot.
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gentle ping on these two patches for EC_REBOOT_COLD_AP_OFF.


On Mon, Dec 21, 2020 at 12:12 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>
> Add cold-ap-off to ChromeOS EC sysfs reboot file option, corresponds to
> the EC_REBOOT_COLD_AP_OFF flag, that will reset EC and keep AP off.
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index f521a5c65091..8210fb10e839 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -28,7 +28,7 @@ static ssize_t reboot_show(struct device *dev,
>         int count = 0;
>
>         count += scnprintf(buf + count, PAGE_SIZE - count,
> -                          "ro|rw|cancel|cold|disable-jump|hibernate");
> +                          "ro|rw|cancel|cold|disable-jump|hibernate|cold-ap-off");
>         count += scnprintf(buf + count, PAGE_SIZE - count,
>                            " [at-shutdown]\n");
>         return count;
> @@ -46,6 +46,7 @@ static ssize_t reboot_store(struct device *dev,
>                 {"cancel",       EC_REBOOT_CANCEL, 0},
>                 {"ro",           EC_REBOOT_JUMP_RO, 0},
>                 {"rw",           EC_REBOOT_JUMP_RW, 0},
> +               {"cold-ap-off",  EC_REBOOT_COLD_AP_OFF, 0},
>                 {"cold",         EC_REBOOT_COLD, 0},
>                 {"disable-jump", EC_REBOOT_DISABLE_JUMP, 0},
>                 {"hibernate",    EC_REBOOT_HIBERNATE, 0},
> --
> 2.29.2.684.gfbc64c5ab5-goog
>
