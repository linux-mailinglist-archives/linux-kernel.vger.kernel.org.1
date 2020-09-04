Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E5725D4A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 11:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgIDJVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 05:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730108AbgIDJVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:21:40 -0400
Received: from localhost (unknown [122.182.253.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1743120770;
        Fri,  4 Sep 2020 09:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599211300;
        bh=Uov920rjggCvYvSHnag6kknZPh9YIjInm05otcT8li8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QeOGLj7IoYNesH1dl//AFVm4t4un4mRiYV0epBQ3cFVUl1+POkVmoZKpvBWwhpBJP
         xVjHV2DG/dXJcyOOO6Hnx7geln7Q5Mros1J1fGexFxS2RDVkPHlzPqI9mG1Kedvs9l
         vnu76oFTeGRVLMyg2wo+KXo/aDt2Y7CEjBVhpJro=
Date:   Fri, 4 Sep 2020 14:51:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 0/4] soundwire: Remove sdw stream operations from Intel
Message-ID: <20200904092135.GY2639@vkoul-mobl>
References: <20200903204739.31206-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903204739.31206-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-09-20, 04:47, Bard Liao wrote:
> Sdw stream operation APIs can be called once per stream. Move these
> operations to dailink ops. The linked series is "ASoC: Add sdw stream
> operations to dailink ops".

Applied all, thanks

-- 
~Vinod
