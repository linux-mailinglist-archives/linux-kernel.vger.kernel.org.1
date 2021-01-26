Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E2303BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405181AbhAZLh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:37:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:47300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403940AbhAZK2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:28:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611656871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pOda+MvC/sHys1dv13U5VXg25nGXKMCvumVGvRV1f6c=;
        b=YXcm+GxgMkbGv/c1skH0GerHWmZ9Lg6XaKFaz1+x8Tcu5n/72+9fgMM3TUNxfnCmzzpFjB
        8LaejLB6PN4pv9IecvMVR1SJ8AdLY6X8WgHAwU63vhnjo21J7xY+xKr1h7JIQ+ELYwN25i
        vBEg+gsy5UtGntgHdqm3PK8WpPW62lw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 164A5ABDA;
        Tue, 26 Jan 2021 10:27:51 +0000 (UTC)
Date:   Tue, 26 Jan 2021 11:27:50 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] printk: rectify kernel-doc for prb_rec_init_wr()
Message-ID: <YA/upguVH/Jj0GJz@localhost.localdomain>
References: <20210125081748.19903-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125081748.19903-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-01-25 09:17:48, Lukas Bulwahn wrote:
> The command 'find ./kernel/printk/ | xargs ./scripts/kernel-doc -none'
> reported a mismatch with the kernel-doc of prb_rec_init_wr().
> 
> Rectify the kernel-doc, such that no issues remain for ./kernel/printk/.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

The patch has been committed into printk/linux.git, branch
printk-rework.

Best Regards,
Petr
