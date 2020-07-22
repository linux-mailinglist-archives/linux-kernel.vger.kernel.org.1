Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B78229834
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 14:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbgGVM1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 08:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgGVM1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:27:37 -0400
Received: from quaco.ghostprotocols.net (unknown [177.17.3.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B928920729;
        Wed, 22 Jul 2020 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595420857;
        bh=Fa5CofAQhSoiPsbbQ+uJaJinSOhOGsOMU5AMeRircfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h66NaUtR3LUv8B6qfuqaJ/9n4sL3iQJDtu8sXbZ2wbnZozp7wDA1NIw2c4TOK5zoM
         r5uuRdtVkzfVIGVJPKnsMpacaD1Ixa0YiA1bM1YFlPAkDenz893d7cFpL9y5dOR4ms
         C+cpXmA9eDxek492K7ED/xmqxuOwKTpM2tk4lH8A=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A8246404B1; Wed, 22 Jul 2020 09:27:34 -0300 (-03)
Date:   Wed, 22 Jul 2020 09:27:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 05/15] perf evlist: implement control command
 handling functions
Message-ID: <20200722122734.GJ77866@kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
 <62518ceb-1cc9-2aba-593b-55408d07c1bf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62518ceb-1cc9-2aba-593b-55408d07c1bf@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 17, 2020 at 10:01:33AM +0300, Alexey Budankov escreveu:
> 
> Implement functions of initialization, finalization and processing
> of control command messages coming from control file descriptors.
> Allocate control file descriptor as descriptor at struct pollfd
> object of evsel_list for atomic poll() operation.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

I'm applying locally for testing, but can you answer what is the reason
for that newline in the CMD_ACK_TAG? I tried looking at previous
discussion but couldn't quickly find any reasoning for that

- Arnaldo

> +++ b/tools/perf/util/evlist.h
> @@ -359,4 +359,22 @@ void perf_evlist__force_leader(struct evlist *evlist);
>  struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
>  						 struct evsel *evsel,
>  						bool close);
> +#define EVLIST_CTL_CMD_ENABLE_TAG  "enable"
> +#define EVLIST_CTL_CMD_DISABLE_TAG "disable"
> +#define EVLIST_CTL_CMD_ACK_TAG     "ack\n"

What for? That '\n'?

