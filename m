Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6AF2C6C88
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 21:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgK0UYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 15:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730758AbgK0UW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606508563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RP1cEck0Wj7Ka2hWnv+yf09td12RPJ0Z4zrqjVXNRLw=;
        b=Ghvn753P88bsMU/zXtG0xFUcnBZnuL/30BI0C++n53pmMNLnXHyn/J+iG6HgLTXcpuJUg2
        Vy/drQ/tLrU5fdZGTsByEa/3TWQtTUjneS956ZdBBfFRpfzF0MKvG3j02kcP3qsFerfIJk
        CcUa/MgsIKOVBqFd8mWjepJYoogGX8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-IXSfVfmEPC2sfqXOv1R08Q-1; Fri, 27 Nov 2020 15:22:40 -0500
X-MC-Unique: IXSfVfmEPC2sfqXOv1R08Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6259F107ACF7;
        Fri, 27 Nov 2020 20:22:38 +0000 (UTC)
Received: from krava (unknown [10.40.194.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2A4260BF1;
        Fri, 27 Nov 2020 20:22:35 +0000 (UTC)
Date:   Fri, 27 Nov 2020 21:22:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH 00/12] Add the page size in the perf record (user tools)
Message-ID: <20201127202234.GA2790163@krava>
References: <20201117195637.6499-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117195637.6499-1-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:56:25AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Current perf can report both virtual addresses and physical addresses,
> but not the page size. Without the page size information of the utilized
> page, users cannot decide whether to promote/demote large pages to
> optimize memory usage.
> 
> The kernel patches have been merged into tip perf/core branch,
> commit 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
> commit 76a5433f95f3 ("perf/x86/intel: Support PERF_SAMPLE_DATA_PAGE_SIZE")
> commit 4cb6a42e4c4b ("powerpc/perf: Support PERF_SAMPLE_DATA_PAGE_SIZE")
> commit 995f088efebe ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE")
> commit 51b646b2d9f8 ("perf,mm: Handle non-page-table-aligned hugetlbfs")
> 
> and Peter's perf/core branch
> commit 524680ce47a1 ("mm/gup: Provide gup_get_pte() more generic")
> commit 44a35d6937d2 ("mm: Introduce pXX_leaf_size()")
> commit 2f1e2f091ad0 ("perf/core: Fix arch_perf_get_page_size()")
> commit 7649e44aacdd ("arm64/mm: Implement pXX_leaf_size() support")
> commit 1df1ae7e262c ("sparc64/mm: Implement pXX_leaf_size() support")
> 
> This patch set is to enable the page size support in user tools.
> 
> Kan Liang (8):
>   tools headers UAPI: Update tools's copy of linux/perf_event.h
>   perf record: Support new sample type for data page size
>   perf script: Support data page size
>   perf sort: Add sort option for data page size
>   perf mem: Factor out a function to generate sort order
>   perf mem: Clean up output format
>   perf mem: Support data page size
>   perf test: Add test case for PERF_SAMPLE_DATA_PAGE_SIZE
> 
> Stephane Eranian (4):
>   perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>   perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>   perf report: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>   perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE


hi,
I can't compile this on Fedora 32, check the log below

jirka


---
$ make JOBS=1
  BUILD:   Doing 'make -j1' parallel build
Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
  CC       util/parse-events.o
  CC       util/session.o
util/session.c: In function ‘machines__deliver_event’:
util/session.c:1278:37: error: ‘%lu’ directive output may be truncated writing between 1 and 20 bytes into a region of size 10 [-Werror=format-truncation=]
 1278 |  snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
      |                                     ^~~
util/session.c:1278:36: note: directive argument in the range [1, 18446744073709551615]
 1278 |  snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
      |                                    ^~~~~~~
In file included from /usr/include/stdio.h:867,
                 from /home/jolsa/kernel/linux-perf/tools/lib/perf/include/perf/cpumap.h:6,
                 from util/session.c:13:
/usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 3 and 22 bytes into a destination of size 10
   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   68 |        __bos (__s), __fmt, __va_arg_pack ());
      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/session.c:1278:37: error: ‘%lu’ directive output may be truncated writing between 1 and 20 bytes into a region of size 10 [-Werror=format-truncation=]
 1278 |  snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
      |                                     ^~~
util/session.c:1278:36: note: directive argument in the range [1, 18446744073709551615]
 1278 |  snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
      |                                    ^~~~~~~
In file included from /usr/include/stdio.h:867,
                 from /home/jolsa/kernel/linux-perf/tools/lib/perf/include/perf/cpumap.h:6,
                 from util/session.c:13:
/usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 3 and 22 bytes into a destination of size 10
   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   68 |        __bos (__s), __fmt, __va_arg_pack ());
      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/session.c: In function ‘get_page_size_name’:
util/session.c:1278:37: error: ‘%lu’ directive output may be truncated writing between 1 and 20 bytes into a region of size 10 [-Werror=format-truncation=]
 1278 |  snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
      |                                     ^~~
util/session.c:1278:36: note: directive argument in the range [1, 18446744073709551615]
 1278 |  snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
      |                                    ^~~~~~~
In file included from /usr/include/stdio.h:867,
                 from /home/jolsa/kernel/linux-perf/tools/lib/perf/include/perf/cpumap.h:6,
                 from util/session.c:13:
/usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 3 and 22 bytes into a destination of size 10
   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   68 |        __bos (__s), __fmt, __va_arg_pack ());
      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:97: util/session.o] Error 1
make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:647: perf-in.o] Error 2
make[1]: *** [Makefile.perf:233: sub-make] Error 2
make: *** [Makefile:70: all] Error 2

