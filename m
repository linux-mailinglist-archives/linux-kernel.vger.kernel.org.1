Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6BA1A73C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 08:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406057AbgDNGfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 02:35:16 -0400
Received: from verein.lst.de ([213.95.11.211]:37669 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406042AbgDNGfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 02:35:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B7A7668BEB; Tue, 14 Apr 2020 08:35:11 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:35:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc v2 1/6] dma-remap: separate DMA atomic pools from direct
 remap code
Message-ID: <20200414063511.GA23359@lst.de>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com> <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com> <alpine.DEB.2.21.2004081419190.19661@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004081419190.19661@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 02:21:03PM -0700, David Rientjes wrote:
> +++ b/kernel/dma/pool.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + * Copyright (c) 2014 The Linux Foundation
> + * Copyright (C) 2020 Google LLC

Of the old copyrights the LF ones apply to the remapping helpers,
that are stil in remap.c, so they don't need to be added here.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
