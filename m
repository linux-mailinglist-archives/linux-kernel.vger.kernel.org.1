Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF872809DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 00:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbgJAWFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 18:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgJAWFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:05:02 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D4820706
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 22:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601589901;
        bh=ySbyvraJuX0jwwsNK/d/UFl6VDicg/JYUCXb5bYZY/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UPOqhg7mZpw3PfyZ0oa+Pip+ZIlIaOuCfgjfX+OffXkGVJ2u+epsd4QNwBF5w/r4E
         hm35CrKR7SKm9plRf8sDMhAt54l9xfvsPJdjMwpFA+Qmlziq7HY1p7Uox9MjFrf1bZ
         B19VDY3XBzOLephTf7rkT5bMZ2CDi/L9VYRJsWTc=
Received: by mail-wm1-f45.google.com with SMTP id s13so204071wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 15:05:01 -0700 (PDT)
X-Gm-Message-State: AOAM530EnAD5YNU/ekClz+vNINwWxCfqLSokVxCQesmjLUG/ODNJl0iX
        VaWm1jL+xRL6Mw1rSEN7Kgjf5lR8g1bcb0CMpkPuBw==
X-Google-Smtp-Source: ABdhPJwRUpEY1OCAHViAHUMa42To814U5ed+pd2Z8VzNXR/n91+63TY7xm1w7bECsSLBxpRVNTTY7bluo9IocmC3Zrs=
X-Received: by 2002:a1c:238e:: with SMTP id j136mr2069411wmj.176.1601589899748;
 Thu, 01 Oct 2020 15:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrXENKF9iVXaQrQcbgFq7fksC2pGz86tr9YGgDdeP3uR-Q@mail.gmail.com>
 <71682bce-a925-d3bd-18ef-d2e4eb8ebc8e@intel.com> <20201001205857.GH7474@linux.intel.com>
 <f1835c1f-31bc-16a9-ffa5-896b1aeb895a@intel.com>
In-Reply-To: <f1835c1f-31bc-16a9-ffa5-896b1aeb895a@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 1 Oct 2020 15:04:48 -0700
X-Gmail-Original-Message-ID: <CALCETrWswWdgXO2J6nRjXW_4JRsK1TzzVZ62EDsF+d_79O+6Sw@mail.gmail.com>
Message-ID: <CALCETrWswWdgXO2J6nRjXW_4JRsK1TzzVZ62EDsF+d_79O+6Sw@mail.gmail.com>
Subject: Re: How should we handle illegal task FPU state?
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 2:50 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/1/20 1:58 PM, Sean Christopherson wrote:
> > One thought for a lowish effort approach to pave the way for CET would be to
> > try XRSTORS multiple times in switch_fpu_return().  If the first try fails,
> > then WARN, init non-supervisor state and try a second time, and if _that_ fails
> > then kill the task.  I.e. do the minimum effort to play nice with bad FPU
> > state, but don't let anything "accidentally" turn off CET.
>
> I'm not sure we should ever keep running userspace after an XRSTOR*
> failure.  For MPX, this might have provided a nice, additional vector
> for an attacker to turn off MPX.  Same for pkeys if we didn't correctly
> differentiate between the hardware init state versus the "software init"
> state that we keep in init_task.
>
> What's the advantage of letting userspace keep running after we init its
> state?  That it _might_ be able to recover?

I suppose we can kill userspace and change that behavior only if
someone complains.  I still think it would be polite to try to dump
core, but that could be tricky with the current code structure.  I'll
try to whip up a patch.  Maybe I'll add a debugfs file to trash MXCSR
for testing.
