Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EBE2B847F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKRTPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:15:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgKRTPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:15:35 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E65EE221EB;
        Wed, 18 Nov 2020 19:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605726934;
        bh=rMQuX91lkr1RJsgraomQtcqKiNK07EY/h76cse3JGTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j88TbSW/tQkQoWlyacSPlGYSeZ2VK/zZpBG0BVMtkWwXkZ9T/R0b7BhPgRkay9dmH
         PYhH4EkfQ5yrW2DTH173GgwdfMvhZinDUiChfmVohySyGHeM03ddw38gpBfQwQRoHs
         sH9k02h3Ip5GYnnuFnTuqCWhC8NENYgc6c4Dc7qw=
Date:   Wed, 18 Nov 2020 19:15:29 +0000
From:   Will Deacon <will@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Barry Song <song.bao.hua@hisilicon.com>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        linuxarm@huawei.com
Subject: Re: [PATCH] arm64: mm: add support for memmap kernel parameters
Message-ID: <20201118191528.GA2680@willie-the-truck>
References: <20201118063314.22940-1-song.bao.hua@hisilicon.com>
 <20201118173854.GA8537@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118173854.GA8537@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 07:38:54PM +0200, Mike Rapoport wrote:
> On Wed, Nov 18, 2020 at 07:33:14PM +1300, Barry Song wrote:
> > memmap should be an useful kernel parameter which has been supported by
> > x86, mips and xtensa.
> 
> Why is this parameter should be useful for ARM64? 
> My understanding is that it is required only to work around really
> broken bootloaders, isn't it?

Agreed, I can't see this being something we really want to support. If it
turns out that it is generally useful, then the implementation should
probably be somewhere outside of arch/ where I don't have to look at it :)

Will
