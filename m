Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8CA2F1DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390425AbhAKS0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:26:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbhAKS0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:26:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8136E2250E;
        Mon, 11 Jan 2021 18:25:29 +0000 (UTC)
Date:   Mon, 11 Jan 2021 18:25:27 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com
Subject: Re: [PATCH] arm64: Kconfig: Increase NR_CPUS default to 512
Message-ID: <20210111182526.GB17941@gaia>
References: <20210110053615.3594358-1-vanshikonda@os.amperecomputing.com>
 <20210111105636.GA7071@willie-the-truck>
 <20210111175741.ldifmv7uhdekbq5d@con01sys-r111.scc-lab.amperecomputing.com>
 <fb9542df-19cf-4db7-d112-0917e5b65e9f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9542df-19cf-4db7-d112-0917e5b65e9f@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:03:18AM -0800, Randy Dunlap wrote:
> On 1/11/21 9:57 AM, Vanshidhar Konda wrote:
> > On Mon, Jan 11, 2021 at 10:56:36AM +0000, Will Deacon wrote:
> >> On Sat, Jan 09, 2021 at 09:36:15PM -0800, vanshikonda@os.amperecomputing.com wrote:
> >>> From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> >>>
> >>> Increase the default value of NR_CPUS to 512 from 256. This will
> >>> enable the defconfig kernel to support platforms that have upto
> >>> 512 cores.
> >>
> >> Do we already support such a platform, and what is it? I'm fine with bumping.
> >> the number, it's just nice to be able to say specifically _why_ we're dong
> >> it.
> > 
> > I'm not aware of any publicly available systems that run into the 256
> > core limitation. At Ampere we have internal systems that would benefit
> > from this change as they support more than 256 cores.
> 
> But what does that have to do with the default value?
> Do you expect to run defconfig kernels?
> I don't ever expect that.

We still aim for the arm64 defconfig to run on all supported SoCs, even
if not optimally. Distros indeed tweak the config to their needs.

-- 
Catalin
