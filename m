Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339C02C4E01
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 05:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbgKZE0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 23:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730980AbgKZE0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 23:26:51 -0500
Received: from localhost (unknown [122.179.79.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C51521741;
        Thu, 26 Nov 2020 04:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606364811;
        bh=9Ab23uvA6gXoRUJ95dH3UVCAG+CifoKA/aDKNyM0a8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLtI8KH5wUOVTxE+nyeGSuezEqsK9cAE8jeOLXlbIz2kEvhFGmE/9CSTPV059Kh9E
         vJB0YPH/jG+5eOGo8oa6nwmq+pkzRp13wRnULW4s46O7X0NKgIBWUdsJ5osuvf4Ekt
         FWEaez9fYQuTMifCzBS7flTgh7GbkYad1jMg4bys=
Date:   Thu, 26 Nov 2020 09:56:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Jonathan Marek <jonathan@marek.ca>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: drivers/soundwire/qcom.c:767: undefined reference to
 `slimbus_bus'
Message-ID: <20201126042646.GH8403@vkoul-mobl>
References: <202011030351.iq9CBMO3-lkp@intel.com>
 <e0d74391-18ae-0493-b8a1-cbeb6f00bde8@infradead.org>
 <20201125055155.GD8403@vkoul-mobl>
 <6e298ed8-dc23-7a1f-1bb1-44ba2f43ee07@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e298ed8-dc23-7a1f-1bb1-44ba2f43ee07@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-11-20, 09:31, Randy Dunlap wrote:
> On 11/24/20 9:51 PM, Vinod Koul wrote:

> > From: Vinod Koul <vkoul@kernel.org>
> > Date: Wed, 25 Nov 2020 11:15:22 +0530
> > Subject: [PATCH] soundwire: qcom: Fix build failure when slimbus is module
> > 
> > Commit 5bd773242f75 ("soundwire: qcom: avoid dependency on
> > CONFIG_SLIMBUS") removed hard dependency on Slimbus for qcom driver but
> > it results in build failure when:
> > CONFIG_SOUNDWIRE_QCOM=y
> > CONFIG_SLIMBUS=m
> > 
> > drivers/soundwire/qcom.o: In function `qcom_swrm_probe':
> > qcom.c:(.text+0xf44): undefined reference to `slimbus_bus'
> > 
> > Fix this by using IS_REACHABLE() in driver which is recommended to be
> > sued with imply.
> 
>   used

right

> 
> > 
> > Fixes: 5bd773242f75 ("soundwire: qcom: avoid dependency on CONFIG_SLIMBUS")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks I have added this and Srini's and pushed out now.

-- 
~Vinod
