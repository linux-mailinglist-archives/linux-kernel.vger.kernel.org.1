Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51BE1F5D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 23:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFJVQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 17:16:15 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:49547 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgFJVQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:16:06 -0400
Received: by mail-io1-f69.google.com with SMTP id d20so2426081iom.16
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sUI1O0BTtU05qonMyEtsZi52Vb5rXo2ggrraYblD2Ao=;
        b=RHRS+kOaaczSaIKTbRedNLiWisMlbB/3AatnqGuCWQ/N9ObaSbc1C/niblhe2jEy3t
         OXb774c3W61q1JR1SsuS4RrgDz7VlicuWH8BOrK/9jjaWjWuKkwg+GyCUds/RT9JP16d
         EytZ25RsW4ua+zCPv/WNkQpxq1Aka2FXuyaUuNUrbkXCldHYW6ZRXKVcsb3ec0zFRYIs
         mktJyKrJ9ARzLHjX5uhgUo+2JdCl19jiGBtLBOCLnTKhgpAGfAA0x0//4yowPBvIMOdl
         FTm6ZRP9w2Y6WaInKPoT0cAH4sigoHUoY+KkSd3K5tMggpYIxAzykFvpyIA2F+5ozXlR
         N1LQ==
X-Gm-Message-State: AOAM531d2i86OAsRh1WtokTZEkApPu5m3JWONNidGLxCp4p3Wp1Zh2jE
        70KDb7eaM9L2peYhr3qR5KaXWqhhj9WAmOkTUT/GYtqarz1b
X-Google-Smtp-Source: ABdhPJzP2fObnwqMht/MQg73gUpjlISw8vhKWYKTEQxMGR0styJRYuImaxvvsiNwskjE4Jp9/pIHOD29/jGcPwxGSttyFl/xpFLQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13f4:: with SMTP id w20mr5060814ilj.294.1591823764565;
 Wed, 10 Jun 2020 14:16:04 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:16:04 -0700
In-Reply-To: <20200610211019.GJ1347934@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000839a705a7c15aa5@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 generic_perform_write (2)
From:   syzbot <syzbot+bca9799bf129256190da@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        dan.j.williams@intel.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

