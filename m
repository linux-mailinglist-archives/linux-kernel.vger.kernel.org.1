Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C721F2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgGNNkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNNkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:40:24 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CD2C061755;
        Tue, 14 Jul 2020 06:40:24 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A2D2D2E2;
        Tue, 14 Jul 2020 13:40:23 +0000 (UTC)
Date:   Tue, 14 Jul 2020 07:40:22 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Openrisc <openrisc@lists.librecores.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] OPENRISC ARCHITECTURE: Replace HTTP links with HTTPS
 ones
Message-ID: <20200714074022.24481c73@lwn.net>
In-Reply-To: <CAMuHMdXoUME_dCOZP1N0tXyMv61edfNECM4-n4NPa56YbBCncw@mail.gmail.com>
References: <20200710062019.28755-1-grandmaster@al2klimov.de>
        <20200713113430.1c1777bb@lwn.net>
        <CAMuHMdXoUME_dCOZP1N0tXyMv61edfNECM4-n4NPa56YbBCncw@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 09:22:39 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > > -     website         http://openrisc.io
> > > +     website         https://openrisc.io
> > >       email           openrisc@lists.librecores.org
> > >       =======         =============================  
> >
> > Applied, thanks.  
> 
> Is that site accessible for anyone? It times out for me.

Works for me.

jon
