Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5793C28BEFD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403986AbgJLR0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389613AbgJLR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:26:35 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C00C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:26:34 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e22so24337320ejr.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jfRqsNqCQEape10RQhRcZ/NBG4vE9xmHkftKBlkAo+w=;
        b=RWEdoDXh23I7mNzcoiO8mFVyVJ5fbuVashSYnodDsgaeHWjWO6oMHKKo0ppUz6vTdB
         sjTVF+8RPwFN2Briszy1xm0Ql6LERqKR2sYtQH+qpOgqphVLQXVH0H6nW1EMgTF1Samg
         T4etfdTV6py+/vbCiyzUpIUDaiaKzZs00RHmv+9FuVSmyK23L+Puz1V21UgWM8dNZbFP
         eAk9TUvg2FDEC/D6A3z+4raglnmB42ozAX9WqnREo4bzYs43sPzdH21ondFetLhqTy6J
         3g4HDDzBi22PL1B7SNQoSRUdQit55tp84jENbsbQzf88taUcGzWnTMqJawVtOBaOOq9c
         fw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=jfRqsNqCQEape10RQhRcZ/NBG4vE9xmHkftKBlkAo+w=;
        b=qMyNe5HlCwSAUnkGzHFwIr5T7MwhUgq0I7diiO/qA4pGzAJ2y/blcuAj2zPoXJM5Qy
         weWRFheSc0k/gbe7BrRc+jTsLon8yQXfuwRXdKdMi8c8vynngj4I3Jn9lvySrPBfoaNU
         LNOtJNXXCEMgD2Ha5v6MTr5GR4tf0LETv+8ntI7tDAyNWlEe9RJZZ5c/T1W87FG+bHj7
         BVj4IbO/HGH5IfTBRbFsy+UrQZn4Q72Dty0APr0dAaNItnbk21C/9sjTmJTLT34xjxSH
         Fctrt3WuTaSYkdQhK7OmteTEh2EE7fQaCcq7944TcpxAZWZ0hZkMpw2oyjgUANHM0syH
         QQCQ==
X-Gm-Message-State: AOAM5328iOWEc/ui5qnRzxU+EJPP8luaZxMzthbGX2hmtmq22UMT0E58
        gR0mLW3pkyYXESoRKvh//LA=
X-Google-Smtp-Source: ABdhPJwryRiLuazDtuWuH3JnNF6sexunfuvtAgvhndx77sTEg0Z1Kzrv1DJGHVryR5ikwRpXhIaUyQ==
X-Received: by 2002:a17:906:394:: with SMTP id b20mr28450692eja.513.1602523592964;
        Mon, 12 Oct 2020 10:26:32 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id rn10sm10736655ejb.8.2020.10.12.10.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 10:26:32 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 19:26:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [GIT PULL] x86/build change for v5.10
Message-ID: <20201012172630.GA2963540@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/build git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2020-10-12

   # HEAD: 642d94cf336fe57675e63a91d11f53d74b9a3f9f x86/build: Declutter the build output

Remove a couple of ancient and distracting printouts from the x86 build,
such as the CRC sum or limited size data - most of which can be gained
via tools.

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      x86/build: Declutter the build output


 arch/x86/boot/tools/build.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index c8b8c1a8d1fc..a3725ad46c5a 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -416,8 +416,6 @@ int main(int argc, char ** argv)
 	/* Set the default root device */
 	put_unaligned_le16(DEFAULT_ROOT_DEV, &buf[508]);
 
-	printf("Setup is %d bytes (padded to %d bytes).\n", c, i);
-
 	/* Open and stat the kernel file */
 	fd = open(argv[2], O_RDONLY);
 	if (fd < 0)
@@ -425,7 +423,6 @@ int main(int argc, char ** argv)
 	if (fstat(fd, &sb))
 		die("Unable to stat `%s': %m", argv[2]);
 	sz = sb.st_size;
-	printf("System is %d kB\n", (sz+1023)/1024);
 	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
 	if (kernel == MAP_FAILED)
 		die("Unable to mmap '%s': %m", argv[2]);
@@ -488,7 +485,6 @@ int main(int argc, char ** argv)
 	}
 
 	/* Write the CRC */
-	printf("CRC %x\n", crc);
 	put_unaligned_le32(crc, buf);
 	if (fwrite(buf, 1, 4, dest) != 4)
 		die("Writing CRC failed");
