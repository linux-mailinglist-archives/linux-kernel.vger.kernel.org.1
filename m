Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7769E2B8915
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 01:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgKSAgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 19:36:35 -0500
Received: from m12-16.163.com ([220.181.12.16]:50049 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgKSAge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 19:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=uuTNk
        X4w4whaUppnGa6dLIJ8adhUbiVRgvm2GnpTQwA=; b=G4kcmMBwIvxZfeiyP42sS
        aG3hpeeI7zUj0tnH+NrywU3D0XBv909E+JisbJoL3x+4b9PiL3wVQRxWbBG+OAkv
        EDT45EiYmyiZzsHe6X8UV9JIMPl7n59aTMVuH5FFIe8QCvyeBpIo89/h5sORWwq0
        pP4UgzhsfPCscdA1q+uIoI=
Received: from localhost (unknown [122.194.9.227])
        by smtp12 (Coremail) with SMTP id EMCowABnqExBvbVf1vnwMg--.23293S2;
        Thu, 19 Nov 2020 08:33:05 +0800 (CST)
Date:   Thu, 19 Nov 2020 08:33:19 +0800
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
Message-ID: <20201119003319.GA6805@geo.homenetwork>
References: <17fc60a3-cc50-7cff-eb46-904c2f0c416e@canonical.com>
 <20201118235015.GB6015@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118235015.GB6015@geo.homenetwork>
X-CM-TRANSID: EMCowABnqExBvbVf1vnwMg--.23293S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFW5tFyfurW5KFWxGrWfXwb_yoW8Cr1fpF
        WkWFW3Kr1DGr18J397Kw4Fva4qqws5J34ruwn5G34rCFZ09r1avr9293ya9FsI9Fn7KF10
        yrs0va4YvayUAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_9NVkUUUUU=
X-Originating-IP: [122.194.9.227]
X-CM-SenderInfo: vwr2x0rx6rljoofrz/1tbiXALhllXlxy9e0wAAs8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 07:50:15AM +0800, Tao Zhou wrote:
> On Wed, Nov 18, 2020 at 07:56:38PM -0300, Guilherme G. Piccoli wrote:
> > Hi Vincent (and all CCed), I'm sorry to ping about such "old" patch, but
> > we experienced a similar condition to what this patch addresses; it's an
> > older kernel (4.15.x) but when suggesting the users to move to an
> > updated 5.4.x kernel, we noticed that this patch is not there, although
> > similar ones are (like [0] and [1]).
> > 
> > So, I'd like to ask if there's any particular reason to not backport
> > this fix to stable kernels, specially the longterm 5.4. The main reason
> > behind the question is that the code is very complex for non-experienced
> > scheduler developers, and I'm afraid in suggesting such backport to 5.4
> > and introduce complex-to-debug issues.
> > 
> > Let me know your thoughts Vincent (and all CCed), thanks in advance.
> > Cheers,
> > 
> > 
> > Guilherme
> > 
> > 
> > P.S. For those that deleted this thread from the email client, here's a
> > link:
> > https://lore.kernel.org/lkml/20200513135528.4742-1-vincent.guittot@linaro.org/
> > 
> > 
> > [0]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fe61468b2cb
> > 
> > [1]
> > https://lore.kernel.org/lkml/20200506141821.GA9773@lorien.usersys.redhat.com/
> > <- great thread BTW!
> 
> 'sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list" failed to apply to
> 5.4-stable tree'
> 
> You could check above. But I do not have the link about this. Can't search it
> on LKML web: https://lore.kernel.org/lkml/
> 
> BTW: 'ouwen210@hotmail.com' and 'zohooouoto@zoho.com.cn' all is myself.
> 
> Sorry for the confusing..
> 
> Thanks.

Sorry again. I forget something. It is in the stable.

Here it is:

  https://lore.kernel.org/stable/159041776924279@kroah.com/

