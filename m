Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91EF2EAC0B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbhAENjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:39:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbhAENjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:39:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED8E622B30;
        Tue,  5 Jan 2021 13:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609853903;
        bh=+nw9pK7R3iyhBRr4aKdoabaFtTYMTb0AcTgGTqP3HVM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=cRDjRicmZDc9DFyw5/KXND3bJWrWnQohQZnd+aQ5DGwSw8yb5R6gUD+yzueh2bcXG
         NJH1kKWpXArpUPP/rAmVrOdBk8wDb2/j7PSiTANOzIxBw3dCqR/umoTLbtLF30UDUK
         PMpdQ6LUgLuMvPZ6hhoqJTppuSySlC1fsz6caLiw=
Date:   Tue, 5 Jan 2021 14:39:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [patch 1/3] speakup: Add synth parameter to io functions
Message-ID: <X/RsI/qmMXcGVVtc@kroah.com>
References: <20201209205829.693745475@ens-lyon.org>
 <20201209205838.531299374@ens-lyon.org>
 <X9I9Xwh+Q3tHXh88@kroah.com>
 <20201210200300.oqwb2zieoxhahiio@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201210200300.oqwb2zieoxhahiio@function>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 09:03:00PM +0100, Samuel Thibault wrote:
> Greg KH, le jeu. 10 déc. 2020 16:23:11 +0100, a ecrit:
> > The build still breaks when this patch is applied:
> 
> > drivers/accessibility/speakup/spk_ttyio.c:344:18: note: in expansion of macro ‘SPK_SYNTH_TIMEOUT’
> >   344 |  return ttyio_in(SPK_SYNTH_TIMEOUT);
> 
> Sorry, I had a refresh missing. I don't contribute often enough to Linux
> any more, my quilt-fu is lacking :)
> 
> I'll resend the series.

Did you resend this?  I can't find it...

thanks,

greg k-h
