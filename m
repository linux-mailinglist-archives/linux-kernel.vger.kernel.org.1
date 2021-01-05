Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D985B2EAC0D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbhAENkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbhAENkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:40:19 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7A7C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 05:39:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id C5B6460F;
        Tue,  5 Jan 2021 14:39:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id doaz35AjzFCr; Tue,  5 Jan 2021 14:39:37 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 04C53186;
        Tue,  5 Jan 2021 14:39:36 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kwmYh-002Fjm-TQ; Tue, 05 Jan 2021 14:39:35 +0100
Date:   Tue, 5 Jan 2021 14:39:35 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [patch 1/3] speakup: Add synth parameter to io functions
Message-ID: <20210105133935.3kk47m5ae6mkl4k2@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20201209205829.693745475@ens-lyon.org>
 <20201209205838.531299374@ens-lyon.org>
 <X9I9Xwh+Q3tHXh88@kroah.com>
 <20201210200300.oqwb2zieoxhahiio@function>
 <X/RsI/qmMXcGVVtc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X/RsI/qmMXcGVVtc@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le mar. 05 janv. 2021 14:39:47 +0100, a ecrit:
> On Thu, Dec 10, 2020 at 09:03:00PM +0100, Samuel Thibault wrote:
> > Greg KH, le jeu. 10 déc. 2020 16:23:11 +0100, a ecrit:
> > > The build still breaks when this patch is applied:
> > 
> > > drivers/accessibility/speakup/spk_ttyio.c:344:18: note: in expansion of macro ‘SPK_SYNTH_TIMEOUT’
> > >   344 |  return ttyio_in(SPK_SYNTH_TIMEOUT);
> > 
> > Sorry, I had a refresh missing. I don't contribute often enough to Linux
> > any more, my quilt-fu is lacking :)
> > 
> > I'll resend the series.
> 
> Did you resend this?  I can't find it...

I believe so, but I'll resend again anyway (with some more changes iirc)

Samuel
