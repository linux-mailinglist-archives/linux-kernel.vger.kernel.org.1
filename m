Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F762FB8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392692AbhASN2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:28:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38586 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391542AbhASNS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:18:57 -0500
Received: from zn.tnic (p200300ec2f0bca001beaf3e1446171b7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:1bea:f3e1:4461:71b7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA0741EC05F1;
        Tue, 19 Jan 2021 14:17:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611062279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=49X+dnnC4B/ABzZM6fYCQbbb7PQaNSr+M45P48fRRVo=;
        b=gfC4JVAPrd2rAZJy0ufv7U7FyT3q2WPsF7fWGSPqwSHylSY5cHS0PWdNGCWfrHTcpixcGX
        Xw4WPkYm3w6ND3AMHt+knar/UAOwijkUEBnNn2ANOrQJf8hNHq32QFHPyupYOj83o3Molu
        aUGwQp4TCwKJ6Og3MvYkAgOVGvWwb18=
Date:   Tue, 19 Jan 2021 14:17:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Jonathan Lemon <bsd@fb.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [x86/mce]  7bb39313cd:  netperf.Throughput_tps -4.5% regression
Message-ID: <20210119131759.GL27433@zn.tnic>
References: <20210112142109.GE30747@xsang-OptiPlex-9020>
 <20210112141438.GF13086@zn.tnic>
 <20210116035251.GB29609@shbuild999.sh.intel.com>
 <20210116153413.GP2743@paulmck-ThinkPad-P72>
 <20210116160921.GA101665@shbuild999.sh.intel.com>
 <20210119042721.GA12664@paulmck-ThinkPad-P72>
 <20210119100255.GC27433@zn.tnic>
 <20210119121505.GA111354@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119121505.GA111354@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 08:15:05PM +0800, Feng Tang wrote:
> On Tue, Jan 19, 2021 at 11:02:55AM +0100, Borislav Petkov wrote:
> > On Mon, Jan 18, 2021 at 08:27:21PM -0800, Paul E. McKenney wrote:
> > > I bet that the results vary depending on the type of CPU, and also on
> > > the kernel address-space layout, which of course also varies based on
> > > the Kconfig options.  Let's see how the maintainers would like to proceed.
> > 
> > So I ran the "reproduce" script in the original mail on a KBL box here
> > with the .config tailored for it:
> > 
> > cpu family      : 6
> > model           : 158
> > model name      : Intel(R) Core(TM) i5-9600K CPU @ 3.70GHz
> > stepping        : 12
> > microcode       : 0xd6
> 
> I will also try to find a similar KBL in 0day to run the job. This
> -4.5% comes from a CascadeLake AP which is 4 nodes, 96C/192T.
> 
> > and I get mixed results. But I'd need to know how exactly they generate
> > the metrics "netperf.Throughput_total_tps" and "netperf.Throughput_tps"
> > 
> > Feng?
> 
> I have to admit I'm just a dumb user of 0day :) I'll leave this question
> to Philip/Oliver/Rong who are from 0day team.
> 
> I assumed you've cloned the lkp-tests.git, and seems one Ruby file
> https://github.com/intel/lkp-tests/blob/master/stats/netperf is used to
> process the output of the netperf.

$ ../lkp-tests/stats/netperf  < rc2.log
Throughput_tps: 12759.701875000002
Throughput_total_tps: 204155.23000000004
workload: 61246569.000000015

$ ../lkp-tests/stats/netperf  < with-holdout.log
Throughput_tps: 12863.416875
Throughput_total_tps: 205814.67
workload: 61744401.00000001

So this definitely depends on the .config because in my case, *with* the
holdout patch it is better vs plain 5.11-rc2.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
