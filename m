Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D132D6806
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 21:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404588AbgLJUEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 15:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404384AbgLJUDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:03:47 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E453C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 12:03:07 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 1ED2ECE0;
        Thu, 10 Dec 2020 21:03:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D0xrO6R4wL3V; Thu, 10 Dec 2020 21:03:04 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 0E56FA25;
        Thu, 10 Dec 2020 21:03:03 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1knS9U-00AfPF-67; Thu, 10 Dec 2020 21:03:00 +0100
Date:   Thu, 10 Dec 2020 21:03:00 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [patch 1/3] speakup: Add synth parameter to io functions
Message-ID: <20201210200300.oqwb2zieoxhahiio@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20201209205829.693745475@ens-lyon.org>
 <20201209205838.531299374@ens-lyon.org>
 <X9I9Xwh+Q3tHXh88@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9I9Xwh+Q3tHXh88@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le jeu. 10 déc. 2020 16:23:11 +0100, a ecrit:
> The build still breaks when this patch is applied:

> drivers/accessibility/speakup/spk_ttyio.c:344:18: note: in expansion of macro ‘SPK_SYNTH_TIMEOUT’
>   344 |  return ttyio_in(SPK_SYNTH_TIMEOUT);

Sorry, I had a refresh missing. I don't contribute often enough to Linux
any more, my quilt-fu is lacking :)

I'll resend the series.

Samuel
