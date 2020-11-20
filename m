Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F52BA68E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKTJuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:50:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:34002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgKTJuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:50:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605865804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1xs/FyEHbTR25nH7LU7ymZu1HNJyJ3XDN8eI7fh5D2s=;
        b=l5zibdCR+QfC0tlu+B6KjUOtYv+PGV5renAYAAYNjlen1woKlzLTKTGGHHN8Rv6DakcjNd
        Ldp9fuRFQ9jgwHCyqvSVooh9YcLE85ecvcBa2y4fadePrjAc4mLKbpGSG0b4y6cC1tWTQj
        Bav2Lvf/VSxANxvgjvVS/I1uAlqykjI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3485FAC60;
        Fri, 20 Nov 2020 09:50:04 +0000 (UTC)
Date:   Fri, 20 Nov 2020 10:50:03 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Hui Su <sh_def@163.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, 0x7f454c46@gmail.com, jroedel@suse.de,
        akpm@linux-foundation.org, jannh@google.com,
        mark.mossberg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/dumpstack: make show_trace_log_lvl() static
Message-ID: <X7eRSzvm98AOk9pZ@alley>
References: <20201113133943.GA136221@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113133943.GA136221@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-11-13 21:39:43, Hui Su wrote:
> show_trace_log_lvl() won't be used by other files, so
> make it static and remove the declaration from the header
> file.
> 
> Signed-off-by: Hui Su <sh_def@163.com>

I would make sense to add:

Fixes: 16d1cb0bc43642a4d9 ("x86/dumpstack: Unify show_regs()")

Othrewise, it looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
