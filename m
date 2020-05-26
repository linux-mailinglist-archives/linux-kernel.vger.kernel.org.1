Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC90B1C02C6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 18:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgD3Qmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 12:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgD3Qmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:42:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A6A2070B;
        Thu, 30 Apr 2020 16:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588264951;
        bh=zWjD8S3kV4daP3x+VDycpzV1UCqFTR84aGKoKz+T2BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ze8Ag/tzgCNXZb6o+oOHbiZkwKN9lMYVQ8p6DfwANYnkgejOfcHKSsfJfwBInslwi
         kYjZ4sddyXFnEWRO/0sOxutXhGT0hd2HTyzXlsFFxscHpj/P+FMezjV0hzZHx3WRnS
         OYAf4vUMI0+t/ZPk7QMwFSDnFA8gjC6azOXz96S0=
Date:   Thu, 30 Apr 2020 17:42:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/asm: Provide a Kconfig symbol for disabling old
 assembly annotations
Message-ID: <20200430164226.GF25258@willie-the-truck>
References: <20200416182402.6206-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416182402.6206-1-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 07:24:02PM +0100, Mark Brown wrote:
> As x86 was converted to use the modern SYM_ annotations for assembly ifdefs
> were added to remove the generic definitions of the old style annotations
> on x86. Rather than collect a list of architectures in the ifdefs as more
> architectures are converted over provide a Kconfig symbol for this and
> update x86 to use it.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> 
> arm64 will all being well be able to use this shortly.

Just for the record (already discussed with Boris off-list), I'm going to
queue this in the arm64 tree by pulling the x86/asm branch from -tip.

Thanks,

Will
