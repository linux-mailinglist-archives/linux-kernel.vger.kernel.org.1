Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABACC2CB214
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgLBBID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgLBBIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:08:02 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06FB420BED;
        Wed,  2 Dec 2020 01:07:17 +0000 (UTC)
Date:   Tue, 1 Dec 2020 20:07:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shakeel Butt <shakeelb@google.com>
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
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
Message-ID: <20201201200715.6171d39b@oasis.local.home>
In-Reply-To: <CALvZod6qpbEX+kp_gh5O4U1-kc+DfoG4DnGoWMvVnuXUOTLBBg@mail.gmail.com>
References: <20201130233504.3725241-1-axelrasmussen@google.com>
        <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com>
        <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com>
        <xr93lfehl8al.fsf@gthelen.svl.corp.google.com>
        <CALvZod4j9fFpGRfkios1ef0D5qhyw3XA_VSVm0k__RuMG1Qhwg@mail.gmail.com>
        <CAJHvVchcm_HLd1RaibCZDZi27_2CVCwUWDX515dvnPPyTpHBHw@mail.gmail.com>
        <CALvZod5CpPhvzB99VZTc33Sb5YCbJNHFe3k33k+HwNfJvJbpJQ@mail.gmail.com>
        <CAJHvVcjBErccEwNjuDqzsrbuzSmJva7uknZKhtBwWfs9_t4zTg@mail.gmail.com>
        <CALvZod6qpbEX+kp_gh5O4U1-kc+DfoG4DnGoWMvVnuXUOTLBBg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 16:36:32 -0800
Shakeel Butt <shakeelb@google.com> wrote:

> SGTM but note that usually Andrew squash all the patches into one
> before sending to Linus. If you plan to replace the path buffer with
> integer IDs then no need to spend time fixing buffer related bug.

I don't think Andrew squashes all the patches. I believe he sends Linus
a patch series.

Andrew?

-- Steve
