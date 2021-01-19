Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025FC2FBE59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392098AbhASR4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389051AbhASOxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:53:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54B7B22241;
        Tue, 19 Jan 2021 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611067977;
        bh=qxNVJaCd1A2eYCrKmv6RdrjjKvh15c8Zqp3Z6CRJSno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zw6gIJz9J8Dkh3C8aPffue9lQz5JRjQ0/BCqd6vB9rfolgW9GNePqh+edfMAuNcQR
         MdwWbXeXbmQEdcWNj2Z9Kmz9ugGvMKrQRbLVaUeXOSkUtfGy2DXtkRg50UG9r2AheR
         p6w6mrBy8zxVTHB1/zcZ2mVES1K3q/8cm1LbGm4tXWOmbKhW1IajL+A841Di8o7OxF
         BtJ7LFF3H0VEHmY2gicHNvFEZ5N+jjmOy8uag+SYQqhiW1mqOkxZJnrd2fJ99LKd/T
         A/nPe0jiIFnNJ8jCa2LIYf7MP2q0ZFz5LyhOpnua0JXYojbCevxtFiV7zm6uXdXWHi
         qXYqf9pKMe5Mg==
Date:   Tue, 19 Jan 2021 20:22:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 2/2] soundwire: cadence: reduce timeout on transactions
Message-ID: <20210119145251.GT2771@vkoul-mobl>
References: <20210115061651.9740-1-yung-chuan.liao@linux.intel.com>
 <20210115061651.9740-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115061651.9740-3-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-01-21, 14:16, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Currently the timeout for SoundWire individual transactions is 2s.
> 
> This is too large in comparison with the enumeration and completion
> timeouts used in codec drivers.
> 
> A command will typically be handled in less than 100us, so 500ms for
> the command completion is more than generous.

Applied, thanks

-- 
~Vinod
