Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473962A80C6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgKEOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:23:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:48792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgKEOXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:23:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6B1CB02D;
        Thu,  5 Nov 2020 14:23:17 +0000 (UTC)
Subject: Re: [PATCH] bcache: make writeback_cutoff and writeback_cutoff_sync
 writeable
To:     Dongdong Tao <tdd21151186@gmail.com>
Cc:     dongdong.tao@canonical.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "open list:BCACHE (BLOCK LAYER CACHE)" <linux-bcache@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201105141939.9223-1-tdd21151186@gmail.com>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Message-ID: <14dd22de-030e-c7af-494b-a4317afeb795@suse.de>
Date:   Thu, 5 Nov 2020 22:23:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201105141939.9223-1-tdd21151186@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/5 22:19, Dongdong Tao wrote:
> From: dongdong tao <dongdong.tao@canonical.com>
> 
> commit 9aaf51654672 ("bcache: make cutoff_writeback and
> cutoff_writeback_sync tunable") intend to make these two option
> configurable by user, but these two are still read-only.
> 
> Signed-off-by: dongdong tao <dongdong.tao@canonical.com>
> ---
>  drivers/md/bcache/sysfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index 554e3afc9b68..81f4a681705c 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -102,8 +102,8 @@ read_attribute(writeback_keys_done);
>  read_attribute(writeback_keys_failed);
>  read_attribute(io_errors);
>  read_attribute(congested);
> -read_attribute(cutoff_writeback);
> -read_attribute(cutoff_writeback_sync);
> +rw_attribute(cutoff_writeback);
> +rw_attribute(cutoff_writeback_sync);
>  rw_attribute(congested_read_threshold_us);
>  rw_attribute(congested_write_threshold_us);
>  
> @@ -902,6 +902,8 @@ STORE(__bch_cache_set)
>  	sysfs_strtoul_bool(copy_gc_enabled,	c->copy_gc_enabled);
>  	sysfs_strtoul_bool(idle_max_writeback_rate,
>  			   c->idle_max_writeback_rate_enabled);
> +	sysfs_strtoul_clamp(cutoff_writeback, bch_cutoff_writeback, 1, 100);
> +	sysfs_strtoul_clamp(cutoff_writeback_sync, bch_cutoff_writeback_sync, 1, 100);
>  

NACK, we only support the default value. Commit 9aaf51654672 ("bcache:
make cutoff_writeback and cutoff_writeback_sync tunable") clearly
announced the purpose was for research and experiment.

Coly Li
