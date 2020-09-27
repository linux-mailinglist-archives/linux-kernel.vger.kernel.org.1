Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F66F27A313
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgI0T4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgI0Tz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:55:27 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85648C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 12:55:27 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w16so9229066oia.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DxOdAl7sH3OhvBKk5Ro74hqjL09MxO9v9O8lpGWE/Ek=;
        b=KVteUaGtYYgt1pv8F5e/d8+hcMVIW/7x3P9l2b0v9RRK6abnRV7j36wZjBv43+lQxZ
         bQv1189Plz+EDjPVCs7EZ13FbC3p9X/J5jasnqWOgqpDmofjC8rx3NVrRmDtWwBHXgVQ
         ujxK3bIkAlFUFaIQEX3j+dXEwqANUUx50lodmuuSJGslWGveIBZW7HypORuc4Q9ioaOM
         NPjPwqK62dDiXNr9S4kwditIsLh56hC0NEJPO6R85C7ArBhBcLLeIB9ml0VtyVX4WVtF
         A9SgKEqrhN/2tTbXdC4FNwwvHroTzFmweTW9wVhVh09419lCrK8f0zIssHYgQqKrt4H+
         zZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=DxOdAl7sH3OhvBKk5Ro74hqjL09MxO9v9O8lpGWE/Ek=;
        b=K+Etb+qHyUtbXbwhVSmf0sE7hYaQURiyax3wQsq+s2ATs0snzuJ7923N0DyVr1oV5x
         YCiF18dMVjHKJJVeTLSPYoIMF7NiRe/6SRfxmb5u/roEq3fjZ1vr7qu93SYaAWz4qLoA
         wCfYueUQww1dL19f/I/swOH66c0Hg0OejLHy9jtIuyyfpdoAvPMSnIuMgOXjAxRyw+Av
         cSfBseQa8yjS2M5bdAVDy0Zx8hYTXvS9LHyh1ZhOdxBH7aqOqIGTgIbRSCyZlRu2oGbj
         C7Y3hfsr1iLEfY7pUDxHKUPu6O3zF+YkRofcmdwawaz9mpVAaiAdb8kwsH/kOViTQYyd
         P+gA==
X-Gm-Message-State: AOAM5339N1BH/rQGe6cEQ/awPV9+izPNQhXCneJBQ0xme2Qx/KU/UBzI
        MGSA+/jLXmL3c1toveZzUw==
X-Google-Smtp-Source: ABdhPJxXHDC780tJT60de9ANwysRXLNM1qinrcGPc66kEjeW46EM1rBaJI0YvkJ7HCiFWd895s2HjQ==
X-Received: by 2002:aca:538f:: with SMTP id h137mr4328180oib.103.1601236526568;
        Sun, 27 Sep 2020 12:55:26 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id w4sm2333319otm.57.2020.09.27.12.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:55:25 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:2c0b:4c97:d400:dc84])
        by serve.minyard.net (Postfix) with ESMTPSA id F017F18003E;
        Sun, 27 Sep 2020 19:55:24 +0000 (UTC)
Date:   Sun, 27 Sep 2020 14:55:23 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug with data getting dropped on a pty
Message-ID: <20200927195523.GP3674@minyard.net>
Reply-To: minyard@acm.org
References: <20200925220536.GG3674@minyard.net>
 <20200927113751.GA98491@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927113751.GA98491@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 01:37:51PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 25, 2020 at 05:05:36PM -0500, Corey Minyard wrote:
