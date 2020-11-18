Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FA42B7E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgKRN24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:28:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgKRN24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:28:56 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA0D2168B;
        Wed, 18 Nov 2020 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605706135;
        bh=GXB+cRJ8S+Trf+du81PieNJ/TBxT7l3tdYWwgb2rQhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xTg6/kl1kBQzTpCAQlHPbXFP963UAv5vU9c3sWuwOg1Q3oOt7LIi8zLZ5wqCh2xzx
         fJw+EPx6TOuIsdIszc1YozVWGx2fKeLuxGiD/uufdJoiWaqths4pvkKeyz/V7DgVMQ
         646pu+Law3l7M2mne3g3XllKxsM4mwgV0lutbCe0=
Date:   Wed, 18 Nov 2020 13:28:50 +0000
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org, ning.sun@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dwmw2@infradead.org, joro@8bytes.org,
        iommu@lists.linux-foundation.org, tboot-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] iommu/vt-d: avoid unnecessory panic if iommu init
 fail in tboot system
Message-ID: <20201118132849.GB2029@willie-the-truck>
References: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
 <34e8f6c6-e9f7-634b-8f68-3645261fd882@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34e8f6c6-e9f7-634b-8f68-3645261fd882@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 07:32:25AM +0800, Lu Baolu wrote:
> Please consider this patch for v5.10.

Cheers, I'll stick this onto a fixes branch momentarily.

Will
