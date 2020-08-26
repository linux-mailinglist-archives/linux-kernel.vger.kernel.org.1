Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4B8252C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgHZLjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 07:39:54 -0400
Received: from foss.arm.com ([217.140.110.172]:44570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbgHZLed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:34:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8205A1FB;
        Wed, 26 Aug 2020 04:24:48 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 678023F71F;
        Wed, 26 Aug 2020 04:24:46 -0700 (PDT)
Date:   Wed, 26 Aug 2020 12:24:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Al Grant <al.grant@foss.arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, acme@redhat.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Message-ID: <20200826112435.GA43491@C02TD0UTHF1T.local>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[ adding the kernel-side perf maintainers ]

Please note that scripts/get_maintainer.pl can help to find relevant
maintainers.

On Mon, Aug 24, 2020 at 10:28:34AM +0100, Al Grant wrote:
> perf_event.h has macros that define the field offsets in the
> data_src bitmask in perf records. The SNOOPX and REMOTE offsets
> were both 37. These are distinct fields, and the bitfield layout
> in perf_mem_data_src confirms that SNOOPX should be at offset 38.
>
> From: Al Grant <al.grant@arm.com>

This needs a Signed-off-by line from you. See:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

The patch itself looks right to me, so provided you add an S-o-B line:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark

> 
>  include/uapi/linux/perf_event.h       | 2 +-
>  tools/include/uapi/linux/perf_event.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/perf_event.h
> b/include/uapi/linux/perf_event.h
> index 077e7ee69e3d..3e5dcdd48a49 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1196,7 +1196,7 @@ union perf_mem_data_src {
> 
>  #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
>  /* 1 free */
> -#define PERF_MEM_SNOOPX_SHIFT  37
> +#define PERF_MEM_SNOOPX_SHIFT  38
> 
>  /* locked instruction */
>  #define PERF_MEM_LOCK_NA       0x01 /* not available */
> diff --git a/tools/include/uapi/linux/perf_event.h
> b/tools/include/uapi/linux/perf_event.h
> index 077e7ee69e3d..3e5dcdd48a49 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -1196,7 +1196,7 @@ union perf_mem_data_src {
> 
>  #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
>  /* 1 free */
> -#define PERF_MEM_SNOOPX_SHIFT  37
> +#define PERF_MEM_SNOOPX_SHIFT  38
> 
>  /* locked instruction */
>  #define PERF_MEM_LOCK_NA       0x01 /* not available */
