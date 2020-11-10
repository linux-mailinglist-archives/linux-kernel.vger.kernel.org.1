Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7AA2AD0A7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgKJHvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgKJHvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:51:12 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7380420795;
        Tue, 10 Nov 2020 07:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604994672;
        bh=sVLgoZcPQTBB9G12Gn4QjCAHaACwZnkUryoMJkbjuz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/GaHcTIZupi+Th/01V/sKVuvpS+pBgyQwdhLz0RhKA83ZeUg9I/bld6DHROsB+Vq
         lx0Non63bdnNh0PbSH3559N+jH6t7zdvy7wEJ8WG6tXlUj2BPDXAQyoEofpxl9D6Cm
         tbEZgnL2K78jPenCl/uzGtpfyy4u4wG8o+JkcSsg=
Date:   Tue, 10 Nov 2020 08:52:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: binder: add transaction latency tracer
Message-ID: <X6pGqcXk3VMgUwu0@kroah.com>
References: <1602781377-4278-1-git-send-email-Frankie.Chang@mediatek.com>
 <1603987737-2763-1-git-send-email-Frankie.Chang@mediatek.com>
 <20201109174605.GA2426739@kroah.com>
 <1604993580.14886.5.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604993580.14886.5.camel@mtkswgap22>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 03:33:00PM +0800, Frankie Chang wrote:
> On Mon, 2020-11-09 at 18:46 +0100, Greg Kroah-Hartman wrote:
> > On Fri, Oct 30, 2020 at 12:08:54AM +0800, Frankie Chang wrote:
> > > Change from v11:
> > >   - rebase.
> > 
> > This whole patch set is sent with DOS line-ends, which makes git really
> > unhappy when it tries to apply it, as rightfully, it doesn't know how to
> > convert things.
> > 
> Hmm.., actually I can use 'git apply' PATCH v11 from the message
> directly.

Ok, let me see if I can figure this out on my end, let me try using `b4`
on this to see if that helps...
