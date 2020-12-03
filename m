Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898782CE2B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgLCXdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:33:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbgLCXdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607038310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPlYKESO+vAmWI9EKWDeRymu2gKUUONfnoufz+hgKcM=;
        b=gn3HXhz/qyXctTeZPlenhJis3rMqgYZeD+O0HcS3+2xROyXtig0BHzUx5METp8GHnywCt1
        dnq7b89r8WWmLRbRwQNIJPjuN8lzsIb0cBzBRrsNUMJdhHb3VQOsHPSM/2bwixifG7tB6h
        gOw4v4btVaGlGtFzPOX9NyR87SFc814=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-6Nrb_VIOOSe1-UjtzYHYFw-1; Thu, 03 Dec 2020 18:31:46 -0500
X-MC-Unique: 6Nrb_VIOOSe1-UjtzYHYFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBFD2800D55;
        Thu,  3 Dec 2020 23:31:44 +0000 (UTC)
Received: from krava (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA4D61A8A5;
        Thu,  3 Dec 2020 23:31:42 +0000 (UTC)
Date:   Fri, 4 Dec 2020 00:31:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v1 2/2] perf-stat: enable counting events for BPF programs
Message-ID: <20201203233141.GE3613628@krava>
References: <20201202093709.3374099-1-songliubraving@fb.com>
 <20201202093709.3374099-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201202093709.3374099-3-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 01:37:09AM -0800, Song Liu wrote:
> Introduce perf-stat -b option, which counts events for BPF programs, like:
> 
> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
>      1.487903822            115,200      ref-cycles
>      1.487903822             86,012      cycles
>      2.489147029             80,560      ref-cycles
>      2.489147029             73,784      cycles
>      3.490341825             60,720      ref-cycles
>      3.490341825             37,797      cycles
>      4.491540887             37,120      ref-cycles
>      4.491540887             31,963      cycles

hi,
I'm getting compile fail with gcc 10:

	builtin-stat.c: In function ‘cmd_stat’:
	builtin-stat.c:2429:7: error: declaration of ‘err’ shadows a previous local [-Werror=shadow]
	 2429 |   int err = perf_event__synthesize_kernel_mmap((void *)&perf_stat,
	      |       ^~~
	builtin-stat.c:2104:33: note: shadowed declaration is here
	 2104 |  int status = -EINVAL, run_idx, err;
	      |                                 ^~~

jirka

