Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69D02A87AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbgKEUCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEUCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:02:04 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322FEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:02:04 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n12so3082749ioc.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fv9PbM0mWbGs3SJ8rmspBCaTVm4/mWO5xuXCNEgpydE=;
        b=hexKqQ2q848VizzUcSockEbXIkhZ5tok06Bg5Eh9kA8qTUX6G0DLzNVQ9j40/XYFIx
         kuHsf774oSPSg1DYqlcy+E7NMln/1ZmB3IORdm1WeYrrMGMCrvPZzzLwdIK4Yrt20fuc
         1OtKjBkKNVcf2P0hTW0N/z/GqGCbQw/CHJPo/qwNQbPsKkVsHMEbHoly8fe4JSn0mZQ2
         4933pt+a6uGxnVlLgtxXMI/yXWieNk7LAKWankbE6Kjm4k81+T806826B6lK25jsjFg7
         /SmyK4Z2y+iNKB14s2m2ZOTOLxkIlNJBvj7RL+dmuSvKHI2YTXHb/t3DFNuELBKqle73
         4o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fv9PbM0mWbGs3SJ8rmspBCaTVm4/mWO5xuXCNEgpydE=;
        b=LOyhs1vg5Ue5ZUlBbrKBoIV+PJuSWUIiS7+jFPAmU1QbCEwNMRcpByX0JjU7vAk876
         plxoUWUw2itjnWg3ZgvSGeQm9yFoeQTfWhB3Ts/3vd8OQO5lEw73lQS1A5wA3vTtLX5P
         kaSgjT0TKPw0vw7f9GMXHTwXqXTSAJGOGL1qjm5wetHoQ8EemKg0ZSM9GxVI4AjqJZsI
         II8HVStpyLT8LLfeUs4es9DDnIXMHiWPl17kSqNzgmZ8fWDeXnZgOV718Xyi1IlqV1r9
         uvYLGcpmrdwGldMo/dAlXiPacOMaAFUwm2E9Ji6YyNexSANfiqEWqPBpgBQ5WO6XxrF7
         T3nQ==
X-Gm-Message-State: AOAM531qI2FokNuB8KSrMrPoBtBOElo07PrQ4k+1NrzFiunbrjk6Ew1b
        8XQRa0IjBSKqdgADfoxMQOcKiiOp7EA5L8hV5Wc=
X-Google-Smtp-Source: ABdhPJyKeYgxsW4c9LKIVlqqAShH9/7iBhFlymfcyy26q67aq0itxDHrk1+eip7nduuU8d/qLK7xCrbBKV55AnjuA3w=
X-Received: by 2002:a02:ac09:: with SMTP id a9mr3584797jao.60.1604606523511;
 Thu, 05 Nov 2020 12:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20201004032536.1229030-1-krisman@collabora.com> <20201004032536.1229030-11-krisman@collabora.com>
In-Reply-To: <20201004032536.1229030-11-krisman@collabora.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Thu, 5 Nov 2020 20:01:52 +0000
Message-ID: <CAJwJo6a8O+BF6T55V94YEFNxbx7pdUsX-Y9fqC5szVpJhwQEzQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] x86: Reclaim TIF_IA32 and TIF_X32
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, hch@lst.de,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        rric@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Oct 2020 at 04:31, Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Now that these flags are no longer used, reclaim those TI bits.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Oh wow!
I've just started rebasing patches that do essentially the same on linux-next
and found that it's already done and merged.

Thanks for doing this! :-)

-- 
             Dmitry
