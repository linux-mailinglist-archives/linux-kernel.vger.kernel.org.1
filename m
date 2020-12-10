Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267332D5F00
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbgLJPGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727766AbgLJPGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:06:22 -0500
Date:   Fri, 11 Dec 2020 00:05:34 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607612741;
        bh=rUc8kAAzgIPOPqDkqYodpVmwWA4T53QTUItA9JEQX1E=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBRxezUJnM3zNgdAvq4O81fM22NGLO6WD4VT4KIBL45R0sAi6OJNS5aU0RPJuKDht
         zzn76UtpaSkcsrialYwyBtsugPN0m2FGjEW6Bg3PEEputq613IEZ6C00i6HBRvQQTu
         Xl8Q8m1RlIt6NIVK11t2rQ5d9D/dZ3ahieMLgTbQ5nquTo9T6DmbRQNLfVBR7yv3Wc
         82UE48MhuNU8JLDo/FT4F6W3uGJ1mLrJPdnlmLE5TxuWxHjlhxNPNPZPkddcDd2G9e
         /hi5QTxQoauLWg9L20PsRjHYiojVHlpsPchoTH/bhE0kIrYwLqaBJ9LbjaPLLsKoqZ
         A8buRGoPAyJvg==
From:   Keith Busch <kbusch@kernel.org>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20201210150534.GB3645@redsun51.ssa.fujisawa.hgst.com>
References: <20201209213228.5044-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209213228.5044-1-ematsumiya@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 06:32:27PM -0300, Enzo Matsumiya wrote:
> +void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
> +{
> +	hwmon_device_unregister(ctrl->dev);
> +}

The hwmon registration uses the devm_ version, so don't we need to use
the devm_hwmon_device_unregister() here?
