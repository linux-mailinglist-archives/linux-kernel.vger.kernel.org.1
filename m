Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E864B1E1D92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 10:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbgEZIqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 04:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgEZIqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:46:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C87AB2075F;
        Tue, 26 May 2020 08:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590482764;
        bh=ocWz0pfCY8jX9J9R95Nc+Lu6TfrWAdd6R8bOnCWkpSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKgC2R++UL+AYxhkUon0jueI1MvMybxcEZw8e5TjMv1//vR3TkK3kKOz6EFUjynx4
         +w++ZukHUunZDnmSVHdPBgzTmVpOzGTDM8NIb6yF/DDXpolhj6bYITtk4yoB73T+67
         7iFnAtSWq4OvisHPnnfwfTIHZPcMy9Eww7prRotE=
Date:   Tue, 26 May 2020 09:46:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     tuanphan@os.amperecomputing.com, patches@amperecomputing.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: arm_dsu: Support DSU ACPI devices.
Message-ID: <20200526084559.GA24773@willie-the-truck>
References: <1589229160-18558-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200518172132.GA2601@willie-the-truck>
 <5adeae2c-86be-6ee9-970b-aa891582c562@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5adeae2c-86be-6ee9-970b-aa891582c562@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 11:45:56AM +0100, Suzuki K Poulose wrote:
> Will,
> 
> Thanks for the Cc.
> 
> On 05/18/2020 06:21 PM, Will Deacon wrote:
> > On Mon, May 11, 2020 at 01:32:40PM -0700, Tuan Phan wrote:
> > > Add ACPI node probing device support. Each DSU ACPI node
> > > defines a "cpus" package with a per cpu MPIDR element.
> 
> I think there is a bit of confusion around the affinity listing.
> I am getting this clarified with the architects.

Thanks, Suzuki. I'll hold off until that's resolved, then.

Will
