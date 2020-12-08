Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190C52D2EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgLHQBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:01:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:46064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729948AbgLHQBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:01:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607443232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iEt8ZrIXTme7sphbzz4VS0xnGTSo4prvT/46s4rgpQI=;
        b=UgbnsxKScw4FVDMb4LgMv7MoyeD/QRm9yBCjN2XlNITHuzhL0WWCuU/aWhIQqeMXfsAlt6
        h6+QGOVBG+7ePU+QKgKw1KHY6X1jDrh5d7KN36LUoVcRAE8wvyZdrUFHpQn7G0yg4+ykZf
        dw+fExTVDJIesgEsgbePu6aR8TRQtqg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75023AD6B;
        Tue,  8 Dec 2020 16:00:32 +0000 (UTC)
Date:   Tue, 8 Dec 2020 17:00:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH] printk: remove obsolete dead assignment
Message-ID: <X8+jHx7sRlroUM8u@alley>
References: <20201130124915.7573-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130124915.7573-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-11-30 13:49:15, Lukas Bulwahn wrote:
> Commit 849f3127bb46 ("switch /dev/kmsg to ->write_iter()") refactored
> devkmsg_write() and left over a dead assignment on the variable 'len'.
> 
> Hence, make clang-analyzer warns:
> 
>   kernel/printk/printk.c:744:4: warning: Value stored to 'len' is never read
>     [clang-analyzer-deadcode.DeadStores]
>                           len -= endp - line;
>                           ^
> 
> Simply remove this obsolete dead assignment here.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

The patch is committed in printk/linux.git, branch for-5.11.

Best Regards,
Petr
