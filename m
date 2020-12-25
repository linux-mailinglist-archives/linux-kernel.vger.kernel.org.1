Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B811F2E2BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 17:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgLYQsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 11:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgLYQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 11:48:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1683EC061573
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 08:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=UwrOzTtTA0vBGuw7CE/CEj6w/tDyk2z40HHGiCNPM9k=; b=sHT+y4xXRxKQ2IJ8aWrfHE0ffb
        NggIhCWly1shnbaXyXPdMFLHcDxHw4OTGeLqPbxWHYpbhvqZU7FqbqT12rFsgRHOMOIihQtoDbNOJ
        GTGJ6Dz77AcYTc/DQOv+VGSdfBEI7odWHzZeyzIrs3LCVG2Wz9t4mMTGBbhDRf9y7+QmLLDg9LhCf
        HrE05/3matkGXSxDR36V1OQE+zAHWP3MKaShhIWap1fWofmltX9sCgIoReBd6YT9hXp57ZIl203KD
        +kaT+BnlfqpvNJMfsZfjmfcGrCJaxqin3sM82JUvD4TLvKqQS4Ud3Fy+GxxRzzLOS02eI/ylBpI1s
        PI7X6lag==;
Received: from [2601:1c0:6280:3f0::64ea]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ksqFS-0003Er-Lc; Fri, 25 Dec 2020 16:47:26 +0000
Subject: Re: [PATCH 2/2] drivers/gpu/drm/ast: Fix infinite loop if read fails
To:     Defang Bo <bodefang@126.com>, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1608884014-2327765-1-git-send-email-bodefang@126.com>
 <1608884014-2327765-2-git-send-email-bodefang@126.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ecb98c83-3906-6111-712d-ddfdeac1607f@infradead.org>
Date:   Fri, 25 Dec 2020 08:47:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1608884014-2327765-2-git-send-email-bodefang@126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/20 12:13 AM, Defang Bo wrote:
> [Why] Similar to commit <298360af3> ast_init_dram_reg() configures a window in order to access BMC memory.
> A BMC register can be configured to disallow this, and if so, causes
> an infinite loop in the ast driver which renders the system unusable.
> [How]
> Fix this by erroring out if an error is detected.

Hm, it appears that all this patch does is change spaces to tabs...


> Signed-off-by: Defang Bo <bodefang@126.com>
> ---
>  drivers/gpu/drm/ast/ast_post.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
> index ef19c70..86e4d23 100644
> --- a/drivers/gpu/drm/ast/ast_post.c
> +++ b/drivers/gpu/drm/ast/ast_post.c
> @@ -302,13 +302,13 @@ static void ast_init_dram_reg(struct drm_device *dev)
>  			ast_write32(ast, 0x12000, 0x1688A8A8);
>  			do {
>  				if (pci_channel_offline(dev->pdev))
> -                                        return -EIO;
> +					return -EIO;
>  			} while (ast_read32(ast, 0x12000) != 0x01);
>  
>  			ast_write32(ast, 0x10000, 0xfc600309);
>  			do {
>  				if (pci_channel_offline(dev->pdev))
> -                                        return -EIO;
> +					return -EIO;
>  			} while (ast_read32(ast, 0x10000) != 0x01);
>  		}
>  
> 


-- 
~Randy

