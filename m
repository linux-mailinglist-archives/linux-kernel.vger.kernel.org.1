Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E521D79E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 15:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgERNcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 09:32:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:35004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgERNcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:32:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 89A9AACCE;
        Mon, 18 May 2020 13:32:14 +0000 (UTC)
Date:   Mon, 18 May 2020 15:32:09 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] "iommu/amd: Relax locking in dma_ops path" makes
 tg3 ethernet transmit queue timeout
Message-ID: <20200518133209.GM8135@suse.de>
References: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 05:06:45PM +0800, Kai-Heng Feng wrote:
> Particularly, as soon as the spinlock is removed, the issue can be reproduced.
> Function domain_flush_complete() doesn't seem to affect the status.
> 
> However, the .map_page callback was removed by be62dbf554c5
> ("iommu/amd: Convert AMD iommu driver to the dma-iommu api"), so
> there's no easy revert for this issue.
> 
> This is still reproducible as of today's mainline kernel, v5.7-rc6.

Is there any error message from the IOMMU driver?

