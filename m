Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0722B1C0307
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgD3QsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 12:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgD3QsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:48:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB7332070B;
        Thu, 30 Apr 2020 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588265281;
        bh=axoYz9ubvidu6Q4qb8tE1iZySwHLJ5aESX8frhVyuiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ca/g0WoiwN4MNpRo23zI84MuVdc3f57axAaaKLI+X0I8yCH2/jidRQBKHbK8Kj0le
         p0ifJPTxniAeJNPxdDSQ3sL1FcGdRO8dvdmXF6bViBXQY+Fl9+SUzjn0eh/2hXocYc
         SNXgDN/8PRduyw3CCDEyv20e7Bjs+BAm0Et0exUw=
Date:   Thu, 30 Apr 2020 17:47:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, maz@kernel.org, suzuki.poulose@arm.com,
        James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 00/16] arm64/cpufeature: Introduce ID_PFR2, ID_DFR1,
 ID_MMFR5 and other changes
Message-ID: <20200430164756.GH25258@willie-the-truck>
References: <1586857710-17154-1-git-send-email-anshuman.khandual@arm.com>
 <6749304e-8a4d-f4b9-eb40-91f0dd13166e@arm.com>
 <20200429212614.GD8604@willie-the-truck>
 <da15c0f0-f8ec-c2bc-bd5b-907a75119dc1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da15c0f0-f8ec-c2bc-bd5b-907a75119dc1@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 08:29:44AM +0530, Anshuman Khandual wrote:
> On 04/30/2020 02:56 AM, Will Deacon wrote:
> > On Wed, Apr 29, 2020 at 03:07:15PM +0530, Anshuman Khandual wrote:
> >> On 04/14/2020 03:18 PM, Anshuman Khandual wrote:
> >>> Changes in V2:
> >>>
> >>> - Added Suggested-by tag from Mark Rutland for all changes he had proposed
> >>> - Added comment for SpecSEI feature on why it is HIGHER_SAFE per Suzuki
> >>> - Added a patch which makes ID_AA64DFR0_DOUBLELOCK a signed feature per Suzuki
> >>> - Added ID_DFR1 and ID_MMFR5 system register definitions per Will
> >>> - Added remaining features bits for relevant 64 bit system registers per Will
> >>> - Changed commit message on [PATCH 5/7] regarding TraceFilt feature per Suzuki
> >>> - Changed ID_PFR2.CSV3 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will
> >>> - Changed ID_PFR0.CSV2 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will 
> >>> - Changed some commit messages
> >>
> >> Just a gentle ping. I am wondering if you had a chance to glance
> >> through this updated series.
> > 
> > Please can you resend based on for-next/cpufeature?
> 
> Sure, will do.

Thanks. I'll keep an eye out for them.

Will
