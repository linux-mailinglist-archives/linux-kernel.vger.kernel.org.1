Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BC122C519
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 14:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgGXM0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 08:26:36 -0400
Received: from 8bytes.org ([81.169.241.247]:59050 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgGXM0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:26:36 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7BF3346A; Fri, 24 Jul 2020 14:26:34 +0200 (CEST)
Date:   Fri, 24 Jul 2020 14:26:33 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.9
Message-ID: <20200724122632.GS27672@8bytes.org>
References: <20200721080352.GA13023@willie-the-truck>
 <20200722133323.GG27672@8bytes.org>
 <20200724115109.GA17451@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724115109.GA17451@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Jul 24, 2020 at 12:51:09PM +0100, Will Deacon wrote:
> Sure, that makes sense to me: I've included a diff below in case anybody
> has comments. I've tackled it slightly differently to how the intel and
> amd drivers are handled, since we have a header file (arm-smmu.h) which
> is shared by a couple of different drivers. I've also moved the v3 driver
> under the arm/ directory as Jean Philippe plans to split out the SVA work
> for 5.10.
> 
> I'll send a second pull early next week if there are no objections (or
> you can pick this patch directly).

Thanks, the diff looks fine to me.


	Joerg
