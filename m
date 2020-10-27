Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A040129AA44
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898950AbgJ0LHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:07:31 -0400
Received: from foss.arm.com ([217.140.110.172]:38360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898903AbgJ0LHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:07:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7D8E30E;
        Tue, 27 Oct 2020 04:07:29 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 321DB3F66E;
        Tue, 27 Oct 2020 04:07:28 -0700 (PDT)
Date:   Tue, 27 Oct 2020 11:07:25 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, kbuild-all@lists.01.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        broonie@kernel.org, robh@kernel.org, satyakim@qti.qualcomm.com
Subject: Re: [PATCH v3 1/4] firmware: arm_scmi: Add Voltage Domain Support
Message-ID: <20201027110725.GE20482@e120937-lin>
References: <20201026203148.47416-2-cristian.marussi@arm.com>
 <202010271312.r4CIynpy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010271312.r4CIynpy-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 02:04:39PM +0800, kernel test robot wrote:
> Hi Cristian,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on soc/for-next]
> [also build test WARNING on next-20201026]
> [cannot apply to regulator/for-next robh/for-next rockchip/for-next keystone/next arm64/for-next/core linux/master linux-rpi/for-rpi-next at91/at91-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Cristian-Marussi/Add-support-for-SCMIv3-0-Voltage-Domain-Protocol-and-SCMI-Regulator/20201027-043404
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> config: arm-randconfig-c004-20201026 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> "coccinelle warnings: (new ones prefixed by >>)"
> >> drivers/firmware/arm_scmi/voltage.c:381:11-17: ERROR: application of sizeof to pointer
> 
This is a false positive because the intention here was in fact to
allocate an array of pointers with devm_kcalloc().
Maybe I could explicitly use a sizeof(void *) to avoid fooling
coccicheck ?

Thanks

Cristian

> Please review and possibly fold the followup patch.
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


