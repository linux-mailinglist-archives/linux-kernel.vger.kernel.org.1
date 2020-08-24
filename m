Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C63224FFF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 16:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHXOh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 10:37:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:39447 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgHXOh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 10:37:57 -0400
IronPort-SDR: 7iWZyPk6yxBvDYRh0MEB0zbVhwwS5qMwUgsKc3uYdrapvU6y2MqgsqkhUBhDDuf6Epp8Wd75fv
 7FrjtBK+ptKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="220178776"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="220178776"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 07:37:57 -0700
IronPort-SDR: k8+kAdr7UoNl4ARrNTt0NMlv377YXwBUPHzRtrOMM6vfQe+5yjaIO0cj7ntFTM6PrwbjZc+Odt
 kT3IJqpHW7Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="298733963"
Received: from shizhong-mobl1.ccr.corp.intel.com (HELO [10.212.53.175]) ([10.212.53.175])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2020 07:37:57 -0700
Subject: Re: [PATCH] ntb: intel: Fix memleak in intel_ntb_pci_probe
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
References: <20200823065512.11626-1-dinghao.liu@zju.edu.cn>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <396e55a5-7ebe-1e81-b1b6-9a53cd885a8a@intel.com>
Date:   Mon, 24 Aug 2020 07:37:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200823065512.11626-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2020 11:55 PM, Dinghao Liu wrote:
> The default error branch of a series of pdev_is_gen calls
> should free ndev just like what we've done in these calls.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Thanks Dinghao
Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index 3185efeab487..093dd20057b9 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -1893,7 +1893,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
>   			goto err_init_dev;
>   	} else {
>   		rc = -EINVAL;
> -		goto err_ndev;
> +		goto err_init_pci;
>   	}
>   
>   	ndev_reset_unsafe_flags(ndev);
> 
