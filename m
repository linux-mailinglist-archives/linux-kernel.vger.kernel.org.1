Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F228C2FB471
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbhASInv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:43:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51520 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730778AbhASImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:42:45 -0500
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l1maP-0003vk-Dy
        for linux-kernel@vger.kernel.org; Tue, 19 Jan 2021 08:42:01 +0000
Received: by mail-lf1-f71.google.com with SMTP id t194so7807829lff.15
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAVGkZ8Ja5y8odt6rz9mT1H76UHS7kPapzXcB65KHNI=;
        b=IBXzoWbIR8/h9YR6BqpP7/tDgl5geStBrt0rA9w5cpofdAI1ijLi7gpwCN8f7snmZT
         dS/WSslfRIjuWkO4IJlRbar3mDou5PYWMKwboMEmhA8NI0z1A5MZSRwfz98bLBAJc0Lb
         3/3SHjCJbE46Z6NMW0MtCtfG7ix7XjETXvT23j9TWyzLw5CLMihdnBDrkUKK6cnrQcHz
         HkSdRKXkzlFyDwsNA7bYAGAb1/z8ev6n4wxD0YSPpIdNF4Xbip7bfgc29llMvz5VThv/
         C5N2TFx2ZPosU9qJjEBGfy4UWnukD+2nizRvG08ILXdLrV7aGXfLr+cwPHgMZhPaVudj
         W00w==
X-Gm-Message-State: AOAM530bB8UacdD9PdynGQbE1cg0/gbs4pAFkA2b+4kaVXf1RmrrZMPF
        IV58uC5w92tmaogyF4+uYy4NRHXglI9Erf5/0goiUN5GemIQLNqT0MPpqc2P8a8+/koP283D5IY
        1CpSuMKi3QKmOXCv9bJYl+fuH7tV5hw5MeUdhTtcZpnvfJCt9VJm1pMqSnQ==
X-Received: by 2002:ac2:561b:: with SMTP id v27mr1381681lfd.425.1611045720894;
        Tue, 19 Jan 2021 00:42:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqjugoRrvtS9zUJau0D6+EsWghXpfBE/XsbWVRkfcXgQQOvDmb8Eb4uZpU/BhB2rkgTmyhylwJwJfL2FSu2xE=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr1381672lfd.425.1611045720638;
 Tue, 19 Jan 2021 00:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20210119081513.300938-1-kai.heng.feng@canonical.com> <YAaXz9Pg5x3DsCs3@kroah.com>
In-Reply-To: <YAaXz9Pg5x3DsCs3@kroah.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 19 Jan 2021 16:41:48 +0800
Message-ID: <CAAd53p7tdFiARtW1RXsjN8+OwRXWzMnok_rfKHDHCh-JSam3cQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / device_sysfs: Use OF_MODALIAS for "compatible" modalias
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        AceLan Kao <acelan.kao@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 4:27 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 19, 2021 at 04:15:13PM +0800, Kai-Heng Feng wrote:
> > Commit 8765c5ba1949 ("ACPI / scan: Rework modalias creation when
> > "compatible" is present") may create two "MODALIAS=" in uevent file if
> > conditions are met.
> >
> > This breaks systemd-udevd, which assumes each "key" in uevent file is
> > unique. The internal implementation of systemd-udevd overwrites the
> > first MODALIAS with the second one, so its kmod rule doesn't load driver
> > for the first MODALIAS.
> >
> > Right now it doesn't seem to have any user relies on the second
> > MODALIAS, so change it to OF_MODALIAS to workaround the issue.
> >
> > Reference: https://github.com/systemd/systemd/pull/18163
> > Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
> > Cc: AceLan Kao <acelan.kao@canonical.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/acpi/device_sysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index 96869f1538b9..c92b671cb816 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -260,7 +260,7 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
> >       if (!adev->data.of_compatible)
> >               return 0;
> >
> > -     if (len > 0 && add_uevent_var(env, "MODALIAS="))
> > +     if (len > 0 && add_uevent_var(env, "OF_MODALIAS="))
>
> Who will use OF_MODALIAS and where have you documented it?

After this lands in mainline, I'll modify the pull request for systemd
to add a new rule for OF_MODALIAS.
I'll modify the comment on the function to document the change.

Kai-Heng

>
> thanks,
>
> greg k-h
