Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300DF2DAE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgLONmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbgLONmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:42:11 -0500
Date:   Tue, 15 Dec 2020 14:42:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608039685;
        bh=U7sArIse/lC1cpJE43lNUsLHNdapp6/fPV9X9nwe6ZQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=STwVhRbf3hb5ELDjzZdd7pppM3CsZAsqPYfz59AkU7Vq67Wj/GxHwB7JSzQgVpT8E
         ZvxLKL9QVebz5w1laiC7+C0x91AqL4MpBBPiERgnAF41+uuGKYaD9WMMCuhpp5INgg
         HeGXfwPk1Fy31P1g8TlyOMwAxZ7n5FrEVmKj5iJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Ji-Ze Hong <hpeter@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: R: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
Message-ID: <X9i9RKAbpoR0F7Y+@kroah.com>
References: <20201214131445.954822-1-f.suligoi@asem.it>
 <X9dr2IvOgPyhsalE@kroah.com>
 <ff8f6af85d27448d93d1220545f163be@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8f6af85d27448d93d1220545f163be@asem.it>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 01:35:31PM +0000, Flavio Suligoi wrote:
> Hi Greg,
> 
> > >
> > >  	switch (chip) {
> > >  	case CHIP_ID_F81865:
> > > +		chip_name = "F81865";
> > > +		break;
> > >  	case CHIP_ID_F81866:
> > > +		chip_name = "F81866";
> > > +		break;
> > >  	case CHIP_ID_F81966:
> > > +		chip_name = "F81966";
> > > +		break;
> > >  	case CHIP_ID_F81216AD:
> > > +		chip_name = "F81216AD";
> > > +		break;
> > >  	case CHIP_ID_F81216H:
> > > +		chip_name = "F81216H";
> > > +		break;
> > >  	case CHIP_ID_F81216:
> > > +		chip_name = "F81216";
> > >  		break;
> > >  	default:
> > >  		return -ENODEV;
> > >  	}
> > >
> > >  	pdata->pid = chip;
> > > +
> > > +	pr_info("%s%s%s Fintek %s\n",
> > > +		uart->port.dev ? dev_name(uart->port.dev) : "",
> > > +		uart->port.dev ? ": " : "",
> > > +		uart->port.name,
> > > +		chip_name);
> > 
> > Drivers, if all goes well, should not print anything to the kernel log.
> > This isn't ok.
> > 
> > And even if it was, dev_info() would be the correct thing to do...
> 
> Ok, too many information in the driver.
> 
> But what do you think about the possibility to introduce
> a new additional field, in "serial8250_config" structure,
> such as "extra_name" or something like this:
> 
> struct serial8250_config {
> 	const char		*name;
> 	const char		*extra_name;
> 	unsigned short	fifo_size;
> 	unsigned short	tx_loadsz;
> 	unsigned char	fcr;
> 	unsigned char	rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
> 	unsigned int	flags;
> };
> 
> In this way, if required, each driver can fill this
> additional field, for example adding the name of
> the particular uart chip or other useful info.
> 
> As result, for example, the "uart_report_port" function output
> could be something like this:
> 
> 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A - Fintek F81216AD
> 00:02: ttyS3 at I/O 0x2e8 (irq = 11, base_baud = 115200) is a 16550A - Fintek F81216AD
> 
> where the "extra_name", if not empty, is printed
> at the end of the line.
> For practical space reasons, the "extra_name" length
> can be limited to 16 chars.

Why?  What tool will use this, and why would userspace care about it?

What problem are you trying to solve here?

thanks,

greg k-h
