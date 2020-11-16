Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6252B2B5078
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgKPTB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgKPTB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:01:28 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EECC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:01:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id BDEC4F01;
        Mon, 16 Nov 2020 20:01:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HY7wajfAMYSj; Mon, 16 Nov 2020 20:01:24 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 10A8EDA3;
        Mon, 16 Nov 2020 20:01:24 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kejkh-00FTP8-0u; Mon, 16 Nov 2020 20:01:23 +0100
Date:   Mon, 16 Nov 2020 20:01:22 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: drivers/accessibility/speakup/serialio.c:48:19: warning:
 variable 'quot' set but not used
Message-ID: <20201116190122.yslib3wicn45rbuo@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <202011160942.AmYkxiJv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202011160942.AmYkxiJv-lkp@intel.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ben,

A long time ago you added a dependency for speakup drivers on
CONFIG_ISA, and you also added || COMPILE_TEST as an alternative.

It seems that some platform portability tests then think they should
be able to build it, even if they don't enable ISA, but then we are
getting warnings, or even errors, depending on the compatibility macros
in <asm/io.h> in the !ISA case (here, the parisc compatibility macros do
not consume their parameter).

Perhaps we should rather use

depends on ISA || (X86 && COMPILE_TEST)

?
so that we have compile testing on x86 only (where the inb/outb macros
always behave fine) to avoid such issues on other archs?

Or we tell the architecture maintainers to fix their out macros into
consuming their parameters?

Samuel

kernel test robot, le lun. 16 nov. 2020 09:54:50 +0800, a ecrit:
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a6af8718b98e1cd37a9ea9a02269c79577fc9138
> commit: 2067fd92d75b6d9085a43caf050bca5d88c491b8 staging/speakup: Move out of staging
> date:   4 months ago
> config: parisc-randconfig-r023-20201116 (attached as .config)
> compiler: hppa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2067fd92d75b6d9085a43caf050bca5d88c491b8
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 2067fd92d75b6d9085a43caf050bca5d88c491b8
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/accessibility/speakup/serialio.c: In function 'spk_serial_init':
> >> drivers/accessibility/speakup/serialio.c:48:19: warning: variable 'quot' set but not used [-Wunused-but-set-variable]
>       48 |  int baud = 9600, quot = 0;
>          |                   ^~~~
>    drivers/accessibility/speakup/serialio.c: In function 'spk_serial_tiocmset':
>    drivers/accessibility/speakup/serialio.c:165:6: warning: unused variable 'old' [-Wunused-variable]
>      165 |  int old = inb(speakup_info.port_tts + UART_MCR);
>          |      ^~~
> 
> vim +/quot +48 drivers/accessibility/speakup/serialio.c
> 
> 1e441594e509c3 drivers/staging/speakup/serialio.c Okash Khawaja          2017-03-14   45  
> 3ee0017e03cd79 drivers/staging/speakup/serialio.c Jiri Slaby             2012-03-05   46  const struct old_serial_port *spk_serial_init(int index)
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   47  {
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  @48  	int baud = 9600, quot = 0;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   49  	unsigned int cval = 0;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   50  	int cflag = CREAD | HUPCL | CLOCAL | B9600 | CS8;
> 327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   51  	const struct old_serial_port *ser;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   52  	int err;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   53  
> 327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   54  	if (index >= ARRAY_SIZE(rs_table)) {
> 327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   55  		pr_info("no port info for ttyS%d\n", index);
> 327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   56  		return NULL;
> 327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   57  	}
> 327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   58  	ser = rs_table + index;
> 327b882d3bcc1f drivers/staging/speakup/serialio.c Samuel Thibault        2016-01-15   59  
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   60  	/*	Divisor, bytesize and parity */
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   61  	quot = ser->baud_base / baud;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   62  	cval = cflag & (CSIZE | CSTOPB);
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   63  #if defined(__powerpc__) || defined(__alpha__)
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   64  	cval >>= 8;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   65  #else /* !__powerpc__ && !__alpha__ */
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   66  	cval >>= 4;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   67  #endif /* !__powerpc__ && !__alpha__ */
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   68  	if (cflag & PARENB)
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   69  		cval |= UART_LCR_PARITY;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   70  	if (!(cflag & PARODD))
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   71  		cval |= UART_LCR_EPAR;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   72  	if (synth_request_region(ser->port, 8)) {
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   73  		/* try to take it back. */
> 3a046c19158e89 drivers/staging/speakup/serialio.c Keerthimai Janarthanan 2014-03-18   74  		pr_info("Ports not available, trying to steal them\n");
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   75  		__release_region(&ioport_resource, ser->port, 8);
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   76  		err = synth_request_region(ser->port, 8);
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   77  		if (err) {
> 3ee0017e03cd79 drivers/staging/speakup/serialio.c Jiri Slaby             2012-03-05   78  			pr_warn("Unable to allocate port at %x, errno %i",
> baf9ac9ff8864c drivers/staging/speakup/serialio.c William Hubbs          2010-10-15   79  				ser->port, err);
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   80  			return NULL;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   81  		}
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   82  	}
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   83  
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   84  	/*	Disable UART interrupts, set DTR and RTS high
> 13d825edd4441d drivers/staging/speakup/serialio.c Aleksei Fedotov        2015-08-14   85  	 *	and set speed.
> 13d825edd4441d drivers/staging/speakup/serialio.c Aleksei Fedotov        2015-08-14   86  	 */
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   87  	outb(cval | UART_LCR_DLAB, ser->port + UART_LCR);	/* set DLAB */
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   88  	outb(quot & 0xff, ser->port + UART_DLL);	/* LS of divisor */
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   89  	outb(quot >> 8, ser->port + UART_DLM);		/* MS of divisor */
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   90  	outb(cval, ser->port + UART_LCR);		/* reset DLAB */
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   91  
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   92  	/* Turn off Interrupts */
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   93  	outb(0, ser->port + UART_IER);
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   94  	outb(UART_MCR_DTR | UART_MCR_RTS, ser->port + UART_MCR);
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   95  
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   96  	/* If we read 0xff from the LSR, there is no UART here. */
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   97  	if (inb(ser->port + UART_LSR) == 0xff) {
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   98  		synth_release_region(ser->port, 8);
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07   99  		serstate = NULL;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  100  		return NULL;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  101  	}
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  102  
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  103  	mdelay(1);
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  104  	speakup_info.port_tts = ser->port;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  105  	serstate = ser;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  106  
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  107  	start_serial_interrupt(ser->irq);
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  108  
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  109  	return ser;
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  110  }
> c6e3fd22cd5383 drivers/staging/speakup/serialio.c William Hubbs          2010-10-07  111  
> 
> :::::: The code at line 48 was first introduced by commit
> :::::: c6e3fd22cd538365bfeb82997d5b89562e077d42 Staging: add speakup to the staging directory
> 
> :::::: TO: William Hubbs <w.d.hubbs@gmail.com>
> :::::: CC: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

