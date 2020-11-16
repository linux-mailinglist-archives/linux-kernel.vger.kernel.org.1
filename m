Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ADA2B4B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbgKPQa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:30:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730302AbgKPQay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:30:54 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C868A223BD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605544254;
        bh=2O3LBp1HPw0KQ1G2spNpvOUgelxUM0n8eKWWsC7ds30=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dqOsYI+0YGbb9NsAnIzVJVzN0+ZCeTcljVXkHY3Ca9c9X+hnuCJH8G2FUn67vfd9U
         obw74aqxw/UPBefBUp/bAQMVgF7JOQ9WyTuYSFtDMR4oweOAreMWzRFjeNPN566/DC
         MYCetQ39nn4CSqfi8ZhF3wCBDvpGh7bvgBDqVpPc=
Received: by mail-wr1-f41.google.com with SMTP id o15so19352282wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:30:53 -0800 (PST)
X-Gm-Message-State: AOAM532T53J/onkMI4e9wpuQnxt2DDbHaoaIYDZ/XcDq7FWW0Vre9qvP
        e/D/QScROTYaMxnp/YXdR6Rd1TY0N76sPoDo/ajiuw==
X-Google-Smtp-Source: ABdhPJxRrSLHlH4ScZov5CaCHz95dre2M6ViQYOjxHY5oh3r9MUJXokIlLxakAYO4Hpet3isswmFWL/5m9Ab6jgvvwU=
X-Received: by 2002:a5d:5482:: with SMTP id h2mr9404192wrv.18.1605544252224;
 Mon, 16 Nov 2020 08:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20201116152301.24558-1-jgross@suse.com> <20201116152301.24558-5-jgross@suse.com>
In-Reply-To: <20201116152301.24558-5-jgross@suse.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Nov 2020 08:30:38 -0800
X-Gmail-Original-Message-ID: <CALCETrVMX+D1fv3bbb7F_Cp2SfrFBudUqJk=uR3AJkgQ_KCniQ@mail.gmail.com>
Message-ID: <CALCETrVMX+D1fv3bbb7F_Cp2SfrFBudUqJk=uR3AJkgQ_KCniQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/xen: drop USERGS_SYSRET64 paravirt call
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 7:23 AM Juergen Gross <jgross@suse.com> wrote:
>
> USERGS_SYSRET64 is used to return from a syscall via sysret, but
> a Xen PV guest will nevertheless use the iret hypercall, as there
> is no sysret PV hypercall defined.
>
> So instead of testing all the prerequisites for doing a sysret and
> then mangling the stack for Xen PV again for doing an iret just use
> the iret exit from the beginning.
>
> This can easily be done via an ALTERNATIVE like it is done for the
> sysenter compat case already.
>
> While at it remove to stale sysret32 remnants.

s/to/the/
