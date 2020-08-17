Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10289245C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 08:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHQGfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 02:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgHQGfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 02:35:04 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A2020716;
        Mon, 17 Aug 2020 06:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597646104;
        bh=WOzCSas7pYUPfYTUIGe5up6ZYyAXxS4L+F4vNZkQK1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJSo0/n5Vd+zD+WAvL5Oe4jBG6FUznp0lkrzbUYzWnyu6IdsAu8CI9w4qXsY1yqtY
         FRK8CCbq2YfnqLCRsvw674uYtvZP1LZRvU+ZIsGMwuad903CNp2et/MD2TQvfdmwdF
         qABh28s3r9qwEgA5W3q8UhHP/apIdSeKB85GYJg4=
Date:   Mon, 17 Aug 2020 12:04:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2] soundwire: master: enable pm runtime
Message-ID: <20200817063455.GN2639@vkoul-mobl>
References: <20200726215945.3119-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726215945.3119-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-07-20, 05:59, Bard Liao wrote:
> The hierarchy of soundwire devices is platform device -> M device -> S
> device. A S device is physically attached on the platform device. So the
> platform device should be resumed when a S device is resumed. As the
> bridge of platform device and S device, we have to implement runtime pm
> on M driver. We have set runtime pm ops in M driver already, but still
> need to enable runtime pm.

Applied, thanks

-- 
~Vinod
