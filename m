Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0A32F32F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbhALO1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:27:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbhALO1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:27:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3DE52312D;
        Tue, 12 Jan 2021 14:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610461629;
        bh=/eN3KoLz22U1MG1qJgPw2OYCxxPzd1K/ODjHtsXMphI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ja8kyZGvcx4qgPbScf0gV2J8dQiRInzFqM3ZXY2FTIfDEuBaXeTVv0MKbNPB7aBVG
         719SrKgdh/PJv2XMVDrdM71WxkVKFaedgYLGJy2Ny53qXhElQpa2dP2+CFLmn7oMAY
         21cvUJSbcu2yDQYM4j5NUPhb8qyIFitglyZ0RCa560gHNnz5lkpmRlgY6WwqmitaWH
         1VBLPQOr2jQPP1OwTakdPn1JfmbFUFkN43T0qMJNVLk6lokrpcB7xEka/JQGTngsDM
         fCQKuS3wBuJg/l97OEh4Bd33hhoSnuBwuiQsJYk1e4PRGn8zCoK/NIQRqW0C6vggqH
         YNMibbCNOT3IQ==
Date:   Tue, 12 Jan 2021 14:27:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com
Subject: Re: [PATCH] arm64: Kconfig: Increase NR_CPUS default to 512
Message-ID: <20210112142705.GB9524@willie-the-truck>
References: <20210110053615.3594358-1-vanshikonda@os.amperecomputing.com>
 <20210111105636.GA7071@willie-the-truck>
 <20210111175741.ldifmv7uhdekbq5d@con01sys-r111.scc-lab.amperecomputing.com>
 <fb9542df-19cf-4db7-d112-0917e5b65e9f@infradead.org>
 <20210111182526.GB17941@gaia>
 <20210112052003.eeg725mmnyv67eop@con01sys-r111.scc-lab.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112052003.eeg725mmnyv67eop@con01sys-r111.scc-lab.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 09:20:03PM -0800, Vanshidhar Konda wrote:
> On Mon, Jan 11, 2021 at 06:25:27PM +0000, Catalin Marinas wrote:
> > On Mon, Jan 11, 2021 at 10:03:18AM -0800, Randy Dunlap wrote:
> > > On 1/11/21 9:57 AM, Vanshidhar Konda wrote:
> > > > On Mon, Jan 11, 2021 at 10:56:36AM +0000, Will Deacon wrote:
> > > >> On Sat, Jan 09, 2021 at 09:36:15PM -0800, vanshikonda@os.amperecomputing.com wrote:
> > > >>> From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> > > >>>
> > > >>> Increase the default value of NR_CPUS to 512 from 256. This will
> > > >>> enable the defconfig kernel to support platforms that have upto
> > > >>> 512 cores.
> > > >>
> > > >> Do we already support such a platform, and what is it? I'm fine with bumping.
> > > >> the number, it's just nice to be able to say specifically _why_ we're dong
> > > >> it.
> > > >
> > > > I'm not aware of any publicly available systems that run into the 256
> > > > core limitation. At Ampere we have internal systems that would benefit
> > > > from this change as they support more than 256 cores.
> > > 
> > > But what does that have to do with the default value?
> > > Do you expect to run defconfig kernels?
> > > I don't ever expect that.
> > 
> > We still aim for the arm64 defconfig to run on all supported SoCs, even
> > if not optimally. Distros indeed tweak the config to their needs.
> 
> Would "all supported SoCs" mean only SoCs that are currently available
> publicly? Could we include support for SoCs/systems in development but
> to be available publicly in the next few years?

I don't really see the need to rush that into defconfig, so I'd prefer
to make the update when something actually exists otherwise it's really
hard to keep track of why we made the decision (especially as unreleased
hardware is liable to change).

Will
