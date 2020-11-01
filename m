Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10FD2A219C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 21:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgKAUsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 15:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgKAUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 15:48:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9FDC0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 12:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HK4WJIQcNc1wsi9NV2soETQrxP57kXJKoEvFH6iI7xo=; b=RdFWirAaAzJbvECzZLuajNCNf3
        +A89JNuVRkXwrDW22v1vju3Be479QAkuaO88OqZbqFfnp41ubc55jK7LrLI+kmT5wBzIEaeyaAnWW
        ePS7ZxysA7YlnnS360EEQAFqtzsH6UiUdXJPjSu0bRoQhhzq6M5SkDjudbfRRfO9xTvGIpT9T+pfw
        +74ZJGTaL598+hUQg47fdgavCiLfYk0gIZ3bcxZanzS7AB3E3rcl5riNGzaql8255sM1/a+t39V5t
        uQFJZkfzOapdqT+6RKHHGqMBoJ/waTyhLl+DPUWtdjqOLzvETO4tnSmnV3k2LRK3UwZS1zh1mYi3E
        rbAjQ+7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZKHC-0003Fp-9Q; Sun, 01 Nov 2020 20:48:34 +0000
Date:   Sun, 1 Nov 2020 20:48:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use
 sysfs_emit_at
Message-ID: <20201101204834.GF27442@casper.infradead.org>
References: <cover.1604261483.git.joe@perches.com>
 <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 12:12:51PM -0800, Joe Perches wrote:
> @@ -4024,7 +4024,7 @@ int __init shmem_init(void)
>  
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SYSFS)
>  static ssize_t shmem_enabled_show(struct kobject *kobj,
> -		struct kobj_attribute *attr, char *buf)
> +				  struct kobj_attribute *attr, char *buf)
>  {
>  	static const int values[] = {
>  		SHMEM_HUGE_ALWAYS,

Why?

> @@ -4034,16 +4034,19 @@ static ssize_t shmem_enabled_show(struct kobject *kobj,
>  		SHMEM_HUGE_DENY,
>  		SHMEM_HUGE_FORCE,
>  	};
> -	int i, count;
> -
> -	for (i = 0, count = 0; i < ARRAY_SIZE(values); i++) {
> -		const char *fmt = shmem_huge == values[i] ? "[%s] " : "%s ";
> +	int len = 0;
> +	int i;

Better:
	int i, len = 0;

> -		count += sprintf(buf + count, fmt,
> -				shmem_format_huge(values[i]));
> +	for (i = 0; i < ARRAY_SIZE(values); i++) {
> +		len += sysfs_emit_at(buf, len,
> +				     shmem_huge == values[i] ? "%s[%s]" : "%s%s",
> +				     i ? " " : "",
> +				     shmem_format_huge(values[i]));

This is ... complicated.  I thought the point of doing all the sysfs_emit
stuff was to simplify things.

