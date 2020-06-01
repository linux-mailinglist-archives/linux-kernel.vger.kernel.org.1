Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF331EB261
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 01:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgFAXtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 19:49:41 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51858 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgFAXtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:49:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 2472C27449;
        Mon,  1 Jun 2020 19:49:37 -0400 (EDT)
Date:   Tue, 2 Jun 2020 09:49:36 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 8/8] macintosh/adb-iop: Implement SRQ autopolling
In-Reply-To: <CAMuHMdVs8ur9pWWEFbYmPLRgdH67coSSrPO0QE8RqFvKjhgyYg@mail.gmail.com>
Message-ID: <alpine.LNX.2.22.394.2006020936430.8@nippy.intranet>
References: <cover.1590880623.git.fthain@telegraphics.com.au> <0fb7fdcd99d7820bb27faf1f27f7f6f1923914ef.1590880623.git.fthain@telegraphics.com.au> <CAMuHMdUjrFDob01EWC4e04tAkj5JTm_2Ei5WsPqN1eGDz=x3+Q@mail.gmail.com> <alpine.LNX.2.22.394.2006011006080.8@nippy.intranet>
 <CAMuHMdVs8ur9pWWEFbYmPLRgdH67coSSrPO0QE8RqFvKjhgyYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jun 2020, Geert Uytterhoeven wrote:

> >
> > Sure, it could be absorbed by both asm/mac_iop.h and 
> > drivers/macintosh/adb-iop.c [...]
> 
> asm/mac_iop.h doesn't include asm/adb_iop.h (at least not in my tree, 
> but perhaps you have plans to change that?), so there's only a single 
> user.

What I meant by "both" was that part of asm/adb_iop.h could be absorbed by 
drivers/macintosh.adb-iop.c and the rest by asm/mac_iop.h. (And some of it 
could be tossed out.) I suspect that much of arch/m68k/include/asm could 
get the same treatment. But I doubt that there is any pay off, because the 
headers rarely change where they relate to hardware characteristics.
