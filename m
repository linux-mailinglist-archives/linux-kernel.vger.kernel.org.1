Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F992793EC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgIYWFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgIYWFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:05:40 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7568C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:05:40 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id z26so4315327oih.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=MCaQMXNIOSIwcEBT/cdZl59AfRo8qudmoHGlKAvr7EI=;
        b=VgLFQX+ahRmeSDyg1ePUTGv/z8BwEf0raiFwb5eTbvZ5n5xyAVaWqTMilEs/w76z9u
         B52Cc6ERp/dOEqUDV2+qiq/utXIzIXn1pkdjHNz1HQEmKW4sOslMxPsRw+lm86hTXSae
         OyIyG8U/2hxJzHwm3rCr8fYM9IKoa+1tUg2/HaSbq6kGrmXjhUTQnrwzPQjEn+Bedd5A
         CER1Vz/8PH28MsFiG34ChrFPJ3B5rJV890BD3hbXV+o9ipp5doXiXWjOP80rkGAPrtTJ
         3+U0v82Ic31yodn6ED0nn+2kPe7GeXWo15OH051m1JR8Oi50JGWGwi/ap4yCL1PSDZ9R
         nCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=MCaQMXNIOSIwcEBT/cdZl59AfRo8qudmoHGlKAvr7EI=;
        b=DfbMM2cVQsm45jdUcYOK+xougOi40dtyX+L7ohPNaixA5pSACS1Roakvy+NZIKFPW4
         AZySFVxeDmEI+mg8tSFAzovx1tcdDG0S1crbrgMSWjA61A8LjMTJ9POx0sCpsT1qYnnV
         hTmJ6hmuLNRWrz8Z6RUYrtExCfcoBDtVuF3jSSbsyRmzbtnRyUaAbfYqvJK2GQAe2/IC
         sP+1UXxYuwJmbRYbuiD+tRXEsbZaR7P0NLzDvh3TzmkloJP+wVDbU03UPLgBVjb0sQqV
         UsSVu4Xg1KeEZUV1PUMCy1fw5iPYo9ZtQ/MXJm3wXgcrQ6VtyrsIeot/mYvah7hyYqpy
         JJGA==
X-Gm-Message-State: AOAM533y9ZQIoqAqSlOiA4w0D/binFJZ+wKTnEdEE9JL1bIs90eza4sH
        UoW9zxEktBcXcs6cg2xkJg==
X-Google-Smtp-Source: ABdhPJwS1yeaxlKUTLajO6U5LoXn/zDqdMmc6RtEebrDusmCLMhk6wM3K4mH/1TAOo7/QMbDxkcGEw==
X-Received: by 2002:aca:d07:: with SMTP id 7mr437852oin.52.1601071540084;
        Fri, 25 Sep 2020 15:05:40 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id r33sm118115ooi.48.2020.09.25.15.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 15:05:38 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:29e1:285e:eacc:d718])
        by serve.minyard.net (Postfix) with ESMTPSA id C313718003E;
        Fri, 25 Sep 2020 22:05:37 +0000 (UTC)
Date:   Fri, 25 Sep 2020 17:05:36 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Bug with data getting dropped on a pty
Message-ID: <20200925220536.GG3674@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been trying to track down a bug in a library I support (named
gensio; it does all kinds of stream I/O) and I have figured out that
the problem is not in the library, it's in the kernel.  I have
attached a reproducer program, more on how to run it later.

Basically, if you have a pty master and do the following:

  write(ptym, data, size);
  close(ptym);

The other end will occasionally not get the first 4095 bytes of data,
but it will get byte 4095 and on.  This only happens on SMP systems; I
couldn't reproduce with just one processor.  (Running under qemu I
have seen it drop 2048 bytes, but it has always been 4095 outside of a
VM.)  I have tested on Ubuntu 18.04.5 x86_64, the base 5.4 kernel, on a
raspberry pi running raspian, 5.4.51 kernel, and the latest on the
master branch of Linus' tree running under qemu on x86_64.

I have never seen it fail going the other way (writing to the slave
and reading from the master) and that's part of the test suite.

I'm ok with it not getting any of the data, I'm ok with it getting
some of the data at the beginning, but dropping a chunk of the data
and getting later data is a problem.

I've looked at the pty and tty code and I haven't found anything
obvious, but I haven't looked that hard and I don't know that code
very well.

To run the reproducer:

  gcc -g -o testpty testpty.c
  ulimit -c unlimited
  while ./testpty; do echo pass; done

It should fail pretty quickly; it asserts when it detects the error.
You can load the core dump into the debugger.  Note that I wasn't able
to reproduce running it in the debugger.

In the debugger, you can back up to the assert and look at the readbuf:

