Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D51287F63
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 02:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgJIAIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 20:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgJIAIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 20:08:49 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B2522253
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 00:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602202129;
        bh=4yPQqqAjXCZM9pc0I7adFNYv+vmVgUi0uzt6sSpyA+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SZLf+rdE55IzCogE/8NBJWXHyCCmMs4AcNfw4Ixb5zyMU6EmgQjXO/DIPkFrmeJyS
         S5FQbWCtdDnOEEbuVyKr7bMDh6gWXa3VTbtyHw55NShHcxxe9fxeMUUShb6Pty5NSW
         54UosAL6QL0vbcarehKH/Uwhzi0lXss7P96n3nss=
Received: by mail-wr1-f51.google.com with SMTP id n6so8117294wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 17:08:48 -0700 (PDT)
X-Gm-Message-State: AOAM531HArvmUTJlzNkBphdXSB5suo3lHo2AYgaggH4rbjL51pSmHODV
        TgRQ8doTXirBkB8yHO/JO+Kc+Y1WHG6iFEfp618/aA==
X-Google-Smtp-Source: ABdhPJwYDfXRcQ5XbD0TQkppXHWItGPi5MyuoEIDAXz6zAIQR8pm57z7RcQOKuYF4daEDBtoAeA7UUBgXpvI8vxcnH4=
X-Received: by 2002:adf:a70b:: with SMTP id c11mr6052015wrd.257.1602202127571;
 Thu, 08 Oct 2020 17:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrXENKF9iVXaQrQcbgFq7fksC2pGz86tr9YGgDdeP3uR-Q@mail.gmail.com>
 <71682bce-a925-d3bd-18ef-d2e4eb8ebc8e@intel.com> <20201001205857.GH7474@linux.intel.com>
 <f1835c1f-31bc-16a9-ffa5-896b1aeb895a@intel.com> <CALCETrWswWdgXO2J6nRjXW_4JRsK1TzzVZ62EDsF+d_79O+6Sw@mail.gmail.com>
 <8e23f875-3c3c-957d-84db-530d2ece432e@intel.com>
In-Reply-To: <8e23f875-3c3c-957d-84db-530d2ece432e@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 8 Oct 2020 17:08:35 -0700
X-Gmail-Original-Message-ID: <CALCETrVyG08xHF6y_mS3TWMVWq19Y+suZkbU3snHT_5w_d44zw@mail.gmail.com>
Message-ID: <CALCETrVyG08xHF6y_mS3TWMVWq19Y+suZkbU3snHT_5w_d44zw@mail.gmail.com>
Subject: Re: How should we handle illegal task FPU state?
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 11:08 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>
> On 10/1/2020 3:04 PM, Andy Lutomirski wrote:
> > On Thu, Oct 1, 2020 at 2:50 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >>
> >> On 10/1/20 1:58 PM, Sean Christopherson wrote:
> >>> One thought for a lowish effort approach to pave the way for CET would be to
> >>> try XRSTORS multiple times in switch_fpu_return().  If the first try fails,
> >>> then WARN, init non-supervisor state and try a second time, and if _that_ fails
> >>> then kill the task.  I.e. do the minimum effort to play nice with bad FPU
> >>> state, but don't let anything "accidentally" turn off CET.
> >>
> >> I'm not sure we should ever keep running userspace after an XRSTOR*
> >> failure.  For MPX, this might have provided a nice, additional vector
> >> for an attacker to turn off MPX.  Same for pkeys if we didn't correctly
> >> differentiate between the hardware init state versus the "software init"
> >> state that we keep in init_task.
> >>
> >> What's the advantage of letting userspace keep running after we init its
> >> state?  That it _might_ be able to recover?
> >
> > I suppose we can kill userspace and change that behavior only if
> > someone complains.  I still think it would be polite to try to dump
> > core, but that could be tricky with the current code structure.  I'll
> > try to whip up a patch.  Maybe I'll add a debugfs file to trash MXCSR
> > for testing.
> >
>
> One complication of letting XRSTORS fail is exit_to_user_mode_prepare()
> will need to go back to exit_to_user_mode_loop() again (or repeat some
> parts of it).
>
> Currently, when exit_to_user_mode_loop() exits, xstates should have been
> validated earlier and to be restored shortly.  At this stage, XRSTORS
> should not fault.  If we need to kill the task, we should have done that
> earlier.

We can still do_exit().  I'll ponder this.
