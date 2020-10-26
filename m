Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12D72988A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772019AbgJZIks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770824AbgJZIks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:40:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 936BF223B0;
        Mon, 26 Oct 2020 08:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603701647;
        bh=YlW8Xfo2Ltbkr7uYAZDLILOKVIUBJu0dIhiivmcrF5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=be0fL6klQ1i17YKh1rgUP8AO06fLg+wyrobdNWQFnYBzf1MJhuHWIxISVF0jXHp+H
         NBj6ex6BF+/2ERzeyDvxH7N4DB4bODRJNn2yGlS/BMnCWRK8rvX6aVcdY1q1NXX4q8
         /LPJpQgHD9EKyvuAp+fVcwh60r+yk88e0GjRFrjQ=
Date:   Mon, 26 Oct 2020 08:40:43 +0000
From:   Will Deacon <will@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, alexandru.elisei@arm.com
Subject: Re: [PATCH 1/3] KVM: arm64: Check if 52-bits PA is enabled
Message-ID: <20201026084042.GC23739@willie-the-truck>
References: <20201025002739.5804-1-gshan@redhat.com>
 <20201025002739.5804-2-gshan@redhat.com>
 <871rhmpr92.wl-maz@kernel.org>
 <333451bd-4730-4ebb-f76c-28fa5d0e1f7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <333451bd-4730-4ebb-f76c-28fa5d0e1f7d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 09:23:31AM +1100, Gavin Shan wrote:
> On 10/25/20 8:52 PM, Marc Zyngier wrote:
> > On Sun, 25 Oct 2020 01:27:37 +0100,
> > Gavin Shan <gshan@redhat.com> wrote:
> > > 
> > > The 52-bits physical address is disabled until CONFIG_ARM64_PA_BITS_52
> > > is chosen. This uses option for that check, to avoid the unconditional
> > > check on PAGE_SHIFT in the hot path and thus save some CPU cycles.
> > 
> > PAGE_SHIFT is known at compile time, and this code is dropped by the
> > compiler if the selected page size is not 64K. This patch really only
> > makes the code slightly less readable and the "CPU cycles" argument
> > doesn't hold at all.
> > 
> > So what are you trying to solve exactly?
> > 
> 
> There are two points covered by the patch: (1) The 52-bits physical address
> is visible only when CONFIG_ARM64_PA_BITS_52 is enabled in arch/arm64 code.
> The code looks consistent with this option used here. (2) I had the assumption
> that gcc doesn't optimize the code and PAGE_SHIFT is always checked in order
> to get higher 4 physical address bits, but you said gcc should optimize the
> code accordingly. However, it would be still nice to make the code explicit.

I don't know: adding #ifdef CONFIG_ lines just reduces the coverage we
get from CI, so unless the code is actually causing a problem then I'd be
inclined to leave it as-is.

Will
