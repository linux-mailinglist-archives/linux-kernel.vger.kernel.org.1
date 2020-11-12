Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C42B00F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgKLINO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:13:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:51438 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgKLINN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:13:13 -0500
IronPort-SDR: wtZvxZ3rihJihuxlz0iAxmh62HJk0ILOAIn531bIpu+/UU2JFtoA3LzHyNvLLMfizZGdTqacZS
 q997/apB9Ohg==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="157292028"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="157292028"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 00:13:12 -0800
IronPort-SDR: auzE3zXNjb4nbrvoPOgodklDPlWISs6bE+3e/oxck2ZR6mnWbiyMT886fkwAgH3KDZQgc7L7t0
 gSmYV2lX8M+w==
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="542165910"
Received: from kszypryt-mobl1.ger.corp.intel.com (HELO lhawrylk-desk.ger.corp.intel.com) ([10.213.18.217])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 00:13:09 -0800
Message-ID: <b52b65eed026b56090bd36533366e54cbc9ff689.camel@linux.intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: avoid unnecessory panic if iommu init
 fail in tboot system
From:   Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     ning.sun@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, tboot-devel@lists.sourceforge.net
Date:   Thu, 12 Nov 2020 09:13:06 +0100
In-Reply-To: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
References: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 

Tested-by: Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>

