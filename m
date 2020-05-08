Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0F51CB287
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 17:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgEHPHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 11:07:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:34052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgEHPHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:07:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E55BAF5D;
        Fri,  8 May 2020 15:07:39 +0000 (UTC)
Date:   Fri, 8 May 2020 17:07:34 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, x86@kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Failure to shutdown/reboot with intel_iommu=on
Message-ID: <20200508150734.GP8135@suse.de>
References: <20200506144558.GA4019@taurus.defre.kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506144558.GA4019@taurus.defre.kleine-koenig.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Baolu, Maintainer of Intel IOMMU

Baolu, does that ring any bells?

On Wed, May 06, 2020 at 04:46:02PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On my Lenovo T460p I cannot shutdown and reboot when the iommu is
> enabled. This is using linux 5.2.7 as provided by Debian, 5.6.4 has the
> same problem. Suspend/resume also fails; I suspect this is the same
> issue.
> 
> When requesting power off the kernel messages just end with:
> 
> 	sd 0:0:0:0: [sda] Synchronizing SCSI cache
> 	sd 0:0:0:0: [sda] Stopping disk
> 	e1000e: EEE TX LPI TIMER: 00000011
> 	ACPI: Preparing to enter system sleep state S5
> 	reboot: Power down
> 	acpi_power_off called
> 
> (photo at https://www.kleine-koenig.org/tmp/uklsiommu.jpg in case I
> mistyped something. Full dmesg and lspci -vvv at
> https://www.kleine-koenig.org/tmp/uklsiommu.tar.gz with and without
> iommu enabled.)
> 
> With the iommu disabled (CONFIG_INTEL_IOMMU_DEFAULT_ON unset or
> intel_iommu=off on cmdline) the machine just works as expected
> (including working suspend/resume).
> 
> I already talked to tglx on irc but unfortunately no new insights
> resulted from that.
> 
> Any ideas how to fix or continue debugging the issue?
> 
> Best regards
> Uwe


