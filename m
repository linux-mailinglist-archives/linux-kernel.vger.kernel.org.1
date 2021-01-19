Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DDF2FB71F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390055AbhASKT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:19:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59192 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389404AbhASKDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:03:43 -0500
Received: from zn.tnic (p200300ec2f0bca00060d4a1f80a80a6a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:60d:4a1f:80a8:a6a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B130E1EC05C2;
        Tue, 19 Jan 2021 11:03:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611050581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Vocl3Ia+wSuccgEhvsNZoOTMpNvciTGDXG8v1K0TYzs=;
        b=RQc+aG1pNsqIeTfc7ZRE/IraIwQje9sGfckE6U5Mztkoz9Tl/cDGWQQUBhyjyAJhB8eRu/
        5vatIaei12FT5WQ3IiekhwaunRGWk+MaQi3VTfzUgP4MgUbXMoMT0TT5D6sPX47KUyknUd
        0Xrg89/q3w9qR190fptK6njY9wGX8VI=
Date:   Tue, 19 Jan 2021 11:02:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jonathan Lemon <bsd@fb.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [x86/mce]  7bb39313cd:  netperf.Throughput_tps -4.5% regression
Message-ID: <20210119100255.GC27433@zn.tnic>
References: <20210112142109.GE30747@xsang-OptiPlex-9020>
 <20210112141438.GF13086@zn.tnic>
 <20210116035251.GB29609@shbuild999.sh.intel.com>
 <20210116153413.GP2743@paulmck-ThinkPad-P72>
 <20210116160921.GA101665@shbuild999.sh.intel.com>
 <20210119042721.GA12664@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119042721.GA12664@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:27:21PM -0800, Paul E. McKenney wrote:
> I bet that the results vary depending on the type of CPU, and also on
> the kernel address-space layout, which of course also varies based on
> the Kconfig options.  Let's see how the maintainers would like to proceed.

So I ran the "reproduce" script in the original mail on a KBL box here
with the .config tailored for it:

cpu family      : 6
model           : 158
model name      : Intel(R) Core(TM) i5-9600K CPU @ 3.70GHz
stepping        : 12
microcode       : 0xd6

and I get mixed results. But I'd need to know how exactly they generate
the metrics "netperf.Throughput_total_tps" and "netperf.Throughput_tps"

Feng?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
