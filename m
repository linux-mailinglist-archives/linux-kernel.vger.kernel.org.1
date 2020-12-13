Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6C2D9039
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 20:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgLMTjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 14:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgLMTjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 14:39:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CCBC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 11:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=gtkC2cwUyIZHi2THFuqJZjqPt1krJsPvyreKUidD7mw=; b=Ch83eRaVuMImRjym8HnQzBa5XQ
        dVYR4G4EuxcCPragNt7sSP0FkCy7XSei5yKmrQE90qh1M5Pi1XjPnaNKEchmnAQSmJwEpLWjcPcvB
        rdzVOHEihCHC95LRzGBF990z4UEUUoEDT8lgtYMEDsJlDJZEHvijvg/8k5I+Y3/Li6+F0301OPNuw
        /ABD5ONp0bVNbr+H+cMEaNCL09swp3D03xKk4HK04ES08EkdskHaf+C1jHXdEgUrDF0dz4rlxBp5q
        Mhv3zCy6EbT2AQyLC6sQLOIq9c6EAFOVHv0Yk6SEVVQyq2D6h+QFB5dFCo72UNduxHsvwg6l9ZJut
        z9lGfXJA==;
Received: from [2602:306:c5a2:a380:9e7b:efff:fe40:2b26]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1koXCT-0005tq-MO; Sun, 13 Dec 2020 19:38:33 +0000
Subject: Re: [PATCH] powerpc/ps3: use dma_mapping_error()
To:     =?UTF-8?Q?Vincent_Stehl=c3=a9?= <vincent.stehle@laposte.net>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
References: <20201213182622.23047-1-vincent.stehle@laposte.net>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <a1aa680e-5eca-6c09-0e57-da7f09d99f9f@infradead.org>
Date:   Sun, 13 Dec 2020 11:38:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201213182622.23047-1-vincent.stehle@laposte.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/20 10:26 AM, Vincent Stehlé wrote:
> The DMA address returned by dma_map_single() should be checked with
> dma_mapping_error(). Fix the ps3stor_setup() function accordingly.
> 
> Fixes: 80071802cb9c ("[POWERPC] PS3: Storage Driver Core")
> Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  drivers/ps3/ps3stor_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good.  Thanks for submitting.

Acked by: Geoff Levand <geoff@infradead.org>
