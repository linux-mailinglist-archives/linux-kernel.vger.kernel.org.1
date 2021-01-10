Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C252F049D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 01:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbhAJAqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 19:46:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726223AbhAJAqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 19:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610239491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cmHpYMFmEST3S8mKjQWm1QgzkHwm1/InymF6tm/5+uQ=;
        b=ToLtnt0AjDNW98Qt+NLJpQaXfIOtXaoaTilKQXmoD/V0d5Zd5qI6ofIE2k6QP/k6SJp0JA
        A59jMQNNOdXqc0I4huBlbjAbjQ1umf1ELvKLQn0zqHaxDSa4ZCFwEGNQ58XNoyGy3YNWgC
        BxeOmq+OQNErvXcma+VAKaCeFp1uRKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-3Y0XI-jcMlGufluGNmi2zw-1; Sat, 09 Jan 2021 19:44:46 -0500
X-MC-Unique: 3Y0XI-jcMlGufluGNmi2zw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CD94801A9E;
        Sun, 10 Jan 2021 00:44:43 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F1BA2C15B;
        Sun, 10 Jan 2021 00:44:36 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Date:   Sat,  9 Jan 2021 19:44:34 -0500
Message-Id: <20210110004435.26382-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew and everyone,

Once we agree that COW page reuse requires full accuracy, the next
step is to re-apply 17839856fd588f4ab6b789f482ed3ffd7c403e1f and to
return going in that direction.

Who is going to orthogonally secure vmsplice, Andy, Jason, Jens?  Once
vmsplice is secured from taking unconstrained unprivileged long term
GUP pins, the attack from child to parent can still happen in theory,
but statistically speaking once that huge window is closed, it won't
be a practical concern, so it'll give us time to perfect the full
solution by closing all windows the VM core. vmsplice has to be
orthogonally fixed anyway, even if all windows were closed in VM core
first.

Unfortunately it's still not clear exactly what failed with
17839856fd588f4ab6b789f482ed3ffd7c403e1f but the whole point is that
we need to discuss that together.

Thanks,
Andrea

// SPDX-License-Identifier: GPL-3.0-or-later
/*
 *  reproducer for v5.11 O_DIRECT mm corruption with page_count
 *  instead of mapcount in do_wp_page.
 *
 *  Copyright (C) 2021  Red Hat, Inc.
 *
 *  gcc -O2 -o page_count_do_wp_page page_count_do_wp_page.c -lpthread
 *  page_count_do_wp_page ./whateverfile
 *
 *  NOTE: CONFIG_SOFT_DIRTY=y is required in the kernel config.
 */

#define _GNU_SOURCE
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/mman.h>

#define PAGE_SIZE (1UL<<12)
#define HARDBLKSIZE 512

static void* writer(void *_mem)
{
	char *mem = (char *)_mem;
	for(;;) {
		usleep(random() % 1000);
		mem[PAGE_SIZE-1] = 0;
	}
}

static void* background_soft_dirty(void *data)
{
	long fd = (long) data;
	for (;;)
		if (write(fd, "4", 1) != 1)
			perror("write soft dirty"), exit(1);
}

int main(int argc, char *argv[])
{
	if (argc < 2)
		printf("%s <filename>", argv[0]), exit(1);

	char path[PAGE_SIZE];
	strcpy(path, "/proc/");
	sprintf(path + strlen(path), "%d", getpid());
	strcat(path, "/clear_refs");
	long soft_dirty_fd = open(path, O_WRONLY);
	if (soft_dirty_fd < 0)
		perror("open clear_refs"), exit(1);

	char *mem;
	if (posix_memalign((void **)&mem, PAGE_SIZE, PAGE_SIZE*3))
		perror("posix_memalign"), exit(1);
	/* THP is not using page_count so it would not corrupt memory */
	if (madvise(mem, PAGE_SIZE, MADV_NOHUGEPAGE))
		perror("madvise"), exit(1);
	bzero(mem, PAGE_SIZE * 3);
	memset(mem + PAGE_SIZE * 2, 0xff, HARDBLKSIZE);

	/*
	 * This is not specific to O_DIRECT. Even if O_DIRECT was
	 * forced to use PAGE_SIZE minimum granularity for reads, a
	 * recvmsg would create the same issue since it also use
	 * iov_iter_get_pages internally to create transient GUP pins
	 * on anon memory.
	 */
	int fd = open(argv[1], O_DIRECT|O_CREAT|O_RDWR|O_TRUNC, 0600);
	if (fd < 0)
		perror("open"), exit(1);
	if (write(fd, mem, PAGE_SIZE) != PAGE_SIZE)
		perror("write"), exit(1);

	pthread_t soft_dirty;
	if (pthread_create(&soft_dirty, NULL,
			   background_soft_dirty, (void *)soft_dirty_fd))
		perror("soft_dirty"), exit(1);

	pthread_t thread;
	if (pthread_create(&thread, NULL, writer, mem))
		perror("pthread_create"), exit(1);

	bool skip_memset = true;
	while (1) {
		if (pread(fd, mem, HARDBLKSIZE, 0) != HARDBLKSIZE)
			perror("read"), exit(1);
		if (memcmp(mem, mem+PAGE_SIZE, HARDBLKSIZE)) {
			if (memcmp(mem, mem+PAGE_SIZE*2, PAGE_SIZE)) {
				if (skip_memset)
					printf("unexpected memory "
					       "corruption detected\n");
				else
					printf("memory corruption detected, "
					       "dumping page\n");
				int end = PAGE_SIZE;
				if (!memcmp(mem+HARDBLKSIZE, mem+PAGE_SIZE,
					    PAGE_SIZE-HARDBLKSIZE))
					end = HARDBLKSIZE;
				for (int i = 0; i < end; i++)
					printf("%x", mem[i]);
				printf("\n");
			} else
				printf("memory corruption detected\n");
		}
		skip_memset = !skip_memset;
		if (!skip_memset)
			memset(mem, 0xff, HARDBLKSIZE);
	}

	return 0;
}

Andrea Arcangeli (1):
  mm: restore full accuracy in COW page reuse

 include/linux/ksm.h |  7 ++++++
 mm/ksm.c            | 25 +++++++++++++++++++
 mm/memory.c         | 59 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 74 insertions(+), 17 deletions(-)

