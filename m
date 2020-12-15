Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6912D2DB003
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgLOPZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:25:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbgLOPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608045868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9favKO92bZy+hUVuBjcpdkLduaBsVNLOb6uBu9wK6Jk=;
        b=TrN1T/6IOGpVceBXrU4chcxL3UppLJLR19Uk9K5nji8t5XseTso4zy9v0bhj8aRdKXv8UH
        AFkCmoft28lFLa+5WdW4CrM6uD8RBMmG0j6QrS/3uXUYD6GvyPpbttPbaYU13ZADyx8ejS
        u7oooqgfbE243v4twr+SQLqp12OTQpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-RgEdB_V4NG6BENukGEQ2vA-1; Tue, 15 Dec 2020 10:24:26 -0500
X-MC-Unique: RgEdB_V4NG6BENukGEQ2vA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCAA315720;
        Tue, 15 Dec 2020 15:24:24 +0000 (UTC)
Received: from krava (ovpn-113-169.ams2.redhat.com [10.36.113.169])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9D7041E5;
        Tue, 15 Dec 2020 15:24:21 +0000 (UTC)
Date:   Tue, 15 Dec 2020 16:24:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 2/3] perf tools: Allow to enable/disable events via
 control file
Message-ID: <20201215152420.GC658008@krava>
References: <20201210204330.233864-1-jolsa@kernel.org>
 <20201210204330.233864-3-jolsa@kernel.org>
 <20201215151413.GE252952@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215151413.GE252952@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 12:14:13PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 10, 2020 at 09:43:29PM +0100, Jiri Olsa escreveu:
> > Adding new control events to enable/disable specific event.
> > The interface string for control file are:
> > 
> >   'enable-<EVENT NAME>'
> >   'disable-<EVENT NAME>'
> 
> Wwy do we have "enable-" as the "tag" for this?

the whole 'enable-' is prefix for command that enables specific event
following '-' starts the event name

> 
> Also is it possible to use "enable sched:*" and have that match what is
> in the evlist and enable (or disable, if using "disable sched:*") what
> matches?

yep, that should be possible to add

> 
> This second suggestion can be done on top of this, i.e. as an
> enhancement, but mixing up the command (enable, disable) with its
> arguments looks strange.

the '-' determines that there's event name following,
pure 'enable' switches on everything

jirka

