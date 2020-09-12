Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487D5267C64
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 22:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgILUxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 16:53:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30019 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725892AbgILUx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 16:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599944006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/TrCMjdFVnXYdHb0xZILR27Mwuk7N3tgJTgpwVnOmJ8=;
        b=AVo0aElTSwU6t8XygIuaPVArD79FwzpHPMcJGmQq+d1Hh92gPu/SmwImQhxt9eI00Eiuml
        lPk6+L/4C7olFTc3aDtqXmnoSzIfzR5vatgOzidQsb33lzRK82HVRn2eLH8ZoIqWonysjY
        QQx6G6eM7HcgjaCZzkaW9Px1YHq4WHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-FXufgUheNe6qFgiiyb11BA-1; Sat, 12 Sep 2020 16:53:23 -0400
X-MC-Unique: FXufgUheNe6qFgiiyb11BA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BFE31DDE2;
        Sat, 12 Sep 2020 20:53:21 +0000 (UTC)
Received: from krava (unknown [10.40.192.28])
        by smtp.corp.redhat.com (Postfix) with SMTP id 22CFD7E731;
        Sat, 12 Sep 2020 20:53:17 +0000 (UTC)
Date:   Sat, 12 Sep 2020 22:53:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: Re: [PATCH v3 0/10] libperf and arm64 userspace counter access
 support
Message-ID: <20200912205317.GG1714160@krava>
References: <20200911215118.2887710-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911215118.2887710-1-robh@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 03:51:08PM -0600, Rob Herring wrote:
> This is resurrecting Raphael's series[1] to enable userspace counter
> access on arm64. My previous versions are here[2][3].
> 
> Changes in v3:
>  - Dropped removing x86 rdpmc test until libperf tests can run via 'perf test'
>  - Added verbose prints for tests
>  - Split adding perf_evsel__mmap() to separate patch

hi,
which commit/branch did you base on? I can't apply arm bits:

Applying: arm64: pmu: Add hook to handle pmu-related undefined instructions
Applying: arm64: perf: Enable pmu counter direct access for perf event on armv8
error: patch failed: arch/arm64/kernel/perf_event.c:836
error: arch/arm64/kernel/perf_event.c: patch does not apply
Patch failed at 0002 arm64: perf: Enable pmu counter direct access for perf event on armv8

thanks,
jirka

