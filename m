Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598F42417A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 09:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgHKH4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 03:56:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:59256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbgHKH4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:56:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DACD9AB9F;
        Tue, 11 Aug 2020 07:56:40 +0000 (UTC)
Date:   Tue, 11 Aug 2020 09:56:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/Kconfig: Fix CPU number in LOG_CPU_MAX_BUF_SHIFT
 description
Message-ID: <20200811075619.GE6215@alley>
References: <20200811073145.3457-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811073145.3457-1-pmenzel@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-08-11 09:31:45, Paul Menzel wrote:
> Currently, LOG_BUF_SHIFT defaults to 17, which is 2 ^ 17 bytes = 128 KB,
> and LOG_CPU_MAX_BUF_SHIFT defaults to 12, which is 2 ^ 12 bytes = 4 KB.
> 
> Half of 128 KB is 64 KB, so more than 16 CPUs are required for the value
> to be used, as then the sum of contributions is greater than 64 KB for
> the first time. My guess is, that the description was written with the
> configuration values used in the SUSE in mind.
> 
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Fixes: 23b2899f7f ("printk: allow increasing the ring buffer depending on the number of CPUs")
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Great catch.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
