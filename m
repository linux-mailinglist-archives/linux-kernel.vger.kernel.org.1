Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D721A2944
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgDHTQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 15:16:48 -0400
Received: from verein.lst.de ([213.95.11.211]:43787 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgDHTQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:16:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B967C68C4E; Wed,  8 Apr 2020 21:16:44 +0200 (CEST)
Date:   Wed, 8 Apr 2020 21:16:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: fix displaying of dma allocation type
Message-ID: <20200408191644.GA12239@lst.de>
References: <20200408184804.30522-1-grygorii.strashko@ti.com> <20200408184958.GA9945@lst.de> <ccd0cca4-ca89-3ecd-90d5-66e5e4090f41@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccd0cca4-ca89-3ecd-90d5-66e5e4090f41@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 10:13:55PM +0300, Grygorii Strashko wrote:
>>>   -static const char *type2name[5] = { "single", "page",
>>> +static const char *type2name[5] = { "single",
>>>   				    "scather-gather", "coherent",
>>>   				    "resource" };
>>
>> To make sure this doesn't happen anymore, can you switch to
>> named initializers?
>>
>
> Just to clarify.
> Do you mean
> [dma_debug_coherent] = "coherent",
> ?

Yes.