syzkaller build failed: failed to run ["make" "target"]: exit status 2
GOOS=linux GOARCH=amd64 go install ./syz-fuzzer
# github.com/google/syzkaller/sys/netbsd/gen
sys/netbsd/gen/amd64.go:41:58: undefined: Field
sys/netbsd/gen/amd64.go:44:10: undefined: Ref
sys/netbsd/gen/amd64.go:45:59: undefined: Ref
sys/netbsd/gen/amd64.go:46:70: undefined: Field
sys/netbsd/gen/amd64.go:49:66: undefined: Field
sys/netbsd/gen/amd64.go:54:60: undefined: Field
sys/netbsd/gen/amd64.go:58:66: undefined: Field
sys/netbsd/gen/amd64.go:62:68: undefined: Field
sys/netbsd/gen/amd64.go:68:62: undefined: Field
sys/netbsd/gen/amd64.go:72:59: undefined: Ref
sys/netbsd/gen/amd64.go:72:59: too many errors
# github.com/google/syzkaller/sys/akaros/gen
sys/akaros/gen/amd64.go:23:63: undefined: Field
sys/akaros/gen/amd64.go:26:69: undefined: Field
sys/akaros/gen/amd64.go:29:56: undefined: Field
sys/akaros/gen/amd64.go:34:52: undefined: Field
sys/akaros/gen/amd64.go:39:67: undefined: Field
sys/akaros/gen/amd64.go:43:54: undefined: Field
sys/akaros/gen/amd64.go:48:54: undefined: Field
sys/akaros/gen/amd64.go:51:64: undefined: Field
sys/akaros/gen/amd64.go:56:51: undefined: Field
sys/akaros/gen/amd64.go:62:56: undefined: Field
sys/akaros/gen/amd64.go:62:56: too many errors
# github.com/google/syzkaller/sys/openbsd/gen
sys/openbsd/gen/amd64.go:49:55: undefined: Field
sys/openbsd/gen/amd64.go:53:10: undefined: Ref
sys/openbsd/gen/amd64.go:54:60: undefined: Field
sys/openbsd/gen/amd64.go:58:10: undefined: Ref
sys/openbsd/gen/amd64.go:59:61: undefined: Field
sys/openbsd/gen/amd64.go:63:10: undefined: Ref
sys/openbsd/gen/amd64.go:64:60: undefined: Field
sys/openbsd/gen/amd64.go:68:10: undefined: Ref
sys/openbsd/gen/amd64.go:69:51: undefined: Field
sys/openbsd/gen/amd64.go:72:52: undefined: Field
sys/openbsd/gen/amd64.go:72:52: too many errors
# github.com/google/syzkaller/sys/test/gen
sys/test/gen/32_fork_shmem.go:29:55: unknown field 'Attrs' in struct literal of type prog.Syscall
sys/test/gen/32_fork_shmem.go:30:45: unknown field 'Attrs' in struct literal of type prog.Syscall
sys/test/gen/32_fork_shmem.go:31:50: undefined: Ref
sys/test/gen/32_fork_shmem.go:31:60: unknown field 'Attrs' in struct literal of type prog.Syscall
sys/test/gen/32_fork_shmem.go:32:53: undefined: Field
sys/test/gen/32_fork_shmem.go:34:5: unknown field 'Attrs' in struct literal of type prog.Syscall
sys/test/gen/32_fork_shmem.go:35:66: undefined: Ref
sys/test/gen/32_fork_shmem.go:36:53: undefined: Field
sys/test/gen/32_fork_shmem.go:39:62: undefined: Field
sys/test/gen/32_fork_shmem.go:42:48: undefined: Field
sys/test/gen/32_fork_shmem.go:42:48: too many errors
# github.com/google/syzkaller/sys/freebsd/gen
sys/freebsd/gen/386.go:49:76: undefined: Field
sys/freebsd/gen/386.go:54:60: undefined: Field
sys/freebsd/gen/386.go:58:68: undefined: Field
sys/freebsd/gen/386.go:65:67: undefined: Field
sys/freebsd/gen/386.go:71:68: undefined: Field
sys/freebsd/gen/386.go:77:67: undefined: Field
sys/freebsd/gen/386.go:83:67: undefined: Field
sys/freebsd/gen/386.go:89:68: undefined: Field
sys/freebsd/gen/386.go:95:69: undefined: Field
sys/freebsd/gen/386.go:101:85: undefined: Field
sys/freebsd/gen/386.go:101:85: too many errors
# github.com/google/syzkaller/sys/windows/gen
sys/windows/gen/amd64.go:23:51: undefined: Field
sys/windows/gen/amd64.go:26:53: undefined: Field
sys/windows/gen/amd64.go:29:59: undefined: Field
sys/windows/gen/amd64.go:32:75: undefined: Field
sys/windows/gen/amd64.go:35:51: undefined: Field
sys/windows/gen/amd64.go:45:57: undefined: Field
sys/windows/gen/amd64.go:55:85: undefined: Field
sys/windows/gen/amd64.go:66:69: undefined: Field
sys/windows/gen/amd64.go:77:97: undefined: Field
sys/windows/gen/amd64.go:88:89: undefined: Field
sys/windows/gen/amd64.go:88:89: too many errors
# github.com/google/syzkaller/sys/fuchsia/gen
sys/fuchsia/gen/amd64.go:96:45: undefined: Field
sys/fuchsia/gen/amd64.go:99:45: undefined: Field
sys/fuchsia/gen/amd64.go:103:45: undefined: Field
sys/fuchsia/gen/amd64.go:108:45: undefined: Field
sys/fuchsia/gen/amd64.go:111:45: undefined: Field
sys/fuchsia/gen/amd64.go:114:10: undefined: Ref
sys/fuchsia/gen/amd64.go:115:41: undefined: Field
sys/fuchsia/gen/amd64.go:117:10: undefined: Ref
sys/fuchsia/gen/amd64.go:118:43: undefined: Field
sys/fuchsia/gen/amd64.go:121:10: undefined: Ref
sys/fuchsia/gen/amd64.go:121:10: too many errors
# github.com/google/syzkaller/sys/linux/gen
sys/linux/gen/386.go:296:58: undefined: Field
sys/linux/gen/386.go:301:10: undefined: Ref
sys/linux/gen/386.go:302:62: undefined: Field
sys/linux/gen/386.go:307:10: undefined: Ref
sys/linux/gen/386.go:308:63: undefined: Field
sys/linux/gen/386.go:313:10: undefined: Ref
sys/linux/gen/386.go:314:67: undefined: Field
sys/linux/gen/386.go:319:10: undefined: Ref
sys/linux/gen/386.go:320:63: undefined: Field
sys/linux/gen/386.go:325:10: undefined: Ref
sys/linux/gen/386.go:325:10: too many errors
Makefile:113: recipe for target 'target' failed
make: *** [target] Error 2

go env (err=<nil>)
GO111MODULE=""
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/syzkaller/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/syzkaller/go/pkg/tool/linux_amd64"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD=""
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build521465815=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at a8c6a3f8
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   sys/akaros/gen/amd64.go
	modified:   sys/freebsd/gen/386.go
	modified:   sys/freebsd/gen/amd64.go
	modified:   sys/fuchsia/gen/amd64.go
	modified:   sys/fuchsia/gen/arm64.go
	modified:   sys/linux/gen/386.go
	modified:   sys/linux/gen/amd64.go
	modified:   sys/linux/gen/arm.go
	modified:   sys/linux/gen/arm64.go
	modified:   sys/linux/gen/mips64le.go
	modified:   sys/linux/gen/ppc64le.go
	modified:   sys/netbsd/gen/amd64.go
	modified:   sys/openbsd/gen/amd64.go
	modified:   sys/test/gen/32_fork_shmem.go
	modified:   sys/test/gen/32_shmem.go
	modified:   sys/test/gen/64.go
	modified:   sys/test/gen/64_fork.go
	modified:   sys/trusty/gen/arm.go
	modified:   sys/windows/gen/amd64.go

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.descriptions

no changes added to commit (use "git add" and/or "git commit -a")



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5b8b9d0c6d0e0f1993c6c56deaf9646942c49d94
dashboard link: https://syzkaller.appspot.com/bug?extid=bca9799bf129256190da
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

