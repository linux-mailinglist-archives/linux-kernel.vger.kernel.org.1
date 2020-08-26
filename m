Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495B625296C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 10:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHZIql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 04:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgHZIqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:46:40 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F552071E;
        Wed, 26 Aug 2020 08:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598431600;
        bh=HoUnL2q1WxrGMZkSItOoLBcbNE9id2blFCNhr5ujsSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dih5vfgd2MSYnjNKJIwqN2EcDZjiYbs4WmUSide/Pmx/pPy68SGTT5MpMvQ2wpIqw
         TISsDTMzie7mChKUidct21AZ1AMPSbh/sYoup4B07jNaMmQhG5QvGAQx436EGER4yw
         DnqW7haaYdXOpEL3cHpWNavOYSSeRzpJojzVu8fQ=
Date:   Wed, 26 Aug 2020 14:16:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2] soundwire: intel: fix intel_suspend/resume defined
 but not used warning
Message-ID: <20200826084635.GX2639@vkoul-mobl>
References: <20200824133234.28115-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200824133234.28115-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-08-20, 21:32, Bard Liao wrote:
> When CONFIG_PM_SLEEP is not defined, GCC throws compilation warnings:
> 
> drivers/soundwire/intel.c:1799:12: warning: ‘intel_resume’ defined but not
> used [-Wunused-function]
>  static int intel_resume(struct device *dev)
>             ^~~~~~~~~~~~
> drivers/soundwire/intel.c:1683:12: warning: ‘intel_suspend’ defined but not
> used [-Wunused-function]
>  static int intel_suspend(struct device *dev)
>             ^~~~~~~~~~~~~
> 
> Fix by using __maybe_unused macro.

Applied, thanks

-- 
~Vinod
