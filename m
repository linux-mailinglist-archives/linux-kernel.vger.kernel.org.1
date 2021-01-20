Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058C72FD132
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732968AbhATNQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:16:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732591AbhATMll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:41:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0703F2332B;
        Wed, 20 Jan 2021 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611146461;
        bh=ay7PyA58pICfptaUXqkjJ2nWQF7Zf555f/Ndk2pLZuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=af6ia+XEhRiHQxNl0BOYqQ+Sa5vlaEf+wX51RYWNmhnny5nhT5Xh5NTcdLoGTSoZH
         DnwOHWUvm3Hi51rvE53knQdffmh2HjQNA9bk2Pvk6B+iziz9TlFWDDTo7A7Z6+XyuA
         Q/BNVD5YX3qJNRpmeEQOWD2Mt9iAIeriANTVjsHIFc7CgYYbtEYBF25lMlKUMTewDx
         H0870FAK2i2iHdSigT85wBLukRREyNGw4bSwBPWREmGuNE+eFqMviNzDEdEofK+MgY
         x8pLeeN5rM5jMnd0WBgNEat2Ov+/zttE/oFJoszU2sE1q4Uf92EWuWzduiwDMTzWRj
         GmHd3KJFWkcgg==
Date:   Wed, 20 Jan 2021 12:40:55 +0000
From:   Will Deacon <will@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, ardb@kernel.org,
        akpm@linux-foundation.org, rppt@kernel.org, nsaenzjulienne@suse.de,
        song.bao.hua@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        xiexiuqi@huawei.com
Subject: Re: [PATCH 0/2] arm64: mm: fix kdump broken with ZONE_DMA
 reintroduced
Message-ID: <20210120124054.GA19504@willie-the-truck>
References: <20201226033557.116251-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226033557.116251-1-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 11:35:55AM +0800, Chen Zhou wrote:
> If the memory reserved for crash dump kernel falled in ZONE_DMA32,
> the devices in crash dump kernel need to use ZONE_DMA will alloc fail.
>            
> Fix this by reserving low memory in ZONE_DMA if CONFIG_ZONE_DMA is
> enabled, otherwise, reserving in ZONE_DMA32.
> 
> Patch 1 updates the comments about the ZONE_DMA.
> Patch 2 fix kdump broken.
> 
> Chen Zhou (2):
>   arm64: mm: update the comments about ZONE_DMA
>   arm64: mm: fix kdump broken with ZONE_DMA reintroduced

Please can you repost this if it is still needed after the changes that
landed in -rc4?

Will
