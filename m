Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A50242C07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 17:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHLPQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 11:16:12 -0400
Received: from 8bytes.org ([81.169.241.247]:35626 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgHLPQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:16:11 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6C0BF2C3; Wed, 12 Aug 2020 17:16:10 +0200 (CEST)
Date:   Wed, 12 Aug 2020 17:16:09 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Vijayanand Jitta <vjitta@codeaurora.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org, kernel-team@android.com
Subject: Re: [PATCH 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
Message-ID: <20200812151608.GG3721@8bytes.org>
References: <1593785835-27250-1-git-send-email-vjitta@codeaurora.org>
 <1593785835-27250-2-git-send-email-vjitta@codeaurora.org>
 <29f44540-44f8-570d-886f-2090596a3b8e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f44540-44f8-570d-886f-2090596a3b8e@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 03:30:48PM +0530, Vijayanand Jitta wrote:
> ping?

Please repost when v5.9-rc1 is released and add

	Robin Murphy <robin.murphy@arm.com>

on your Cc list.

Thanks,

	Joerg
