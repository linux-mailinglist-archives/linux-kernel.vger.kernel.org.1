Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5C82B4CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbgKPR30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:29:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732876AbgKPR3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:29:24 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC7E2225E;
        Mon, 16 Nov 2020 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605547763;
        bh=h0kQPBBQt3mMrkvg6WqzvqOQC9S+K6ABgDjq5RmEljs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPhJ636OaSphhVlpwW7nPGW4NkbF8cq1HauK07Klo4nk8PwoOsOEtbCu077Jdj0Vb
         xJqY5l3pP4ffVANeyb3UXwcnc85LgBuRHTFtGLMVT6TqUTuRG8Kn6v9xVb50fMd1pz
         N6kpqdinxjqko+bQQLKAkcWkqIi/vlTU4KXxhuhU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 95D6940E29; Mon, 16 Nov 2020 14:29:20 -0300 (-03)
Date:   Mon, 16 Nov 2020 14:29:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Subject: Re: [PATCH] perf test: Avoid an msan warning in a copied stack.
Message-ID: <20201116172920.GI509215@kernel.org>
References: <20201113182053.754625-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113182053.754625-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 13, 2020 at 10:20:53AM -0800, Ian Rogers escreveu:
> This fix is for a failure that occurred in the DWARF unwind perf test.
> Stack unwinders may probe memory when looking for frames. Memory
> sanitizer will poison and track uninitialized memory on the stack, and
> on the heap if the value is copied to the heap. This can lead to false
> memory sanitizer failures for the use of an uninitialized value. Avoid
> this problem by removing the poison on the copied stack.
> 
> The full msan failure with track origins looks like:



Thanks, applied.

- Arnaldo

