Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6712F1E7E65
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 15:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgE2NPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgE2NPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:15:48 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA15C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 06:15:47 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id ADB67327; Fri, 29 May 2020 15:15:46 +0200 (CEST)
Date:   Fri, 29 May 2020 15:15:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/vt-d: Fix compile warning
Message-ID: <20200529131545.GE14598@8bytes.org>
References: <1590689031-79318-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590689031-79318-1-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks.

On Thu, May 28, 2020 at 11:03:51AM -0700, Jacob Pan wrote:
> Make intel_svm_unbind_mm() a static function.
> 
> Fixes: 064a57d7ddfc ("iommu/vt-d: Replace intel SVM APIs with generic
> SVA APIs")

Please make sure the fixes tags (or any other tags) are not line-wrapped
in future patch submissions.

Thanks,

	Joerg
