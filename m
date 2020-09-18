Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE9A26FBFA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIRMCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgIRMCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:02:33 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F42420848;
        Fri, 18 Sep 2020 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600430553;
        bh=hPQbvKMhsX/VBlMqQXADrTEDn/hz9SyKcPsiDbJyVwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpjNoPkrE9MhPcKSNoWS4AFSrH990PR0b+eFy8zWF9xLAN4zp7QfHCeIch2vD1AG8
         zi1nmNt7va/tjAe5q4YzH/APAdXoChNm2WVJvNNjQtSLtM2nQpPhgj4A8cL/lB8+Ba
         hFfzoGmn0sFRmwdfbjPcNF7U0JQBteg0GN0gEGQ8=
Date:   Fri, 18 Sep 2020 17:32:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] soundwire: qcom: fix IP version v1.5.1 support
Message-ID: <20200918120229.GQ2968@vkoul-mobl>
References: <20200917120138.11313-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917120138.11313-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-09-20, 13:01, Srinivas Kandagatla wrote:
> While testing Qualcomm soundwire controller version 1.5.1, found two issue,
> Firstly the frame shape information configured vs the bus parameters
> are out of sync. secondly some ports on this ip version require
> block packing mode support.
> 
> With this patchset I was able to test 2 WSA speakers!
> 
> Also I found a regression due to move to REG_FIELD, which patch 1 fixes it!

Applied all, thanks

-- 
~Vinod
