Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5439225B435
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 21:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgIBTDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 15:03:21 -0400
Received: from foss.arm.com ([217.140.110.172]:44940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBTDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:03:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57F1F1045;
        Wed,  2 Sep 2020 12:03:13 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACB313F71F;
        Wed,  2 Sep 2020 12:03:09 -0700 (PDT)
Date:   Wed, 2 Sep 2020 20:03:06 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 0/3] arm64: Convert to ARCH_STACKWALK
Message-ID: <20200902190306.GB5875@C02TD0UTHF1T.local>
References: <20200819124913.37261-1-broonie@kernel.org>
 <20200901160626.GE95447@C02TD0UTHF1T.local>
 <20200902173803.GE6162@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902173803.GE6162@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 06:38:03PM +0100, Mark Brown wrote:
> On Tue, Sep 01, 2020 at 05:06:26PM +0100, Mark Rutland wrote:
> 
> > Just to check, has the skipping logic been tested to work equivalently
> > to what we had before? By inspection I think it should, but since it
> > relies on function call boundaries it always strikes me as fragile.
> 
> > If you could confirm that (e.g. with LKDTM perhaps?) that'd be great.
> > Assuming that looks right, for the series:
> 
> I've tested this with LKDTM and otherwise and didn't spot any issues
> (and just did a bit of retesting) but it is a pretty manual process so
> it's possible I missed something.

It looks like the case Mirolav pointed out (self-bactrace with NULL
regs) isn't triggered by LKDTM (since it always causes a backtrace from
an exception with non-NULL regs), but we do rely on that elsewhere in
the kernel.

It might be worth adding an LKDTM test to trigger that.

I'll wait for a respin that handles that -- please drop the ack for now.

Thanks,
Mark.
