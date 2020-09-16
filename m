Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F1F26C654
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgIPRqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbgIPRkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:41 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4389F206B6;
        Wed, 16 Sep 2020 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600267741;
        bh=xciECLeowjq9oRm5zSpSaLEMfjQl3cjS16SOJpmO/h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rk0IbZhmcjCCVrlZD0ocwFS4EDzxXZOajRd7LCMMZBzcOOU7iQStzKL4xNIogEJQB
         CZvsgOQ6+TLv8BVcwb18Ade8Stb1tL2cp3NnrxqKRQ7ENW2DQWJnFMUHGGygMSqZGB
         6VeqVJcZKJ5tMl4/nKvY5rD0Dl2aZcP0bUeI3Nbc=
Date:   Wed, 16 Sep 2020 20:18:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] soundwire: qcom: clear BIT FIELDs before value
 set.
Message-ID: <20200916144852.GS2968@vkoul-mobl>
References: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
 <20200916092125.30898-2-srinivas.kandagatla@linaro.org>
 <20200916124634.GM2968@vkoul-mobl>
 <24401c7c-b12c-0924-9d8f-fde633d15918@linux.intel.com>
 <20200916142929.GR2968@vkoul-mobl>
 <42bbf464-2bc9-2b13-5f08-a19ad1848277@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42bbf464-2bc9-2b13-5f08-a19ad1848277@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-20, 09:36, Pierre-Louis Bossart wrote:
> 
> 
> On 9/16/20 9:29 AM, Vinod Koul wrote:
> > On 16-09-20, 08:18, Pierre-Louis Bossart wrote:
> > > 
> > > > > According to usage (bitfields.h) of REG_FIELDS,
> > > > > Modify is:
> > > > >     reg &= ~REG_FIELD_C;
> > > > >     reg |= FIELD_PREP(REG_FIELD_C, c);
> > > 
> > > 
> > > if this is indeed the case, all the code in cadence_master.c is also broken,
> > > e.g:
> > > 
> > > 	dpn_config = cdns_readl(cdns, dpn_config_off);
> > > 
> > > 	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_WL, (p_params->bps - 1));
> > > 	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_FLOW, p_params->flow_mode);
> > > 	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_DAT, p_params->data_mode);
> > 
> > This should be replaced with u32_replace_bits(), i am sending the fix
> 
> wondering if we should replace all uses of FIELD_PREP with either
> u32_insert_bits() or u32_encode_bits() then?

That might be overkill as in the rest of the cases we have

        foo = FIELD_PREP();
        foo |= FIELD_PREP();

so the first one would set the bitfield and clear the rest

Thanks
-- 
~Vinod
