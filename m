Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF6D2A63E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgKDMIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:08:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729520AbgKDMIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:08:18 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D3D21734;
        Wed,  4 Nov 2020 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604491697;
        bh=J9jQ94Kh0nfwpFB+1SReiHKtznl4Xosc5X/PYpyQhuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPXai+z5eiF95Xeim8hbCMSKtdpYpbs7eDKVyKPKqDOgmBMO4zl+C7xPVY5oRWPsv
         GwEK0wT4xR59MHcFyKPpiRWEr6Yz8bF7LGLhpFQLEHL0svFtnrKWq46hrfsfEdJCGT
         D3wCgITxfJr9SepPdqvNSaVs0TuHGZVDmx3tFf38=
Date:   Wed, 4 Nov 2020 12:08:12 +0000
From:   Will Deacon <will@kernel.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: Implement CONFIG_CMDLINE_EXTEND
Message-ID: <20201104120812.GA6632@willie-the-truck>
References: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
 <20201103155952.GA4335@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103155952.GA4335@sequoia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:59:52AM -0600, Tyler Hicks wrote:
> On 2020-09-21 14:15:55, Tyler Hicks wrote:
> > Provide the CONFIG_CMDLINE_EXTEND config option for arm64 kernels. This
> > config option can be used to extend the kernel command line parameters,
> > specified by the bootloader, with additional command line parameters
> > specified in the kernel configuration.
> 
> Hi Catalin and Will - Friendly ping on this series now that we're
> on the other side of the 5.10 merge window. I hope it can be considered
> for 5.10+1. Let me know if I need to rebase/resubmit. Thanks!

Can you use bootconfig to achieve what you need?

Will
