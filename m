Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A2027EF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbgI3Q2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgI3Q2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:28:37 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5D0C2072E;
        Wed, 30 Sep 2020 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601483316;
        bh=A/LaFBNm69fgtLEE6uxXcOS8lLCnslN506CQsSMOD2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5GE0J60khqPqCPoixVlcVVizCgkbhU3fbNnB8Kf9jQw9DayjANwVC/Ur3wUcwZRz
         3SoFTCK9XSeScHfawCerW2dT0VNmN3oXK6MJfx4NVV2+bkGdgZLL7kRumQQ58k3UNa
         1jRr4bXN1r7SiyzpDa3FrBJWann7moytB9VT2Svo=
Date:   Wed, 30 Sep 2020 18:28:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: exclude char maintainers from things they
 do not maintain
Message-ID: <20200930162839.GB1672130@kroah.com>
References: <20200930121007.GA1615300@kroah.com>
 <CAK8P3a3FX=uuqG6KW7b4Zsh0xiCea_6B2sE3DChQx-e8EUF43g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3FX=uuqG6KW7b4Zsh0xiCea_6B2sE3DChQx-e8EUF43g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:19:09PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 30, 2020 at 2:10 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > There are a number of subdirectories and files in drivers/char/ that
> > have their own maintainers and developers and ways of getting patches to
> > Linus.  This includes random.c, IPMI, hardware random drivers, TPM
> > drivers, and agp drivers.  Instead of sending those patches to Arnd and
> > myself, who can't do anything with them, send them to the proper
> > developers instead.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Good idea,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Now our inboxes will be a tiny bit smaller :)