> > I've been trying to track down a bug in a library I support (named
> > gensio; it does all kinds of stream I/O) and I have figured out that
> > the problem is not in the library, it's in the kernel.  I have
> > attached a reproducer program, more on how to run it later.
> > 
> > Basically, if you have a pty master and do the following:
> > 
> >   write(ptym, data, size);
> >   close(ptym);
> > 
> > The other end will occasionally not get the first 4095 bytes of data,
> > but it will get byte 4095 and on.  This only happens on SMP systems; I
> > couldn't reproduce with just one processor.  (Running under qemu I
> > have seen it drop 2048 bytes, but it has always been 4095 outside of a
> > VM.)  I have tested on Ubuntu 18.04.5 x86_64, the base 5.4 kernel, on a
> > raspberry pi running raspian, 5.4.51 kernel, and the latest on the
> > master branch of Linus' tree running under qemu on x86_64.
> > 
> > I have never seen it fail going the other way (writing to the slave
> > and reading from the master) and that's part of the test suite.
> > 
> > I'm ok with it not getting any of the data, I'm ok with it getting
> > some of the data at the beginning, but dropping a chunk of the data
> > and getting later data is a problem.
> > 
> > I've looked at the pty and tty code and I haven't found anything
> > obvious, but I haven't looked that hard and I don't know that code
> > very well.
> > 
> > To run the reproducer:
> > 
> >   gcc -g -o testpty testpty.c
> >   ulimit -c unlimited
> >   while ./testpty; do echo pass; done
> > 
> > It should fail pretty quickly; it asserts when it detects the error.
> > You can load the core dump into the debugger.  Note that I wasn't able
> > to reproduce running it in the debugger.
> > 
> > In the debugger, you can back up to the assert and look at the readbuf:
> > 
> > (gdb) x/30xb readbuf
> > 0x559e5e9c6080 <readbuf>:	0xff	0x08	0x00	0x08	0x01	0x08	0x02	0x08
> > 0x559e5e9c6088 <readbuf+8>:	0x03	0x08	0x04	0x08	0x05	0x08	0x06	0x08
> > 0x559e5e9c6090 <readbuf+16>:	0x07	0x08	0x08	0x08	0x09	0x08	0x0a	0x08
> > 0x559e5e9c6098 <readbuf+24>:	0x0b	0x08	0x0c	0x08	0x0d	0x08
> > 
> > verses the data that was sent:
> > 
> > 0x559e5e9b6080 <data>:	0x00	0x00	0x00	0x01	0x00	0x02	0x00	0x03
> > 0x559e5e9b6088 <data+8>:	0x00	0x04	0x00	0x05	0x00	0x06	0x00	0x07
> > 0x559e5e9b6090 <data+16>:	0x00	0x08	0x00	0x09	0x00	0x0a	0x00	0x0b
> > 0x559e5e9b6098 <data+24>:	0x00	0x0c	0x00	0x0d	0x00	0x0e
> > 
> > The data is two byte big endian numbers ascending, the data in readbuf
> > that was read by the reader thread is the data starting at position
> > 4095 in the data buffer that was transmitted.  Since n_tty has a 4096
> > byte buffer, that's somewhat suspicious.
> > 
> > Though the reproducer always fails on the first buffer, the test
> > program I had would close in random places, it would fail at places
> > besides the beginning of the buffer.
> > 
> > I searched and I couldn't find any error report on this.
> > 
> > -corey
> 
> > 
> > #define _XOPEN_SOURCE 600
> > #define _DEFAULT_SOURCE
> > 
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <fcntl.h>
> > #include <pthread.h>
> > #include <unistd.h>
> > #include <errno.h>
> > #include <termios.h>
> > #include <assert.h>
> > 
> > static int pty_make_raw(int ptym)
> > {
> >     struct termios t;
> >     int err;
> > 
> >     err = tcgetattr(ptym, &t);
> >     if (err)
> > 	return err;
> > 
> >     cfmakeraw(&t);
> >     return tcsetattr(ptym, TCSANOW, &t);
> > }
> > 
> > unsigned char data[65536];
> > unsigned char readbuf[65536];
> > int slavefd, slaveerr;
> > size_t readsize;
> > 
> > int
> > cmp_mem(unsigned char *buf, unsigned char *buf2, size_t len, size_t pos)
> > {
> >     size_t i;
> >     int rv = 0;
> > 
> >     for (i = 0; i < len; i++) {
> > 	if (buf[i] != buf2[i]) {
> > 	    printf("Mismatch on byte %lu, expected 0x%2.2x, got 0x%2.2x\n",
> > 		   (long) (i + pos), buf[i], buf2[i]);
> > 	    fflush(stdout);
> > 	    rv = -1;
> > 	    break;
> > 	}
> >     }
> >     return rv;
> > }
> > 
> > static void *read_thread(void *dummy)
> > {
> >     ssize_t i;
> > 
> >     do {
> > 	i = read(slavefd, readbuf + readsize, sizeof(readbuf) - readsize);
> > 	if (i <= -1) {
> > 	    if (errno == EAGAIN)
> > 		continue;
> > 	    if (errno == EIO)
> > 		/* Remote close causes an EIO. */
> > 		return NULL;
> > 	    perror("read");
> > 	    slaveerr = errno;
> > 	    return NULL;
> > 	}
> > 	if (i + readsize > sizeof(data)) {
> > 	    slaveerr = E2BIG;
> > 	    return NULL;
> > 	}
> > 	if (i && cmp_mem(data + readsize, readbuf + readsize, i, readsize)) {
> > 	    fprintf(stderr, "Data mismatch, starting at %ld, %ld bytes\n",
> > 		    (long) readsize, (long) i);
> > 	    assert(0);
> > 	    slaveerr = EBADMSG;
> > 	    return NULL;
> > 	}
> > 	readsize += i;
> >     } while (i != 0);
> > 
> >     return NULL;
> > }
> > 
> > int main(int argc, char *argv[])
> > {
> >     int ptym, err;
> >     char *slave;
> >     ssize_t i;
> >     pthread_t slavethr;
> > 
> >     for (i = 0; i < sizeof(data); i += 2) {
> > 	data[i] = (i / 2) >> 8;
> > 	data[i + 1] = i / 2;
> >     }
> > 
> >     ptym = posix_openpt(O_RDWR | O_NOCTTY);
> >     if (ptym == -1) {
> > 	perror("posix_openpt");
> > 	exit(1);
> >     }
> > 
> >     if (fcntl(ptym, F_SETFL, O_NONBLOCK) == -1) {
> > 	perror("fcntl ptym");
> > 	exit(1);
> >     }
> > 
> >     if (pty_make_raw(ptym)) {
> > 	perror("pty_make_raw");
> > 	exit(1);
> >     }
> > 
> >     if (unlockpt(ptym) < 0) {
> > 	perror("unlockpt");
> > 	exit(1);
> >     }
> > 
> >     slave = ptsname(ptym);
> >     slavefd = open(slave, O_RDWR);
> >     if (slavefd == -1) {
> > 	perror("open");
> > 	exit(1);
> >     }
> > 
> >     err = pthread_create(&slavethr, NULL, read_thread, NULL);
> >     if (err) {
> > 	fprintf(stderr, "pthread_create: %s\n", strerror(err));
> > 	exit(1);
> >     }
> > 
> >     i = write(ptym, data, sizeof(data));
> >     if (i == -1) {
> > 	perror("write");
> > 	exit(1);
> >     }
> 
> Can this write be racing with the pthred_create() and start writing data
> before the reader is actually reading?  Odds are the write() is breaking
> things up into chunks anyway (libc does this), so the first 4k of data
> might have been sent and filled up in the kernel, and then overwritten
> by the second 4k of data before the reader gets a chance to run.
> 
> If you serialize your reader thread starting up before you start
> writing, does that solve the issue here?

I don't know of a way to serialize this to guarantee that the reader is
sitting in the read call before the write happens.  I would think that
is impossible.  The first thread creates and opens the slave side of the
pty, so it's not a matter of the reader side not being open.  In my test
programs, the read side is definitely open and waiting, there is an
interlock there to make sure.

It was my impression from looking through the kernel code that the writer
would block (or return with EAGAIN in this case, since it is
non-blocking) if the buffer to the reader side is full (from looking in
n_tty_write()).  Is that not the case with ptys?

thanks,

-corey

> 
> thanks,
> 
> greg k-h
