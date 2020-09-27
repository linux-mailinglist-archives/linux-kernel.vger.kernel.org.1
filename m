Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C24927A0AA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 13:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgI0Lhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 07:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgI0Lhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 07:37:43 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 556272388B;
        Sun, 27 Sep 2020 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601206661;
        bh=yOO3IWYaWa9ZUTsOWddo7KzzFQEzLLN31SDrl7Bad1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyNvYiBteN6vwDHCafZ8BfTxQI5mjHxETLR8B0Mk/bA+gjpbMt9Vkf2Enc2smaB22
         ceMsbsn5rJSRL6CnX9SE8cdhf7mEA6KNUj7HJeEWRdDYdjHJwUd5oo3CJSQ4brwFIU
         bmYU1k134fk31suwYN4jGQQDAY4yedbcdWdSqUlU=
Date:   Sun, 27 Sep 2020 13:37:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug with data getting dropped on a pty
Message-ID: <20200927113751.GA98491@kroah.com>
References: <20200925220536.GG3674@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925220536.GG3674@minyard.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 05:05:36PM -0500, Corey Minyard wrote:
> I've been trying to track down a bug in a library I support (named
> gensio; it does all kinds of stream I/O) and I have figured out that
> the problem is not in the library, it's in the kernel.  I have
> attached a reproducer program, more on how to run it later.
> 
> Basically, if you have a pty master and do the following:
> 
>   write(ptym, data, size);
>   close(ptym);
> 
> The other end will occasionally not get the first 4095 bytes of data,
> but it will get byte 4095 and on.  This only happens on SMP systems; I
> couldn't reproduce with just one processor.  (Running under qemu I
> have seen it drop 2048 bytes, but it has always been 4095 outside of a
> VM.)  I have tested on Ubuntu 18.04.5 x86_64, the base 5.4 kernel, on a
> raspberry pi running raspian, 5.4.51 kernel, and the latest on the
> master branch of Linus' tree running under qemu on x86_64.
> 
> I have never seen it fail going the other way (writing to the slave
> and reading from the master) and that's part of the test suite.
> 
> I'm ok with it not getting any of the data, I'm ok with it getting
> some of the data at the beginning, but dropping a chunk of the data
> and getting later data is a problem.
> 
> I've looked at the pty and tty code and I haven't found anything
> obvious, but I haven't looked that hard and I don't know that code
> very well.
> 
> To run the reproducer:
> 
>   gcc -g -o testpty testpty.c
>   ulimit -c unlimited
>   while ./testpty; do echo pass; done
> 
> It should fail pretty quickly; it asserts when it detects the error.
> You can load the core dump into the debugger.  Note that I wasn't able
> to reproduce running it in the debugger.
> 
> In the debugger, you can back up to the assert and look at the readbuf:
> 
> (gdb) x/30xb readbuf
> 0x559e5e9c6080 <readbuf>:	0xff	0x08	0x00	0x08	0x01	0x08	0x02	0x08
> 0x559e5e9c6088 <readbuf+8>:	0x03	0x08	0x04	0x08	0x05	0x08	0x06	0x08
> 0x559e5e9c6090 <readbuf+16>:	0x07	0x08	0x08	0x08	0x09	0x08	0x0a	0x08
> 0x559e5e9c6098 <readbuf+24>:	0x0b	0x08	0x0c	0x08	0x0d	0x08
> 
> verses the data that was sent:
> 
> 0x559e5e9b6080 <data>:	0x00	0x00	0x00	0x01	0x00	0x02	0x00	0x03
> 0x559e5e9b6088 <data+8>:	0x00	0x04	0x00	0x05	0x00	0x06	0x00	0x07
> 0x559e5e9b6090 <data+16>:	0x00	0x08	0x00	0x09	0x00	0x0a	0x00	0x0b
> 0x559e5e9b6098 <data+24>:	0x00	0x0c	0x00	0x0d	0x00	0x0e
> 
> The data is two byte big endian numbers ascending, the data in readbuf
> that was read by the reader thread is the data starting at position
> 4095 in the data buffer that was transmitted.  Since n_tty has a 4096
> byte buffer, that's somewhat suspicious.
> 
> Though the reproducer always fails on the first buffer, the test
> program I had would close in random places, it would fail at places
> besides the beginning of the buffer.
> 
> I searched and I couldn't find any error report on this.
> 
> -corey

