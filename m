Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E271C2E97AF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbhADOxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbhADOxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:53:22 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6670C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 06:52:41 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id 6so37127336ejz.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZCf/j6E7ndk6ZbomNdTWSNmnrq/kKIWpB5ee8yFR1vQ=;
        b=u1/mnbn3Qm2LLbmuXt+BTEccgfs8KIohvLR5sJ/h5OdvJX+bRYrb31pGGOjd6rm3s5
         i9l4AvEnvv/K0RRU4lpbZmY0tDOXjgcsDLAqCbCLvtlhhBgywirnnRKzDTlP3PJCM0wI
         IU2P/kmNPCdclfd6ab3b9t6m29KdqRrhUVOlk/SfWTDpVTpV0RJYooUHvFrYt1ej/jDp
         6R2qmjgyDGX/d6Se+cIb1a7RnE+ObYrsSSKE4F0Aq8k4JD4r0KzPnF4f41DxZCqWNbnQ
         AN9gNMJTX8upeLiVi4L5FcXzPceyjFU0phqOdcpAY6V7xPhe6XaG/P3mi6alA4CrIhMq
         5DgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCf/j6E7ndk6ZbomNdTWSNmnrq/kKIWpB5ee8yFR1vQ=;
        b=ebvCRSkzUwRqlakLcC2FsW3y2yF/xXbNABcm3iJ50zluo93RbJI+TW2rv1w/acNFtY
         iOHpk0aMb6HNqinx73zLLyTsxZ5+Yhkti9Z13FGed4RhwnY7pmwjBdYAB4Jz2sQYrnuh
         YPCgfMdsLD6XR0aw08pV3C3D2adryyPGVqRnc4DnHPW375hXjNh342ElclRh2hvf7G4L
         FmRi1YN2zRXs+eua8zDD/8VER0+QPI14IYsoin92lHe0iIJ4cwzzy4WizbkJ5Zz+eYMU
         3zFMUGxDQR/dKzLFT0nM7oWCRN0bSfb8BSFyxsDRl/n3TemJNWkZPNTgG0GTUjpt9XzL
         MkpQ==
X-Gm-Message-State: AOAM531gK/B9AKu6mcO9P3gZqvHtQJQmMl408IVtXBTqTeqVjW3v4sD0
        PG+K/daSCJh8Xhm7vXBcMoOzUIex1at6Wn3i64U=
X-Google-Smtp-Source: ABdhPJzHUKI2IbZMBBKC8HyPgJojqN5/XCE8M1CkwpRVmbjHkyE0gMYqnUHPuMT/wSAlfFoilNUNZ5SkKH4R01w4sQc=
X-Received: by 2002:a17:906:d8a1:: with SMTP id qc1mr65889499ejb.294.1609771960435;
 Mon, 04 Jan 2021 06:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20201215205641.34096-1-lstoakes@gmail.com> <13deefab-de94-4e68-67f8-e03f99bcb115@intel.com>
In-Reply-To: <13deefab-de94-4e68-67f8-e03f99bcb115@intel.com>
From:   Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Mon, 4 Jan 2021 14:52:29 +0000
Message-ID: <CAA5enKa+wMcNbYKxDAzPnZYXvGMeo4GL6y0nHWcCenRmFvM=2A@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: increase pgt_buf size for 5-level page tables
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Happy NY all, thanks for the review! I haven't contributed an
x86-specific mm patch before so am not sure of the process - usually I
submit patches to the mm mailing list and Andrew gathers them up into
his tree, is there anything else I need to do with this?

Thanks, Lorenzo
