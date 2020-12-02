Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4806A2CB222
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgLBBMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLBBMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:12:49 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F51C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 17:12:03 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u19so147076lfr.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 17:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWjyeifvSwsRpNI5bt393TR+i6zbs6RUOPTBxq9kpw8=;
        b=FGE8oRA2h0WmXKhJu9sTaV4vzrA5cucmermNBgl50MomYCjqwiEoGbM4bM3Qt0OxW+
         jjgqLICCbSPA/jd3sYCpiWjnnYQ5Dvme5tfsDiTMOvzBcZh9p1110bw7+/Ux+wxyZUmR
         xEgo8WrhU5lWf1rTtEEAkKCLvoaZQBFUq6CSju8CcwY9WqhbhFhT93tlGNWCuRis9ibz
         h2bvQ+K4uDxj+GWvnwLmCO5ergZUTAO9/zXJzDOT3Cc81KbI23WMy52SKzECOjaP7v71
         lKopOX9BMBB6qpSwNs5dh/ZzFyh4WyNobsZC2NumjBhWq/g+omTA4isEThGrU3Il8tQb
         a6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWjyeifvSwsRpNI5bt393TR+i6zbs6RUOPTBxq9kpw8=;
        b=Hfs1lqzDFX8T47c4dsngZkiZ1gMZn6+aWKyYesEV7nnb0mgN6xa1pMDNgNHLzo6TkS
         MnrZOTdtb3wgTLQCvAp32K9vkJp28yrPJfVenof9S5M8edoK5dEDyf0yS5S3aU1de76O
         Uv5YPK61gJoI7NTCCRP0EVx8Ij+x6EAVtm7FmTnFV3maQ0ev0OUa9row9lFUKIGHWuPi
         /tIP6rWRif6IEaqG4BZxk8BYrez5pxJ96xxBzyfevF+R3ELOnlya+giFrcHrO+u8/vTs
         8nlBg7uI5hRgSSS50W/OyReG97V6EkLKFaqM56RS2mqxUn5i/scusqJep7IH50TcnEde
         GXHA==
X-Gm-Message-State: AOAM532Uoz39ZokRZZT5q0ZexvsFLcnCLIwNn4a/QKN+0rO4ByksxGvi
        gbxA2MHZPSaaJgyWB8ksIUdq+qUZcwozMZMO9VBZ1A==
X-Google-Smtp-Source: ABdhPJwtgioO16asUFHaShqSlxtaZ8WR8+eLYHmxioCs94wY0t5VnpsiMOilaXZuEgd6GY7yhlUswECBEu2xdICu6Do=
X-Received: by 2002:a19:cc42:: with SMTP id c63mr116521lfg.521.1606871521372;
 Tue, 01 Dec 2020 17:12:01 -0800 (PST)
MIME-Version: 1.0
References: <20201130233504.3725241-1-axelrasmussen@google.com>
 <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com>
 <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com>
 <xr93lfehl8al.fsf@gthelen.svl.corp.google.com> <CALvZod4j9fFpGRfkios1ef0D5qhyw3XA_VSVm0k__RuMG1Qhwg@mail.gmail.com>
 <CAJHvVchcm_HLd1RaibCZDZi27_2CVCwUWDX515dvnPPyTpHBHw@mail.gmail.com>
 <CALvZod5CpPhvzB99VZTc33Sb5YCbJNHFe3k33k+HwNfJvJbpJQ@mail.gmail.com>
 <CAJHvVcjBErccEwNjuDqzsrbuzSmJva7uknZKhtBwWfs9_t4zTg@mail.gmail.com>
 <CALvZod6qpbEX+kp_gh5O4U1-kc+DfoG4DnGoWMvVnuXUOTLBBg@mail.gmail.com> <20201201200715.6171d39b@oasis.local.home>
In-Reply-To: <20201201200715.6171d39b@oasis.local.home>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 1 Dec 2020 17:11:50 -0800
Message-ID: <CALvZod5mAtes0T5DFCgjU+CKVBVOdYc=jPFHXvAU+LzDqGXomg@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Tejun Heo <tj@kernel.org>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <walken@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yafang Shao <laoar.shao@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, dsahern@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>, liuhangbin@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 5:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 1 Dec 2020 16:36:32 -0800
> Shakeel Butt <shakeelb@google.com> wrote:
>
> > SGTM but note that usually Andrew squash all the patches into one
> > before sending to Linus. If you plan to replace the path buffer with
> > integer IDs then no need to spend time fixing buffer related bug.
>
> I don't think Andrew squashes all the patches. I believe he sends Linus
> a patch series.

I am talking about the patch and the following fixes to that patch.
Those are usually squashed into one patch.
