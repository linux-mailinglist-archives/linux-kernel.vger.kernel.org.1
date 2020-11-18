Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412832B88CE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgKRXv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:51:57 -0500
Received: from m12-14.163.com ([220.181.12.14]:33427 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbgKRXv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=9pqaT
        Qp4Vb5INsN8AW1OxXTjIEtfHbwuFt3hkNTEU2M=; b=MJOHMPKsveQ+/y2u8nfNP
        QIJfNBjB3e+Ljr/mZeIWHjhS3ExCdXoSWdOP6qfHECp/fpQhzTRPIYeq2o3Le//V
        bYarg7toNQfh4bes5Cu7c33ous2Z+53ufuuFaC0sxpXdrY8J1Q2ir+PgHQoLh0p5
        h9dPkf1nROHE3cRnOk067c=
Received: from localhost (unknown [122.194.9.203])
        by smtp10 (Coremail) with SMTP id DsCowABXf_sos7VfGZ44Wg--.37073S2;
        Thu, 19 Nov 2020 07:50:01 +0800 (CST)
Date:   Thu, 19 Nov 2020 07:50:15 +0800
From:   Tao Zhou <t1zhou@163.com>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     vincent.guittot@linaro.org, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        zohooouoto@zoho.com.cn, mgorman@suse.de, mingo@redhat.com,
        ouwen210@hotmail.com, pauld@redhat.com, peterz@infradead.org,
        pkondeti@codeaurora.org, rostedt@goodmis.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Gavin Guo <gavin.guo@canonical.com>, halves@canonical.com,
        nivedita.singhvi@canonical.com, linux-kernel@vger.kernel.org,
        t1zhou@163.com
Subject: Re: [PATCH v3] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
Message-ID: <20201118235015.GB6015@geo.homenetwork>
References: <17fc60a3-cc50-7cff-eb46-904c2f0c416e@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17fc60a3-cc50-7cff-eb46-904c2f0c416e@canonical.com>
X-CM-TRANSID: DsCowABXf_sos7VfGZ44Wg--.37073S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr18ZF1UXr1DJF1fAr4ruFg_yoW8Wr1fpF
        4kWrW3Gr1DGr1xJ3ykGw4Sva4DXws5JrWa93Z5G34rCFWYqr9FvryI939I9FZI9F97KFy0
        yFsFva45ta4DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zM_ManUUUUU=
X-Originating-IP: [122.194.9.203]
X-CM-SenderInfo: vwr2x0rx6rljoofrz/1tbiygngllQHKOCYqgAAsc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 07:56:38PM -0300, Guilherme G. Piccoli wrote:
> Hi Vincent (and all CCed), I'm sorry to ping about such "old" patch, but
> we experienced a similar condition to what this patch addresses; it's an
> older kernel (4.15.x) but when suggesting the users to move to an
> updated 5.4.x kernel, we noticed that this patch is not there, although
> similar ones are (like [0] and [1]).
> 
> So, I'd like to ask if there's any particular reason to not backport
> this fix to stable kernels, specially the longterm 5.4. The main reason
> behind the question is that the code is very complex for non-experienced
> scheduler developers, and I'm afraid in suggesting such backport to 5.4
> and introduce complex-to-debug issues.
> 
> Let me know your thoughts Vincent (and all CCed), thanks in advance.
> Cheers,
> 
> 
> Guilherme
> 
> 
> P.S. For those that deleted this thread from the email client, here's a
> link:
> https://lore.kernel.org/lkml/20200513135528.4742-1-vincent.guittot@linaro.org/
> 
> 
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fe61468b2cb
> 
> [1]
> https://lore.kernel.org/lkml/20200506141821.GA9773@lorien.usersys.redhat.com/
> <- great thread BTW!

'sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list" failed to apply to
5.4-stable tree'

You could check above. But I do not have the link about this. Can't search it
on LKML web: https://lore.kernel.org/lkml/

BTW: 'ouwen210@hotmail.com' and 'zohooouoto@zoho.com.cn' all is myself.

Sorry for the confusing..

Thanks.

