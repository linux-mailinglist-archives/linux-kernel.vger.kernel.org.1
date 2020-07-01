Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2504210359
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 07:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGAFjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 01:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgGAFjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 01:39:15 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E76920722;
        Wed,  1 Jul 2020 05:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593581955;
        bh=rAReKMBuPEcSrpqTIyDSz5RppJfxO0qdNn1tZhXgB98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJ/CeRZmrVl3MDu+is500vYr9W8IyBYjUO/J5YEHMGuccoZ7DzqG3L8V3lz+59/Qw
         aIAXZYZDtWWvbmYpj1vbaGzBZgPcspgCRFSXrG0KGBrdJA1zTcjyyLhnZLViqZJm0o
         X2lzSmWcR+F4QEmXU7UdJasB5KQnZcMNdoFFTgUs=
Date:   Wed, 1 Jul 2020 11:09:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com,
        slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 2/5] soundwire: stream: add helper to startup/shutdown
 streams
Message-ID: <20200701053910.GU2599@vkoul-mobl>
References: <20200622212332.16277-1-yung-chuan.liao@linux.intel.com>
 <20200622212332.16277-3-yung-chuan.liao@linux.intel.com>
 <20200630160349.GR2599@vkoul-mobl>
 <5123471d-92f3-8f49-7a2c-d7b70bf442af@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5123471d-92f3-8f49-7a2c-d7b70bf442af@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-06-20, 11:58, Pierre-Louis Bossart wrote:
> > > +int sdw_startup_stream(void *sdw_substream)
> > 
> > Can we have kernel doc style Documentation for exported APIs?
> 
> yes, that's a miss indeed.
> 
> Though if we follow the existing examples it's not going to be very
> informative, e.g.

Yeah but...
> 
> /**
>  * sdw_disable_stream() - Disable SoundWire stream
>  *
>  * @stream: Soundwire stream
>  *
>  * Documentation/driver-api/soundwire/stream.rst explains this API in detail

it would help to have this pointer. I plan to include the kernel-doc
comments in Documentation for sdw so it would great to have these in
place

-- 
~Vinod
