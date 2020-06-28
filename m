Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E844E20CACD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 23:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgF1VzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 17:55:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23837 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbgF1VzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 17:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593381315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V9rU1owZj4QEI59rGzsBKydkEO4eidu+tIgu8wPHQ0I=;
        b=hPzPYCMDtNFLTpMmX3MVt/iuVJISsSsxeO1dnVerPDseYiyU8B1ur9zJS+xz3mSzq6ed+s
        LjsYTc3vjfs8LaPy/1aIIJD0JcTO/clCLcQagOTrBoRyZkVWddJLlGNqy9kMOmntEc665t
        e28gZR7qPPvLzAY2ZfJoT/nzFS734nI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-oVwzBy9fMe6idJNQlDr1Pg-1; Sun, 28 Jun 2020 17:55:12 -0400
X-MC-Unique: oVwzBy9fMe6idJNQlDr1Pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 114AB1005512;
        Sun, 28 Jun 2020 21:55:11 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3D1AE19C4F;
        Sun, 28 Jun 2020 21:55:08 +0000 (UTC)
Date:   Sun, 28 Jun 2020 23:55:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 07/10] perf tools: Collect other metrics in struct
 metric_expr
Message-ID: <20200628215507.GM2988321@krava>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626194720.2915044-8-jolsa@kernel.org>
 <CAP-5=fUB3cs7Px6NkpBtWaWdR5-qQGAd2hAGjQjyMJt=bDKXOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUB3cs7Px6NkpBtWaWdR5-qQGAd2hAGjQjyMJt=bDKXOA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:10:57PM -0700, Ian Rogers wrote:
> On Fri, Jun 26, 2020 at 12:48 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Add 'other' metrics into struct metric_expr object,
> > so they are accessible when computing the metric.
> >
> > Storing just name and expression itself, so the metric
> > can be resolved and computed.
> 
> Nit, other vs something like referenced_metric but otherwise lgtm.

I'd like to keep metric prefix

  struct metric_ref ?

jirka

