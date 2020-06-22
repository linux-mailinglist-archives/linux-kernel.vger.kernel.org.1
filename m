Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3B7203638
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgFVLxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 07:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgFVLxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:53:24 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80C53206EB;
        Mon, 22 Jun 2020 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592826804;
        bh=p49NeIc0kpeFGr/02f2AC5waXFM9NEIZRqULrCZGSGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSUxBhJzMLZEuTCQANk9t/tNvguviJO/p1au7dd4aDMaKEkchFIXVYL4S8Fc3rhEs
         ngP87MlGp+eWUahARiLtHviMYo66HDW+qd9AVG711JMOKIRMHkj0PZiMKfSAV5gNh0
         oTnP5r93R1tFHKuFq8weP3grwiRPeVjHdlpAZDZo=
Date:   Mon, 22 Jun 2020 17:23:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH v2 0/6] soundwire: intel: transition to 3 steps
 initialization
Message-ID: <20200622115320.GK2324254@vkoul-mobl>
References: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-06-20, 02:20, Bard Liao wrote:
> This series is to split the original "soundwire: intel: transition to 3
> steps initialization" patch into different patches for better review.
> It also address comments from Vinod.

Applied all, thanks
-- 
~Vinod
