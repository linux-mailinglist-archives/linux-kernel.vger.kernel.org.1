Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2A0215572
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 12:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgGFKW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 06:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbgGFKW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:22:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3834720739;
        Mon,  6 Jul 2020 10:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594030977;
        bh=hyubO64upSNhqMywGjKfEDtfPQCLU+NfTnStguiiInQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4G5rNnJWpkPLV7AlSxzZjB4OL/dkUxu4G2J3uDie1OFt2hgg4W+EoO2DFQTwNTP2
         44OhXBEGR0OXw7WB4966lqDNIa3Il4jASWf2p4v/3GYBEv50TfM06jQgqUNNEZ/zYO
         ucyO/bNVvwYYAQpaQdrBfkr9cYGkIFT3bGPnJRpE=
Date:   Mon, 6 Jul 2020 12:22:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     NeilBrown <neilb@suse.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200706102254.GA10206@kroah.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAFhKne_ZVWVhZX5hNEbeGBfU6BMRN9JKQeTsVYOcMmEH1cd3xg@mail.gmail.com>
 <87h7ul15le.fsf@notabene.neil.brown.name>
 <20200706072221.GA1947246@kroah.com>
 <CAMuHMdWj2d5GF1ZkuhzQxg9teA51zjF0oQQPWcphzK=kJ6-x9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWj2d5GF1ZkuhzQxg9teA51zjF0oQQPWcphzK=kJ6-x9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:53:55AM +0200, Geert Uytterhoeven wrote:
> On Mon, Jul 6, 2020 at 9:22 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > look at the USB spec for an example of these terms being used in this
> > way for many decades.
> 
> And when does the "gadget" enter the show? ;-)

It doesn't, as the USB spec does not describe that in any reasonable way
for us to use when dealing with drivers for both "types" of devices.  So
we came up with the word "gadget" on purpose to be able to talk about
those things in a specific manner.

thanks,

greg k-h
