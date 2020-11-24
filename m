Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA3E2C202D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgKXIjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgKXIjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:39:08 -0500
Received: from localhost (unknown [122.167.149.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCF0B206FA;
        Tue, 24 Nov 2020 08:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606207147;
        bh=iANSHoT6ai2CnJZ+iiwv27Wcx82PQo3VLZlsbLa9oOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xfsiGijaatWRH+EIx9AoiQ49LDB8/0+AyQlZ+NmLEgTvHoWqX8IV9CLfS6YkZjDZ/
         yucQ9OmCv5IcJCZPCFh6xXykE+fJyLwwUE4cOEQt6zJs0xyA5A/GxUGn0qFlZhKCVk
         IciK/jYIwcpdAx3lcqV3HXOK6GCTahjpVZduO13E=
Date:   Tue, 24 Nov 2020 14:09:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: Fix DEBUG_LOCKS_WARN_ON for uninitialized
 attribute
Message-ID: <20201124083902.GJ8403@vkoul-mobl>
References: <20201104112941.1134-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104112941.1134-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-11-20, 11:29, Srinivas Kandagatla wrote:
> running kernel with CONFIG_DEBUG_LOCKS_ALLOC enabled will below warning:
> 
> BUG: key ffff502e09807098 has not been registered!
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 5 PID: 129 at kernel/locking/lockdep.c:4623
> 	lockdep_init_map_waits+0xe8/0x250
> Modules linked in:
> CPU: 5 PID: 129 Comm: kworker/5:1 Tainted: G
>        W         5.10.0-rc1-00277-ged49f224ca3f-dirty #1210
> Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> Workqueue: events deferred_probe_work_func
> pstate: 80c00005 (Nzcv daif +PAN +UAO -TCO BTYPE=--)
> pc : lockdep_init_map_waits+0xe8/0x250
> lr : lockdep_init_map_waits+0xe8/0x250

Applied, thanks

-- 
~Vinod
