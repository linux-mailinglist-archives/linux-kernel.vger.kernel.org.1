Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD1F27AD49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgI1LyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgI1LyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:54:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D1982073A;
        Mon, 28 Sep 2020 11:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601294046;
        bh=Q7RXb/v9uX736muDKOclzAf+SXdqC1VcGgN5YXZKtnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Emv6X7KVIN7PUQmP9k5fSNww8kHYF7fhZYWkRztJT/G0HnvThbQN+8XqIZHVI+2R
         w1iawwO/6wcOe4XzL/KRDbtAYmce2ZL4sRHjGh/IALNFgUEB2uY6RDwHVQFLER65ZD
         KTEIFGDde21cnRb0Vdak8DU41hl1lSp+HnO8Ufes=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5774540B02; Mon, 28 Sep 2020 08:54:04 -0300 (-03)
Date:   Mon, 28 Sep 2020 08:54:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH 3/5] perf tools: Copy metric events properly when expand
 cgroups
Message-ID: <20200928115404.GA3087422@kernel.org>
References: <20200924124455.336326-1-namhyung@kernel.org>
 <20200924124455.336326-4-namhyung@kernel.org>
 <20200925132636.GB3273770@krava>
 <CAM9d7cgHBe6-SfCc3RTfLmrvaKr1hSprmJPd2BFnQtMUu_6TFw@mail.gmail.com>
 <20200925135133.GC3273770@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925135133.GC3273770@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 25, 2020 at 03:51:33PM +0200, Jiri Olsa escreveu:
> On Fri, Sep 25, 2020 at 10:44:53PM +0900, Namhyung Kim wrote:
> > On Fri, Sep 25, 2020 at 10:26 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > On Thu, Sep 24, 2020 at 09:44:53PM +0900, Namhyung Kim wrote:
> > No actually, I still think perf record should use --all-cgroups.

> > > my ack from last version stays

> > Thanks!  But I didn't see your ack for this patch set.
> > (I've only seen it for the perf inject patchset..)
 
> ah that was for the build id inject speed up.. too many
> patchsets flying around ;-)
 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

I take this is for the entire patchset, right?

- Arnaldo
