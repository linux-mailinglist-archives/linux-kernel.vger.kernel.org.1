Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF22626CD98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgIPVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgIPQaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:30:23 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E84F22245;
        Wed, 16 Sep 2020 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600266577;
        bh=acejB/prIRtsxQWg9QojyBj2lNUB1jdZy+zS/DMW7k8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/G3ibtpL/helsck+Eq0cptCROJFScHN/nQ/IkiLTpfKInK2uYM5Yn+VH8e4+GNGp
         6gDbCrwtBRP+LI1uU+hJMCbKiug6fXVyOHA7jtcAtkVGb1tZSStL9V14CEv1D4ol3j
         +rMOgaGhVEQ5nOf3CMwF2kjFH6y5qpfXEaRV61rI=
Date:   Wed, 16 Sep 2020 19:59:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] soundwire: qcom: clear BIT FIELDs before value
 set.
Message-ID: <20200916142929.GR2968@vkoul-mobl>
References: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
 <20200916092125.30898-2-srinivas.kandagatla@linaro.org>
 <20200916124634.GM2968@vkoul-mobl>
 <24401c7c-b12c-0924-9d8f-fde633d15918@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24401c7c-b12c-0924-9d8f-fde633d15918@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-20, 08:18, Pierre-Louis Bossart wrote:
> 
> > > According to usage (bitfields.h) of REG_FIELDS,
> > > Modify is:
> > >    reg &= ~REG_FIELD_C;
> > >    reg |= FIELD_PREP(REG_FIELD_C, c);
> 
> 
> if this is indeed the case, all the code in cadence_master.c is also broken,
> e.g:
> 
> 	dpn_config = cdns_readl(cdns, dpn_config_off);
> 
> 	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_WL, (p_params->bps - 1));
> 	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_FLOW, p_params->flow_mode);
> 	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_DAT, p_params->data_mode);

This should be replaced with u32_replace_bits(), i am sending the fix
> 
> 
> Gah.

should have caught this :(

-- 
~Vinod
