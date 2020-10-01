Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395D127FD43
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 12:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbgJAKZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 06:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbgJAKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601547929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iMHq4W3FFlmuZXN1AAYUBjJey9b4v21DrESV0WQsAwk=;
        b=TYUTYFPfcasXTIDzfW39mf9t5BgsN9xYQIoRu4rH3wuJMjeY9R5A8Cc0mDzPXU3X8HI6zY
        bwjQx1t+iQGvb5ieBldd8Iq0/ZLuw6dEJh8VoWM8gDWZjnonpTnQ9FBn1GNtE8iqmX2IAU
        9FeCMAfXBWcYsLHoYLeUF+wpfejtKGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-4DOucC4hPbKdx8l4F5ZGwQ-1; Thu, 01 Oct 2020 06:25:24 -0400
X-MC-Unique: 4DOucC4hPbKdx8l4F5ZGwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ADA7802B5C;
        Thu,  1 Oct 2020 10:25:23 +0000 (UTC)
Received: from krava (ovpn-115-79.ams2.redhat.com [10.36.115.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9ABB55D9D3;
        Thu,  1 Oct 2020 10:25:19 +0000 (UTC)
Date:   Thu, 1 Oct 2020 12:25:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/9] perf tools: Add build id shell test
Message-ID: <20201001102517.GC3999500@krava>
References: <20200930171512.3986425-1-jolsa@kernel.org>
 <20200930171512.3986425-2-jolsa@kernel.org>
 <CAP-5=fVwe5wowm9Z6RgMAKA-nRd01U6DL0LGuUJSnPc_H=w17w@mail.gmail.com>
 <20201001092530.GB3999500@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001092530.GB3999500@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 11:25:34AM +0200, Jiri Olsa wrote:
> On Wed, Sep 30, 2020 at 07:00:05PM -0700, Ian Rogers wrote:
> > On Wed, Sep 30, 2020 at 10:15 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding test for build id cache that adds binary
> > > with sha1 and md5 build ids and verifies it's
> > > added properly.
> > >
> > > The test updates build id cache with perf record
> > > and perf buildid-cache -a.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > 
> > This is great! If I build perf and test from the build directory the
> > test gets run. If I build using O=/tmp/perf and run from that
> > directory then ./tests/shell isn't found and the test doesn't run.
> > Similarly the install directory doesn't contain the executables and so
> > the test is skipped. Is there any way to get the test running in these
> > other scenarios?
> 
> ok, if there's already some way to get the build path I did not see that
> I'll check and add something if it's missing

would the patch below work for you?

thanks,
jirka


---
diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
index 57fcd28bc4bd..dd9f9c306c34 100755
--- a/tools/perf/tests/shell/buildid.sh
+++ b/tools/perf/tests/shell/buildid.sh
@@ -2,12 +2,23 @@
 # build id cache operations
 # SPDX-License-Identifier: GPL-2.0
 
+ex_md5=buildid-ex-md5
+ex_sha1=buildid-ex-sha1
+
 # skip if there are no test binaries
 if [ ! -x buildid-ex-sha1 -a ! -x buildid-ex-md5 ]; then
-	echo "failed: no test binaries"
-	exit 2
+	ex_dir=$(dirname `which perf`)
+	ex_md5=${ex_dir}/buildid-ex-md5
+	ex_sha1=${ex_dir}/buildid-ex-sha1
+
+	if [ ! -x ${ex_sha1} -a ! -x ${ex_md5} ]; then
+		echo "failed: no test binaries"
+		exit 2
+	fi
 fi
 
+echo "test binaries: ${ex_sha1} ${ex_md5}"
+
 # skip if there's no readelf
 if [ ! -x `which readelf` ]; then
 	echo "failed: no readelf, install binutils"
@@ -80,11 +91,11 @@ test_record()
 }
 
 # add binaries manual via perf buildid-cache -a
-test_add buildid-ex-sha1
-test_add buildid-ex-md5
+test_add ${ex_sha1}
+test_add ${ex_md5}
 
 # add binaries via perf record post processing
-test_record buildid-ex-sha1
-test_record buildid-ex-md5
+test_record ${ex_sha1}
+test_record ${ex_md5}
 
 exit ${err}

