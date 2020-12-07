Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CF42D14B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgLGP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgLGP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:28:39 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F07C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:27:53 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id m19so19994081ejj.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 07:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CWPqY7gB/QoMToun+/6liS3Aa5bW1uZwjLPmmW+88Ls=;
        b=oBuBU1tDmmtrU8cWvFlNKQWEqdKRQqE+dKLNuy9coZBBMCAJGg+E3Kc1wVxRgi/hGQ
         vGFMphwkXSofsqjWkq+HMZ3AqYHvAvIvBunbHGBON3w6W+gamq3+mTIDD9MnwpbG5daf
         V/RYUVeN5MDlShhtWblzedtvCxeXUWBY+Ay/n5eL34XeViW2U/znT0VRqBFDQfosUJ5+
         iaF0gRhMU8gUf4QTzKigFbIIixW09ocdj2KLMN3eylf2lrn3YSOvJcVIcN2BJpCTZ4U1
         GCRaC/lGDa+Wu2VviBnS9CCYjnPe/na+kkUsZu2PyCc21jIo5N4Dk8oSQ2sBrjDlzmkB
         AHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWPqY7gB/QoMToun+/6liS3Aa5bW1uZwjLPmmW+88Ls=;
        b=YV7c9hyzvdjo4SiNu6TIgVZ4jgHHkFhodRBAs33oGVomQ4+b4Of8iILETQZgbNioQe
         u8mGHGv5qbpomj9lPGmaU3axK0VKrH/3F3ooBcm39QijR6byOXvX2IjOv4xhV+qoTYLV
         gAFWnemhguiJQM4d1I8MXpdfb+qBNAioMsknMAOeac4gHaw3CH33I9ORC13XK0dZl5vF
         Sendk5Q5riG96hnm26YGF3BKDVeuY+IBnazDnTsJIWX28V4bcoiuyJh+U03LVXYg+HAI
         qt5oHkksAlQLcZ/K+5WCdKs1oZ1ieD5k5t5JiO1Ef0XR56gIUTVKn/FRdRBr6aRsWB61
         X6HQ==
X-Gm-Message-State: AOAM533ZrRQE2Jrabxae9bXIQHZZ2OXY217iSzDLWj7AiJhtnbDqOUZx
        xDjfe5CFJMfdM1EoBypSBECq2ZTaa5BpK/35WbfLGg==
X-Google-Smtp-Source: ABdhPJxzlqdtQ7zxg9nsdsKrHpDmw3fYW0PNLe0UvSzvUx0bNUOWgUFAyJCA9n9a8k59bXziSr7Lj3CtVdIGqZTX0SA=
X-Received: by 2002:a17:906:1542:: with SMTP id c2mr18896508ejd.382.1607354872135;
 Mon, 07 Dec 2020 07:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20201119153901.53705-1-steven.price@arm.com> <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com> <db5ad775fa7cfe7defbd78d9ca6ccfd8@kernel.org>
 <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com> <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
 <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
In-Reply-To: <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 7 Dec 2020 15:27:40 +0000
Message-ID: <CAFEAcA_Q8RSB-zcS8+cEfvWz_0U5GLzmsf12m_7BFjX8h-1hrA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Steven Price <steven.price@arm.com>
Cc:     Haibo Xu <haibo.xu@linaro.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juan Quintela <quintela@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 at 14:48, Steven Price <steven.price@arm.com> wrote:
> Sounds like you are making good progress - thanks for the update. Have
> you thought about how the PROT_MTE mappings might work if QEMU itself
> were to use MTE? My worry is that we end up with MTE in a guest
> preventing QEMU from using MTE itself (because of the PROT_MTE
> mappings). I'm hoping QEMU can wrap its use of guest memory in a
> sequence which disables tag checking (something similar will be needed
> for the "protected VM" use case anyway), but this isn't something I've
> looked into.

It's not entirely the same as the "protected VM" case. For that
the patches currently on list basically special case "this is a
debug access (eg from gdbstub/monitor)" which then either gets
to go via "decrypt guest RAM for debug" or gets failed depending
on whether the VM has a debug-is-ok flag enabled. For an MTE
guest the common case will be guests doing standard DMA operations
to or from guest memory. The ideal API for that from QEMU's
point of view would be "accesses to guest RAM don't do tag
checks, even if tag checks are enabled for accesses QEMU does to
memory it has allocated itself as a normal userspace program".

thanks
-- PMM
