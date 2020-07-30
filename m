Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65A233269
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 14:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgG3Muf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 08:50:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49293 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgG3Mud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:50:33 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BHVd31wkwz9sTS; Thu, 30 Jul 2020 22:50:30 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200727171112.2781-1-weiyongjun1@huawei.com>
References: <20200727171112.2781-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] powerpc/powernv/sriov: Remove unused but set variable 'phb'
Message-Id: <159611328042.1601380.2744826699786899081.b4-ty@ellerman.id.au>
Date:   Thu, 30 Jul 2020 22:50:30 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 01:11:12 +0800, Wei Yongjun wrote:
> Gcc report warning as follows:
> 
> arch/powerpc/platforms/powernv/pci-sriov.c:602:25: warning:
>  variable 'phb' set but not used [-Wunused-but-set-variable]
>   602 |  struct pnv_phb        *phb;
>       |                         ^~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/powernv/sriov: Remove unused but set variable 'phb'
      https://git.kernel.org/powerpc/c/cf1ae052e073c7ef6cf1a783a6427f7228253bd3

cheers