(gdb) x/30xb readbuf
0x559e5e9c6080 <readbuf>:	0xff	0x08	0x00	0x08	0x01	0x08	0x02	0x08
0x559e5e9c6088 <readbuf+8>:	0x03	0x08	0x04	0x08	0x05	0x08	0x06	0x08
0x559e5e9c6090 <readbuf+16>:	0x07	0x08	0x08	0x08	0x09	0x08	0x0a	0x08
0x559e5e9c6098 <readbuf+24>:	0x0b	0x08	0x0c	0x08	0x0d	0x08

verses the data that was sent:

0x559e5e9b6080 <data>:	0x00	0x00	0x00	0x01	0x00	0x02	0x00	0x03
0x559e5e9b6088 <data+8>:	0x00	0x04	0x00	0x05	0x00	0x06	0x00	0x07
0x559e5e9b6090 <data+16>:	0x00	0x08	0x00	0x09	0x00	0x0a	0x00	0x0b
0x559e5e9b6098 <data+24>:	0x00	0x0c	0x00	0x0d	0x00	0x0e

The data is two byte big endian numbers ascending, the data in readbuf
that was read by the reader thread is the data starting at position
4095 in the data buffer that was transmitted.  Since n_tty has a 4096
byte buffer, that's somewhat suspicious.

Though the reproducer always fails on the first buffer, the test
program I had would close in random places, it would fail at places
besides the beginning of the buffer.

I searched and I couldn't find any error report on this.

-corey

--aVD9QWMuhilNxW9f
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="testpty.c"


#define _XOPEN_SOURCE 600
#define _DEFAULT_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <pthread.h>
#include <unistd.h>
#include <errno.h>
#include <termios.h>
#include <assert.h>

static int pty_make_raw(int ptym)
{
    struct termios t;
    int err;

    err = tcgetattr(ptym, &t);
    if (err)
	return err;

    cfmakeraw(&t);
    return tcsetattr(ptym, TCSANOW, &t);
}

unsigned char data[65536];
unsigned char readbuf[65536];
int slavefd, slaveerr;
size_t readsize;

int
cmp_mem(unsigned char *buf, unsigned char *buf2, size_t len, size_t pos)
{
    size_t i;
    int rv = 0;

    for (i = 0; i < len; i++) {
	if (buf[i] != buf2[i]) {
	    printf("Mismatch on byte %lu, expected 0x%2.2x, got 0x%2.2x\n",
		   (long) (i + pos), buf[i], buf2[i]);
	    fflush(stdout);
	    rv = -1;
	    break;
	}
    }
    return rv;
}

static void *read_thread(void *dummy)
{
    ssize_t i;

    do {
	i = read(slavefd, readbuf + readsize, sizeof(readbuf) - readsize);
	if (i <= -1) {
	    if (errno == EAGAIN)
		continue;
	    if (errno == EIO)
		/* Remote close causes an EIO. */
		return NULL;
	    perror("read");
	    slaveerr = errno;
	    return NULL;
	}
	if (i + readsize > sizeof(data)) {
	    slaveerr = E2BIG;
	    return NULL;
	}
	if (i && cmp_mem(data + readsize, readbuf + readsize, i, readsize)) {
	    fprintf(stderr, "Data mismatch, starting at %ld, %ld bytes\n",
		    (long) readsize, (long) i);
	    assert(0);
	    slaveerr = EBADMSG;
	    return NULL;
	}
	readsize += i;
    } while (i != 0);

    return NULL;
}

int main(int argc, char *argv[])
{
    int ptym, err;
    char *slave;
    ssize_t i;
    pthread_t slavethr;

    for (i = 0; i < sizeof(data); i += 2) {
	data[i] = (i / 2) >> 8;
	data[i + 1] = i / 2;
    }

    ptym = posix_openpt(O_RDWR | O_NOCTTY);
    if (ptym == -1) {
	perror("posix_openpt");
	exit(1);
    }

    if (fcntl(ptym, F_SETFL, O_NONBLOCK) == -1) {
	perror("fcntl ptym");
	exit(1);
    }

    if (pty_make_raw(ptym)) {
	perror("pty_make_raw");
	exit(1);
    }

    if (unlockpt(ptym) < 0) {
	perror("unlockpt");
	exit(1);
    }

    slave = ptsname(ptym);
    slavefd = open(slave, O_RDWR);
    if (slavefd == -1) {
	perror("open");
	exit(1);
    }

    err = pthread_create(&slavethr, NULL, read_thread, NULL);
    if (err) {
	fprintf(stderr, "pthread_create: %s\n", strerror(err));
	exit(1);
    }

    i = write(ptym, data, sizeof(data));
    if (i == -1) {
	perror("write");
	exit(1);
    }
    close(ptym);

    pthread_join(slavethr, NULL);

    exit(0);
}

--aVD9QWMuhilNxW9f--
