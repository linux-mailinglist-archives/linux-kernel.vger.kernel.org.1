Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D102959AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508964AbgJVHyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:54:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:44928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508957AbgJVHyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:54:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603353276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cg+tcmkvWp5iSn5X367Swi4D8X/gEzacrPENhCVg7N8=;
        b=NztgMB21XpZkSCtyLdRmGo2ySnOxdLkxMUQyw7bb0ZJIJh4qh/5/Ob93wN9RaPEBcsGbrE
        Kf9W1NUvqgHVRqYhdIiW28hosxXIf5hcVsxzvHFeYZkDx+OMcBZ7jm/KKc0yAojtMfgBBn
        YUpBV4ZWovwng65Ha/UYmL5V033p6+M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7D48AB95;
        Thu, 22 Oct 2020 07:54:35 +0000 (UTC)
Subject: Re: [PATCH 3/5] xen/events: only register debug interrupt for 2-level
 events
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20201022074214.21693-1-jgross@suse.com>
 <20201022074214.21693-4-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <9bfc266f-1efb-7910-6ff7-9cea6e40d7c9@suse.com>
Date:   Thu, 22 Oct 2020 09:54:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201022074214.21693-4-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.2020 09:42, Juergen Gross wrote:
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -2050,7 +2050,7 @@ void xen_setup_callback_vector(void) {}
>  static inline void xen_alloc_callback_vector(void) {}
>  #endif
>  
> -static bool fifo_events = true;
> +bool fifo_events = true;

When making this non-static, perhaps better to also prefix it with
xen_?

Jan
