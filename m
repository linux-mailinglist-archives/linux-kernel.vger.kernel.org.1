Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB02302952
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbhAYRvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:51:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731169AbhAYRuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:50:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72DC922E03
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611596979;
        bh=zuyRHftsqVWCQjq18XklCtmYkyBWLlstKHGMnVWyIhU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NtztpnmERvAG+Cu5ZQgPtvxJnbhIc0D5b2rZxAfyC7FjfqSf9U7aW+mGY/epm3Mx2
         9HgkT+7I7QMHsq01AmYpqYRUnfNRwPAbF7neKs67HnHmdC0rbr5bxTf/+rvujufQE3
         AbZAHOViddhFAZNq9mlwTOapAnzvJeyDc1v1GlgsDeOmFpTlrDFRMQbJA46DXiDKGX
         W9Y1c8raPjWgA+cVc8qsqeOHlUf1+BhH7iB276EpqCGkUcknlPOR+jeDMwtgsTdy8S
         i3yXlVRXDyXYnRz4PkPPlwVTgs/31UxDbWc5lDoGg0Y9+EGvWUuvT7hp5BzSDlA4hJ
         LTwUDemWDExWQ==
Received: by mail-lj1-f181.google.com with SMTP id s18so3228133ljg.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:49:39 -0800 (PST)
X-Gm-Message-State: AOAM5320Z09dT10Jneo/2EQLqqok0KO0mLIUAQaEuxg9xXGxXlC83Cy1
        BvGVJyAyrjF6OYPdS+Rl1xTnlHCVB/bhoAfEK0bsiA==
X-Google-Smtp-Source: ABdhPJzCKGQ60lMer0NxdTG1QVtvRZKsUtiEFk5qlpzoTCsaG5EwRDumBYPDFKvTostFYe0kM9lQRf1vMb8y2QQgCiU=
X-Received: by 2002:a2e:2c11:: with SMTP id s17mr693442ljs.468.1611596977707;
 Mon, 25 Jan 2021 09:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20210122123003.46125-1-mikko.ylinen@linux.intel.com>
 <CACYkzJ6sMBvZ_ZG9++jwpQ+JQL3PL02okhD0O5Ftz4Hd7jEC3Q@mail.gmail.com>
 <CACYkzJ5i6DNxY3D3SqiO_LO2HBbA-EgPFdK8ZBcFNmTVWweucg@mail.gmail.com> <YA5rXLwy4mcgcvLx@outtakka>
In-Reply-To: <YA5rXLwy4mcgcvLx@outtakka>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 25 Jan 2021 18:49:26 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6q53qwEvTjvNP_d5O+ytQM=jFVRQ9PV2+ie6Ah5VDnRA@mail.gmail.com>
Message-ID: <CACYkzJ6q53qwEvTjvNP_d5O+ytQM=jFVRQ9PV2+ie6Ah5VDnRA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Drop disabled LSM hooks from the sleepable set
To:     Mikko Ylinen <mikko.ylinen@linux.intel.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 7:55 AM Mikko Ylinen
<mikko.ylinen@linux.intel.com> wrote:
>
> On Sat, Jan 23, 2021 at 12:50:21AM +0100, KP Singh wrote:
> > On Fri, Jan 22, 2021 at 11:33 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > On Fri, Jan 22, 2021 at 1:32 PM Mikko Ylinen
> > > <mikko.ylinen@linux.intel.com> wrote:
> > > >
> > > > Networking LSM hooks are conditionally enabled and when building the new
> > > > sleepable BPF LSM hooks with the networking LSM hooks disabled, the
> > > > following build error occurs:
> > > >
> > > > BTFIDS  vmlinux
> > > > FAILED unresolved symbol bpf_lsm_socket_socketpair
> > > >

[...]

>
> Agree, a way to get the set automatically created makes sense. But the
> extra parameter to LSM_HOOK macro would be BPF specific, right?
>

The information about whether the hook "must not sleep" has been
mentioned sporadically in comments and

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/lsm_hooks.h#n920
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/lsm_hooks.h#n594

I think it would be generally useful for the framework to actually provide this
in the definition in the hook and then ensure (by calling
might_sleep() for hooks
that can sleep).

- KP

> -- Regards, Mikko
