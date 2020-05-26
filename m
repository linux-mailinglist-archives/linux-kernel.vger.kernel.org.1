Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF9E1AAEFD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404611AbgDORAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbgDORAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:00:35 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AE31206F9;
        Wed, 15 Apr 2020 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970034;
        bh=MgOckoa6oaXylsn5YDxRnw+SO2S8/uU9ZQM4CMMYhm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cp7XRASHgNQMYStqM9ccE+H4cbmpnvWsouW1/UcDJzRy7Tj4nwWnYlg5nCtAE246T
         bvnQx6CzbbqsPvaDF8ASoMzrXi3scNKrNh/PmIe+hw+3dcNqI/VHdWiAfYOEXE8JtC
         JaG0B9RXKq7wg2MukI0p2o4VLkjDuFNms4+4269M=
Date:   Wed, 15 Apr 2020 18:00:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com
Subject: Re: [PATCH 3/8] arm64: cpufeature: Add CPU capability for AArch32
 EL1 support
Message-ID: <20200415170029.GA19615@willie-the-truck>
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-4-will@kernel.org>
 <1b76993491176577567a0960a435dac0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b76993491176577567a0960a435dac0@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Wed, Apr 15, 2020 at 09:55:57AM +0100, Marc Zyngier wrote:
> On 2020-04-14 22:31, Will Deacon wrote:
> > Although we emit a "SANITY CHECK" warning and taint the kernel if we
> > detect a CPU mismatch for AArch32 support at EL1, we still online the
> > CPU with disastrous consequences for any running 32-bit VMs.
> > 
> > Introduce a capability for AArch32 support at EL1 so that late onlining
> > of incompatible CPUs is forbidden.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> Definitely an improvement over the current situation, as the direct read
> of ID_AA64PFR0 was always a bit dodgy. Given that I'm pretty sure these new
> braindead SoCs are going to run an older version of the kernel, should we
> Cc stable for this?

I don't think there's a real need for -stable given that we do at least
taint the kernel. That's likely to annoy vendors enough to backport this
themselves ;)

Will
