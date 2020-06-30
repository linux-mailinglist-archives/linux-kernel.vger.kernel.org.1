Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB320F8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389830AbgF3P5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 11:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730478AbgF3P5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:57:33 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20BE2068F;
        Tue, 30 Jun 2020 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593532652;
        bh=9Gn86c0eaFtjRePihFDUtEKyfWZ/egWqKrd+Msf1fJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MOZJJD3ekIMjv9Q3vcG6xeGRAGvGu3G/QtP7hzgydRVMLYVutKSb0opJ7xD3SJGzh
         cc3pb7HS2Vo3xz9N8x6PrU36mdmSWpY8PRiasyt7/6pMJiMfvW88DFKRnYRWl5PqDG
         aL5aj+iT5bzACtTyJMj0P/YrxnQ04sAEOuVNVbbU=
Date:   Tue, 30 Jun 2020 21:27:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/4] soundwire: add SoundWire 1.2 spec support
Message-ID: <20200630155728.GQ2599@vkoul-mobl>
References: <20200608205436.2402-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608205436.2402-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-06-20, 04:54, Bard Liao wrote:
> This series adds basic support for SoundWire 1.2.

Applied, thanks

-- 
~Vinod
