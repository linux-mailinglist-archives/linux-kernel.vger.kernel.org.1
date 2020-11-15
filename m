Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56012B335F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 11:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKOKVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 05:21:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgKOKVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:21:33 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80BE02242E;
        Sun, 15 Nov 2020 10:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605435693;
        bh=mXgIMi8cI35WDzJ6UNqYT9kCS+Tl30QxG5mMi58J93s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceF3xV8MRFlE6TQ2r3BsUjbh+p7R10o0cJyDlT6/U+qBr+D/goWA51VR8I1aHCthM
         b12UoesbvB1Mg5Y65n1GBLdPz/iAIEid7RC5yZ0QiOaS6UngiZzdiXo1UlTPK5KEL5
         oT4/jnzS4T0ux8kqd1DYWVcsJq3vD7GzRnAQI7DM=
Date:   Sun, 15 Nov 2020 11:21:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Has the linux-kernel already implemented the functions in
 apollo-kernel?
Message-ID: <X7EBKS5BNl8eHi9X@kroah.com>
References: <CAGP6POKB=dbeyGSCG2qgjZGq-wKcPBOjOLLuzeWME=Pbax7uhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGP6POKB=dbeyGSCG2qgjZGq-wKcPBOjOLLuzeWME=Pbax7uhg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 02:44:07PM +0800, Hongyi Zhao wrote:
> Hi,
> 
> The apollo-kernel (https://github.com/ApolloAuto/apollo-kernel) is a
> patched Linux Kernel based on official Linux Kernel 4.4.32 with some
> modifications on the kernel level, especially for the scenario
> necessary to run the Apollo (https://github.com/ApolloAuto/apollo)
> open autonomous driving platform software stack.
> 
> According to the official description as shown
> <https://github.com/ApolloAuto/apollo-kernel#what-is-the-difference>,
> the major difference from the original Linux kernel is as follows:
> 
> 
> - Realtime patch (https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO)
> - Latest e1000e intel ethernet driver
> - Bugfix for Nvidia driver under realtime patch
> - Double free in the inet_csk_clone_lock function patch
> (https://bugzilla.redhat.com/show_bug.cgi?id=1450972)
> - Other cve security patches
> 
> 
> However, considering that Linux Kernel 4.4.32 is a fairly old version,
> so I want to know whether the modifications/fixes applied/added have
> been already available in the current Linux kernel.
> 
> Any hints will be highly appreciated.

As you have the source to both trees, why not compare them and see if
all of this is true or not?  That's the best way to be sure.

good luck!

greg k-h
