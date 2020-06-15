Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFE91F969F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgFOMex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 08:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgFOMew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:34:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97A02076A;
        Mon, 15 Jun 2020 12:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592224492;
        bh=pNOetLVtZRG2fbCc3C2vy0lTqxav4Zkaq+VhJKAi9xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYQoNejN7Wl6z1zgAQEittcbfoy14EFCmsV9ZNIch7IpLkTEorON1IXETisNTSpbJ
         /46VDugqsbns3ihaOeFhTIp7Hd5u91327GzSjt/ysVzrtnvA3VuUhyR1wYnmo2ogaK
         qUTn21WrXp9UzkJC1xE7ZZKqkvsGGGAipgCioVCs=
Date:   Mon, 15 Jun 2020 14:34:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ricardo Ferreira <rikajff@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] Staging: rtl8712: Addressed checkpatch.pl issues related
 to macro parameter wrapping in parentheses.
Message-ID: <20200615123439.GB943330@kroah.com>
References: <20200614135125.19502-1-rikajff@gmail.com>
 <20200614140531.GA2661398@kroah.com>
 <CACtES-qmpRJ2mk+1vhsJm55G6j6U1+rLB1t2izHwJ1u4_eUKHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACtES-qmpRJ2mk+1vhsJm55G6j6U1+rLB1t2izHwJ1u4_eUKHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:28:51AM +0100, Ricardo Ferreira wrote:
> On Sun, 14 Jun 2020 at 15:05, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jun 14, 2020 at 02:51:25PM +0100, Ricardo Ferreira wrote:
> > >  #define init_h2fwcmd_w_parm_no_rsp(pcmd, pparm, code) \
> > >  do {\
> > > -     INIT_LIST_HEAD(&pcmd->list);\
> > > -     pcmd->cmdcode = code;\
> > > -     pcmd->parmbuf = (u8 *)(pparm);\
> > > -     pcmd->cmdsz = sizeof(*pparm);\
> > > -     pcmd->rsp = NULL;\
> > > -     pcmd->rspsz = 0;\
> > > +     INIT_LIST_HEAD(&(pcmd)->list);\
> > > +     (pcmd)->cmdcode = code;\
> > > +     (pcmd)->parmbuf = (u8 *)((pparm));\
> > > +     (pcmd)->cmdsz = sizeof(*(pparm));\
> > > +     (pcmd)->rsp = NULL;\
> > > +     (pcmd)->rspsz = 0;\
> > >  } while (0)
> >
> > Does that change really make any sense?  checkpatch is a nice hint,
> > sometimes it is not correct...
> 
> (Replying again since I mistakenly sent my comments only to Greg...)
> 
> Yeah I was over-eager and applied some of checkpatche's patches
> without thinking twice... I guess the parenthesis wrapping only makes
> sense when you have an operator (either binary or unary). I've
> rechecked each macro identified by checkpatch to see if there is a
> need for parenthesis wrapping in their current usage.

Yes, please do that, and also test-build your patches.  Sending patches
that break the build are a sure way to make maintainers grumpy :)

thanks,

greg k-h
