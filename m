Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8EC2F32C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbhALOP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbhALOP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:15:28 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52458C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:14:48 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e8c004f0317ef2d68091d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8c00:4f03:17ef:2d68:91d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA1FA1EC0472;
        Tue, 12 Jan 2021 15:14:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610460885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hngORQgRG46QizXwWrP2zHg2kjdLhdRg1OBJMju8KYI=;
        b=mYIyGVoKQfsLI67uWiDlasNdLA69eE1ZXhHBk3BaKMOmPWZUxfz2gnZWKIx4CSAbJcOQRk
        MZa3627NRyKGCd3ReUzQu7sx52TU2AeMfdDNx8EEyBDSBaBtSZljeLosObEGixqB/PJgZ2
        benk2sNsrcExVJe2qLGV+vB9nX+JuTQ=
Date:   Tue, 12 Jan 2021 15:14:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Lemon <bsd@fb.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com
Subject: Re: [x86/mce]  7bb39313cd:  netperf.Throughput_tps -4.5% regression
Message-ID: <20210112141438.GF13086@zn.tnic>
References: <20210112142109.GE30747@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112142109.GE30747@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:21:09PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -4.5% regression of netperf.Throughput_tps due to commit:
> 
> 
> commit: 7bb39313cd6239e7eb95198950a02b4ad2a08316 ("x86/mce: Make mce_timed_out() identify holdout CPUs")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git ras/core
> 
> 
> in testcase: netperf
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 16
> 	cluster: cs-localhost
> 	test: TCP_CRR
> 	cpufreq_governor: performance
> 	ucode: 0x5003003
> 
> test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> test-url: http://www.netperf.org/netperf/

I'm very very sceptical this thing benchmarks #MC exception handler
performance. Because the code this patch adds gets run only during a MCE
exception.

So unless I'm missing something obvious please check your setup.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
