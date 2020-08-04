Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EACC23B476
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 07:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgHDFec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 01:34:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:41656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgHDFea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:34:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A2D4ACB5;
        Tue,  4 Aug 2020 05:34:45 +0000 (UTC)
Subject: Re: [PATCH v3 09/11] swiotlb-xen: introduce phys_to_dma/dma_to_phys
 translations
To:     Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        hch@infradead.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
 <20200710223427.6897-9-sstabellini@kernel.org>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <2f68bb03-60b6-44d6-b9cd-d21ef20a4a68@suse.com>
Date:   Tue, 4 Aug 2020 07:34:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710223427.6897-9-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.20 00:34, Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> With some devices physical addresses are different than dma addresses.
> To be able to deal with these cases, we need to call phys_to_dma on
> physical addresses (including machine addresses in Xen terminology)
> before returning them from xen_swiotlb_alloc_coherent and
> xen_swiotlb_map_page.
> 
> We also need to convert dma addresses back to physical addresses using
> dma_to_phys in xen_swiotlb_free_coherent and xen_swiotlb_unmap_page if
> we want to do any operations on them.
> 
> Call dma_to_phys in is_xen_swiotlb_buffer.
> Introduce xen_phys_to_dma and call phys_to_dma in its implementation.
> Introduce xen_dma_to_phys and call dma_to_phys in its implementation.
> Call xen_phys_to_dma/xen_dma_to_phys instead of
> xen_phys_to_bus/xen_bus_to_phys through swiotlb-xen.c.
> 
> Everything is taken care of by these changes except for
> xen_swiotlb_alloc_coherent and xen_swiotlb_free_coherent, which need a
> few explicit phys_to_dma/dma_to_phys calls.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> Tested-by: Corey Minyard <cminyard@mvista.com>
> Tested-by: Roman Shaposhnik <roman@zededa.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
