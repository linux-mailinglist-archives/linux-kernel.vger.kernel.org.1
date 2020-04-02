Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD9E19C2D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbgDBNlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 09:41:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43909 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388745AbgDBNlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585834868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MDNUw2FznPZvQbgwPPTdiYNaYM8qbaBb+172YsXMGe4=;
        b=HYp7MQX2EnprbpYz3ZKs9+G/jg3TcA9NlGSQtUv/D5+q9V788/bQSpY1SoTFOs6zykouUe
        5bJlV+nbj70ibKcHytXk2AvAHpy/7Y2PNe9fstc8yhCa1OHSP6sCbkDyb4IOsDz03Qqd2U
        4ECihqbM/yGQgsWYxnR4CjxBWBR5nMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-A1Afh47qNSaAOicP-CTsiw-1; Thu, 02 Apr 2020 09:41:01 -0400
X-MC-Unique: A1Afh47qNSaAOicP-CTsiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEBA41902EB9;
        Thu,  2 Apr 2020 13:40:58 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ED5A5C57B;
        Thu,  2 Apr 2020 13:40:55 +0000 (UTC)
Date:   Thu, 2 Apr 2020 15:40:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 5/5] perf synthetic events: Remove use of sscanf from
 /proc reading
Message-ID: <20200402134052.GI2518490@krava>
References: <20200401233945.133550-1-irogers@google.com>
 <20200401233945.133550-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401233945.133550-6-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:39:45PM -0700, Ian Rogers wrote:
> The synthesize benchmark, run on a single process and thread, shows
> perf_event__synthesize_mmap_events as the hottest function with fgets
> and sscanf taking the majority of execution time. fscanf performs
> similarly well. Replace the scanf call with manual reading of each field
> of the /proc/pid/maps line, and remove some unnecessary buffering.
> This change also addresses potential, but unlikely, buffer overruns for
> the string values read by scanf.
> 
> Performance before is:
> Average synthesis took: 120.195100 usec
> Average data synthesis took: 156.582300 usec
> 
> And after is:
> Average synthesis took: 67.189100 usec
> Average data synthesis took: 102.451600 usec
> 
> On a Intel Xeon 6154 compiling with Debian gcc 9.2.1.

I can see the speedup as well, thanks!

jirka

