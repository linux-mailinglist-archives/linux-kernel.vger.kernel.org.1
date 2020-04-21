Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BB71B22DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 11:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgDUJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 05:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgDUJe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:34:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF60E206E9;
        Tue, 21 Apr 2020 09:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587461669;
        bh=7Dka82G9l1uFtfwcq6PqZbOKLwt6bMNcseQiY/abPzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsNHxSsMR1kvqvd2SRGAOvl6xVL1jmjaSqDARnRLr443/FFjTwk0nvXKlUXKt8FNP
         FHaYgMbgKTVZ51LD19AoHN81r9E44mxWTTieu0ho5A3Ylzn1f5InblYJwC1dqgwCFY
         Ayt31FqfryDbDjNNDkxRl4kMkegsp8QxXL2C7oC8=
Date:   Tue, 21 Apr 2020 11:34:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@vivo.com, robh@kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2,RESEND] misc: new driver sram_uapi for user level SRAM
 access
Message-ID: <20200421093427.GC725219@kroah.com>
References: <20200420145128.GA4131449@kroah.com>
 <AB6A-gBhCLyx5bgBRPuIiqp1.3.1587460187094.Hmail.wenhu.wang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AB6A-gBhCLyx5bgBRPuIiqp1.3.1587460187094.Hmail.wenhu.wang@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 05:09:47PM +0800, 王文虎 wrote:
> Hi, Greg, Arnd,
> 
> Thank you for your comments first, and then really very very very sorry
> for driving Greg to sigh and I hope there would be chance to share Moutai
> (rather than whisky, we drink it much, a kind of Baijiu), after the virus.
> 
> Back to the comments, I'd like to do a bit of documentation or explanation first,
> which should have been done early or else there would not be so much to explain:
> 1. What I have been trying to do is to access the Freescale Cache-SRAM device form
> user level;
> 2. I implemented it using UIO, which was thought of non-proper;

I still think that using uio is the best way to do this, and never said
it was "non-proper".  All we got bogged down in was the DT
representation of stuff from what I remember.  That should be worked
through.

thanks,

greg k-h
