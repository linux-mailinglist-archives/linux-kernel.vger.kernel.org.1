Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A852C83E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgK3MLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:11:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgK3MLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:11:33 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88C6F206D8;
        Mon, 30 Nov 2020 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606738252;
        bh=uyXgexDHOYtKam8cO/UEgCKNm4cYXUw4M2CdO9PNIFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUfk6Gvrvxqb1wfHcq9GarnAAGqsFcUyXAtusyHw4ll2CaDoM1RrrhTolrNkeiMni
         43zzwHq+eLBNJDkoBA3Gfx8LhUy/ST4/N5RHmLod8/NptOujX3finAqDq4UTDjc+zA
         /WS8pQg2750ddSBQ1oz2fZ/mgXPoe65Rmu05g0NA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A5FC34079D; Mon, 30 Nov 2020 09:10:56 -0300 (-03)
Date:   Mon, 30 Nov 2020 09:10:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        maddy@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix metric parsing test
Message-ID: <20201130121056.GB20959@kernel.org>
References: <20201119152411.46041-1-kjain@linux.ibm.com>
 <CAP-5=fX76BQMaOnKTCgBD9MMwx_Q=tShDFBYZxzJOreOhXV=Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX76BQMaOnKTCgBD9MMwx_Q=tShDFBYZxzJOreOhXV=Mw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 19, 2020 at 08:48:57AM -0800, Ian Rogers escreveu:
> On Thu, Nov 19, 2020 at 7:25 AM Kajol Jain <kjain@linux.ibm.com> wrote:
> > Result in power9 platform after this patch:

> > [command]# ./perf test 10
> > 10: PMU events                                                      :
> > 10.1: PMU event table sanity                                        : Ok
> > 10.2: PMU event map aliases                                         : Ok
> > 10.3: Parsing of PMU event table metrics                            : Skip
> > (some metrics failed)
> > 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

> > Fixes: e1c92a7fbbc5 ("perf tests: Add another metric parsing test")
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

> Acked-by: Ian Rogers <irogers@google.com>



Thanks, applied.

- Arnaldo