> 
> #define _XOPEN_SOURCE 600
> #define _DEFAULT_SOURCE
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <fcntl.h>
> #include <pthread.h>
> #include <unistd.h>
> #include <errno.h>
> #include <termios.h>
> #include <assert.h>
> 
> static int pty_make_raw(int ptym)
> {
>     struct termios t;
>     int err;
> 
>     err = tcgetattr(ptym, &t);
>     if (err)
> 	return err;
> 
>     cfmakeraw(&t);
>     return tcsetattr(ptym, TCSANOW, &t);
> }
> 
> unsigned char data[65536];
> unsigned char readbuf[65536];
> int slavefd, slaveerr;
> size_t readsize;
> 
> int
> cmp_mem(unsigned char *buf, unsigned char *buf2, size_t len, size_t pos)
> {
>     size_t i;
>     int rv = 0;
> 
>     for (i = 0; i < len; i++) {
> 	if (buf[i] != buf2[i]) {
> 	    printf("Mismatch on byte %lu, expected 0x%2.2x, got 0x%2.2x\n",
> 		   (long) (i + pos), buf[i], buf2[i]);
> 	    fflush(stdout);
> 	    rv = -1;
> 	    break;
> 	}
>     }
>     return rv;
> }
> 
> static void *read_thread(void *dummy)
> {
>     ssize_t i;
> 
>     do {
> 	i = read(slavefd, readbuf + readsize, sizeof(readbuf) - readsize);
> 	if (i <= -1) {
> 	    if (errno == EAGAIN)
> 		continue;
> 	    if (errno == EIO)
> 		/* Remote close causes an EIO. */
> 		return NULL;
> 	    perror("read");
> 	    slaveerr = errno;
> 	    return NULL;
> 	}
> 	if (i + readsize > sizeof(data)) {
> 	    slaveerr = E2BIG;
> 	    return NULL;
> 	}
> 	if (i && cmp_mem(data + readsize, readbuf + readsize, i, readsize)) {
> 	    fprintf(stderr, "Data mismatch, starting at %ld, %ld bytes\n",
> 		    (long) readsize, (long) i);
> 	    assert(0);
> 	    slaveerr = EBADMSG;
> 	    return NULL;
> 	}
> 	readsize += i;
>     } while (i != 0);
> 
>     return NULL;
> }
> 
> int main(int argc, char *argv[])
> {
>     int ptym, err;
>     char *slave;
>     ssize_t i;
>     pthread_t slavethr;
> 
>     for (i = 0; i < sizeof(data); i += 2) {
> 	data[i] = (i / 2) >> 8;
> 	data[i + 1] = i / 2;
>     }
> 
>     ptym = posix_openpt(O_RDWR | O_NOCTTY);
>     if (ptym == -1) {
> 	perror("posix_openpt");
> 	exit(1);
>     }
> 
>     if (fcntl(ptym, F_SETFL, O_NONBLOCK) == -1) {
> 	perror("fcntl ptym");
> 	exit(1);
>     }
> 
>     if (pty_make_raw(ptym)) {
> 	perror("pty_make_raw");
> 	exit(1);
>     }
> 
>     if (unlockpt(ptym) < 0) {
> 	perror("unlockpt");
> 	exit(1);
>     }
> 
>     slave = ptsname(ptym);
>     slavefd = open(slave, O_RDWR);
>     if (slavefd == -1) {
> 	perror("open");
> 	exit(1);
>     }
> 
>     err = pthread_create(&slavethr, NULL, read_thread, NULL);
>     if (err) {
> 	fprintf(stderr, "pthread_create: %s\n", strerror(err));
> 	exit(1);
>     }
> 
>     i = write(ptym, data, sizeof(data));
>     if (i == -1) {
> 	perror("write");
> 	exit(1);
>     }

Can this write be racing with the pthred_create() and start writing data
before the reader is actually reading?  Odds are the write() is breaking
things up into chunks anyway (libc does this), so the first 4k of data
might have been sent and filled up in the kernel, and then overwritten
by the second 4k of data before the reader gets a chance to run.

If you serialize your reader thread starting up before you start
writing, does that solve the issue here?

thanks,

greg k-h
