Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8713B22A541
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 04:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbgGWCdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 22:33:55 -0400
Received: from foss.arm.com ([217.140.110.172]:37338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbgGWCdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 22:33:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7DD231B;
        Wed, 22 Jul 2020 19:33:54 -0700 (PDT)
Received: from [10.163.85.73] (unknown [10.163.85.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08D203F718;
        Wed, 22 Jul 2020 19:33:49 -0700 (PDT)
Subject: Re: [PATCH] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
To:     Wei Li <liwei213@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     song.bao.hua@hisilicon.com, sujunfei2@hisilicon.com,
        saberlily.xia@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        steve.capper@arm.com, puck.chen@hisilicon.com,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        fengbaopeng2@hisilicon.com, nsaenzjulienne@suse.de,
        butao@hisilicon.com
References: <20200721073203.107862-1-liwei213@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <dce65cf2-399b-28a7-8375-c8d5a69a9c81@arm.com>
Date:   Thu, 23 Jul 2020 08:03:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200721073203.107862-1-liwei213@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/21/2020 01:02 PM, Wei Li wrote:
> For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
> do not free the reserved memory for the page map, this patch do it.
> 
> Signed-off-by: Wei Li <liwei213@huawei.com>
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
> ---
>  arch/arm64/mm/init.c | 81 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 71 insertions(+), 10 deletions(-)

This patch does not compile on 5.8-rc6 with defconfig.
