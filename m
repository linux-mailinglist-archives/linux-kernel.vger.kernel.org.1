Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE6927ADF1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1Mgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbgI1Mgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:36:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601296597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tiyaAhVJk1gQmUe/zhm0tjK1CH0y/owdDudvSDFfoj8=;
        b=GVXOxy4KrbbcuWI23pOUFExpOh6R/6clrLQgSq7KSwr5fwSjNTlsC4FAWUv10XsjZqn6qG
        R0YC+HFNLBHFnm2g+an3m6cEbhQ4hxKe5rzqjvLnPsJ9ByVWcVNqfkOM91EWLVCln2bqTg
        3d8eqE9qVgNBWQTZ1BFNFROV/QwYZ/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-BnZdiPAGNoGhKghrvSSpiQ-1; Mon, 28 Sep 2020 08:36:33 -0400
X-MC-Unique: BnZdiPAGNoGhKghrvSSpiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AB6710059A8;
        Mon, 28 Sep 2020 12:36:31 +0000 (UTC)
Received: from krava (unknown [10.40.193.42])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0058755771;
        Mon, 28 Sep 2020 12:36:27 +0000 (UTC)
Date:   Mon, 28 Sep 2020 14:36:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <20200928123626.GB3517742@krava>
References: <20200924124455.336326-1-namhyung@kernel.org>
 <20200924124455.336326-4-namhyung@kernel.org>
 <20200925132636.GB3273770@krava>
 <CAM9d7cgHBe6-SfCc3RTfLmrvaKr1hSprmJPd2BFnQtMUu_6TFw@mail.gmail.com>
 <20200925135133.GC3273770@krava>
 <20200928115404.GA3087422@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928115404.GA3087422@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 08:54:04AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 25, 2020 at 03:51:33PM +0200, Jiri Olsa escreveu:
> > On Fri, Sep 25, 2020 at 10:44:53PM +0900, Namhyung Kim wrote:
> > > On Fri, Sep 25, 2020 at 10:26 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > On Thu, Sep 24, 2020 at 09:44:53PM +0900, Namhyung Kim wrote:
> > > No actually, I still think perf record should use --all-cgroups.
> 
> > > > my ack from last version stays
> 
> > > Thanks!  But I didn't see your ack for this patch set.
> > > (I've only seen it for the perf inject patchset..)
>  
> > ah that was for the build id inject speed up.. too many
> > patchsets flying around ;-)
>  
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> I take this is for the entire patchset, right?

yes

jirka

