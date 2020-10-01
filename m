Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001B027FEA6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 13:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbgJALwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 07:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731767AbgJALwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:52:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B43321481;
        Thu,  1 Oct 2020 11:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601553123;
        bh=jqZ3p8GBPPZmtbp66FihdHwotuZ0yu+zF8O8+xsMAMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmajexn4JCnBBAQWL8xuneRcIx/PSu52qsXa7Z0uNGEdAMQiokkA7jP6lPMKzMvje
         c30NbFTsZNnCw64BUg2JuD69MzdYVNopBtSpJFYjKPsVUams3H1qmM1uDBgBTOA1E8
         C7Cfk5b7lb2mnB5MqbRXAh3lWzVOPs7xktz1MmK0=
Date:   Thu, 1 Oct 2020 12:51:59 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.10
Message-ID: <20201001115158.GA18755@willie-the-truck>
References: <20200930080523.GA15805@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930080523.GA15805@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 09:05:23AM +0100, Will Deacon wrote:
> Please pull these arm-smmu updates for 5.10. Summary in the tag, but the
> big thing here is the long-awaited SVM enablement from Jean-Philippe.
> We're not quite done yet, but this pull extends the SMMUv3 driver so that
> we're very close to being able to share page-tables directly with the CPU.
> 
> Other than that, there are a couple of things to note:
> 
>   1. My PGP subkeys expired. I've updated them here:
> 
> 	https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/3E542FD9.asc
> 
>      and I've also mailed an updated copy for inclusion in the pgpkeys
>      repository on kernel.org, but it hasn't landed yet:

Just to say that my updated key has now landed in the pgpkeys repo.

Will
