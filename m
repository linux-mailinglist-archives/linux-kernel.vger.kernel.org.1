Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8032E2257
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 23:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgLWWMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 17:12:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgLWWMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 17:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608761472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYTG9iXqzUmfK52yJWZCu8FMFbHFYcDD55d0R+uDFu8=;
        b=ZQNozVrfIClenyr6PBKSjQXCuQekQZBgaaMsB3fGCOeWXzyxEhHPKnvwtsWRdcuE2SiT+X
        wvKk57WBsJl/9wcy4HMmf/bz4WrSjKtR/jx3RvAzweIMHDEph/BR72C3EU69XpXXbdtoMI
        kAwlBoXVbzbHiLDrHdaUQLefPDqebZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-s2q2O-1ZPAeR--bKvC_Skg-1; Wed, 23 Dec 2020 17:11:10 -0500
X-MC-Unique: s2q2O-1ZPAeR--bKvC_Skg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A0851800D42;
        Wed, 23 Dec 2020 22:11:08 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id C96315D9D5;
        Wed, 23 Dec 2020 22:11:05 +0000 (UTC)
Date:   Wed, 23 Dec 2020 23:11:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Denis Nikitin <denik@chromium.org>
Cc:     linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        al.grant@arm.com, al.grant@foss.arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject: correct event attribute sizes
Message-ID: <20201223221105.GA236568@krava>
References: <20201124195818.30603-1-al.grant@arm.com>
 <20201216065816.1840893-1-denik@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216065816.1840893-1-denik@chromium.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 10:58:16PM -0800, Denis Nikitin wrote:
> When perf inject reads a perf.data file from an older version of perf,
> it writes event attributes into the output with the original size field,
> but lays them out as if they had the size currently used. Readers see
> a corrupt file. Update the size field to match the layout.
> 
> Signed-off-by: Al Grant <al.grant@foss.arm.com>
> Signed-off-by: Denis Nikitin <denik@chromium.org>
> ---
>  tools/perf/util/header.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index be850e9f8852..0d95981df8dd 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3331,6 +3331,14 @@ int perf_session__write_header(struct perf_session *session,
>  	attr_offset = lseek(ff.fd, 0, SEEK_CUR);
>  
>  	evlist__for_each_entry(evlist, evsel) {
> +		if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
> +			/*
> +			 * We are likely in "perf inject" and have read
> +			 * from an older file. Update attr size so that
> +			 * reader gets the right offset to the ids.
> +			 */
> +			evsel->core.attr.size = sizeof(evsel->core.attr);
> +		}

seems ok, just wondering if it would be better
to fix it in perf_event__process_attr instead

where we know where the data is coming from,
here we could cover for some unexpected case
of having different attr.size?

anyway both would be probably equal, I'm ok
with either way

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka


>  		f_attr = (struct perf_file_attr){
>  			.attr = evsel->core.attr,
>  			.ids  = {
> -- 
> 2.29.2.684.gfbc64c5ab5-goog
> 

