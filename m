Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38392C41F7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgKYOPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:15:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729109AbgKYOPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606313741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Td/8Ow1h2VVzvZfHFudQxWhJpRZ2ytrBuToX3K1/lQk=;
        b=BIdKt48HpKac8LgixvG59JN6A33mSw/Snh6jMwpCv6ZO0j659CjLsZDUFX/9LhqWOLuKo8
        /enOqD5iZreiZQjI9b4ccF5whhyR9j04YKzaKJKiKxmMWPrLkIU6VNLECduHmm4J2bUJN1
        YnpAGYMN3Vz9ebzSMkFEEigd6piDQEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-ibup7d3cMViW2mgFm_Tuvg-1; Wed, 25 Nov 2020 09:15:37 -0500
X-MC-Unique: ibup7d3cMViW2mgFm_Tuvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F71B190A7B0;
        Wed, 25 Nov 2020 14:15:35 +0000 (UTC)
Received: from krava (unknown [10.40.192.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id 42DBB1899A;
        Wed, 25 Nov 2020 14:15:32 +0000 (UTC)
Date:   Wed, 25 Nov 2020 15:15:31 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 13/25] perf tools: Store build id from mmap2 events
Message-ID: <20201125141531.GE2164284@krava>
References: <20201123230512.2097312-1-jolsa@kernel.org>
 <20201123230512.2097312-14-jolsa@kernel.org>
 <CAM9d7ciq_D2F_bPoq7S5aw+0jPZ0EokCNDadEcO2KF_rYsL8VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciq_D2F_bPoq7S5aw+0jPZ0EokCNDadEcO2KF_rYsL8VQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 09:56:31PM +0900, Namhyung Kim wrote:
> On Tue, Nov 24, 2020 at 8:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > When processing mmap2 event, check on the build id
> > misc bit: PERF_RECORD_MISC_MMAP_BUILD_ID and if it
> > is set, store the build id in mmap's dso object.
> >
> > Also adding the build id data arts to struct
> 
> s/arts/args/ ?

right, perhaps also s/arts// 

thanks,
jirka

> 
> Thanks,
> Namhyung
> 
> 
> > perf_record_mmap2 event definition.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 

