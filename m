Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B126423B47D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 07:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgHDFff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 01:35:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:41998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgHDFfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:35:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12673ACB5;
        Tue,  4 Aug 2020 05:35:49 +0000 (UTC)
Subject: Re: [PATCH v3 10/11] xen/arm: introduce phys/dma translations in
 xen_dma_sync_for_*
To:     Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        hch@infradead.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
 <20200710223427.6897-10-sstabellini@kernel.org>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <68f244b5-86e7-4c94-7a22-f9ca53311857@suse.com>
Date:   Tue, 4 Aug 2020 07:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710223427.6897-10-sstabellini@kernel.org>
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
> xen_dma_sync_for_cpu, xen_dma_sync_for_device, xen_arch_need_swiotlb are
> getting called passing dma addresses. On some platforms dma addresses
> could be different from physical addresses. Before doing any operations
> on these addresses we need to convert them back to physical addresses
> using dma_to_phys.
> 
> Move the arch_sync_dma_for_cpu and arch_sync_dma_for_device calls from
> xen_dma_sync_for_cpu/device to swiotlb-xen.c, and add a call dma_to_phys
> to do address translations there.
> 
> dma_cache_maint is fixed by the next patch.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> Tested-by: Corey Minyard <cminyard@mvista.com>
> Tested-by: Roman Shaposhnik <roman@zededa.com>

Acked-by: Juergen Gross <jgross@suse.com>


Juergen
