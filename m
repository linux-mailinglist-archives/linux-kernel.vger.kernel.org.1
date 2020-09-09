Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85ED262958
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 09:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgIIH4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 03:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgIIH4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:56:06 -0400
Received: from localhost (unknown [122.179.21.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7508F2087C;
        Wed,  9 Sep 2020 07:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599638165;
        bh=JARiYueBjjGPlebhXcfjdVe1PdGZejQ1v9IQ50hAApA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xDYefFctxhwXQbotzFIaWwJRSkw/f/qoeiMWJ8/r6KjzfmC4qqvetpY5qNmqI6l+J
         i4WnFSoEuohmVoItnSzX23DYn3OawZOmywupJUQN3/9nNiD9L8FkUnNMTWXesGCzF5
         MFDGj9q6EdlJ+6MdFNJFpgWVyORi0/LIdgzO9ldM=
Date:   Wed, 9 Sep 2020 13:25:55 +0530
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
Message-ID: <20200909075555.GK77521@vkoul-mobl>
References: <20200901162225.33343-1-pierre-louis.bossart@linux.intel.com>
 <20200901162225.33343-3-pierre-louis.bossart@linux.intel.com>
 <20200904050244.GT2639@vkoul-mobl>
 <f35a0ae7-2779-0c69-9ef3-0d0e298888ac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f35a0ae7-2779-0c69-9ef3-0d0e298888ac@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-09-20, 08:33, Pierre-Louis Bossart wrote:
> Thanks for the review Vinod,
> 
> > This is good, thanks for adding it in changelog. Can you also add this
> > description to Documentation (that can come as an individual patch),
> 
> ok
> 
> > > +/*
> > > + * v1.2 device - SDCA address mapping
> > > + *
> > > + * Spec definition
> > > + *	Bits		Contents
> > > + *	31		0 (required by addressing range)
> > > + *	30:26		0b10000 (Control Prefix)
> > 
> > So this is for 30:26
> 
> I don't get the comment, sorry.

I should have added see below.

> > 
> > > + *	25		0 (Reserved)
> > > + *	24:22		Function Number [2:0]
> > > + *	21		Entity[6]
> > > + *	20:19		Control Selector[5:4]
> > > + *	18		0 (Reserved)
> > > + *	17:15		Control Number[5:3]
> > > + *	14		Next
> > > + *	13		MBQ
> > > + *	12:7		Entity[5:0]
> > > + *	6:3		Control Selector[3:0]
> > > + *	2:0		Control Number[2:0]
> > > + */
> > > +
> > > +#define SDW_SDCA_CTL(fun, ent, ctl, ch)						\
> > > +	(BIT(30)							|	\
> > 
> > Programmatically this is fine, but then since we are defining for the
> > description above, IMO it would actually make sense for this to be defined
> > as FIELD_PREP:
> > 
> >          FIELD_PREP(GENMASK(30, 26), 1)
> > 
> > or better
> > 
> >          u32_encode_bits(GENMASK(30, 26), 1)
> > 
> > > +	FIELD_PREP(GENMASK(24, 22), FIELD_GET(GENMASK(2, 0), (fun)))	|	\
> > 
> > Why not use u32_encode_bits(GENMASK(24, 22), (fun)) instead for this and
> > below?
> 
> Because your comment for the v1 review was to use FIELD_PREP/FIELD_GET, and
> your other patches for bitfield access only use FIELD_PREP/FIELD_GET.

yes and looking at this, I feel u32_encode_bits(GENMASK(24, 22), (fun))
would look better than FIELD_PREP(GENMASK(24, 22), FIELD_GET(GENMASK(2, 0), (fun)))

Do you agree?

> 
> I really don't care about which macro is used but it wouldn't hurt to have
> some level of consistency between different parts of the code? Why not use
> FIELD_PREP/GET everywhere?
> 
> > > +	FIELD_PREP(BIT(21), FIELD_GET(BIT(6), (ent)))			|	\
> > > +	FIELD_PREP(GENMASK(20, 19), FIELD_GET(GENMASK(5, 4), (ctl)))	|	\
> > > +	FIELD_PREP(GENMASK(17, 15), FIELD_GET(GENMASK(5, 3), (ch)))	|	\
> > > +	FIELD_PREP(GENMASK(12, 7), FIELD_GET(GENMASK(5, 0), (ent)))	|	\
> > > +	FIELD_PREP(GENMASK(6, 3), FIELD_GET(GENMASK(3, 0), (ctl)))	|	\
> > > +	FIELD_PREP(GENMASK(2, 0), FIELD_GET(GENMASK(2, 0), (ch))))
> > 
> > Also, can we rather have a nice function for this, that would look much
> > cleaner
> 
> I am not sure what would be cleaner but fine.

Ok

> > And while at it, consider defining masks for various fields rather than
> > using numbers in GENMASK() above, that would look better, be more
> > readable and people can reuse it.
> 
> Actually on this one I disagree. These fields are not intended to be used by
> anyone, the goal is precisely to hide them behind regmap, and the use of raw
> numbers makes it easier to cross-check the documentation and the code.
> Adding a separate set of definitions would not increase readability.

Which one would you prefer:

        #define SDCA_FUN_MASK           GENMASK(24, 22)

        foo |= u32_encode_bits(SDCA_FUN_MASK, fun)

Or the one proposed...?

-- 
~Vinod
