Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852DB26CD55
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgIPU6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgIPQd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:33:27 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F338420665;
        Wed, 16 Sep 2020 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600259750;
        bh=dUpUZqe3rC0sVtDWDaPG2xJyKgaEhAZQeOxcGrqq61I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aClGXSR6UsBal59SBWT86GU8nrZzQUWEy+YFXPAHx6RnuJqnIj4OOq7G9hwiTPAVh
         phpz/3aiU+J3+ipNNHH04Nf8BXPocH9FpXlJKfQdH6nw7M6uoFARGm+QxHLMuR2GAA
         Td6e/ltujdkiU7VAnoAPXpsbFUqosKCXR7IwU14s=
Date:   Wed, 16 Sep 2020 18:05:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] soundwire: SDCA: add helper macro to access
 controls
Message-ID: <20200916123545.GK2968@vkoul-mobl>
References: <20200904050244.GT2639@vkoul-mobl>
 <f35a0ae7-2779-0c69-9ef3-0d0e298888ac@linux.intel.com>
 <20200909075555.GK77521@vkoul-mobl>
 <184867c2-9f0c-bffe-2eb7-e9c5735614b0@linux.intel.com>
 <20200910062223.GQ77521@vkoul-mobl>
 <adf51127-2813-cdf0-e5a6-f5ec3b0d33fa@linux.intel.com>
 <20200911070649.GU77521@vkoul-mobl>
 <21606609-8aaf-c7b2-ffaf-c7d37de1fa3f@linux.intel.com>
 <20200914050825.GA2968@vkoul-mobl>
 <11feabb2-dc8b-7acc-6e4d-0903fc435b00@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11feabb2-dc8b-7acc-6e4d-0903fc435b00@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-09-20, 09:44, Pierre-Louis Bossart wrote:
> > For LSB bits, I dont think this is an issue. I expect it to work, for example:
> > #define CONTROL_LSB_MASK  GENMASK(2, 0)
> >          foo |= u32_encode_bits(control, CONTROL_LSB_MASK);
> > 
> > would mask the control value and program that in specific bitfeild.
> > 
> > But for MSB bits, I am not sure above will work so, you may need to extract
> > the bits and then use, for example:
> > #define CONTROL_MSB_BITS        GENMASK(5, 3)
> > #define CONTROL_MSB_MASK        GENMASK(17, 15)
> > 
> >          control = FIELD_GET(CONTROL_MSB_BITS, control);
> >          foo |= u32_encode_bits(control, CONTROL_MSB_MASK);
> > 
> > > If you have a better suggestion that the FIELD_PREP/FIELD_GET use, I am all
> > > ears. At the end of the day, the mapping is pre-defined and we don't have
> > > any degree of freedom. What I do want is that this macro/inline function is
> > > shared by all codec drivers so that we don't have different interpretations
> > > of how the address is constructed.
> > 
> > Absolutely, this need to be defined here and used by everyone else.
> 
> Compare:
> 
> #define SDCA_CONTROL_MSB_BITS        GENMASK(5, 3)
> #define SDCA_CONTROL_MSB_MASK        GENMASK(17, 15)
> #define SDCA_CONTROL_LSB_MASK        GENMASK(2, 0)
> 
> foo |= u32_encode_bits(control, SDCA_CONTROL_LSB_MASK);
> control = FIELD_GET(SDCA_CONTROL_MSB_BITS, control);
> foo |= u32_encode_bits(control, SDCA_CONTROL_MSB_MASK);
> 
> with the original proposal:
> 
> foo |= FIELD_GET(GENMASK(2, 0), control))	
> foo |= FIELD_PREP(GENMASK(17, 15), FIELD_GET(GENMASK(5, 3), control))	
> 
> it gets worse when the LSB positions don't match, you need another variable
> and an additional mask.
> 
> I don't see how this improves readability? I get that hard-coding magic
> numbers is a bad thing in general, but in this case there are limited
> benefits to the use of additional defines.

I think it would be prudent to define the masks and use them rather than
magic values. Also it makes it future proof

Thanks
-- 
~Vinod
