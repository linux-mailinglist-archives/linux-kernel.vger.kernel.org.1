Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB558285088
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgJFROq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJFROp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:14:45 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66022C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 10:14:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q7so6330046ile.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fus0GuCBy+PUOs13nkiYMRRj5ZLVf0qK2djsulwqdqg=;
        b=Bk04IsZcOEuvw2B6hkoY1Bew1ab1UXV3YB29ea+qqrItVOVg72gyzYK5cKWISsZxzD
         3my4cqx7aWXt80HytX+4VyQYXjHRvzdHSpvu4t9O0vCzbAg73w2zEFQzIjnBehq5Xach
         iyJFAFmA0f6apOpCPuaI3tL1K0Z/xT3b19en0gRpDCMMvyARsBezWAOBAVISnvSFOiWH
         Boxoe3/CNgeMIDuwWYy5IJqIs/17TA1gyjUIr0qYg1t/lfcSZAOqJ4QO3UtLOzBhrrHV
         Bl7TWiE91cqUIwjsU1EgKtWbbBGYoipkeRWEw9a3diPdPRgV54vsjhW7Q/U4SdH0zv7U
         dQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fus0GuCBy+PUOs13nkiYMRRj5ZLVf0qK2djsulwqdqg=;
        b=P3yJQE8HgNdKrdSqY2Xdhuo3u/bgxLJgKvCLNDts4jC66SKS+5bsyiWzxa8Rc+eets
         0wlYhFyyckbeUslAove1gBrQH7/FfZXty6mBxRK2PaETl+p1WT8/uHh0OHtS7een2lWE
         EQXDCvrRjtqtKxxQt0ZjkRYxX2gNWjA3onIV+FtGr17Qe1d1bZra9imOyF59P/ARR/Rd
         TSsakSdrPzNNQ+VWo2vnrlxpRcRjivbaAMPMDQlCsChoWo1kf3rhiD7D4tVnO8v76R3g
         sRxgvpZ2NkCBSJMH9CbCOuXeQcSlpTjNdwpBXT+aTG5BHDQAyOuvog+psoySde0uqHFV
         IVCw==
X-Gm-Message-State: AOAM533qDxoYXM6gvSCHebq8DB/+KLxdSJuTFgDdc1T1V2R6mxpc/nAR
        G3a8+R3PjfwvBL8dZ4xp25FaOfM3wh+LV3jIVA==
X-Google-Smtp-Source: ABdhPJwcrXaHiUNR7VwhGuHQeBt5U1uDkuT50I4035swmcp9xRtuq7VLFivoCWyeaQH/3ptfFRMmW652ZHGyt+pGu9I=
X-Received: by 2002:a92:4188:: with SMTP id o130mr4141165ila.27.1602004483736;
 Tue, 06 Oct 2020 10:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601925251.git.luto@kernel.org> <4b3b4fbf8e9806840135e95cef142a0adefc3455.1601925251.git.luto@kernel.org>
In-Reply-To: <4b3b4fbf8e9806840135e95cef142a0adefc3455.1601925251.git.luto@kernel.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 6 Oct 2020 13:14:32 -0400
Message-ID: <CAMzpN2iTceq90wMU7O5jDDq4KH_AWF-AbajNowp_xvkGWxuwCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/stackprotector/32: Make the canary into a regular
 percpu variable
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 3:31 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On 32-bit kernels, the stackprotector canary is quite nasty -- it is
> stored at %gs:(20), which is nasty because 32-bit kernels use %fs for
> percpu storage.  It's even nastier because it means that whether %gs
> contains userspace state or kernel state while running kernel code
> sepends on whether stackprotector is enabled (this is
> CONFIG_X86_32_LAZY_GS), and this setting radically changes the way
> that segment selectors work.  Supporting both variants is a
> maintenance and testing mess.
>
> Merely rearranging so that percpu and the stack canary
> share the same segment would be messy as the 32-bit percpu address
> layout isn't currently compatible with putting a variable at a fixed
> offset.
>
> Fortunately, GCC 8.1 added options that allow the stack canary to be
> accessed as %fs:stack_canary, effectively turning it into an ordinary
> percpu variable.  This lets us get rid of all of the code to manage
> the stack canary GDT descriptor and the CONFIG_X86_32_LAZY_GS mess.
>
> This patch forcibly disables stackprotector on older compilers that
> don't support the new options and makes the stack canary into a
> percpu variable.

This doesn't consider !SMP builds, where per-cpu variable are just
normal variables, and the FS segment is disabled.  Unfortunately,
-mstack-protector-guard-reg=ds is not accepted.  The simplest fix
would be to define  __KERNEL_PERCPU when either SMP or STACKPROTECTOR
are enabled.

--
Brian Gerst
