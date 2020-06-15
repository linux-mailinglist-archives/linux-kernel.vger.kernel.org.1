Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220EC1F8F09
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 09:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgFOHHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 03:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgFOHHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:07:20 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F354120707;
        Mon, 15 Jun 2020 07:07:16 +0000 (UTC)
Subject: Re: drivers/net/can/kvaser_pciefd.c:801:17: sparse: sparse: cast
 removes address space '<asn:2>' of expression
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>,
        Henning Colliander <henning.colliander@evidente.se>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>
References: <202006121356.lKucoVPo%lkp@intel.com>
 <e93fe895-a6b8-34ff-f9c8-00ec7138b1c1@pengutronix.de>
 <9b599221-3c15-909c-168a-766c554827d9@linux-m68k.org>
 <20200612163509.6ieqxm4peqcfgd7o@ltop.local>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <044ff868-00f1-90a4-25e6-9f62f7a042ad@linux-m68k.org>
Date:   Mon, 15 Jun 2020 17:07:13 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612163509.6ieqxm4peqcfgd7o@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/6/20 2:35 am, Luc Van Oostenryck wrote:
> On Sat, Jun 13, 2020 at 01:33:16AM +1000, Greg Ungerer wrote:
>>>>      arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
>>
>> This one I am not sure about yet.
>> Still investigating.
> 
> 	swab32(__raw_readl(addr)) ?
> 
> Keeping __le32_to_cpu() will only force you to use ugly casts for no benefits
> and the comment above explain clearly the situation about the endianness.

That is unfortunate, the use of le32_to_cpu() made it very clear
what was going on - for those that don't choose to read comments.

In any case that would seem to be the cleanest solution.
Patch to follow.

Regards
Greg

  
