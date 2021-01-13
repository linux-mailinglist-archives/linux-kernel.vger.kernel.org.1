Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202332F532F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 20:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbhAMTPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 14:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbhAMTPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 14:15:39 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D31DC06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 11:14:59 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b5so1802230pjk.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=QV7CCVnr0hRxwERgOubKWnTd8AO41CRti7z6Nf1xz20=;
        b=DuGtFutstu9QfhTtTzBu4bVaS8xB1tnYCXn4FJj59m8bWVnltjiuH06zE2qKM9ZBWD
         ib5ifETmzyS4YNldclh29XxqvhtttEoHYOfBahxXsI2r3TQ4dK9fJDHQ7M067+N8eMf+
         hHREE8DgBf/IZ4HtSlTQtbIcB7yD3hKd6D6ieotFI30ZA2/W77oHnn7EYb/uNPS3POvd
         b0YPLd+QsZlrxr2oxj/5l3J81uSalA7OtloXe57msXrlewLXDkDtXWtQKbLQ3Lp2dgpj
         dt37jDjQ0h0+iggnEcS86auyc+qYqE7EZGPcD3fY/xXMCpNPpgD9lE+pGdW308f/44wk
         XG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=QV7CCVnr0hRxwERgOubKWnTd8AO41CRti7z6Nf1xz20=;
        b=eJinev5T2g+EiDKKqSDT7FHgCVOJH1C8G8SbZXqePPlwaF8r9XSD3Do40CkTHEIngX
         ORQOd93yeXmrSDXUVwW3vulJKhiswG1nhYdKVCJNewKXb3SckjzQsE9ZSZCGcJEm4ULs
         Folo5wFWbNM2AqI0uN2ue0a53cvRNdyNm56Q5RFgPRU5Gxd1KqDh+BO2vnGpDE+wxYjW
         JjqRH4+Wse04NB8264VeFFkvDd+UCcV5A+Wtu2Kf+Cz+bnI2jysVk3sxmIXMXVYbT5mW
         rtxMmIu5KBtdaifgAgw2oOXWdoH/ADEwbKmHLvqAl9SoxSyM0hPJyfbVK//XOyI2Epjl
         3U8g==
X-Gm-Message-State: AOAM533I2nRzvR8NsqzKedIftFSgYGC+3ft+keIYfSNfTyofrL0FWMnw
        +b+Pq6+UtzgIzOd8jm4Ieky2jA==
X-Google-Smtp-Source: ABdhPJyK7Q/nG/8kEXLMTMhhEOT2nDYHx7gK6IRp52RYkswXs9uEmohuDcpHAkG/orAIZHMEqjhuZQ==
X-Received: by 2002:a17:90a:ae13:: with SMTP id t19mr836640pjq.52.1610565298698;
        Wed, 13 Jan 2021 11:14:58 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z125sm3262354pfz.121.2021.01.13.11.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 11:14:58 -0800 (PST)
Date:   Wed, 13 Jan 2021 11:14:58 -0800 (PST)
X-Google-Original-Date: Wed, 13 Jan 2021 11:14:56 PST (-0800)
Subject:     Re: [PATCH] dm-snapshot: Flush merged data before committing metadata
In-Reply-To: <ecb35731d19b41984dd7157d48661f5297a1b668.1609119545.git.akailash@google.com>
CC:     Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>, kernel-team@android.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     kernel-team@android.com
Message-ID: <mhng-81f035b4-1104-44e8-9099-4a99972512b3@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Dec 2020 23:14:07 PST (-0800), kernel-team@android.com wrote:
> If the origin device has a volatile write-back
> cache and the following events occur:
>
> 1: After finishing merge operation of one set of exceptions,
>    merge_callback() is invoked.
> 2: Update the metadata in COW device tracking the merge completion.
>    This update to COW device is flushed cleanly.
> 3: System crashes and the origin device's cache where the recent
>    merge was completed has not been flushed.
>
> During the next cycle when we read the metadata from the COW device,
> we will skip reading those metadata whose merge was completed in
> step (1). This will lead to data loss/corruption.
>
> To address this, flush the origin device post merge IO before
> updating the metadata.

This is essentially the same as the flushes added in 8b3fd1f53af3 ("dm clone:
Flush destination device before committing metadata") and 694cfe7f31db ("dm
thin: Flush data device before committing metadata"), but for dm-snap.  Looks
like this bug has been around since before the git tree, so I'm not sure what
the right thing to do with a Fixes tag is.

> Signed-off-by: Akilesh Kailash <akailash@google.com>
> ---
>  drivers/md/dm-snap.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
> index 4668b2cd98f4..11890db71f3f 100644
> --- a/drivers/md/dm-snap.c
> +++ b/drivers/md/dm-snap.c
> @@ -141,6 +141,11 @@ struct dm_snapshot {
>  	 * for them to be committed.
>  	 */
>  	struct bio_list bios_queued_during_merge;
> +
> +	/*
> +	 * Flush data after merge.
> +	 */
> +	struct bio flush_bio;
>  };
>
>  /*
> @@ -1121,6 +1126,17 @@ static void snapshot_merge_next_chunks(struct dm_snapshot *s)
>
>  static void error_bios(struct bio *bio);
>
> +static int flush_data(struct dm_snapshot *s)
> +{
> +	struct bio *flush_bio = &s->flush_bio;
> +
> +	bio_reset(flush_bio);
> +	bio_set_dev(flush_bio, s->origin->bdev);
> +	flush_bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
> +
> +	return submit_bio_wait(flush_bio);
> +}
> +
>  static void merge_callback(int read_err, unsigned long write_err, void *context)
>  {
>  	struct dm_snapshot *s = context;
> @@ -1134,6 +1150,11 @@ static void merge_callback(int read_err, unsigned long write_err, void *context)
>  		goto shut;
>  	}
>
> +	if (flush_data(s) < 0) {
> +		DMERR("Flush after merge failed: shutting down merge");
> +		goto shut;
> +	}
> +
>  	if (s->store->type->commit_merge(s->store,
>  					 s->num_merging_chunks) < 0) {
>  		DMERR("Write error in exception store: shutting down merge");
> @@ -1318,6 +1339,7 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	s->first_merging_chunk = 0;
>  	s->num_merging_chunks = 0;
>  	bio_list_init(&s->bios_queued_during_merge);
> +	bio_init(&s->flush_bio, NULL, 0);

There's no bio_uninit() in the error handling code here, but there aren't any
in any of the other cleanup blocks either.  The bio_uninit() call won't do
anything here, as it does nothing for empty BIOs, so I guess it just doesn't
matter.

>  	/* Allocate hash table for COW data */
>  	if (init_hash_tables(s)) {
> @@ -1504,6 +1526,8 @@ static void snapshot_dtr(struct dm_target *ti)
>
>  	dm_exception_store_destroy(s->store);
>
> +	bio_uninit(&s->flush_bio);
> +
>  	dm_put_device(ti, s->cow);
>
>  	dm_put_device(ti, s->origin);

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
