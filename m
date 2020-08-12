Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442E6242938
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 14:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgHLMTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 08:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgHLMTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:19:16 -0400
Received: from quaco.ghostprotocols.net (179.176.8.134.dynamic.adsl.gvt.net.br [179.176.8.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB5C12245C;
        Wed, 12 Aug 2020 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597234756;
        bh=2V8LC8Z0fyID40kPZ6gRZzu3p05ZGHbpAZ1Q92ev8l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqcQHKE0mA1l2AxKzD7GuM3IX83UVBGGj+K096Y8ZUH3XJLt5IV/tVtEwlZLAjI6s
         0DAB1PiPrzEIUmaW6QuJpWnVub5r+h9/QFHlrxz0nNrJhav/s+a6XtD/r3gt2AldBA
         RO5+TjYUrVI2HH+CvnuEyrGwJjbybzQPl0JPkrwU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 84B7A403C6; Wed, 12 Aug 2020 09:19:13 -0300 (-03)
Date:   Wed, 12 Aug 2020 09:19:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 1/2] perf sched: Prefer sched_waking event when it exists
Message-ID: <20200812121913.GF13995@kernel.org>
References: <20200807164844.44870-1-dsahern@kernel.org>
 <CAM9d7chu8VOWfQv0dF89U6AaTE7VvwQDJj+V39cMp12k0Q1s_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chu8VOWfQv0dF89U6AaTE7VvwQDJj+V39cMp12k0Q1s_A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 11, 2020 at 03:42:45PM +0900, Namhyung Kim escreveu:
> Hi David,
> 
> On Sat, Aug 8, 2020 at 1:48 AM David Ahern <dsahern@kernel.org> wrote:
> >
> > Commit fbd705a0c618 ("sched: Introduce the 'trace_sched_waking' tracepoint")
> > added sched_waking tracepoint which should be preferred over sched_wakeup
> > when analyzing scheduling delays.
> >
> > Update 'perf sched record' to collect sched_waking events if it exists
> > and fallback to sched_wakeup if it does not. Similarly, update timehist
> > command to skip sched_wakeup events if the session includes
> > sched_waking (ie., sched_waking is preferred over sched_wakeup).
> >
> > Signed-off-by: David Ahern <dsahern@kernel.org>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo
