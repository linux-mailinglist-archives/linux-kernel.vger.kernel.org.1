Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455372B6ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgKQQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:54:21 -0500
Received: from m12-16.163.com ([220.181.12.16]:55618 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbgKQQyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=c7Q8K
        3WNUEIw3WkhA/expB+AKSCPVZj5coJ398yQkYk=; b=a0cCx9ITqbxv/9zVmTSKl
        Uq6jSkpYvqT/vI6pLk1K/dXIz7zc4OV3XOHAInXsq2uMtHlrnc3xoiVmKTQQMTgp
        xzxRFNENnEir14UgVSNKQSwnFwWnjk/V+QkAxvhJKVdMk7xWl9hwFacc538MV5jV
        vxebwwyu9k6vqgSzKImbn0=
Received: from localhost (unknown [101.86.213.141])
        by smtp12 (Coremail) with SMTP id EMCowABnhI3__7Nf5hfiMQ--.22511S2;
        Wed, 18 Nov 2020 00:53:19 +0800 (CST)
Date:   Wed, 18 Nov 2020 00:53:19 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: Re: [PATCH] mm/lru: simplify is_file_lru() and is_active_lru()
Message-ID: <20201117165319.GA83217@rlk>
References: <20201117164919.GA82821@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117164919.GA82821@rlk>
X-CM-TRANSID: EMCowABnhI3__7Nf5hfiMQ--.22511S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr45tr17urWfWFW5Aw45trb_yoWftFXE9a
        4kZ3WkGwsxXF1Duw1Fk3ZrX3yYk3W3XFs5Z3Z3tw4Iyrn8Cws8Kw18Jr4Dtwn5Ga129ry8
        W3409ryfur15ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAcTBJUUUUU==
X-Originating-IP: [101.86.213.141]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiJh-fX1v2fBzBywAAs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:49:19AM +0800, Hui Su wrote:
> page->lru bit 0 can tell whether the page is
> avtive page or not.
> page->lru bit 1 can tell whether the page is
> file page or not.
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  include/linux/mmzone.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index fb3bf696c05e..294369c652d0 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -258,12 +258,12 @@ enum lru_list {
>  
>  static inline bool is_file_lru(enum lru_list lru)
>  {
> -	return (lru == LRU_INACTIVE_FILE || lru == LRU_ACTIVE_FILE);
> +	return lru & LRU_FILE;
>  }
>  
>  static inline bool is_active_lru(enum lru_list lru)
>  {
> -	return (lru == LRU_ACTIVE_ANON || lru == LRU_ACTIVE_FILE);
> +	return lru & LRU_ACTIVE;
>  }
>  
>  #define ANON_AND_FILE 2
> -- 
> 2.29.0

The commit message is not correct, please ignore this change.

