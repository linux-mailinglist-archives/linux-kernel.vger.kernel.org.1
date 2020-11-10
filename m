Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEC32ADAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbgKJPxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:53:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:24820 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730299AbgKJPxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:53:42 -0500
IronPort-SDR: oCt6siBiOfnWUs1mn3I/HmUnETys2XhtxGkDYnMj/8edsObVmSRkl0Zqt5McnMK1g8eFSTE828
 6H0VOGaeZFIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="254707256"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="254707256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 07:53:39 -0800
IronPort-SDR: dracVvCiK/bgswNxiYrBwOdkO98TtU2a9F4PJqB57gXg+uh8aL8UQ7fpvgZZrxzyGa//lle4MV
 SxRan/iDmzHg==
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="531272516"
Received: from lhawrylk-desk.ger.corp.intel.com ([10.213.18.46])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 07:53:36 -0800
Message-ID: <4cfa1f1827e0ccbfbc94de3beba64a4a141b2248.camel@linux.intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: avoid unnecessory panic if iommu init
 fail in tboot system
From:   Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     ning.sun@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, tboot-devel@lists.sourceforge.net
Date:   Tue, 10 Nov 2020 16:53:33 +0100
In-Reply-To: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
References: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenzhong

On Tue, 2020-11-10 at 15:19 +0800, Zhenzhong Duan wrote:
> "intel_iommu=off" command line is used to disable iommu but iommu is force
> enabled in a tboot system for security reason.
> 
> However for better performance on high speed network device, a new option
> "intel_iommu=tboot_noforce" is introduced to disable the force on.
> 
> By default kernel should panic if iommu init fail in tboot for security
> reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".
> 
> Fix the code setting force_on and move intel_iommu_tboot_noforce
> from tboot code to intel iommu code.
> 
> Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
> v2: move ckeck of intel_iommu_tboot_noforce into iommu code per Baolu.

I have check it on my TXT testing environment with latest TBOOT,
everything works as expected.

Thanks,
Lukasz

