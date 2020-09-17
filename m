Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB0B26DC74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgIQNHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727033AbgIQNGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600347964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+EhJWlLN1A8CkzM7jfs30eTPVteDhvC+b3Jahv7I/6c=;
        b=bj4rBz9C1f4Ot3JuR5TovKKE1/Ul3QgxW6s3ChQoF0oWAQl/Iazq/6oy9XiUvypcMd718D
        IjIUyEQk2X201sU7NRVO7QYmrwMcYJAnDtr2p+JQk9lF1yhYBw0HkAuajT5xec5Q2IN57q
        KDJ+m/82P5lVyanH5W2tBW4PYS8OnIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-hFGzDPZgP6y7Sqby6zsvcw-1; Thu, 17 Sep 2020 09:06:01 -0400
X-MC-Unique: hFGzDPZgP6y7Sqby6zsvcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5579C801AF5;
        Thu, 17 Sep 2020 13:05:59 +0000 (UTC)
Received: from krava (ovpn-113-64.ams2.redhat.com [10.36.113.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 07D3910027AB;
        Thu, 17 Sep 2020 13:05:56 +0000 (UTC)
Date:   Thu, 17 Sep 2020 15:05:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 0/7] perf: Stream comparison
Message-ID: <20200917130556.GA2511679@krava>
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911080353.13359-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 04:03:46PM +0800, Jin Yao wrote:

SNIP

>                       main div.c:40
>                       main div.c:40
>                       main div.c:39
> 
> [ Hot streams in new perf data only ]
> 
> hot chain 1:
>                                                      cycles: 4, hits: 4.54%
>                                                  --------------------------
>                                                               main div.c:42
>                                                       compute_flag div.c:28
> 
> hot chain 2:
>                                                      cycles: 5, hits: 3.51%
>                                                  --------------------------
>                                                               main div.c:39
>                                                               main div.c:44
>                                                               main div.c:42
>                                                       compute_flag div.c:28
> 
>  v6:
>  ---
>  Rebase to perf/core

it looks good to me

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

