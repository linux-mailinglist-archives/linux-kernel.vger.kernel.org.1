Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A121E81B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgE2PXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 11:23:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:52152 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgE2PXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:23:13 -0400
IronPort-SDR: zOsxaUvYPLLgtKnJ7GnQMPE4ssT5o8DYy/DJ/NZKHFgA7+mKYNP7m95a7Zhb55a8/2SP9kCuzM
 W5Rvu/IJsOqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 08:23:12 -0700
IronPort-SDR: l318gQ8nIBDjKO4cXKwE+zpz60aCkP0wzi8myVgviAVc9I2MiVxMtmit7k1V0dCrayrFk/5DoI
 Cwl6hZii3y+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="443425001"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 29 May 2020 08:23:12 -0700
Date:   Fri, 29 May 2020 08:29:30 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix compile warning
Message-ID: <20200529082930.798466dc@jacob-builder>
In-Reply-To: <20200529131545.GE14598@8bytes.org>
References: <1590689031-79318-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200529131545.GE14598@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 15:15:45 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> Applied, thanks.
> 
> On Thu, May 28, 2020 at 11:03:51AM -0700, Jacob Pan wrote:
> > Make intel_svm_unbind_mm() a static function.
> > 
> > Fixes: 064a57d7ddfc ("iommu/vt-d: Replace intel SVM APIs with
> > generic SVA APIs")  
> 
> Please make sure the fixes tags (or any other tags) are not
> line-wrapped in future patch submissions.
> 
Got it, thanks.

> Thanks,
> 
> 	Joerg

[Jacob Pan]
