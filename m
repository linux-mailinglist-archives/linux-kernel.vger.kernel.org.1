Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115DA2B71C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgKQWnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbgKQWnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:43:12 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6120E20709;
        Tue, 17 Nov 2020 22:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605652991;
        bh=0SFBsqaNbJ3KLyPX1uMM76O7e/5+G6SX1GOQxGY2lSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t77rKKLuLqLBsLIsln15cG9Bd24C8388FbOO1O3Fn590nTBPfZHjEXmGFpUNj2eXA
         jj652eSTeTo7sXjohtTNp4+olWdnP2G5cpwGJY1/flcNXKiKY3ewaum/GPBreA/UzN
         sGCiWf+SL3u1DxlMjpnwbNoDqh8fbB0TmjS0lwEM=
Date:   Tue, 17 Nov 2020 22:43:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        joro@8bytes.org, robin.murphy@arm.com
Subject: Re: [PATCH v3 00/14] iommu/amd: Add Generic IO Page Table Framework
 Support
Message-ID: <20201117224306.GE524@willie-the-truck>
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
 <f28359ed-47dc-281f-7261-6320150ef906@amd.com>
 <eb567d23-b63b-a10a-d0b1-c03281a1f602@amd.com>
 <4dce5bdb-1a08-75ad-fd41-a1686521fef1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dce5bdb-1a08-75ad-fd41-a1686521fef1@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Suravee (it's been a while!),

On Fri, Nov 13, 2020 at 12:57:18PM +0700, Suravee Suthikulpanit wrote:
> Please ignore to include the V3. I am working on V4 to resubmit.

Please can you put me on CC for that?

Thanks,

Will
