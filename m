Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8F72ED2E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbhAGOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:39:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbhAGOjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:39:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92646217A0;
        Thu,  7 Jan 2021 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610030348;
        bh=YWEcxhex87qRhDcmUQgovNSsPvhG+kKequUOj5ZrPco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIC+a1NcKdmkefH0TZ04wEJSA0N0X+XPEmffWdWFyJ65aslvzDaOubPJtqvdTEgTA
         mL66YFSKt6oTvwq1HMMco+2c7mpiBV5XyQ+iKVcjd+GHlb2+97YSAW44RP+P9J76gP
         ilI3tcRIrJodIWbSSRxBuf2TgixmFufEbqMshUbeGi/OOtv9krfjQX26q3+vEMe+dp
         kIGxU6/4n4KJhNIhViwcd58ScrT7JRpZGt4/gbON+oEOx1gbk3FJzFv9tv7ML9d+WZ
         KPska6pUUN8AnT8bNn0it3DUNiHag8bLAITlg4bKsnhQRHEgamgzixOM+ek6pKctOC
         WI6vvUUgst9CQ==
Date:   Thu, 7 Jan 2021 14:39:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Liu Yi L <yi.l.liu@intel.com>, joro@8bytes.org,
        kevin.tian@intel.com, ashok.raj@intel.com, jun.j.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com, dan.carpenter@oracle.com,
        Xin Zeng <xin.zeng@intel.com>
Subject: Re: [PATCH v4 2/3] iommu/vt-d: Track device aux-attach with
 subdevice_domain_info
Message-ID: <20210107143903.GA3413@willie-the-truck>
References: <1609949037-25291-1-git-send-email-yi.l.liu@intel.com>
 <1609949037-25291-3-git-send-email-yi.l.liu@intel.com>
 <20210107134906.GA3043@willie-the-truck>
 <591fa06b-8db1-57a5-8c61-d6ba28bc8c04@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <591fa06b-8db1-57a5-8c61-d6ba28bc8c04@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 10:16:57PM +0800, Lu Baolu wrote:
> On 2021/1/7 21:49, Will Deacon wrote:
> > On Thu, Jan 07, 2021 at 12:03:56AM +0800, Liu Yi L wrote:
> > > In the existing code, loop all devices attached to a domain does not
> > > include sub-devices attached via iommu_aux_attach_device().
> > > 
> > > This was found by when I'm working on the below patch, There is no
> > > device in the domain->devices list, thus unable to get the cap and
> > > ecap of iommu unit. But this domain actually has subdevice which is
> > > attached via aux-manner. But it is tracked by domain. This patch is
> > > going to fix it.
> > > 
> > > https://lore.kernel.org/kvm/1599734733-6431-17-git-send-email-yi.l.liu@intel.com/
> > > 
> > > And this fix goes beyond the patch above, such sub-device tracking is
> > > necessary for other cases. For example, flushing device_iotlb for a
> > > domain which has sub-devices attached by auxiliary manner.
> > 
> > Sorry, but I'm having a really hard time understanding what this patch is
> > doing based on this commit message. Baolu -- do you think you could reword
> > it for me please? No need to resend the patch.
> 
> iommu/vt-d: Fix general protection fault in aux_detach_device()

[...]

Thanks! I'll push this out shortly.

Will
