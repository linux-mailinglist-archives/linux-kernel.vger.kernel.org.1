Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CF4273DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIVJDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIVJDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:03:52 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5AC20715;
        Tue, 22 Sep 2020 09:03:50 +0000 (UTC)
Date:   Tue, 22 Sep 2020 10:03:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rui.xiang@huawei.com,
        weiyongjun1@huawei.com
Subject: Re: [PATCH -next 2/5] mm/kmemleak: skip update_checksum for
 OBJECT_NO_SCAN objects
Message-ID: <20200922090346.GA15643@gaia>
References: <20200921020007.35803-1-chenjun102@huawei.com>
 <20200921020007.35803-3-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921020007.35803-3-chenjun102@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 02:00:04AM +0000, Chen Jun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Objects marked with OBJECT_NO_SCAN are never scanned.
> So there is no need to update checksum for them.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>  mm/kmemleak.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index b3f603fd9fc3..c09c6b59eda6 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1166,6 +1166,10 @@ static bool update_checksum(struct kmemleak_object *object)
>  {
>  	u32 old_csum = object->checksum;
>  
> +	/* always return false for not scan object */
> +	if (object->flags & OBJECT_NO_SCAN)
> +		return false;

The reason for OBJECT_NO_SCAN is to avoid introducing more false
negatives. The point of the checksum is to reduce the false positives -
i.e. an object that is being modified between scans won't be considered
a (transient) leak even if kmemleak couldn't find a reference pointer to
it.

So please drop this patch.

-- 
Catalin
