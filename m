Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F6328FE20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 08:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393986AbgJPGRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 02:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388285AbgJPGRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 02:17:43 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6058D206E5;
        Fri, 16 Oct 2020 06:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602829061;
        bh=cYqKBPH2nZeu+1j7jX1+aJ9mfGsIWLosit3bFJAF/+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlIcc41be5ysg2k1z827SkkiwBG2aOPxAvUyHtFLRVS5KqI5FZlat1qhCJXTK7rzV
         gGsqIbVPON6MCvXgaQt5x5cDOVNU1c1C9knfTbKEnFmCme2JXxA29IzlMa6sdCJUxd
         TTNPijhiNKaD1XTWJdEDYDSCtD6Jbk0JYxGLX/9k=
Date:   Fri, 16 Oct 2020 08:18:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kiran Suren <kirank.suren@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: android: ashmem: changed struct file_operations
 to const file_operations
Message-ID: <20201016061813.GA569795@kroah.com>
References: <20201016051111.1947-1-kirank.suren@gmail.com>
 <CAMHzSAHVtv+BuYgCAdbB26J3EHTdEyH3ZZUfP-g3zftppzJOkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMHzSAHVtv+BuYgCAdbB26J3EHTdEyH3ZZUfP-g3zftppzJOkw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Oct 16, 2020 at 01:38:47AM -0400, Kiran Suren wrote:
> Hi,
> 
> My apologies about the last couple emails, I test built completely the
> wrong file. This is my first attempt at doing patch so I’m still trying to
> get a hang of how all this works. Also, I’m not sure what you mean by the
> signed off line? I believe I did put my actual full name? Again, apologies
> for any inconveniences just trying to get a hang of how the entire process
> works.

For the signed-off-by line, look at your email below:

> 
> On Fri, Oct 16, 2020 at 1:12 AM kiransuren <kirank.suren@gmail.com> wrote:
> 
> > From: kiransuren <kirank.suren@gmail.com>

That has one name and then:

> >
> > Fixed a coding style issue.
> >
> > Signed-off-by: Kiran Surendran <kirank.suren@gmail.com>

This has another.

They have to match, otherwise it doesn't make any sense, right?

thanks,

greg k-h
