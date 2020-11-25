Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33D2C384E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 06:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgKYFCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 00:02:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgKYFCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 00:02:40 -0500
Received: from localhost (unknown [122.179.120.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BDC72075A;
        Wed, 25 Nov 2020 05:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606280560;
        bh=Z2MumUoWaErnDkqpEsdXBKAkVR9BygO6dPF4F2sLmas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHxY11tKenZKqF/Bb1Eu00O6dpub0GG89Z7v3SGCpvjK7QbthgBDQBYpAWBpuL8b9
         C2rvJtedchduzLIbo+lNNzmGolr3g4Z0G3wsDkfgXm98wqk1ZQk87Z5Mp3fsQ2ww/t
         ocLi+wOw3bikjCAc0Vjv7R4e3oh4D56b9REIyi7w=
Date:   Wed, 25 Nov 2020 10:32:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/5] soundwire: only clear valid interrupts
Message-ID: <20201125050235.GB8403@vkoul-mobl>
References: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-11-20, 09:33, Bard Liao wrote:
> We wrote 1 to the handled interrupts bits along with 0 to all other bits
> to the SoundWire DPx interrupt register. However, DP0 has reserved fields
> and the read-only SDCA_CASCADE bit. DPN also has reserved fields. We should
> not try to write values in these fields.
> Besides, we deal with pending interrupts in a loop but we didn't reset the
> slave_notify status.

Applied, thanks

-- 
~Vinod
