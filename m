Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB82ED12C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 14:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbhAGNtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 08:49:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbhAGNtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:49:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2318D22B45;
        Thu,  7 Jan 2021 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610027351;
        bh=CyJHEpw/9U0bkeevqTLF1zdpKDkC8mWFj1rIo9sBJeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jElZUmrqemAzi6DOfsP5zcN765QpO7PdinJTImuhgJHzKYSrRaQs+Lk7rKeyaiou9
         V7W3ZndWJXxsbd2jJZTptzZnZvZ+jpgSN8PD8eGYmxfkVRg43NDdwO4Bot4DELij4u
         khjOMZ+ma5PGbcmFq9QCGLUb1eSwVdbwquqRbZaMAyflaeA8gJZdqF98bN1YHO8S4k
         pvX6JSYzsERHBVrPKk8qRsOdQN/+dK8CQ/TFp5ZItdjQ3AqN32bcKsYXPIEC/krK8z
         yU8mxr/9CIuIrO34LsnaRofknuztgLRcml2SVG+IU7BGYT7EW8LoSQ5LQYBsxEBKoq
         qEavsmGZKjOAg==
Date:   Thu, 7 Jan 2021 13:49:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, kevin.tian@intel.com,
        ashok.raj@intel.com, jun.j.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com, dan.carpenter@oracle.com,
        Xin Zeng <xin.zeng@intel.com>
Subject: Re: [PATCH v4 2/3] iommu/vt-d: Track device aux-attach with
 subdevice_domain_info
Message-ID: <20210107134906.GA3043@willie-the-truck>
References: <1609949037-25291-1-git-send-email-yi.l.liu@intel.com>
 <1609949037-25291-3-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609949037-25291-3-git-send-email-yi.l.liu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 12:03:56AM +0800, Liu Yi L wrote:
> In the existing code, loop all devices attached to a domain does not
> include sub-devices attached via iommu_aux_attach_device().
> 
> This was found by when I'm working on the below patch, There is no
> device in the domain->devices list, thus unable to get the cap and
> ecap of iommu unit. But this domain actually has subdevice which is
> attached via aux-manner. But it is tracked by domain. This patch is
> going to fix it.
> 
> https://lore.kernel.org/kvm/1599734733-6431-17-git-send-email-yi.l.liu@intel.com/
> 
> And this fix goes beyond the patch above, such sub-device tracking is
> necessary for other cases. For example, flushing device_iotlb for a
> domain which has sub-devices attached by auxiliary manner.

Sorry, but I'm having a really hard time understanding what this patch is
doing based on this commit message. Baolu -- do you think you could reword
it for me please? No need to resend the patch.

Thanks,

Will
