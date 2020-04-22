Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C941B4A10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 18:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgDVQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 12:18:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41782 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDVQSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:18:04 -0400
Received: from zn.tnic (p200300EC2F0DC10099981D244BC6B235.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c100:9998:1d24:4bc6:b235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 771731EC0D07;
        Wed, 22 Apr 2020 18:18:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587572282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ma3ktAvhs7nRGRilL5NROZKZrJMEP9b4pVVZxv/cT8Q=;
        b=JrG+2ok86rZQkejV92cdQ03RnqLcUvjOKvWSJe16xJE0HdCy5wmY0iTrpUztONd8bVdX0J
        QYMokkHoAg9moXNMg5VYTjn35B+apaM2eKtNiT2ptzZVRtu67Zv5sUZUsTFFsFTWYf72KK
        2rUMP2f32C4kOHG1O9chGBG3eTYE274=
Date:   Wed, 22 Apr 2020 18:17:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and
 pgprot_large_2_4k()"
Message-ID: <20200422161757.GC26846@zn.tnic>
References: <1ED37D02-125F-4919-861A-371981581D9E@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ED37D02-125F-4919-861A-371981581D9E@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 11:55:54AM -0400, Qian Cai wrote:
> Reverted the linux-next commit and its dependency,
> 
> a85573f7e741 ("x86/mm: Unexport __cachemode2pte_tbl”)
> 9e294786c89a (“x86/mm: Cleanup pgprot_4k_2_large() and pgprot_large_2_4k()”)
> 
> fixed crashes or hard reset on AMD machines during boot that have been flagged by
> KASAN in different forms indicating some sort of memory corruption with this config,
> 
> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

What is the special thing about this config? You have KASAN enabled and?
Anything else?

I need to know what are the relevant switches you've enabled so that I
can enable them on my box too and try to reproduce.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
