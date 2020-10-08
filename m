Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12A2286D15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 05:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgJHDQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 23:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbgJHDQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 23:16:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374C5C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 20:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=kXM7EUBC114FMRgRNwA6orziPJHN9U/LgwGi0VWrC/c=; b=HrNyheoJ/OR6EENm+vBBbAbU2R
        vMxoBOMLo0jpWFE+8jX8iD5wcltLg6bderWtm01wu7SVEeZZ12UEjIz7LBGXKN8LTafrcvHCdctcy
        QIgZm7x6ItrL9GkL0ySFlVxKrN4DHo/TcYMgwDfDyeTAePoXxLnwgj1dYVKgzGgEOpZWZrkITujVg
        ZD4bqe97NCN33j+W6fj6UtqBLkiEOHs+c3fXjQxIdlX+XMkYBEm1P+W2YNxka3/iCRb8jckmIjdmT
        Qvp5NuehOSqtUNAUIJEw6gLzh7jHLSMywxAnq0vijURD5wHlZcruxJAVVneQ9A2XOofbk/2G5tHz/
        nihePxZA==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQMQJ-000627-SE; Thu, 08 Oct 2020 03:16:56 +0000
Subject: Re: [PATCH V2] kprobes: Correct a typo in function
 kprobes_module_callback
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org
References: <1602126837-32346-1-git-send-email-zhouzhouyi@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <96dc6681-e671-7ed9-1374-974abf12267b@infradead.org>
Date:   Wed, 7 Oct 2020 20:16:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1602126837-32346-1-git-send-email-zhouzhouyi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/20 8:13 PM, Zhouyi Zhou wrote:
> There is a tiny typo in comment of function kprobes_module_callback.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  kernel/kprobes.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index e995541..9d2042b 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2432,7 +2432,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
>  			     within_module_core((unsigned long)p->addr, mod))) {
>  				/*
>  				 * The vaddr this probe is installed will soon
> -				 * be vfreed buy not synced to disk. Hence,
> +				 * be vfreed but not synced to disk. Hence,
>  				 * disarming the breakpoint isn't needed.
>  				 *
>  				 * Note, this will also move any optimized probes
> 


-- 
~Randy
