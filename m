Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE622696F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgINUtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:49:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42193 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725994AbgINUtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600116579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HpDYiv10tYVYDJrxEFMWOJKMJ7SlDkXMpuN/E0UP6ro=;
        b=f31Jxh0mnInf2DReCX1Bc/KRyMf3+pYTd4EH/urIZCryQspQkTph1jMrP79WqGFqjJiCJN
        6lQmPzGv3jHhc3A4RpTkoAltTtoCugAaFrpmGtwqhS5ffpFzARlmRb32gjo2Z5XE3aCXmY
        /eAYSn+/yngZ6VwI8imM62oLbDhsRfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-wicbst9BMG-ltON0yNQi3Q-1; Mon, 14 Sep 2020 16:49:37 -0400
X-MC-Unique: wicbst9BMG-ltON0yNQi3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89C9E427C2;
        Mon, 14 Sep 2020 20:49:35 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 343E827BDD;
        Mon, 14 Sep 2020 20:49:30 +0000 (UTC)
Date:   Mon, 14 Sep 2020 22:49:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 05/26] perf tools: Add build_id__is_defined function
Message-ID: <20200914204928.GA1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-6-jolsa@kernel.org>
 <CAM9d7cjjGjTN8sDgLZ1PoQZ-sUXWjnVaNdyOVE1yHxq46PrPkw@mail.gmail.com>
 <20200914160318.GG160517@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914160318.GG160517@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 01:03:18PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> +       if (!ns) {
> +               status = NVME_SC_INVALID_NS | NVME_SC_DNR;
> +               goto out;
> +       }
> +
> +       if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
> +               status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
> +                                                 NVME_NIDT_UUID_LEN,
> +                                                 &ns->uuid, &off);
> +               if (status)
> +                       goto out_put_ns;
> +       }
> 
> More:
> 
> [acme@five perf]$ find arch/ -type f | xargs grep memchr_inv
> arch/x86/kernel/fpu/xstate.c:	if (memchr_inv(hdr->reserved, 0, sizeof(hdr->reserved)))
> arch/x86/mm/init_64.c:			if (!memchr_inv(page_addr, PAGE_INUSE, PAGE_SIZE)) {
> arch/x86/mm/init_64.c:				if (!memchr_inv(page_addr, PAGE_INUSE,
> arch/x86/mm/init_64.c:				if (!memchr_inv(page_addr, PAGE_INUSE,
> arch/s390/mm/vmem.c:	return !memchr_inv(page, PAGE_UNUSED, PMD_SIZE);
> arch/powerpc/platforms/powermac/nvram.c:	if (memchr_inv(base, 0xff, NVRAM_SIZE)) {
> arch/powerpc/platforms/powermac/nvram.c:	if (memchr_inv(base, 0xff, NVRAM_SIZE)) {
> [acme@five perf]$

nice, another stricg.c candidate ;-)

I can add the is_zeroed function and we can speed it up
for above archs later

thanks,
jirka

