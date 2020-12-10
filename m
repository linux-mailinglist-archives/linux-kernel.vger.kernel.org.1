Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3812D6909
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 21:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393838AbgLJUof convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Dec 2020 15:44:35 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:21310 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730646AbgLJUoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:44:34 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-rfWuTEKPNlidN7Tvp7G-7g-1; Thu, 10 Dec 2020 15:43:37 -0500
X-MC-Unique: rfWuTEKPNlidN7Tvp7G-7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE5E9801817;
        Thu, 10 Dec 2020 20:43:34 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91BDA5D9CC;
        Thu, 10 Dec 2020 20:43:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCHv2 0/3] perf tools: Allow to enable/disable events via control pipe
Date:   Thu, 10 Dec 2020 21:43:27 +0100
Message-Id: <20201210204330.233864-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
adding support to enable/disable specific events via control
file via following commands:

    # echo enable-sched:sched_process_fork > control
    # echo disabled-sched:sched_process_fork > control

v2 changes:
  - added acks
  - change list to evlist [Arnaldo]
  - add evlist-verbose command [Arnaldo]
  - add '' to enale-/disable- error message

The code is available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/control

thanks,
jirka


---
Jiri Olsa (3):
      perf tools: Add evlist__disable_evsel/evlist__enable_evsel
      perf tools: Allow to enable/disable events via control file
      perf tools: Add evlist/evlist-verbose control commands

 tools/perf/builtin-record.c |   4 ++++
 tools/perf/builtin-stat.c   |   4 ++++
 tools/perf/util/evlist.c    | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 tools/perf/util/evlist.h    |  10 ++++++++++
 4 files changed, 128 insertions(+), 4 deletions(-)

