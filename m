Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E932C2034
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgKXIju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:39:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgKXIjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:39:49 -0500
Received: from localhost (unknown [122.167.149.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C7E8206FA;
        Tue, 24 Nov 2020 08:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606207189;
        bh=pxqmtk5/OaJeLZ3v+XADzNZmmNxQt38OoL+FYoVFdQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fARV9PljrFrO9MOPpSMv0niQ7g9dGIJw1CQMi+X0IGvaI9tdotf2cUDxNOj0P+cSi
         QNizqze5/eVlibQ9eivR7isQig4WRSkM4OMwcd7rBOCcE78BxwHGkevMHfMjN5CxYK
         ESCeNCDyOzXDQHdR3eZAqdAT+qioPbT4+E2/oS4w=
Date:   Tue, 24 Nov 2020 14:09:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: SDCA: detect sdca_cascade interrupt
Message-ID: <20201124083944.GK8403@vkoul-mobl>
References: <20201104152358.9518-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104152358.9518-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-11-20, 23:23, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The SoundWire 1.2 specification defines an "SDCA cascade" bit which
> handles a logical OR of all SDCA interrupt sources (up to 30 defined).
> 
> Due to limitations of the addressing space, this bit is located in the
> SDW_DP0_INT register when DP0 is used, or alternatively in the
> DP0_SDCA_Support_INTSTAT register when DP0 is not used.
> 
> To allow for both cases to be handled, this bit will be checked in the
> main device-level interrupt handling code. This will result in the
> register being read twice if DP0 is enabled, but it's not clear how to
> optimize this case. It's also more logical to deal with this interrupt
> at the device than the port level, this bit is really not DP0 specific
> and its location in the DP0_INTSTAT bit is only due to the lack of
> free space in SCP_INTSTAT_1.
> 
> The SDCA_Cascade bit cannot be masked or cleared, so the interrupt
> handling only forwards the detection to the Slave driver, which will
> deal with reading the relevant SDCA status bits and clearing them. The
> bus driver only signals the detection.
> 
> The communication with the Slave driver is based on the same interrupt
> callback, with only an extension to provide the status of the
> sdca_cascade bit.

Applied, thanks

-- 
~Vinod
