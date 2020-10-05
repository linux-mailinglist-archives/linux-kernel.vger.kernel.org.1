Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E945282EA5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 03:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgJEBbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 21:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgJEBbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 21:31:12 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9867C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 18:31:11 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dt13so145982ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 18:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CD5SBm3/k0Ur4raQN8g9T0RxF/NmKyvFSpy4+yfD9sk=;
        b=Y+H61gCLmfNTTS4JMK8PGWoMU16hNcXcQEEpS8zS8zPM/9eWzYk3EeXQwCP5MnkUe7
         gNqa7sV3vWHsE4TA51zW7JFUYTynr5yAgiv6OTj3t+tpWcBLLLSQBo5UcUKjJpDkCMdM
         MaUvwW+vapI037EuoBFnxBAu2KynoI3RLBiXdETKl5XzK18JRMSJr72DM5t7DLGaid89
         rzHxxlqNkE+4vSxvvp2f1htj/e6D/bZPU3www+f5E+T0Sz/23lnfEZLpsBx9zD9WNXVK
         aT/Y3cI8CKqK5mNSAofu3kVN1tVTg86RRre9dn6EDtGpqqL5tylmDc0ZbxAB3R5ATUgJ
         rkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CD5SBm3/k0Ur4raQN8g9T0RxF/NmKyvFSpy4+yfD9sk=;
        b=X+RpxflN92jBlGNzxgPmInopiCk9Mbn1U43moUsqUIR2ETzD0/DDQadlRuYyBSLfDR
         MUnEjS0KN+LasV7U5yIo5dM2Z4nS52hZ5bjxUlckoF2QzXBTc+1dKh7DXtMlFpPslo4x
         bUDCjToqY+4mXNBXtVfaaUodsvjMxdDqTNGXWLELHsflYdaWwuCPmX9j/23m8ZUzgSOz
         NhuZftOBOIfpeEqQNJF2w0+CjV0K9sgbNeCMAlU+YbpUy6MF1MKgl/kgy4lT0NI4ttoX
         2kPPQ4LGmtJ5iHdjKP5fN+OFdUnb7QjeMjdoZ+O2D4Wd+ewQZdeP7d/e0gL6D77rh/Na
         f0EA==
X-Gm-Message-State: AOAM532AuE8kiwPXc5I166mXEWu2p0cG+1xRa4EocSdjyhqa9ysx1gLQ
        ZMwn5lGsV2fZPFHtES2i/YN6WCFE1yFRmg+x7VIe5Q==
X-Google-Smtp-Source: ABdhPJxa/HUBqDnJGQEr80nERMqxQKclVk7SauN1nvsVxGnJ+WoTz7RM0b1rJ8WuuhDeABsmfMQxhJfWHL1mB9XDYTo=
X-Received: by 2002:a17:906:33c8:: with SMTP id w8mr13108506eja.233.1601861470277;
 Sun, 04 Oct 2020 18:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
 <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com>
 <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com>
 <CAG48ez2LdreJtHcZBL=t010PghjVECcsat2e2kzgakDvR0ue5w@mail.gmail.com> <CANN689H6fQkSXL8U0M-MoSrw8b8cQFMDaTRKr2v8oacZJ_FhKA@mail.gmail.com>
In-Reply-To: <CANN689H6fQkSXL8U0M-MoSrw8b8cQFMDaTRKr2v8oacZJ_FhKA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 5 Oct 2020 03:30:43 +0200
Message-ID: <CAG48ez0LuG9nULaBF_3ofE--u=TBgbxVdACthpb8wtJhADO02w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmap locking API: Order lock of nascent mm outside
 lock of live mm
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 3, 2020 at 11:30 PM Michel Lespinasse <walken@google.com> wrote:
> Unrelated to the above: copy_from_user and copy_to_user should not be
> called with mmap_lock held; it may be worth adding these assertions
> too (probably in separate patches) ?

We already have that: All (hopefully?) the userspace accessors call
might_fault(), and that does might_lock_read(&current->mm->mmap_lock)
(if we're not running in a lazytlb kernel thread or KERNEL_DS is on or
we're in IRQ context or page faults have explicitly been disabled).


But another place where lockdep asserts should be added is find_vma();
there are currently several architectures that sometimes improperly
call that with no lock held:

SPARC's arch_validate_prot():
https://lore.kernel.org/linux-mm/CAG48ez3YsfTfOFKa-Po58e4PNp7FK54MFbkK3aUPSRt3LWtxQA@mail.gmail.com/

nios2 sys_cacheflush():
https://lore.kernel.org/linux-mm/CAG48ez3hxeXU29UGWRH-gRXX2jb5Lc==npbXFt8UDrWO4eHZdQ@mail.gmail.com/

nds32 sys_cacheflush():
https://lore.kernel.org/linux-mm/CAG48ez1UnQEMok9rqFQC4XHBaMmBe=eaedu8Z_RXdjFHTna_LA@mail.gmail.com/
