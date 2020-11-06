Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203F02AA0EF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 00:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgKFXTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 18:19:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59620 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgKFXTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:19:43 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by linux.microsoft.com (Postfix) with ESMTPSA id 85CB320C1713
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 15:19:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85CB320C1713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604704782;
        bh=5p29qD6PMUhjZLui+DA1aSOuDvxmG7/CLwJlDaDmPwo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hCInwJHObLih5PwcJrZe7TiqFoT9abhuhihDoKzpPbLSmu9kIlJUcxtN3XNbEp0Hx
         msGAvngvE8NJDLbKEZAcS/ssAStwOYW2rlrAzPIY9Ac08G7XPOTGPv2Zms8uEYYahx
         gVO7UP1/6Q6HRSsN3AWbuFJULeajJii+6M7yJoUU=
Received: by mail-qk1-f176.google.com with SMTP id n132so1600291qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 15:19:42 -0800 (PST)
X-Gm-Message-State: AOAM533pHDGx7YRMq2AiY2vpq4cIv49n6jZoLe/KNpayjMgDWChoQHKv
        8rgy35hNMi6dF60sMNirQ+osHv5z6K7ieqIyKEY=
X-Google-Smtp-Source: ABdhPJwQVwzy5Yt2/M2RCUs5htyUiWHkM7ZEmmHeoCuf/JwGCl4WZ2c7KvmNx/GoyKwFYcNIuPvL2ji59E0XFY0QN8c=
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr4144811qkf.436.1604704781537;
 Fri, 06 Nov 2020 15:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20201106200704.192894-1-mcroce@linux.microsoft.com> <20201106143312.830f2a7410efcf397614b9d4@linux-foundation.org>
In-Reply-To: <20201106143312.830f2a7410efcf397614b9d4@linux-foundation.org>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Sat, 7 Nov 2020 00:19:05 +0100
X-Gmail-Original-Message-ID: <CAFnufp2_3Ghyhs-kEBepdsGZ6c+x66z=T7m4Uyc1Xi48TwK8jw@mail.gmail.com>
Message-ID: <CAFnufp2_3Ghyhs-kEBepdsGZ6c+x66z=T7m4Uyc1Xi48TwK8jw@mail.gmail.com>
Subject: Re: [PATCH v2] reboot: allow to specify reboot mode via sysfs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 11:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri,  6 Nov 2020 21:07:04 +0100 Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> > The kernel cmdline reboot= option offers some sort of control
> > on how the reboot is issued.
> > Add handles in sysfs to allow setting these reboot options, so they
> > can be changed when the system is booted, other than at boot time.
>
> Please include a description of why you believe the kernel needs this
> feature.  Use cases, end-user benefits, etc.
>
> We've survived this long without it - what changed?

Hi Andrew,

We don't always know in advance what type of reboot to perform.

Sometimes a warm reboot is preferred to persist certain memory regions
across the reboot. Others a cold one is needed to apply a future system
update that makes a memory memory model change, like changing the base
page size or resizing a persistent memory region.

Or simply we want to enable reboot_force because we noticed that
something bad happened.

Bye,
-- 
per aspera ad upstream
