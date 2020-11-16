Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AF92B52A9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbgKPUeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:34:00 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:43296 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKPUd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:33:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 6979BF20;
        Mon, 16 Nov 2020 21:33:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EsWDGVyKgCHc; Mon, 16 Nov 2020 21:33:56 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id CA9B5F07;
        Mon, 16 Nov 2020 21:33:56 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kelCF-00FUbU-Ki; Mon, 16 Nov 2020 21:33:55 +0100
Date:   Mon, 16 Nov 2020 21:33:55 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: drivers/accessibility/speakup/serialio.c:48:19: warning:
 variable 'quot' set but not used
Message-ID: <20201116203355.t7dboh6vlj57dsau@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <202011160942.AmYkxiJv-lkp@intel.com>
 <20201116190122.yslib3wicn45rbuo@function>
 <ef625c1e21c492be8c423730e45e90d92b1ae899.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef625c1e21c492be8c423730e45e90d92b1ae899.camel@decadent.org.uk>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Hutchings, le lun. 16 nov. 2020 19:51:23 +0000, a ecrit:
> On Mon, 2020-11-16 at 20:01 +0100, Samuel Thibault wrote:
> > Perhaps we should rather use
> > 
> > depends on ISA || (X86 && COMPILE_TEST)
> > 
> > ?
> > so that we have compile testing on x86 only (where the inb/outb macros
> > always behave fine) to avoid such issues on other archs?
> 
> That seems reasonable though unusual.
> 
> > Or we tell the architecture maintainers to fix their out macros into
> > consuming their parameters?
> [...]
> 
> It does seem odd for parisc to define the I/O functions this way.  I
> don't know if it's really a bug.

Sorry I wasn't clear: the problem here is when CONFIG_EISA is disabled,
the eisa_in/out calls are replaced by BUG() stubs, and the stubs do not
consume their input:

arch/parisc/include/asm/io.h

#if defined(CONFIG_PCI)
extern void outb(unsigned char b, int addr);
#elif defined(CONFIG_EISA)
#define outb eisa_out8
#else
#define outb(x, y)	BUG()
#endif

Samuel
