Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FD7259D29
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 19:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgIAR0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 13:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgIAR0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:26:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA652078B;
        Tue,  1 Sep 2020 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598981171;
        bh=fEW6oJfvn5Ucjhclk7f4qerwSkmRvaGzBLRUjhSJGCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LykNUrVs3FSPdq/7Cys5tJ+kyZbOsgPy32lcNp8gZ3IFPvkRPuCF3SPnhYeGvltE/
         VmSlzT5sDAUshbgs88HAmlibM+C1/yJZNnE3IZI6xWtHl9vCAiz4HrUdqsOjJZ5ufH
         3JKDbb7gKEJS8G3jZo0pomhsjNQPwsiHa6EwJ0nU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C146740D3D; Tue,  1 Sep 2020 14:26:08 -0300 (-03)
Date:   Tue, 1 Sep 2020 14:26:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Al Grant <al.grant@foss.arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
Subject: Re: [PATCH] perf inject: correct event attribute sizes
Message-ID: <20200901172608.GE1424523@kernel.org>
References: <b5f9e19c-6adb-ccdd-3dbd-df8e1b82ee93@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f9e19c-6adb-ccdd-3dbd-df8e1b82ee93@foss.arm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 26, 2020 at 10:42:04AM +0100, Al Grant escreveu:
> When perf inject reads a perf.data file from an older version of perf,
> it writes event attributes into the output with the original size field,
> but lays them out as if they had the size currently used. Readers see
> a corrupt file. Update the size field to match the layout.
> 
> From: Denis Nikitin <denik@google.com>
> Signed-off-by: Al Grant <al.grant@foss.arm.com>

Ok, so the author is Denis, has he provided his Signed-off-by?

- Arnaldo
 
>  tools/perf/util/header.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9cf4efdcbbbd..762eb94bd532 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3326,6 +3326,14 @@ int perf_session__write_header(struct
> perf_session *session,
>         attr_offset = lseek(ff.fd, 0, SEEK_CUR);
> 
>         evlist__for_each_entry(evlist, evsel) {
> +               if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
> +                       /*
> +                        * We are likely in "perf inject" and have read +
> * from an older file. Update attr size so that
> +                        * reader gets the right offset to the ids.
> +                        */
> +                       evsel->core.attr.size = sizeof(evsel->core.attr);
> +               }
>                 f_attr = (struct perf_file_attr){
>                         .attr = evsel->core.attr,
>                         .ids  = {

-- 

- Arnaldo
