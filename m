Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC0726A02E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIOHvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgIOHv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:51:27 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49882C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:51:27 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id w186so3378454qkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=w5tc9cbOehLAywHlBo2Tn7koEhhESNIiqMonIppKdcc=;
        b=JkavMRh6oyCevlqAdtvEHCuA7VM1wdoKsDVyv9jk+yAYDjZtp3AaAlWzTNWZobwbXC
         crzh6IHu55s+uiBeJgL1cRhiYk7+x9JiIuMBL9/Ai2csN7UTcUz+B9yEicgw8rlUP9w2
         EKWgCfZNS2Y6YxLj4oW8KZevv5aWhs71sUre8lILgG/Fr1mvFdMLM/M7FkiBbwrQe6rm
         x39xGHPro7oB5hphFr0kZwRphh/1Aec1dmUsnoG0DZ4UzRd27Vk4sBxr5E30NrILhx7K
         BpYKWxfIWcH/o6SnXP3CQCJORTz9/E5YHwoFdiNHAcQWDe9dY9/+7z+fzgZtp2sA62Ls
         BQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=w5tc9cbOehLAywHlBo2Tn7koEhhESNIiqMonIppKdcc=;
        b=QH3qT5YsiJtod54dYvoengvUrKJWTA8uR15wmW22qnKGk1cTJFu6Br1trPJXCPM2aO
         INXAUqHL0mB8VWkk+QM7p2WM+PiCAtU9qwqS+sjmBfisFNqcxthVrmH+AaRK2ImTARzY
         /YpY7hwKtLhcVBAHZ3nA7CascCQpdBVU0LmqCuiqhS5J/yAYPuCjxgS87oxwdV/DeJAR
         qeXgwuWQnoSiP9DHpl7Or34j4/fj049KEkjDOhfTa80nWQRJc3SaRKPDn+mnNZvdaV4c
         8x5l6aFDDycqfNQ34AXAeMpkEaZdQ/WPcdVm5et67BfTAsIhxyp8tsy0lZ6C7tIve9BX
         ywUQ==
X-Gm-Message-State: AOAM530s/sogX8dBJ8dGu5ydRTqb3+g74QFqKGsTKLvc7bilTTWWBHmD
        1GNtLOZSFUv2hG+z+M/hGjo+Og==
X-Google-Smtp-Source: ABdhPJwMQFnhqCsm/LQt1wT5UWzKruTmYBlNV9pPGzNrQIKY+6qWLiX0RR3OGsdbBvHEqh4FLfPWow==
X-Received: by 2002:a37:6543:: with SMTP id z64mr16563968qkb.173.1600156286129;
        Tue, 15 Sep 2020 00:51:26 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q185sm15245373qke.25.2020.09.15.00.51.22
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 15 Sep 2020 00:51:23 -0700 (PDT)
Date:   Tue, 15 Sep 2020 00:50:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Static call dependency on libelf version?
Message-ID: <alpine.LSU.2.11.2009142337530.1550@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just an FYI written from a position of ignorance: I may
have got it wrong, and my build environment too piecemeal to matter
to anyone else; but what I saw was weird enough to be worth mentioning,
in case it saves someone some time.

I usually build and test on mmotm weekly rather linux-next daily.
No problem with 5.9-rc3-mm1 from 2020-09-04, nor with 5.9-rc5, but
(on two machines) 5.9-rc5-mm1 from 2020-09-13 could not link vmlinux:

  AR      init/built-in.a
  LD      vmlinux.o
ld: warning: init/main.o has a corrupt section with a size (7472747368732e00) larger than the file size
ld: warning: init/main.o has a corrupt section with a size (7472747368732e00) larger than the file size
ld: warning: init/main.o has a corrupt section with a size (7472747368732e00) larger than the file size
ld: warning: init/main.o has a corrupt section with a size (7472747368732e00) larger than the file size
ld: init/built-in.a: member init/main.o in archive is not an object
make[1]: *** [vmlinux] Error 1
make: *** [__sub-make] Error 2

On the third machine, a more recent installation, but using the same
gcc and the same binutils, I could build the same config successfully.
init/main.o was the same size on each (49216 bytes), but diff of hd
of the good against the bad showed:

2702,2709c2702,2709
< 00bfc0 000001db 00000001 00000003 00000000  >................<
< 00bfd0 00000000 00000000 0000b316 00000000  >................<
< 00bfe0 00000018 00000000 00000000 00000000  >................<
< 00bff0 00000001 00000000 00000008 00000000  >................<
< 00c000 000001ee 00000004 00000040 00000000  >........@.......<
< 00c010 00000000 00000000 0000b330 00000000  >........0.......<
< 00c020 00000090 00000000 0000002d 00000030  >........-...0...<
< 00c030 00000008 00000000 00000018 00000000  >................<
---
> 00bfc0 00000000 00000000 000001f1 00000000  >................<
> 00bfd0 79732e00 6261746d 74732e00 62617472  >..symtab..strtab<
> 00bfe0 68732e00 74727473 2e006261 616c6572  >..shstrtab..rela<
> 00bff0 7865742e 722e0074 2e616c65 61746164  >.text..rela.data<
> 00c000 73622e00 722e0073 5f616c65 6172745f  >..bss..rela__tra<
> 00c010 6f706563 73746e69 7274705f 722e0073  >cepoints_ptrs..r<
> 00c020 2e616c65 74617473 635f6369 2e6c6c61  >ela.static_call.<
> 00c030 74786574 65722e00 692e616c 2e74696e  >text..rela.init.<

and 217 other .os in the build tree also "corrupted".

CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
stand out as new in the .config for 5.9-rc5-mm1, and references
to objtool in static_call.h and static_call_types.h took me to
tools/objtool/Makefile, with its use of libelf.

I've copied over files of the newer libelf (0.168) to the failing
machines, which are now building the 5.9-rc5-mm1 vmlinux correctly.

It looks as if CONFIG_HAVE_STATIC_CALL=y depends on a newer libelf
than I had before (0.155), and should either insist on a minimum
version, or else be adjusted to work with older versions.

Hope this helps,
Hugh
