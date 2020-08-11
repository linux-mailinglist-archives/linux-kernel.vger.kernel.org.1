Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304CF241E89
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 18:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgHKQoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgHKQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:44:33 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EBAC06174A;
        Tue, 11 Aug 2020 09:44:33 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5DC8431A;
        Tue, 11 Aug 2020 16:44:33 +0000 (UTC)
Date:   Tue, 11 Aug 2020 10:44:32 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Remi Andruccioli <remi.andruccioli@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: cdrom: Fix a typo and rst markup
Message-ID: <20200811104432.0fbe21db@lwn.net>
In-Reply-To: <20200808163123.17643-1-remi.andruccioli@gmail.com>
References: <20200808163123.17643-1-remi.andruccioli@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  8 Aug 2020 18:31:23 +0200
Remi Andruccioli <remi.andruccioli@gmail.com> wrote:

> "The capability fags" should be "The capability flags".
> 
> In rst markup, a incorrect markup expression is causing bad rendering in
> Sphinx output. Replace the erroneous single quote by a backquote.
> 
> Signed-off-by: Remi Andruccioli <remi.andruccioli@gmail.com>
> ---
>  Documentation/cdrom/cdrom-standard.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I've applied this, thanks.

The backtick replacement makes the warning go away, but a better fix would
be to remove the backticks entirely; I'm not sure why they are used as
quotes in that file.

jon
