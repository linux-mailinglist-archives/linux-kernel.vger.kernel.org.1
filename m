Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7D621533F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgGFHWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 03:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgGFHWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:22:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F7EE2073E;
        Mon,  6 Jul 2020 07:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594020140;
        bh=gKp3g1bxO6Epz5NAk4E1pJBvKl8b9XpmYD9Xk7Fl920=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JufFr+0gHoxadzahDRSG2gCHqcnRkW9pANK7oExJ2xVU52xIpdQrekouQAcCKjgaQ
         sDnOhnay4RY9Cr2KqMaxtiOdZiD6lDATCvh5sj7aTD059yzyR3+F+qBrD5zfxSsTa7
         PvX18zdzs4ZNYFThXfTSDqlIgQwKo/nhtEkbLRZU=
Date:   Mon, 6 Jul 2020 09:22:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Matthew Wilcox <willy6545@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Chris Mason <clm@fb.clm>,
        tech-board-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200706072221.GA1947246@kroah.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAFhKne_ZVWVhZX5hNEbeGBfU6BMRN9JKQeTsVYOcMmEH1cd3xg@mail.gmail.com>
 <87h7ul15le.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7ul15le.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 05:10:37PM +1000, NeilBrown wrote:
> On Sat, Jul 04 2020, Matthew Wilcox wrote:
> 
> > Another suggestion for "slave" replacement should be "device". This is in
> > the context of the w1 bus which is by far the largest user of the
> > master/slave terminology in the kernel.
> 
> Ugh.  Please, no.  "device" doesn't mean anything, in that you can use
> it to refer to any thing.  (i.e. it is almost semantically equivalent to
> "thing").

Context is everything, you can have a "controller" and a "device" that
the controller controls.  These are common terms in many specs today,
look at the USB spec for an example of these terms being used in this
way for many decades.

So while the term might be generic, like the word it is replacing, it
makes sense when used in the context it will show up in, so it is a good
replacement in many instances.

thanks,

greg k-h
