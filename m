Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAD41E4664
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 16:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbgE0Ots (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 10:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387942AbgE0Ots (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:49:48 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD6EC207D8;
        Wed, 27 May 2020 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590590987;
        bh=9QBFIZ7tMm3t2h8fOc4Ro7g4pDUA7x4zvv3HpsR2W48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hNdtzSApgRkxJv4p2WSM2Dopbs9pjHp8zXC85sqlwcGDDXabQdkgSQo90r9OpVW1Y
         gVDxo+7vxCtCwFwDNS9LsBHyWemioRiCr19rUroWhvN4y8xF5cZahfILOcaUllDvjS
         rRak0V+KDsxdCHrw2gD1wTjhfRTR6iDDdmi3rh4Q=
Date:   Wed, 27 May 2020 23:49:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ziqian SUN <zsun@redhat.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH -tip V6 0/6] kprobes: Fixes mutex, rcu-list warnings and
 cleanups
Message-Id: <20200527234941.a15490ee50669812df8183dc@kernel.org>
In-Reply-To: <158927054236.27680.18209720730136003586.stgit@devnote2>
References: <158927054236.27680.18209720730136003586.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Oops, I missed Jiri in loop.)

Hi Ingo,

Could you take this series?
These are not adding any feature, but fixing real bugs.

Thank you,

On Tue, 12 May 2020 17:02:22 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Ingo,
> 
> Here is the 6th version of the series for kprobes. The previous
> version is here.
> 
>  https://lore.kernel.org/lkml/158583483116.26060.10517933482238348979.stgit@devnote2/
> 
> In this version, I picked 2 patches[1][2] which has been reviewed
> on LKML but not merged to tip tree yet.
> 
> [1] https://lore.kernel.org/lkml/20200408164641.3299633-1-jolsa@kernel.org/
> [2] https://lore.kernel.org/lkml/20200507185733.GA14931@embeddedor/
> 
> You can also pull this series from kprobes/core branch from
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/
> 
> Thank you,
> 
> ---
> 
> Gustavo A. R. Silva (1):
>       kprobes: Replace zero-length array with flexible-array
> 
> Jiri Olsa (1):
>       kretprobe: Prevent triggering kretprobe from within kprobe_flush_task
> 
> Masami Hiramatsu (4):
>       kprobes: Suppress the suspicious RCU warning on kprobes
>       kprobes: Use non RCU traversal APIs on kprobe_tables if possible
>       kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
>       kprobes: Remove redundant arch_disarm_kprobe() call
> 
> 
>  arch/x86/kernel/kprobes/core.c |   16 ++--------
>  include/linux/kprobes.h        |    6 +++-
>  kernel/kprobes.c               |   61 +++++++++++++++++++++++++++++++---------
>  3 files changed, 56 insertions(+), 27 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
