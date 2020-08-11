Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D8C241486
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 03:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgHKBVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 21:21:12 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:47373 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727088AbgHKBVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:21:11 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 10 Aug 2020 18:21:09 -0700
Received: from [0.0.0.0] (oddjob.vmware.com [10.253.4.32])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 071E940A41;
        Mon, 10 Aug 2020 18:21:08 -0700 (PDT)
Subject: Re: [PATCH] drm/vmwgfx: fix spelling mistake "Cant" -> "Can't"
To:     Colin King <colin.king@canonical.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200810100401.61209-1-colin.king@canonical.com>
From:   Roland Scheidegger <sroland@vmware.com>
Message-ID: <d4859590-75fb-2d5b-a76c-58c4f6e799c3@vmware.com>
Date:   Tue, 11 Aug 2020 03:21:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810100401.61209-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Received-SPF: None (EX13-EDG-OU-002.vmware.com: sroland@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I've put the fix in the vmwgfx-next branch.

Roland

Am 10.08.20 um 12:04 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a DRM_ERROR message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> index bbce45d142aa..471836672312 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -186,7 +186,7 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
>  		/* TODO handle none page aligned offsets */
>  		/* TODO handle more dst & src != 0 */
>  		/* TODO handle more then one copy */
> -		DRM_ERROR("Cant snoop dma request for cursor!\n");
> +		DRM_ERROR("Can't snoop dma request for cursor!\n");
>  		DRM_ERROR("(%u, %u, %u) (%u, %u, %u) (%ux%ux%u) %u %u\n",
>  			  box->srcx, box->srcy, box->srcz,
>  			  box->x, box->y, box->z,
> 

