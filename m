Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD4A2CFAF1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 11:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgLEKGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 05:06:12 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:47412 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgLEKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 05:01:25 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 549A920110F;
        Sat,  5 Dec 2020 09:05:30 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 54C6620ECA; Sat,  5 Dec 2020 09:58:05 +0100 (CET)
Date:   Sat, 5 Dec 2020 09:58:05 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Wei Li <liwei391@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com
Subject: Re: [PATCH] drivers/pcmcia: Fix error return code in
 electra_cf_probe()
Message-ID: <X8tLnWhuUhTjwnH4@light.dominikbrodowski.net>
References: <20201124070040.3583-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124070040.3583-1-liwei391@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, Nov 24, 2020 at 03:00:40PM +0800 schrieb Wei Li:
> When it fails to call of_get_property(), it just jumps to 'fail1',
> while the 'status' which will be returned is not updated.
> 
> Fixes: 2b571a066a2f ("pcmcia: CompactFlash driver for PA Semi Electra boards")
> Signed-off-by: Wei Li <liwei391@huawei.com>

Thnaks for the patch. However, this issue is already fixed by
commit f15480e947d4 ("pcmcia/electra_cf: Fix some return values in 'electra_cf_probe()'
in case of error")
in pcmcia-next.

Thanks,
	Dominik
