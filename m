Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E397825D5B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 12:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgIDKKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDKKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:10:06 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A9BC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 03:10:05 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6542D3D5; Fri,  4 Sep 2020 12:10:02 +0200 (CEST)
Date:   Fri, 4 Sep 2020 12:10:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Yuqi Jin <jinyuqi@huawei.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/iova: Replace cmpxchg with xchg in queue_iova
Message-ID: <20200904101000.GV6714@8bytes.org>
References: <1598517834-30275-1-git-send-email-zhangshaokun@hisilicon.com>
 <20200904093732.GN6714@8bytes.org>
 <208d2f74-1a04-f01e-b885-c175b0480784@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208d2f74-1a04-f01e-b885-c175b0480784@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Fri, Sep 04, 2020 at 10:58:14AM +0100, Robin Murphy wrote:
> On 2020-09-04 10:37, Joerg Roedel wrote:
> > Adding Robin.
> 
> Did you miss that I've reviewed this already? :)
> 
> https://lore.kernel.org/linux-iommu/3afcc7b2-0bfb-b79c-513f-1beb66c5f164@arm.com/

Hmm, that mail wasn't in my inbox, but b4 found it. I'll need to look
why it didn't make it...


	Joerg
