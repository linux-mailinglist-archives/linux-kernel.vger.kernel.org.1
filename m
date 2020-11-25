Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD542C3D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 10:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgKYJzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 04:55:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgKYJzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 04:55:15 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A026206B7;
        Wed, 25 Nov 2020 09:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606298115;
        bh=re7AA/JYRI8haIErRYirxD5qBBNucRha2mgCCLcEBdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uau/cOV8xuxLqlAHyOwuhgXQj5gfAd69Ye96ug6M5hYeQd+3qxXFa51WdbVyB9rXi
         WfIth7NR1+dXktcByKqTBwpvQzIg5ovQr4UjreFibvMs5l41P+SANO1kJnPqLen/+R
         6LXv7rCZZ3lE/HBDUr+L4LC6Z/qeenih8S8MxBP8=
Date:   Wed, 25 Nov 2020 09:55:10 +0000
From:   Will Deacon <will@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, joro@8bytes.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        jonathanh@nvidia.com
Subject: Re: [PATCH RESEND 0/5] iommu/tegra-smmu: Some pending reviewed
 changes
Message-ID: <20201125095509.GB15052@willie-the-truck>
References: <20201111222129.15736-1-nicoleotsuka@gmail.com>
 <20201124212100.GA32108@Asurada-Nvidia>
 <68237d7c-12f7-3053-2e79-75b7e95f0af3@gmail.com>
 <20201124231215.GA32405@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201124231215.GA32405@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 03:12:16PM -0800, Nicolin Chen wrote:
> On Wed, Nov 25, 2020 at 02:05:14AM +0300, Dmitry Osipenko wrote:
> > 25.11.2020 00:21, Nicolin Chen пишет:
> > > These five patches were acked by Thierry and acked-n-tested by
> > > Dmitry a while ago. Would it be possible for you to apply them?
> > > 
> > > Thanks!
> > 
> > You probably should try to ping Will Deacon.
> > 
> > https://lkml.org/lkml/2020/11/17/243
> 
> Thank you, Dmitry.
> --
> 
> Will, would it be possible for you to take these changes?
> 
> I sent them on Nov 11 to the following lists:
> linux-kernel@vger.kernel.org
> iommu@lists.linux-foundation.org
> 
> If you need me to resend it again by adding you in To line,
> please kindly let me know.

Weird, this ended up in my spam. If you wouldn't mind resending with me
on To: then please do that. Then I know I'm looking at the correct version.

Thanks,

Will
