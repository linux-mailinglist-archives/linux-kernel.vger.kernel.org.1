Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE38276ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgIXKev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:34:51 -0400
Received: from 8bytes.org ([81.169.241.247]:46406 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgIXKeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:34:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C40D5295; Thu, 24 Sep 2020 12:34:49 +0200 (CEST)
Date:   Thu, 24 Sep 2020 12:34:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 00/13] iommu: amd: Add Generic IO Page Table Framework
 Support
Message-ID: <20200924103448.GO27174@8bytes.org>
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Wed, Sep 23, 2020 at 10:14:29AM +0000, Suravee Suthikulpanit wrote:
> The framework allows callable implementation of IO page table.
> This allows AMD IOMMU driver to switch between different types
> of AMD IOMMU page tables (e.g. v1 vs. v2).

Is there a reason you created your own framework, there is already an
io-pgtable framework for ARM, maybe that can be reused?

Regards,

	Joerg

