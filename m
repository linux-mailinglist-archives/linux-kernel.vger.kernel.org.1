Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D5125D9B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgIDNep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 09:34:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:59172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730443AbgIDNaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:30:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7267AC19;
        Fri,  4 Sep 2020 13:29:33 +0000 (UTC)
Date:   Fri, 4 Sep 2020 15:30:01 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     ltp@lists.linux.it,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [LTP] [PATCH] syscall/ptrace08: Simplify the test.
Message-ID: <20200904133001.GA9091@yuki.lan>
References: <20200904115817.8024-1-chrubis@suse.cz>
 <20200904132121.GE4768@mussarela>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904132121.GE4768@mussarela>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> This is failing on our 4.4 and 4.15 kernels, though they passed with the
> previous test and have commit f67b15037a7a applied.
> 
> So, this is dependent on some other behavior/commit that has changed. It passes
> on 5.4, for example. I'll try to investigate further.

We are looking at it now in SUSE, looks like the initial fix to the
kernel postponed the check to the write to the dr7 that enabled the
breakpoint, so when the dr0 wasn't enabled you could write anything
there.

Also looks like somehow the EINVAL is not propagated into the POKEUSER
call to the dr7 as it should have been.

-- 
Cyril Hrubis
chrubis@suse.cz
