Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17284240D14
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 20:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgHJSlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 14:41:25 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:17232 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgHJSlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:41:24 -0400
Received: from [192.168.42.210] ([93.22.133.151])
        by mwinf5d63 with ME
        id DuhF2300D3G8tn903uhF7e; Mon, 10 Aug 2020 20:41:22 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 10 Aug 2020 20:41:22 +0200
X-ME-IP: 93.22.133.151
Subject: Re: [PATCH] drm: amdgpu: Use the correct size when allocating memory
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, sumit.semwal@linaro.org,
        colton.w.lewis@protonmail.com, Ori.Messinger@amd.com,
        m.szyprowski@samsung.com, bernard@vivo.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200809203406.751971-1-christophe.jaillet@wanadoo.fr>
 <20200810154213.GM1793@kadam>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <8c414dd7-4a80-6ff2-03de-5340fb0d9c61@wanadoo.fr>
Date:   Mon, 10 Aug 2020 20:41:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810154213.GM1793@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 10/08/2020 à 17:42, Dan Carpenter a écrit :
> On Sun, Aug 09, 2020 at 10:34:06PM +0200, Christophe JAILLET wrote:
>> When '*sgt' is allocated, we must allocated 'sizeof(**sgt)' bytes instead
>> of 'sizeof(*sg)'. 'sg' (i.e. struct scatterlist) is smaller than
>> 'sgt' (i.e struct sg_table), so this could lead to memory corruption.
> The sizeof(*sg) is bigger than sizeof(**sgt) so this wastes memory but
> it won't lead to corruption.
>
>      11  struct scatterlist {
>      12          unsigned long   page_link;
>      13          unsigned int    offset;
>      14          unsigned int    length;
>      15          dma_addr_t      dma_address;
>      16  #ifdef CONFIG_NEED_SG_DMA_LENGTH
>      17          unsigned int    dma_length;
>      18  #endif
>      19  };
>
>      42  struct sg_table {
>      43          struct scatterlist *sgl;        /* the list */
>      44          unsigned int nents;             /* number of mapped entries */
>      45          unsigned int orig_nents;        /* original size of list */
>      46  };
>
> regards,
> dan carpenter


My bad. I read 'struct scatterlist sgl' (without the *)
Thanks for the follow-up, Dan.

Doesn't smatch catch such mismatch?
(I've not run smatch for a while, so it is maybe reported)

Well, the proposal is still valid, even if it has less impact as 
initially thought.

Thx for the review.

CJ

