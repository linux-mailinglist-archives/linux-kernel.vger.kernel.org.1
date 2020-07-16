Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484EB2222BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgGPMrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:47:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50051 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPMru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:47:50 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vDP0wsfz9sTF; Thu, 16 Jul 2020 22:47:49 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
In-Reply-To: <20200619070113.16696-1-sathnaga@linux.vnet.ibm.com>
References: <20200619070113.16696-1-sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] powerpc/pseries/svm: Remove unwanted check for shared_lppaca_size
Message-Id: <159490364667.3801815.6147810158620423747.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:47:49 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 12:31:13 +0530, Satheesh Rajendran wrote:
> Early secure guest boot hits the below crash while booting with
> vcpus numbers aligned with page boundary for PAGE size of 64k
> and LPPACA size of 1k i.e 64, 128 etc, due to the BUG_ON assert
> for shared_lppaca_total_size equal to shared_lppaca_size,
> 
>  [    0.000000] Partition configured for 64 cpus.
>  [    0.000000] CPU maps initialized for 1 thread per core
>  [    0.000000] ------------[ cut here ]------------
>  [    0.000000] kernel BUG at arch/powerpc/kernel/paca.c:89!
>  [    0.000000] Oops: Exception in kernel mode, sig: 5 [#1]
>  [    0.000000] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pseries/svm: Fix incorrect check for shared_lppaca_size
      https://git.kernel.org/powerpc/c/b710d27bf72068b15b2f0305d825988183e2ff28

cheers
