Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049442FB875
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393266AbhASMk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393150AbhASMdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:33:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 979EE22D2A;
        Tue, 19 Jan 2021 12:32:40 +0000 (UTC)
Date:   Tue, 19 Jan 2021 12:32:38 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     =?utf-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, gustavoars@kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpuinfo: Show right CPU architecture information
Message-ID: <20210119123237.GA17369@gaia>
References: <20210119105510.27836-1-zhangliguang@linux.alibaba.com>
 <20210119110131.GA18433@willie-the-truck>
 <ff3a2f25-083c-2363-5e09-4d6acf5291e7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff3a2f25-083c-2363-5e09-4d6acf5291e7@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 07:26:31PM +0800, 乱石 wrote:
> 锟斤拷 2021/1/19 19:01, Will Deacon 写锟斤拷:
> > On Tue, Jan 19, 2021 at 06:55:10PM +0800, Liguang Zhang wrote:
> > > CPU architecture is assigned to be a fixed value, it should be obtained
> > > from midr register.
> > > 
> > > Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> > > ---
> > >   arch/arm64/kernel/cpuinfo.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> > > index 77605aec25fe..0bd11e0fe9f2 100644
> > > --- a/arch/arm64/kernel/cpuinfo.c
> > > +++ b/arch/arm64/kernel/cpuinfo.c
> > > @@ -191,7 +191,7 @@ static int c_show(struct seq_file *m, void *v)
> > >   		seq_printf(m, "CPU implementer\t: 0x%02x\n",
> > >   			   MIDR_IMPLEMENTOR(midr));
> > > -		seq_printf(m, "CPU architecture: 8\n");
> > > +		seq_printf(m, "CPU architecture: %d\n", MIDR_ARCHITECTURE(midr));
> > Huh? Won't this always return 0xf?
> 
> Hi Will,
> 
> I'm not sure. My platform return 0xf, but /proc/cpuinfo show 8. Why we
> assign a fixed
> 
> value to cpu architecture?

Because 0xf first appeared on some ARMv6 CPUs (1176, 11MPcore and some
newer revisions of 1136). A field value of 0xf means don't bother with
architecture version but rather check the CPUID information for the
features you need. We decided to call it 8 here with 64-bit as that was
announced as ARMv8. A 32-bit kernel running on ARMv8 hardware would
report 7 (as it would on some ARMv6 hardware like 1176 etc.)

-- 
Catalin
