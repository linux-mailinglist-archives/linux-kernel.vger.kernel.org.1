Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320512DCFE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgLQK4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:56:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgLQK4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:56:09 -0500
Date:   Thu, 17 Dec 2020 10:55:25 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] arm64: topology: Avoid the have_policy check
Message-ID: <20201217105524.GA15336@gaia>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
 <20201217075732.blac5pbca7prmuum@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217075732.blac5pbca7prmuum@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Thu, Dec 17, 2020 at 01:27:32PM +0530, Viresh Kumar wrote:
> On 15-12-20, 11:04, Viresh Kumar wrote:
> > Every time I have stumbled upon this routine, I get confused with the
> > way 'have_policy' is used and I have to dig in to understand why is it
> > so. Here is an attempt to make it easier to understand, and hopefully it
> > is an improvement.
> > 
> > The 'have_policy' check was just an optimization to avoid writing
> > to amu_fie_cpus in case we don't have to, but that optimization itself
> > is creating more confusion than the real work. Lets just do that if all
> > the CPUs support AMUs. It is much cleaner that way.
> > 
> > Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V3:
> > - Added Reviewed by tag.
> 
> Catalin, please pick the first two patches for 5.11. I will send the
> last one separately later on.

I haven't figured out whether these are fixes (a cover letter would
help ;)). They look like generic improvements to me and given that we
are already in the 5.11 merging window, they would probably need to wait
until 5.12.

-- 
Catalin
