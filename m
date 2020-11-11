Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E788F2AF77D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgKKRn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgKKRn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:43:59 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B48C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:43:58 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y22so1342293plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tsu1wgRN/XwGLZIcqUwi0BvJaexsFk3P467mtRcVH+w=;
        b=l0aza8swvNOkP3/BQF1fjPWdXJ8NDZ6neGb/HBDhbCEv7IxFwebR+0GV3b01VjOOoh
         +EhA4UCd3guChQSOUmVdE4IhbLrZbhfl2loC6k0L6Mb+pn+X6JYoJIuo7giccGyRvknW
         lvgmNorVek0WmHzB8Cq6cOZRmYZTpLJRx9u+eQkYwy9alXp5Wxf7z6aLPKkU7JE9AKty
         +SwUYQnAfAVHg+ilizoNDvKr5T3TsC/p69GcUU+nPIINoAOsqb4u96xdnngvNzU6nsuG
         f95hD+JN3q7c9XkOq/JSc7mgYguAu1iQx6H/eJ+Ps1PZV/8W5ZUIlifeKkIukHg+9o+6
         6BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tsu1wgRN/XwGLZIcqUwi0BvJaexsFk3P467mtRcVH+w=;
        b=gMBR9cezwHY/dALzts2rz66SjrCH9VOpdNPCLDyCABYpvuuzpqZBy0CtrmKxMNqeoL
         9MAetBSjL0GvDGa3wgz6cKndTBIA+AkmQTPvr0dTjC3tZeYM8pgbjb/c+CNRn8yxeQhS
         FarnThKT9x3cMtCocI/VWDs80JIi0F7daZfHZ/qy88ICXH5i68SH+Brw0SI4e9WcUK5V
         R/R/wr0WpObg60gB2kPR4EAwi4Rc1QGWI8u0jJDaPcQXl1u+UiKGYiM7Bh7NDERjsWRF
         vmn9ueg6fG4GmvVJdfTO+Wp9cdgHRngNp3KkS286JJNVRE02M0FEsoc465UVuOZA3hQz
         MTZw==
X-Gm-Message-State: AOAM531m7WretmKPR8YxkuH9rZy1Wt+3GZn97gZwAg6u0mB4QwHeLXkU
        RCYLS5yoWCoH4u4Lr/Ohesn8z3gTRulONioXO/3x2w==
X-Google-Smtp-Source: ABdhPJzO1ttJvAzBSg/S2s27I/7TEhnJ1LpjynWSVH/0ZPre4UGMid8v2eZv1EVmiuPhDDZTp5wz9Rg0ACvrOd8M1D0=
X-Received: by 2002:a17:90b:3111:: with SMTP id gc17mr4869942pjb.41.1605116637429;
 Wed, 11 Nov 2020 09:43:57 -0800 (PST)
MIME-Version: 1.0
References: <000000000000fe575905b3cff92c@google.com> <bf31020f4e50b303fd0dd3dfda0e50de79ed25db.camel@redhat.com>
In-Reply-To: <bf31020f4e50b303fd0dd3dfda0e50de79ed25db.camel@redhat.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 11 Nov 2020 18:43:46 +0100
Message-ID: <CAAeHK+yLgDYOS35sWT8=4_d-gZKU_B10D9ZEBPZDC1P6MO2D6Q@mail.gmail.com>
Subject: Re: linux-next boot error: BUG: unable to handle kernel NULL pointer
 dereference in mempool_init_node
To:     Qian Cai <cai@redhat.com>
Cc:     syzbot <syzbot+2d6f3dad1a42d86a5801@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 5:26 PM Qian Cai <cai@redhat.com> wrote:
>
> It looks to me the code paths below had recently been modified heavily by this
> patchset. If this is reproducible, it can be confirmed by reverting it.
>
> https://lore.kernel.org/linux-arm-kernel/cover.1605046662.git.andreyknvl@google.com/

I'll try to reproduce this and figure out the issue. Thanks for letting us know!
