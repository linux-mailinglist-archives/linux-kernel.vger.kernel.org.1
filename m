Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96F12767A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIXEYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgIXEYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:24:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EAFC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 21:24:17 -0700 (PDT)
Date:   Thu, 24 Sep 2020 06:24:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600921455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cfpS9DPPY8rOz0UxqYMocgg1xPkcu8YAdrj/3nL8k6c=;
        b=OCh/hxfjVuXH6dPm4RKc47u3DaRFeuclZnta0cKydzSycbMWPpLNyzEMJyfpJBjE+QriMD
        4eOYpJtqAueQtBFQDh4bCN8cShLNlXat1CnT+0CBU6pFimCOF9tM8m4nGaJrbVii241FSf
        zDnNkJhSkLeyDRmw36gelEtqthKFdWSlWEnEvRMNjDuxUR11/b95pHGjMlDo9BauTKbpWd
        Gn1ba1NDcaoiv10fFruaoRX+BKo7ytEZftY8/5pbSlWt2sLETNOtceRkxbgufAgxURDdrX
        UujRlN9wyOP1Pj2mjyE4WjV2lZmhVuXCKnIiNRJ+eQVmaodFhUmqQwnhjYi6Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600921455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cfpS9DPPY8rOz0UxqYMocgg1xPkcu8YAdrj/3nL8k6c=;
        b=wNGr7Z0wp/okPXcT0bLmJxKPBr+FDN5iiwBLqbWiexHf58TRzRtDkWQy955XKI5Zjg2VNP
        fYRnP7cxrWr9HpAg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] printk: Add more information about the printk caller
Message-ID: <20200924042414.GA6039@lx-t490>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923135617.27149-3-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 03:56:17PM +0200, Petr Mladek wrote:
...
>
> -static inline u32 printk_caller_id(void)
> +static enum printk_caller_ctx get_printk_caller_ctx(void)
> +{
> +	if (in_nmi())
> +		return printk_ctx_nmi;
> +
> +	if (in_irq())
> +		return printk_ctx_hardirq;
> +
> +	if (in_softirq())
> +		return printk_ctx_softirq;
> +
> +	return printk_ctx_task;
> +}
> +

in_softirq() here will be true for both softirq contexts *and*
BH-disabled regions. Did you mean in_serving_softirq() instead?

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
