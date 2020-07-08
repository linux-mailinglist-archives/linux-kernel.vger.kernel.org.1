Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4F218ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgGHPMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 11:12:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:38659 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729500AbgGHPMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:12:20 -0400
IronPort-SDR: wn1mD+4u1JrDgQoYhiI3nbFrgItezNjTnCJejeIxoWa6U7FNIn6zNwXId6Ei8S/VmeAHdQi702
 V9kT3QBKe1uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="149325301"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="149325301"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 08:12:20 -0700
IronPort-SDR: /MVkUG8GhZH1siJlqEVBaQOSKpuUsBci6rmNU/vkTH1JLRLuD7R56lPhmqa2xMGebYejjce4y/
 KN1FCGXMa4lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="457534824"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2020 08:12:20 -0700
Date:   Wed, 8 Jul 2020 08:18:58 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 3/5] iommu/uapi: Use named union for user data
Message-ID: <20200708081858.37091f4b@jacob-builder>
In-Reply-To: <3b36c219-4120-402b-b03e-62b076db865c@linux.intel.com>
References: <1594165429-20075-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1594165429-20075-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <3b36c219-4120-402b-b03e-62b076db865c@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 10:17:57 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 7/8/20 7:43 AM, Jacob Pan wrote:
> > IOMMU UAPI data size is filled by the user space which must be
> > validated by ther kernel. To ensure backward compatibility, user
> > data can only be extended by either re-purpose padding bytes or
> > extend the variable sized union at the end. No size change is
> > allowed before the union. Therefore, the minimum size is the offset
> > of the union.
> > 
> > To use offsetof() on the union, we must make it named.
> > 
> > Link:https://lkml.org/lkml/2020/6/11/834  
> 
> Please use lore.kernel.org links.
> 
OK. will do.

> Best regards,
> baolu

[Jacob Pan]
