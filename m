Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F6C2CC618
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgLBTBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbgLBTBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:01:52 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E412C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:01:06 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f27so1847812qtv.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ex6whwlqrxCFKKDxiBHCz0Iun6q+iHD48FG8thAt3fM=;
        b=tZMMtKfJdT15exuAK2gRKZczPljRL5vGy+JomKrE9H42xmQTdFNQFuShKRGDn/YksS
         LC1ZNOCv75/pxA90sPrT4F1AefQOXFNQAE9mixAmkr4jpYQFWC/TiOnPfKVbZYjvY0Gv
         h/lC/UrIJcWcFKb3pr6YdFT6TYPVos7Exrxfi8cBbK4TdwEF/hMvrLZ1jKPkwm3mQlkz
         y6GzvAmwoiF39s0B1Or8v7ZbC3ZXoKPN77URTZZGsOoUCLxjGR7q0QwtUFcTAEXO1CLw
         RiVmHrWQWld0eoAyfZ2dKPzW4yEEXc8Bn01MNnR6g+BBBBR2zN4BJOuLKXCGv/47xT8t
         gXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ex6whwlqrxCFKKDxiBHCz0Iun6q+iHD48FG8thAt3fM=;
        b=qNk0Uv66VPzrZQdYd0R4JBlx/OTH1qZtBLJejdkup9Zj+F7rk7VHqf8HYKXJK/we5b
         fRX0NSvuoUKNcS0w4AZ2trmS/RlUqkcSGsHbeKQiZGQmH4PzUTyxXIA2iEXA16GjWXR3
         mCudq/4W4L3Zw0BDVIdxi6/DCeT7ECfWIiYBquJPoLenbnhgn8BC9S9SFgWeEQvBjj92
         gcqyewD4rVIa7uwFRi8mBsFR4EXhTID5GaS4rERF2CKy42mQp76WqBq2JIGOdoYePFXM
         WYwoZ08rb9bLBVurrS7XuRMv+bgWMU8yL1AuWYIidjA5rpWowTkolHV8TK+8OovdQldn
         Jdkw==
X-Gm-Message-State: AOAM5310IaSvdNlX1B9aKEbKQ31eg39ZcCzR++/JEGb/+lYfMAIh1kNQ
        lTmAbdDP7jv2Gr2Gk7ZjpjI=
X-Google-Smtp-Source: ABdhPJxhHqhvqzx/xH94AgsGYWvBMWrtyiVjgIAbw0jjz8xci7x6+BUJMpxAWYS8J9g6a99eF7qm/A==
X-Received: by 2002:ac8:7b85:: with SMTP id p5mr1791191qtu.264.1606935665249;
        Wed, 02 Dec 2020 11:01:05 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8dbd])
        by smtp.gmail.com with ESMTPSA id v13sm1546960qkb.130.2020.12.02.11.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:01:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 14:00:37 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <walken@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yafang Shao <laoar.shao@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, dsahern@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>, liuhangbin@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
Message-ID: <X8fkVcfztQtX2dRT@mtj.duckdns.org>
References: <20201130233504.3725241-1-axelrasmussen@google.com>
 <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com>
 <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com>
 <xr93lfehl8al.fsf@gthelen.svl.corp.google.com>
 <CALvZod4j9fFpGRfkios1ef0D5qhyw3XA_VSVm0k__RuMG1Qhwg@mail.gmail.com>
 <CAJHvVchcm_HLd1RaibCZDZi27_2CVCwUWDX515dvnPPyTpHBHw@mail.gmail.com>
 <CALvZod5CpPhvzB99VZTc33Sb5YCbJNHFe3k33k+HwNfJvJbpJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5CpPhvzB99VZTc33Sb5YCbJNHFe3k33k+HwNfJvJbpJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 01, 2020 at 12:53:46PM -0800, Shakeel Butt wrote:
> The writeback tracepoint in include/trace/events/writeback.h is
> already using the cgroup IDs. Actually it used to use cgroup_path but
> converted to cgroup_ino.
> 
> Tejun, how do you use these tracepoints?

There've been some changes to cgroup ids recently and now cgroup id, ino and
its file_handle are all compatible. On 64bit ino machines, they're all the
same and won't be reused. On 32bit ino machines, the lower 32bit of full id
is used as ino. ino may be reused but not the full 64bit id.

You can map back cgroup id to path from userspace using open_by_handle_at().
The following is an example program which does path -> cgrp id -> path
mappings.

#define _GNU_SOURCE
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdint.h>

#ifndef FILEID_KERNFS
#define FILEID_KERNFS 0xfe
#endif

struct fh_store {
	struct file_handle fh;
	char stor[MAX_HANDLE_SZ];
};

uint64_t path_to_cgrp_id(const char *path)
{
	struct fh_store fh_store;
	struct file_handle *fh = &fh_store.fh;
	int mnt_id;

	fh->handle_bytes = MAX_HANDLE_SZ;

	if (name_to_handle_at(AT_FDCWD, path, fh, &mnt_id, 0)) {
		perror("name_to_handle_at");
		abort();
	}

	if (fh->handle_type != FILEID_KERNFS) {
		fprintf(stderr, "invalid handle_type 0x%x\n", fh->handle_type);
		abort();
	}

	return *(uint64_t *)fh->f_handle;
}

void cgrp_id_to_path(uint64_t cgrp_id, char *path_buf)
{
	struct fh_store fh_store;
	struct file_handle *fh = &fh_store.fh;
	char proc_path[PATH_MAX];
	int mnt_fd, fd;

	fh->handle_type = FILEID_KERNFS;
	fh->handle_bytes = sizeof(uint64_t);
	*(uint64_t *)fh->f_handle = cgrp_id;

	mnt_fd = open("/sys/fs/cgroup", O_RDONLY);
	if (mnt_fd < 0) {
		perror("open(\"/sys/fs/cgroup\")");
		abort();
	}

	fd = open_by_handle_at(mnt_fd, fh, O_RDONLY);
	if (fd < 0) {
		perror("open_by_handle_at");
		abort();
	}

	snprintf(proc_path, PATH_MAX, "/proc/self/fd/%d", fd);
	printf("proc_path=%s\n", proc_path);

	if (readlink(proc_path, path_buf, PATH_MAX) < 0) {
		perror("readlink");
		abort();
	}
}

int main(int argc, char **argv)
{
	char path_buf[PATH_MAX + 1] = "";
	uint64_t cgrp_id;

	if (argc != 2) {
		fprintf(stderr, "Usage: test-cgrp-id CGROUP_PATH\n");
		return 1;
	}

	cgrp_id = path_to_cgrp_id(argv[1]);
	printf("cgrp_id=%llu\n", (unsigned long long)cgrp_id);

	cgrp_id_to_path(cgrp_id, path_buf);
	printf("cgrp_path=%s\n", path_buf);

	return 0;
}
