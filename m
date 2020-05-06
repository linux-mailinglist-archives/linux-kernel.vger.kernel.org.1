Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87301C7503
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgEFPfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:35:41 -0400
Received: from ale.deltatee.com ([207.54.116.67]:55930 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgEFPfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:35:41 -0400
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jWM58-0000e4-J6; Wed, 06 May 2020 09:35:36 -0600
To:     Sanjay R Mehta <sanju.mehta@amd.com>, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com,
        Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
References: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2197ff4b-be91-7c73-ad2e-f3849a088953@deltatee.com>
Date:   Wed, 6 May 2020 09:35:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Shyam-sundar.S-k@amd.com, arindam.nath@amd.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, sanju.mehta@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        LR_URI_NUMERIC_ENDING,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v3 0/5] ntb perf, ntb tool and ntb-hw improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-05-05 10:21 p.m., Sanjay R Mehta wrote:
> v3: 
> - Increased ntb_perf command re-try sleep time
> - avoid false dma unmap of dst address.
> 
> v2: Incorporated improvements suggested by Logan Gunthorpe
> 
> Links of the review comments for v3:
> 1. https://lkml.org/lkml/2020/3/11/981
> 2. https://lkml.org/lkml/2020/3/10/1827
> 
> Logan Gunthorpe (1):
>   ntb: hw: remove the code that sets the DMA mask
> 
> Sanjay R Mehta (4):
>   ntb_perf: pass correct struct device to dma_alloc_coherent
>   ntb_tool: pass correct struct device to dma_alloc_coherent
>   ntb_perf: increase sleep time from one milli sec to one sec
>   ntb_perf: avoid false dma unmap of destination address

Looks good to me. For these 4 patches:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan
