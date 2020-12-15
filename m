Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F2A2DB15B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgLOQ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbgLOQ12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:27:28 -0500
Date:   Tue, 15 Dec 2020 13:27:00 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608049608;
        bh=tcmyW7AJFwhcK+1hvrWQ4t7pwlscL1GhVHy2Kq9hGSQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=jB1GeohIctB1PmVQdlxHh69vmmIFogGxkIXuiXbg0G9+k9XznRikX4yc13PsjAoUd
         kQJCWrECbdnOkphjGriQ07+XY0yCGvzd068bq8O3bpwiXwZhTUTxGFC283ySy/eMB5
         SUJVz/jWYQopRsaeKY3WSDIiGlAiUeLaBLwGU232Pjb4xDbKdEHFV+g7tSuWbU4SyX
         ZiXo9O8yR+vG4ASI4pGITWRVPcNhgtWV7rTku5KJQ/IPq458vWfHdDlicUj9Ywp1Zy
         6Nqp059dYbsStJuH+hNNaZDX8Uj/4Zp9mkxoxSF5S3iqQaUOFOHLnbwH0k4etPj00+
         Ua91W9XH932WQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 2/3] perf tools: Allow to enable/disable events via
 control file
Message-ID: <20201215162700.GP258566@kernel.org>
References: <20201210204330.233864-1-jolsa@kernel.org>
 <20201210204330.233864-3-jolsa@kernel.org>
 <20201215151413.GE252952@kernel.org>
 <20201215152420.GC658008@krava>
 <20201215160332.GN258566@kernel.org>
 <20201215161838.GA698181@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215161838.GA698181@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 15, 2020 at 05:18:38PM +0100, Jiri Olsa escreveu:
> On Tue, Dec 15, 2020 at 01:03:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > I see it, but why not use the more natural ' ' space to separate the
> > command from its arguments? Just like in a bash command line, say?

> > I.e. why not:

> >   enable

> > to enable everything, and:

> >   enable sched:sched_switch

> > To enable just the "sched:sched_switch" event?
 
> right, that's we discussed in the other patch thread,
> I'll make the change

This is a new way to control perf, its important that we try to reuse
the same concepts as in the pre-existing forms of interaction, so as to
reduce the learning curve for using this control mode.

I.e. this 'enable' should be as equivalent to the -e argument as
possible, for what makes sense for a pre-existing, already configured
event.

For _adding_ new ones, that we probably will want next, then its even
more important to reuse the same -e parser :-)

Thanks!

- Arnaldo
