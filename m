Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A0C2FBE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404378AbhASSGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:06:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391683AbhASRlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611077990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m0oJa+7KblrnP8owEXHv1NwXEfaIZVqOOXGhT4PIWXc=;
        b=gxRdh6LmSh2p4/OSDcN1KyAkMP40YNIyqT9QMNJTjZMk+/QabwJT0Cwxxp5NlgZHRntPiQ
        qxfsrdgDEuT30ACSg5N+2bQYpaqEoq0kVl/4cYVilzqbN2FIXcWuCbA3mJ21FwSG3bZUxW
        zKNze7M1i/QbC23mZUUiYCISIUwPGWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-J_ApeiosPmeNKraR_Mgkbg-1; Tue, 19 Jan 2021 12:39:46 -0500
X-MC-Unique: J_ApeiosPmeNKraR_Mgkbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05EA7800D53;
        Tue, 19 Jan 2021 17:39:44 +0000 (UTC)
Received: from krava (unknown [10.40.195.212])
        by smtp.corp.redhat.com (Postfix) with SMTP id 754E010429FC;
        Tue, 19 Jan 2021 17:39:38 +0000 (UTC)
Date:   Tue, 19 Jan 2021 18:39:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 03/22] perf tools: Add debug_set_display_time function
Message-ID: <20210119173937.GB1717058@krava>
References: <20210102220441.794923-1-jolsa@kernel.org>
 <20210102220441.794923-4-jolsa@kernel.org>
 <20210119145922.GL12699@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119145922.GL12699@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 11:59:22AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > +}
> 
>   78    12.70 ubuntu:18.04-x-sparc64        : FAIL sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
> 
> util/debug.c: In function 'fprintf_time':
> util/debug.c:63:32: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type '__suseconds_t {aka int}' [-Werror=format=]
>   return fprintf(file, "[%s.%06lu] ", date, tod.tv_usec);
>                             ~~~~^           ~~~~~~~~~~~
>                             %06u
> 
> I'll try to fix it.

thanks, hopefuly the %u will do

jirka

