Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BAC2ADD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgKJRgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:36:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52436 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJRgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:36:43 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5407B20C27E3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:36:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5407B20C27E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605029802;
        bh=HUErppECuDoI+CymY3xzV+J5v4YPtoq7gqNIuravNIs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tMMw994Gdbtp33DnHRd2qi63bt2KnoX14WBybNVad8m8qZLLNNCxzxoy9ZrPl8o/V
         mGvZbOMP+e/ZlOkvvwf7N14dUNXDFEhZYEgI+OIrODe5ONsAzy0vt4Z1AH6dHuo+yc
         UmBsdQXYs1Ci0Dc54RZHM8QK4nW3UHBl4qaaREoo=
Received: by mail-qt1-f170.google.com with SMTP id i12so9148686qtj.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:36:42 -0800 (PST)
X-Gm-Message-State: AOAM532+43SsL5PMOlpxHdcyUdAZ00PAxC7IqeVXJj3VU+WHAGVe6k/8
        DNAeQgDCkJk/K9cAVUTbwz01JVjvn67R0YjqqV4=
X-Google-Smtp-Source: ABdhPJzFoFyCA5onBvM4kgF2om877SmQHwv4u/BmOctidLGxaMzXiHY+SUaRUKwsgewgID2fz0GQP5AfbQdWHt9GrbY=
X-Received: by 2002:ac8:75d6:: with SMTP id z22mr19087093qtq.255.1605029801402;
 Tue, 10 Nov 2020 09:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20201109164538.18934-1-mcroce@linux.microsoft.com> <20201110145834.GE20201@alley>
In-Reply-To: <20201110145834.GE20201@alley>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 10 Nov 2020 18:36:05 +0100
X-Gmail-Original-Message-ID: <CAFnufp3xfBCwodEmD-sSM7sRWdEv3iDbyBcjYKP_tL70yc+gtQ@mail.gmail.com>
Message-ID: <CAFnufp3xfBCwodEmD-sSM7sRWdEv3iDbyBcjYKP_tL70yc+gtQ@mail.gmail.com>
Subject: Re: [PATCH v3] reboot: allow to specify reboot mode via sysfs
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 3:58 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Mon 2020-11-09 17:45:38, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > The kernel cmdline reboot= option offers some sort of control
> > on how the reboot is issued.
> > Add handles in sysfs to allow setting these reboot options, so they
> > can be changed when the system is booted, other than at boot time.
> >
> > The handlers are under <sysfs>/kernel/reboot, can be read to
> > get the current configuration and written to alter it.
> >
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-reboot
> > @@ -0,0 +1,31 @@
> > +What:                /sys/kernel/reboot
> > +Date:                November 2020
> > +KernelVersion:       5.11
> > +Contact:     Matteo Croce <mcroce@microsoft.com>
> > +Description: Interface to set the kernel reboot mode, similarly to
> > +             what can be done via the reboot= cmdline option.
> > +             (see Documentation/admin-guide/kernel-parameters.txt)
> > +
>
> s/reboot mode/reboot behavior/
>
> The reboot mode is only one of the modified parameters.
>

Right


>
> > +What:                /sys/kernel/reboot/mode
> > +Date:                November 2020
> > +KernelVersion:       5.11
> > +Contact:     Matteo Croce <mcroce@microsoft.com>
> > +Description: Reboot mode. Valid values are: cold warm hard soft gpio
> > +
> > +What:                /sys/kernel/reboot/type
> > +Date:                November 2020
> > +KernelVersion:       5.11
> > +Contact:     Matteo Croce <mcroce@microsoft.com>
> > +Description: Reboot type. Valid values are: bios acpi kbd triple efi pci
> > +
> > +What:                /sys/kernel/reboot/cpu
> > +Date:                November 2020
> > +KernelVersion:       5.11
> > +Contact:     Matteo Croce <mcroce@microsoft.com>
> > +Description: CPU number to use to reboot.
> > +
> > +What:                /sys/kernel/reboot/force
> > +Date:                November 2020
> > +KernelVersion:       5.11
> > +Contact:     Matteo Croce <mcroce@microsoft.com>
> > +Description: Force an immediate reboot.
>
> This makes me feel like that the kernel will reboot
> immediately when you write "1". It would deserve a better
> explanation that would make it clear, something like:
>
> Description:    Use forced reboot that does not contact the init system.
>

Description: Don't wait for any other CPUs on reboot and avoid
anything that could hang.

>
> Otherwise, it looks good to me. With the two above updates:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Best Regards,
> Petr

Thanks!
--
per aspera ad upstream
