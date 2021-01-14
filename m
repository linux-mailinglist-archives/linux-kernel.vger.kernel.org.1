Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAB02F6A63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbhANTCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbhANTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610650846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvigHIWWc2Gmn8PwEExISaYWts5OrhPsazqZGgBea+c=;
        b=L9C08Twk+t3hOagI9fOCt2NmOakYGKYH6pfQq9n4NHUVR2D6oAaQ/4heecE71Y1Dt/e6gX
        Xxr5gQ/xnL0FAAxGHTiysBacyLN/Q79MWcMWqsaRgmsvqhx0RUJOzwrsDKSl7WWXcOZ243
        gGH2VXnFtpPYA97RndSzF7Y9VExwKuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-LXsq5mefP4i8fPOCWS0bLw-1; Thu, 14 Jan 2021 14:00:41 -0500
X-MC-Unique: LXsq5mefP4i8fPOCWS0bLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A4DA94F0D;
        Thu, 14 Jan 2021 19:00:39 +0000 (UTC)
Received: from krava (unknown [10.40.195.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0301B27C2C;
        Thu, 14 Jan 2021 19:00:32 +0000 (UTC)
Date:   Thu, 14 Jan 2021 20:00:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
Subject: Re: [PATCH v6] perf stat: Fix wrong skipping for per-die aggregation
Message-ID: <20210114190032.GC1416940@krava>
References: <20210114012755.1106-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114012755.1106-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 09:27:55AM +0800, Jin Yao wrote:

SNIP

>      2.003776312 S1-D0           1             855616 Bytes llc_misses.mem_read
>      2.003776312 S1-D1           1             949376 Bytes llc_misses.mem_read
>      3.006512788 S0-D0           1            1338880 Bytes llc_misses.mem_read
>      3.006512788 S0-D1           1             920064 Bytes llc_misses.mem_read
>      3.006512788 S1-D0           1             877184 Bytes llc_misses.mem_read
>      3.006512788 S1-D1           1            1020736 Bytes llc_misses.mem_read
>      4.008895291 S0-D0           1             926592 Bytes llc_misses.mem_read
>      4.008895291 S0-D1           1             906368 Bytes llc_misses.mem_read
>      4.008895291 S1-D0           1             892224 Bytes llc_misses.mem_read
>      4.008895291 S1-D1           1             987712 Bytes llc_misses.mem_read
>      5.001590993 S0-D0           1             962624 Bytes llc_misses.mem_read
>      5.001590993 S0-D1           1             912512 Bytes llc_misses.mem_read
>      5.001590993 S1-D0           1             891200 Bytes llc_misses.mem_read
>      5.001590993 S1-D1           1             978432 Bytes llc_misses.mem_read
> 
> On no-die system, die_id is 0, actually it's hashmap(socket,0), original behavior
> is not changed.
> 
> Reported-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
> v6:
>  Fix the perf test python failure by adding hashmap.c to python-ext-sources.
> 
>  root@kbl-ppc:~# ./perf test python
>  19: 'import perf' in python                                         : Ok

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

