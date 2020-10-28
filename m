Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DB729D49D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgJ1Vxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgJ1Vxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:53:32 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CD6E246CD;
        Wed, 28 Oct 2020 21:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603922011;
        bh=w0+pxBjU+zt4O2vwvDzMt1r0M9UokpQ6mVEdgrP7ujI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kZij+PrTtTiHIS3et04LeuL1PA8cVhJV9S9ZksXTaBfbaRNDl2VI00pkPk5ti7+Gz
         S/z+3dLqlDaS5jtaJWlpvT2DEEfr3dBAH75BSiMjv9BWEPkXbui0LEytjdoYFdb6u2
         gvB5JJmo1/1V+bjKU/Z4NpUstwN0WJMb1imPd7i8=
Date:   Wed, 28 Oct 2020 14:53:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hui Su <sh_def@163.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/oom_kill: remove comment and rename
 is_dump_unreclaim_slabs()
Message-Id: <20201028145330.1cf7a32bb109ccb50d2b0dbb@linux-foundation.org>
In-Reply-To: <20201028153141.GB77196@rlk>
References: <20201027144529.GA3558@rlk>
        <20201027145814.GY20500@dhcp22.suse.cz>
        <20201027151156.GA4336@rlk>
        <20201027192322.GA20500@dhcp22.suse.cz>
        <20201028153141.GB77196@rlk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 23:31:41 +0800 Hui Su <sh_def@163.com> wrote:

> Comment for is_dump_unreclaim_slabs is not really clear whether it is
> meant to instruct how to use the function or whether it is an outdated
> information of the past implementation of the function. it doesn't realy
> help that is_dump_unreclaim_slabs is hard to grasp on its own.
> 
> Rename the helper to should_dump_unreclaim_slabs which should make it
> clear what it is meant to do and drop the comment as the purpose
> should be pretty evident now.
> 

I think your recent attempt to improve the comment:

/*
 * Check whether unreclaimable slabs amount is greater than all user
 * memory(LRU pages).
 */

was actually somewhat useful, and worth retaining.

It would be better if it explained *why* we're doing this, rather than
simply "what we are doing"?

<looks at the code>

It's actually quite unobvious why we're doing this!

