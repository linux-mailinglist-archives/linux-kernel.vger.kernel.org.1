Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4FD1DE33F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 11:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgEVJho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 05:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgEVJhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:37:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7753206DD;
        Fri, 22 May 2020 09:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590140262;
        bh=35cJRmTh058RiER0D+CYZkhMXu//HtQ3orgCY5xtYP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZcfJm0kE2vSf7EEvq3kgSsrOTYMGhxJC4lfhzQfB4x3kuCS0sitncoxxiZRJyNtQT
         DhhU1IdrLLNy+OaJN6HHOBI0A/swZ5e9WDAerOZoaGxPkYeF1bZQ2gbeRcJos11IQ+
         1SORWP5ncr9j4Sf4ubcCcFpZoDe6Ury/yb8kpPHs=
Date:   Fri, 22 May 2020 11:37:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     MugilRaj <dmugil2000@gmail.com>
Cc:     devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Chris Brannon <chris@the-brannons.com>
Subject: Re: [PATCH] taging: speakup: remove volatile
Message-ID: <20200522093738.GA1231689@kroah.com>
References: <1590138989-6091-1-git-send-email-dmugil2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590138989-6091-1-git-send-email-dmugil2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 02:46:28PM +0530, MugilRaj wrote:
> fix checkpatch.pl warning, which is Use of volatile is usually wrong: see
> Documentation/process/volatile-considered-harmful.rst
> Signed-off-by: MugilRaj <dmugil2000@gmail.com>

As Samuel said, you can't "just remove this", otherwise it would have
been done a long time ago, don't you think?

But for your next patch, you need to have a blank line before the
signed-off-by: line in order for it to be in a format the patch could be
merged in.

thanks,

greg k-h
