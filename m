Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE171DB5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 15:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgETNzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 09:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgETNzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:55:18 -0400
Received: from localhost (unknown [122.178.227.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FEB6206C3;
        Wed, 20 May 2020 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589982917;
        bh=77eBqGPO9oS6IAJe/Q1U2VGxJbTGtULUpvt12elCIEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDVoSJtml/vZvPY+QL93DOKrAz8b2rx0MEzt0MpJSeplTEHUtTelisIA5A49pwfqN
         OGfnznwwcy3P5ERnzc8tsw1WuOnvrsfrm/LMe9Cju45/aJ3WiPmWC6M9nHMJTdbOQj
         gtw87WVzkIHsiXScRyFyXtT4Jktbt1UD/9phXEeQ=
Date:   Wed, 20 May 2020 19:25:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/2] soundwire: intel: use a single module
Message-ID: <20200520135509.GY374218@vkoul-mobl.Dlink>
References: <20200519191903.6557-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519191903.6557-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-05-20, 03:19, Bard Liao wrote:
> From: Rander Wang <rander.wang@intel.com>
> 
> It's not clear why we have two modules for the Intel controller/master
> support when there is a single Kconfig. This adds complexity for no
> good reason, the two parts need to work together anyways.

Applied, thanks

-- 
~Vinod
