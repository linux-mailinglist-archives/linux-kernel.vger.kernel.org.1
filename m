Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2598226D09
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 19:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbgGTRU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 13:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgGTRU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:20:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0F2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:20:58 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jxZTC-0087T9-PW; Mon, 20 Jul 2020 19:20:54 +0200
Message-ID: <2b2e1695f6d9341f357f12ffdce59c06e36a383b.camel@sipsolutions.net>
Subject: Re: Build regressions/improvements in v5.8-rc6
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-um <linux-um@lists.infradead.org>
Date:   Mon, 20 Jul 2020 19:20:40 +0200
In-Reply-To: <CAMuHMdUB5kFC5R6b6-OxPfP-PRLYBOK_d7dPjU_LcmYuLtGJpg@mail.gmail.com>
References: <20200720130737.4428-1-geert@linux-m68k.org>
         <CAMuHMdUB5kFC5R6b6-OxPfP-PRLYBOK_d7dPjU_LcmYuLtGJpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-20 at 16:01 +0200, Geert Uytterhoeven wrote:
> On Mon, Jul 20, 2020 at 3:12 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v5.8-rc6[1] to v5.8-rc5[3], the summaries are:
> >   - build errors: +6/-3
> 
>   + error: modpost: "devm_ioremap"
> [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
>   + error: modpost: "devm_ioremap_resource"
> [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
>   + error: modpost: "devm_of_iomap"
> [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
>   + error: modpost: "devm_platform_ioremap_resource"
> [drivers/iio/adc/adi-axi-adc.ko] undefined!:  => N/A
>   + error: modpost: "devm_platform_ioremap_resource"
> [drivers/ptp/ptp_ines.ko] undefined!:  => N/A
>   + error: modpost: "devm_platform_ioremap_resource"
> [drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.ko] undefined!:
>  => N/A
> 
> um-x86_64/um-all{mod,yes}config

Must be an issue with those drivers - ARCH=um can't do ioremap(). The
drivers should depend on HAS_IOMEM or something like that?

johannes

