Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84C2A023B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgJ3KJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:09:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:18571 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgJ3KJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:09:00 -0400
IronPort-SDR: pOqnZk97Qp2Cfq5nAvaj6YundiAF5BvX9sQu2QzCcqJmP3wwg0/yvDOTCBJZAHEhFOmgK+y/Fm
 CjV3fscx24KQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="166000819"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="166000819"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 03:09:00 -0700
IronPort-SDR: mFvDCriwTsMm57moiZ5dHGjEUb97JPysXglsWYC7Z6KfmLA+w07/xGl9mpfV4Hf9+u/kqIdyHq
 WWzYj5zMardg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="356553438"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 30 Oct 2020 03:08:59 -0700
Received: from [10.255.142.248] (vramuthx-MOBL1.gar.corp.intel.com [10.255.142.248])
        by linux.intel.com (Postfix) with ESMTP id 86BAD5808A3;
        Fri, 30 Oct 2020 03:08:49 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [RESENDPATCH v15 2/2] mtd: rawnand: Add NAND controller support
 on Intel LGM SoC
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        robh+dt@kernel.org, boris.brezillon@collabora.com,
        devicetree@vger.kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20201026073021.33327-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201026073021.33327-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201028112037.326c06e2@xps13>
 <ab2b0b7a-93b6-51e4-ec08-7af4f4f38745@linux.intel.com>
 <20201030092329.280466d9@xps13>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <3ac47b27-5399-e0e7-43f3-d4394c26f800@linux.intel.com>
Date:   Fri, 30 Oct 2020 18:08:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201030092329.280466d9@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Thank you for the review comments...
On 30/10/2020 4:23 pm, Miquel Raynal wrote:
>>>> +
>>>> +static const struct of_device_id ebu_nand_match[] = {
>>>> +	{ .compatible = "intel,nand-controller", },
>>> No version or soc in the compatible? (not mandatory).
>> Yes, you're right, it should be "intel,lgm-ebunand", but this same driver supports 2 dfferent SOC's , that's the reason kept as generic
>> "intel,nand-controller"
> In this case I guess declaring two compatibles is the way to go.
Ok, Noted.

Best Regards
Vadivel
