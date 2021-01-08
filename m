Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EA42EF186
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbhAHLlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAHLlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:41:51 -0500
Received: from cc-smtpout1.netcologne.de (cc-smtpout1.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3449C0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 03:41:10 -0800 (PST)
Received: from cc-smtpin1.netcologne.de (cc-smtpin1.netcologne.de [89.1.8.201])
        by cc-smtpout1.netcologne.de (Postfix) with ESMTP id 4A64713400;
        Fri,  8 Jan 2021 12:41:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by cc-smtpin1.netcologne.de (Postfix) with ESMTP id 3BDC511DF3;
        Fri,  8 Jan 2021 12:41:08 +0100 (CET)
Received: from [213.196.221.66] (helo=cc-smtpin1.netcologne.de)
        by localhost with ESMTP (eXpurgate 4.11.6)
        (envelope-from <kurt@garloff.de>)
        id 5ff844d4-02f5-7f0000012729-7f000001c91e-1
        for <multiple-recipients>; Fri, 08 Jan 2021 12:41:08 +0100
Received: from nas2.garloff.de (xdsl-213-196-221-66.nc.de [213.196.221.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin1.netcologne.de (Postfix) with ESMTPSA;
        Fri,  8 Jan 2021 12:41:03 +0100 (CET)
Received: from [192.168.155.202] (ap4.garloff.de [192.168.155.15])
        by nas2.garloff.de (Postfix) with ESMTPSA id 9A542B3B13A5;
        Fri,  8 Jan 2021 12:41:01 +0100 (CET)
To:     Neil Brown <NeilB@suse.de>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Kurt Garloff <kurt@garloff.de>
Subject: NFS 4.2 client support broken on 5.10.5
Message-ID: <ee320885-9a78-80b8-9341-7c631df60d3a@garloff.de>
Date:   Fri, 8 Jan 2021 12:41:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------72260F2B7C3F9D9DB07CA8F7"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------72260F2B7C3F9D9DB07CA8F7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Neil, Anna, Trond,

compiling a kernel, I suddenly started getting errors from objtool orc.
(This first occurs on init/main.o.)

I looked at all kind of things, before I noticed that this was not a
toolchain issue (gcc-10.2.1 self compiled), gcc plugins (I use
structleak and stackleak) nor an issue with objtool or libelf,
but that there was an -EIO error.

The kernel tree is on an NFS share, and I run 5.10.5 client kernel
against the kernel NFS (4.2) server, running a 5.10.3 kernel.

The issue does NOT occur on a 5.10.3 client kernel, but is easily
reproducible on 5.10.5. Note that 5.10.5 on a local file system or
against an NFSv3 server does not show the issue.

Test program that reproduces this on the first pwrite64() is attached.
Note that the call to ftruncate() is required to make the problem happen.=


I could go on bisecting this to a particular patch, but you'll
probably be able to see right away what's wrong.

Best,

--=20
Kurt Garloff <kurt@garloff.de>
Cologne, Germany


--------------72260F2B7C3F9D9DB07CA8F7
Content-Type: text/x-csrc; charset=UTF-8;
 name="testpwrite.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="testpwrite.c"

/* testpwrite.c
 * reproduces issue on NFS 4.2 client on Linux 5.10.5
 * (c) Kurt Garloff <scs@garloff.de>, 1/2021
 * License: GNU GPL 2 or later=20
 */

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <time.h>

#define MAXBUF 1048576
#define MAXSIZE (128*MAXBUF)
#define REP 16384

long randomwrite(int fd)
{
	void* buf =3D malloc(MAXBUF);
	long written =3D 0;
	int rep =3D REP;
	int ret;
	if (!buf) {
		perror("malloc");
		return -3;
	}

	memset(buf, 0, MAXBUF);
	while (--rep) {
#if MAXSIZE >=3D RAND_MAX
		loff_t offset =3D rand() * (MAXSIZE/RAND_MAX);
#else
		loff_t offset =3D rand() / (RAND_MAX/MAXSIZE);
#endif
#if MAXBUF >=3D RAND_MAX
		size_t len =3D rand() * (MAXBUF/RAND_MAX);
#else
		size_t len =3D rand() / (RAND_MAX/MAXBUF);
#endif
		//ret =3D pread(fd, buf+len/4, len/2, offset);
		/* Slowly fill in some random non-0 values */
		*(int*)(buf + (len - len%8)) =3D rand();
		ret =3D pwrite(fd, buf, len, offset);
		if (ret < 0) {
			fprintf(stderr, "pwrite(%i,%p,%li,%li): ", fd, buf, len, offset);
			perror("");
			return -1;
		} else=20
			written +=3D ret;
	}
	return written;
}

int main(int argc, char *argv[])
{
	srand(time(0));
	int fd =3D open("testfile", O_RDWR|O_CREAT, S_IRUSR|S_IWUSR|S_IRGRP);
	if (fd <=3D 0) {
		perror("open(\"testfile\")");
		return 2;
	}
	ftruncate(fd, MAXSIZE);
	unlink("testfile");
	long rc =3D randomwrite(fd);
	close(fd);
	if (rc < 0)
		return -rc;
	printf("%li bytes written successfully\n", rc);
	return 0;
}


--------------72260F2B7C3F9D9DB07CA8F7--
