Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57101EF9F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 16:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgFEOGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 10:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgFEOGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:06:33 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6F8C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3646+nLfQNB1TESO4RVGCLY9LYs5rMvIB3rw1pnYSU8=; b=24/s0S7879gySR/FmN/u7FND91
        f1N7ToulvAIFplRet12L9lK1cliyd4euZm6tTDUazi8qkZrpHzjtya4OvCdBkYOY+K+I/IDb/WcLZ
        MY5l7iaVCUbtctX2cg59+ZfrRlI3xBYajFLmhMwG4m1y/iyMl/yL5Q4WrzcTjqOU69i/IMqex0b4A
        +icQc/XM37OL/4GshMXhxYflgQLSXEceptaBxryvYbmF98Pk70pWycXYAcbS43usFWbJkcXbTJJ+Q
        p6YfrhxfgMSPpCy4TC/Cp+pHIAzD6fqdcBeutmyfgDm2YYHk2IyN+1JQsH1r+sGgzKQcc1l3kk8jZ
        takv0BLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhCyN-0002yk-5a; Fri, 05 Jun 2020 14:05:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2F6D301ABC;
        Fri,  5 Jun 2020 16:05:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCAA821A74B45; Fri,  5 Jun 2020 16:05:21 +0200 (CEST)
Date:   Fri, 5 Jun 2020 16:05:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Yuqi Jin <jinyuqi@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jiong Wang <jiongwang@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [net] a6211caa63:
 dmesg.UBSAN:signed-integer-overflow_in_arch/x86/include/asm/atomic.h
Message-ID: <20200605140521.GD4117@hirez.programming.kicks-ass.net>
References: <20200605080929.GK12456@shao2-debian>
 <CANn89iK1EfAqw-SkXyQR=88fKnBpXCcR_FaiFkVDUNazNgAX1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iK1EfAqw-SkXyQR=88fKnBpXCcR_FaiFkVDUNazNgAX1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 06:17:51AM -0700, Eric Dumazet wrote:
> On Fri, Jun 5, 2020 at 1:10 AM kernel test robot <rong.a.chen@intel.com> wrote:

> There you go.
> 
> We decided this was a bogus report, and that UBSAN requires sane compilers.
> 
> Please read the fine comment that was added in this commit and update
> your compiler or do not mess with compiler flags.
> 
> +       /* If UBSAN reports an error there, please make sure your compiler
> +        * supports -fno-strict-overflow before reporting it that was a bug
> +        * in UBSAN, and it has been fixed in GCC-8.
> +        */
> +       return atomic_add_return(segs + delta, p_id) - segs;

> >         make HOSTCC=gcc-4.9 CC=gcc-4.9 ARCH=i386 olddefconfig prepare modules_prepare bzImage

Rong, can you make sure to exclude gcc<8 for UBSAN reports ?
