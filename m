Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55F265366
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 23:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgIJVe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 17:34:26 -0400
Received: from foss.arm.com ([217.140.110.172]:36620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbgIJNuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:50:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 429D011B3;
        Thu, 10 Sep 2020 06:43:27 -0700 (PDT)
Received: from [192.168.1.79] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14D603F66E;
        Thu, 10 Sep 2020 06:43:25 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Ensure GPU quirks are always initialised
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "Marty E. Plummer" <hanetzer@startmail.com>
References: <20200909122957.51667-1-steven.price@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <dd65be77-7410-3365-24b0-91d88c24568e@arm.com>
Date:   Thu, 10 Sep 2020 14:42:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909122957.51667-1-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2020 13:29, Steven Price wrote:
> The GPU 'CONFIG' registers used to work around hardware issues are
> cleared on reset so need to be programmed every time the GPU is reset.
> However panfrost_device_reset() failed to do this.
> 
> To avoid this in future instead move the call to
> panfrost_gpu_init_quirks() to panfrost_gpu_power_on() so that the
> regsiters are always programmed just before the cores are powered.
> 
> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> Signed-off-by: Steven Price <steven.price@arm.com>

Applied to drm-misc-next

Steve
