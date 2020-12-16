Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1CE2DBC80
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgLPIQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725274AbgLPIQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608106489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XuEItb8Kt7vU3EOR493LqE4OTCNJ41od+JQ7yAldRu0=;
        b=LOKHYcHo4BuONkiWBLsNWoDDeVOH98AJNFOlwSqKSu5e1VMKG3ToMcUfqTN9nfDrKfjkCp
        IeZHl5iquxMR8qcHc6HK5qBFE1UBZjrgMaDkLWsloLPkvUU9tRP5UcNS0fmRZjn4Py8cVW
        nJPKlJLf1rT6KzWxvZZrDlHkN0RfOn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-p4F0q_6TPLW5bQWSeYBIJQ-1; Wed, 16 Dec 2020 03:14:45 -0500
X-MC-Unique: p4F0q_6TPLW5bQWSeYBIJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C88A21005504;
        Wed, 16 Dec 2020 08:14:43 +0000 (UTC)
Received: from krava (unknown [10.40.193.13])
        by smtp.corp.redhat.com (Postfix) with SMTP id E37095D9E3;
        Wed, 16 Dec 2020 08:14:40 +0000 (UTC)
Date:   Wed, 16 Dec 2020 09:14:39 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Budankov <abudankov@huawei.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 4/8] perf daemon: Add daemon command
Message-ID: <20201216081439.GA4153@krava>
References: <20201212104358.412065-1-jolsa@kernel.org>
 <20201212104358.412065-5-jolsa@kernel.org>
 <1e467abe-4613-765f-5138-6215b711f9fb@huawei.com>
 <20201215194354.GH698181@krava>
 <c3981c21-e970-6e27-af2a-364cbcdc6f2e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3981c21-e970-6e27-af2a-364cbcdc6f2e@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 10:54:43AM +0300, Alexei Budankov wrote:
> 
> On 15.12.2020 22:43, Jiri Olsa wrote:
> > On Tue, Dec 15, 2020 at 06:40:26PM +0300, Alexei Budankov wrote:
> >> Hi,
> >>
> >> On 12.12.2020 13:43, Jiri Olsa wrote:
> >>> Adding daemon command that allows to run record sessions
> >>> on background. Each session represents one perf record
> >>> process and is configured in config file.
> >>>
> >>> Example:
> >>>
> >>>   # cat config.daemon
> >>>   [daemon]
> >>>   base=/opt/perfdata
> >>
> >> It could probably make sense to consider using locations at /var/
> >> directory, similar to other already existing daemon processes in
> >> system so admin and user experience would be easily reusabe for
> >> performance monitoring daemon (service).
> > 
> > hm, you can specify any /var path in there if you like,
> > do you suggest to hardcode it?
> 
> This thing: https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
> Since Perf is a part of OS it would better use some standardized locations.

sure, user is free to configure that

SNIP

> >>> +	start = current = time(NULL);
> >>> +
> >>> +	do {
> >>> +		usleep(500);
> >>
> >> This polling design is actually sub-optimal because it induces redundant
> >> noise in a system. Ideally it should be implemented in async fashion so
> >> kernel would atomically notify daemon process on event happened in some
> >> of record processes e.g. using of poll-like() system call.
> > 
> > ok, any suggestion?
> 
> Possibly, checking SIGCHLDs via signalfd [1] OR using pidfd [2] on kernel v5.3+
> 
> [1] https://man7.org/linux/man-pages/man2/signalfd.2.html
> [2] https://man7.org/linux/man-pages/man2/pidfd_open.2.html

will check, thanks

jirka

