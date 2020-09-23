Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091492754FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 11:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIWJ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 05:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWJ7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:59:48 -0400
Received: from localhost (unknown [122.171.175.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 073932076A;
        Wed, 23 Sep 2020 09:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600855187;
        bh=gXbJ4m3EOZZIo68OmhBK/pSuASydiqJQCDYHTsm+A+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7moUM9hDNa6yVYV/Akfr9mwsSyjdfx8/42T8ZXZRBMg90PB2MQuTDYLxRv1bb4qM
         IoNY7sguQBc5ZM1dFosz2A7rqM5uKycTMqJFhpk+1lhsN8xevBwjEs/HupwvNbvuq6
         6Jm3p0c6Mmh5nivWGzz+jIrZfPesiZ8AMOnbCjY8=
Date:   Wed, 23 Sep 2020 15:29:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/3] soundwire: enable Data Port test modes
Message-ID: <20200923095939.GE2968@vkoul-mobl>
References: <20200920193207.31241-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920193207.31241-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-09-20, 03:32, Bard Liao wrote:
> Test modes are required for all SoundWire IP, and help debug
> integration issues. This series adds debugfs support and data
> port test fail interrupt to enable data port test mode feature
> on Intel platforms. 

Applied, thanks

-- 
~Vinod
