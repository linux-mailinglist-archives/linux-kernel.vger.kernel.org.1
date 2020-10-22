Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE602959C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509170AbgJVIBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:01:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:57764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509164AbgJVIBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:01:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603353710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=al5X9k9TmXnWVtHnDRc3HqlGbm+NoIWAXwyHFtAngDw=;
        b=cvLN1NFO4flcJ7AqVjmOAOYFNPxed6JADv1j2NB9NnIE/WIqa9Y1zTrnZjfjt9QbjwXhcp
        9vW4/GI6DGzMeNr16xacgc9d6c58Z1h1WWKIRVyyPWF/OKW6Q+52qGGG/ZMXYmMvuK3hoC
        gDRGji9S/lulT/lCAcVc6a7EupoAzZY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 270F9AE7A;
        Thu, 22 Oct 2020 08:01:50 +0000 (UTC)
Subject: Re: [PATCH 0/5] xen: event handling cleanup
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
References: <20201022074214.21693-1-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <9f2c78c8-da92-1b64-02ba-1130bfc79962@suse.com>
Date:   Thu, 22 Oct 2020 10:01:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201022074214.21693-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.2020 09:42, Juergen Gross wrote:
> Do some cleanups in Xen event handling code.
> 
> Juergen Gross (5):
>   xen: remove no longer used functions
>   xen/events: make struct irq_info private to events_base.c
>   xen/events: only register debug interrupt for 2-level events
>   xen/events: unmask a fifo event channel only if it was masked
>   Documentation: add xen.fifo_events kernel parameter description

With the two remarks to individual patches suitably taken care of
one way or another
Reviewed-by: Jan Beulich <jbeulich@suse.com>

Jan
