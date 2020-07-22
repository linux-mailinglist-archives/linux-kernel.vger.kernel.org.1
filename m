Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92E4229F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 20:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgGVSNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 14:13:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:52798 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgGVSNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:13:34 -0400
IronPort-SDR: u0eGuz9e3a4AdZ23kllChrNnlDbFofDfGet1Rz9u7C4TdTmd3y99/j9dFIV4O/DCcwy/WCbMsu
 1zCPwV1QUgsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="150375356"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="150375356"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 11:13:33 -0700
IronPort-SDR: JtosvAJzexhbLhNoi/bpHeYCke7S9aJw9zZ5psF19WXy3tSdooc7FEJ044mf0MaEnHkKcbQJBx
 FLxREYTzpqiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="328296444"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 22 Jul 2020 11:13:33 -0700
Date:   Wed, 22 Jul 2020 11:20:20 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Handle non-page aligned address
Message-ID: <20200722112020.62ff5acc@jacob-builder>
In-Reply-To: <7a8f70af-f39b-1b57-a9eb-db085ab63149@linux.intel.com>
References: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1594080774-33413-5-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200721095036.1977e3bf@jacob-builder>
        <7a8f70af-f39b-1b57-a9eb-db085ab63149@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 09:01:27 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> > 
> > Not sure what state is this patch in, there is a bug in this patch
> > (see below), shall I send out an updated version of this one only?
> > or another incremental patch.  
> 
> Please send an updated version. I hope Joerg could pick these as 5.8
> fix.
OK, will do.
