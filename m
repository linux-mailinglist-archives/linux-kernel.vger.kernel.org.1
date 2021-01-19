Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB3C2FC3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbhASWoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:44:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405128AbhASOc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:32:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9255D206E5;
        Tue, 19 Jan 2021 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611066706;
        bh=NfQU7Bh2uGMJeTO1WgOYbXM6ko6/LlpUampJfSpsipY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrigU5FPI0Ij6S0yCfy3btTTVYmZ21Kog35h7ZfbCA3lL/nF60IGKYii68Qjny6qz
         fecUUSH/PaMNni3xl4FPTGy5Og3BE9SmovOULwnvYf7z0NUHRFmqNmzY9/52/gHrpm
         ySJCEzXWay0OfgI4nzrW4Xx4760SRj5f1oO03XDBn7kSNNsn4py8Mx5ndFFi74YRa1
         n6bypWLiR/i5S+c2sWJHevMWbb8SM1iLw2nUJFmlx//kVQoUHKHuFCmQu7XtnC+S2s
         AxHp0QUpsInrqyY1aRGtBvbc3vjYZKHCGpudJIdEsxZg+SNDJ8iZjuhpZMkVp3eBXu
         Iw9q+Mj7qT0dQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F3B6F40CE2; Tue, 19 Jan 2021 11:31:43 -0300 (-03)
Date:   Tue, 19 Jan 2021 11:31:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v7 3/3] perf-stat: enable counting events for BPF programs
Message-ID: <20210119143143.GJ12699@kernel.org>
References: <20201229214214.3413833-1-songliubraving@fb.com>
 <20201229214214.3413833-4-songliubraving@fb.com>
 <20210118193817.GG12699@kernel.org>
 <379919CC-594F-40C5-A10E-97E048F73AE2@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <379919CC-594F-40C5-A10E-97E048F73AE2@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 19, 2021 at 12:48:19AM +0000, Song Liu escreveu:
> > On Jan 18, 2021, at 11:38 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> We are looking at two issues:
> 1. Cannot recursively attach;
> 2. prog FD 3 doesn't have valid btf. 
 
> #1 was caused by the verifier disallowing attaching fentry/fexit program 
> to program with type BPF_PROG_TYPE_TRACING (in bpf_check_attach_target). 
> This constraint was added when we only had fentry/fexit in the TRACING
> type. We have extended the TRACING type to many other use cases, like 
> "tp_btf/", "fmod_ret" and "iter/". Therefore, it is good time to revisit 
> this constraint. I will work on this. 
 
> For #2, we require the target program to have BTF. I guess we won't remove
> this requirement.
 
> While I work on improving #1, could you please test with some kprobe 
> programs? For example, we can use fileslower.py from bcc. 

Sure, and please consider improving the error messages to state what you
described above.

- Arnaldo
