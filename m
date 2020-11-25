Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357A62C4572
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgKYQkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:40:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730247AbgKYQky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606322453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/zQ1cKIShwHABz182npq17vBHXZMt6hAGrjSiY6wq4=;
        b=cTvMEnDCGVan/xFdUckkdBEYtjxs5WzBNisA6TTdW6PNMSEXPgYXTPJM/Qf1iaTaXjKFa8
        TSVPGnRdOYhmXZNLebXG71hY2onAAIZN6XGtFlhUqlRarh0vd05aopF9JM2eO9fJ5XzhTO
        b0iMmEhHvuMIHA3uGWf5BvoUsh8GskI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-MYYcJmb1Moaj6yuDWwhSkg-1; Wed, 25 Nov 2020 11:40:49 -0500
X-MC-Unique: MYYcJmb1Moaj6yuDWwhSkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FCA48145E0;
        Wed, 25 Nov 2020 16:40:47 +0000 (UTC)
Received: from krava (unknown [10.40.192.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4C3A3100AE2D;
        Wed, 25 Nov 2020 16:40:45 +0000 (UTC)
Date:   Wed, 25 Nov 2020 17:40:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [RFC 1/2] perf: support build BPF skeletons with perf
Message-ID: <20201125164044.GL2164284@krava>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-2-songliubraving@fb.com>
 <20201122233521.GD1902740@krava>
 <F035411D-BC52-4A65-97FE-D53120E06689@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F035411D-BC52-4A65-97FE-D53120E06689@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:52:43PM +0000, Song Liu wrote:
> 
> 
> > On Nov 22, 2020, at 3:35 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Wed, Nov 18, 2020 at 08:50:45PM -0800, Song Liu wrote:
> >> BPF programs are useful in perf to profile BPF programs. BPF skeleton is
> >> by far the easiest way to write BPF tools. Enable building BPF skeletons
> >> in util/bpf_skel. A dummy bpf skeleton is added. More bpf skeletons will
> >> be added for different use cases.
> > 
> > I was just in a place adding bpf program to perf as well,
> > so this will save me some time ;-) thanks!
> 
> I'd love to learn about your plan. Maybe we have some similar ideas, 
> and could collaborate on them. 

the plan was to use skeleton as you did, because I agree it's the best
way to include bpf program in perf

I'm now using your patch and adding my bpf program on top of that ;-)

thanks,
jirka

