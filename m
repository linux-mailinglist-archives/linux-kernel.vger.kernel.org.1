Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDDD1E0E83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 14:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390569AbgEYMfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 08:35:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54239 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390504AbgEYMfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 08:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590410121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ulfxOt08QO1WwrMMpVkpGa0ners+2XK6qDqQvQKbL0=;
        b=cC0FfjQbsc4afIBTtX5Wnay6vdfbrF1EMcm5SuGhu/IKGOThdJ7zmUcAcdfHclw15EMMyS
        vlYxd7hZnidY/U6MWqY9Gbqf4zuzH+cf+U2aWB2NkhENv9vRW1dHeqNH3IKL9P9mpytTqV
        FjYn2b6ue8Ua/6d1Mzboh3HJSUpTwI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-1tjLqYJ8PFSlSl3xnEyQnw-1; Mon, 25 May 2020 08:35:17 -0400
X-MC-Unique: 1tjLqYJ8PFSlSl3xnEyQnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E6E7876EE2;
        Mon, 25 May 2020 12:35:15 +0000 (UTC)
Received: from krava (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with SMTP id B4C3110013C1;
        Mon, 25 May 2020 12:35:12 +0000 (UTC)
Date:   Mon, 25 May 2020 14:35:11 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC 00/14] perf tests: Check on subtest for user specified test
Message-ID: <20200525123511.GE123450@krava>
References: <20200524224219.234847-1-jolsa@kernel.org>
 <alpine.LRH.2.20.2005251401230.4075@Diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.2005251401230.4075@Diego>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 02:06:07PM +0200, Michael Petlan wrote:
> On Mon, 25 May 2020, Jiri Olsa wrote:
> > hi,
> > changes for using metric result in another metric seem
> > to change lot of core metric code, so it's better we
> > have some more tests before we do that.
> > 
> > Sending as RFC as it's still alive and you guys might
> > have some other idea of how to do this.
> > 
> > Also available in here:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/fixes
> > 
> > jirka
> > 
> Hi!
> Last commit from perf/fixes branch I see there is:
> 
> commit 0445062df28fef1002302aa419af65fa80513dd4 (HEAD -> perf/fixes, origin/perf/fixes)
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Fri Dec 6 00:10:13 2019 +0100
> 
> Different branch?

ugh.. sorry it's perf/metric_test

thanks,
jirka

