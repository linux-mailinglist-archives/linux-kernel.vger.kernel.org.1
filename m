Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116DF1D0BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 11:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbgEMJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 05:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbgEMJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:14:07 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BA5C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 02:14:07 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DC6B0379; Wed, 13 May 2020 11:14:05 +0200 (CEST)
Date:   Wed, 13 May 2020 11:14:04 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/amd: fix over-read of ACPI UID from IVRS table
Message-ID: <20200513091404.GI9820@8bytes.org>
References: <20200511102352.1831-1-amonakov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511102352.1831-1-amonakov@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:23:52AM +0000, Alexander Monakov wrote:
> IVRS parsing code always tries to read 255 bytes from memory when
> retrieving ACPI device path, and makes an assumption that firmware
> provides a zero-terminated string. Both of those are bugs: the entry
> is likely to be shorter than 255 bytes, and zero-termination is not
> guaranteed.
> 
> With Acer SF314-42 firmware these issues manifest visibly in dmesg:
> 
> AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0\xf0\xa5, rdevid:160
> AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1\xf0\xa5, rdevid:160
> AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2\xf0\xa5, rdevid:160
> AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3>\x83e\x8d\x9a\xd1...
> 
> The first three lines show how the code over-reads adjacent table
> entries into the UID, and in the last line it even reads garbage data
> beyond the end of the IVRS table itself.
> 
> Since each entry has the length of the UID (uidl member of ivhd_entry
> struct), use that for memcpy, and manually add a zero terminator.
> 
> Avoid zero-filling hid and uid arrays up front, and instead ensure
> the uid array is always zero-terminated. No change needed for the hid
> array, as it was already properly zero-terminated.
> 
> Fixes: 2a0cb4e2d423c ("iommu/amd: Add new map for storing IVHD dev entry type HID")
> 
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux-foundation.org
> ---
>  drivers/iommu/amd_iommu_init.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied for v5.7, thanks.
