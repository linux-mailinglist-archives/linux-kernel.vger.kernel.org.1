Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF5620F1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbgF3J5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 05:57:25 -0400
Received: from 8bytes.org ([81.169.241.247]:50654 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbgF3J5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:57:24 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3A07426B; Tue, 30 Jun 2020 11:57:23 +0200 (CEST)
Date:   Tue, 30 Jun 2020 11:57:21 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Qian Cai <cai@lca.pw>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 0/2] iommu/amd: Don't use atomic64_t for
 domain->pt_root
Message-ID: <20200630095721.GI28824@8bytes.org>
References: <20200626080547.24865-1-joro@8bytes.org>
 <63D91069-6A2E-4C05-8409-76A56D1E0FCA@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63D91069-6A2E-4C05-8409-76A56D1E0FCA@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 08:30:21AM -0400, Qian Cai wrote:
> BTW, from the previous discussion, Linus mentioned,
>  
> “
> The thing is, the 64-bit atomic reads/writes are very expensive on
> 32-bit x86. If it was just a native pointer, it would be much cheaper
> than an "atomic64_t".
> “
> 
> However, here we have AMD_IOMMU depend on x86_64, so I am wondering if
> it makes any sense to run this code on 32-bit x86 at all?

No, it doesn't, the driver is not supported on 32bit and probably never
will. I skip this patch and only apply the first one, as it is an
improvement in itself.

Regards,

	Joerg
