Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB942FBB51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbhASPfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391544AbhASPen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:34:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E5DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 07:33:58 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bca00ae49d9fe8335ba6f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:ae49:d9fe:8335:ba6f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8BDB1EC0608;
        Tue, 19 Jan 2021 16:33:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611070436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dKMeMKvzsrD0kIurpDZTCz5aerm1J86c9j6bD3+ekvI=;
        b=W7uNUiaZ0JNz4dHB6uEfh0QKxlZ80U3sA/6FAb/2E89KA1W4+hK2shiuELcPlx5PX4SNAy
        fturupYF0QnWbIC/oO7JPaCPPCJj7gU+3ERd/lhcy/PK2e4BEA7f3p9+x9BHzg10COFPMk
        FH1vIsOaPMqUIG/cfpYRsTghVePCqdg=
Date:   Tue, 19 Jan 2021 16:33:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Jonathan Lemon <bsd@fb.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [x86/mce]  7bb39313cd:  netperf.Throughput_tps -4.5% regression
Message-ID: <20210119153350.GM27433@zn.tnic>
References: <20210112142109.GE30747@xsang-OptiPlex-9020>
 <20210112141438.GF13086@zn.tnic>
 <20210116035251.GB29609@shbuild999.sh.intel.com>
 <20210116153413.GP2743@paulmck-ThinkPad-P72>
 <20210116160921.GA101665@shbuild999.sh.intel.com>
 <20210119042721.GA12664@paulmck-ThinkPad-P72>
 <20210119100255.GC27433@zn.tnic>
 <20210119121505.GA111354@shbuild999.sh.intel.com>
 <20210119131759.GL27433@zn.tnic>
 <20210119150903.GA21908@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119150903.GA21908@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 11:09:03PM +0800, Feng Tang wrote:
> Yes, that can happen. I started a 4 tasks netperf on a 4C/8T KBL desktop,
> and also saw around 2% improvement. Both the kernel config and the
> platform matters.

Oh great. ;-\

> For the performance changes I have checked, sometimes the change can be
> reproduced on platforms of different generations (the exact delta number
> may differs), sometimes it can only be reproduced on one specific platform,
> like some old generation, or special one like Xeon Phi.

Probably because that Xeon Phi thing is not as powerful cache-wise as
some newer ones which have bigger caches and smarter hw prefetchers,
etc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
