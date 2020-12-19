Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA56A2DF0C5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 18:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgLSRwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 12:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgLSRwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 12:52:34 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A41C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 09:51:54 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id l207so6713593oib.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 09:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Bi9+8PWR8xRsIKhCEM2h2bE5clfk/H11A/Yp12L9OEg=;
        b=jUN8UuEPAlu4QHUtm9xoZZ67pzyNPhGzGpDj2V6xRqEC6O3ZlaBmHGUCQsTr1uRQau
         pz6EmwkOmdmXM9uyX//H+T5MK/0+g6LEmbX80m1GomCWr7koxLQ2kONoZ38tPc4X2GHS
         COdJrIG2ti9YGjuHKFlEuSQaPIRWZoit2fHnA8zaIqwmEU1WL+a7iFCFoKl5tua3q7dJ
         X7G4c5FFcTEF5XSQa6YDMnRt/hGFrzvyFO00Bp+xF1zq9KBl2HCg5cBeaz+6v4qM26RE
         3S4bDPBbQmvnLngkpt60QJFcAwRcfJS8L60PcJDex2ycz+7l29Lk6Wc1eNB4PPzbKFvE
         h+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Bi9+8PWR8xRsIKhCEM2h2bE5clfk/H11A/Yp12L9OEg=;
        b=h+kFZoStE8JGaz8ZAMptog0Sp9jb795SbFo2PkGKLefyqUGlFXKmc1+jkRCAqVjxHx
         dnZJfVv1y9CHuO9rG4aJKpopEuEsy2Z9jZ/8uQtNbAqbfRSIXpPeJqLG6fSK/RWQ3wgE
         /1VJhKGvuJVkweQTyDHSdLyZNKmbTsxgVooP6k5MASWqEpBU6YTEc7tu88irYKzXRyOQ
         KwyceIq3zvNVK/1pMN1s1PR3l0bqKERHzTe7g3YMhPexbo/bxTsO8+UZXK2UoUhSmpXH
         xiv3k+TSH/s/yhWFX7lEPc5nyd3ztGhAvt0Td16dPnN75Kbkms1Nu4AZFOJFQvBY10pw
         rvUw==
X-Gm-Message-State: AOAM533j803XyZ5QuJKzN6ludNXldwIF+ZGrqBAGtMmLjbikhWKpzujq
        ZUr7/RHusIsLPgbgTOMYeFU=
X-Google-Smtp-Source: ABdhPJzl302HbXKhes494AXjy7KLvhTnVIsw6QClQhMrOYYsnFCPU+SnUD4zmIduRPFM3liguu82tw==
X-Received: by 2002:a54:4787:: with SMTP id o7mr6496342oic.113.1608400313506;
        Sat, 19 Dec 2020 09:51:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r15sm2498257oie.33.2020.12.19.09.51.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Dec 2020 09:51:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Dec 2020 09:51:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@kernel.org, joelaf@google.com,
        lokeshgidra@google.com, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mremap - Fix extent calculation
Message-ID: <20201219175151.GA6542@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 05:04:33PM +0000, Kalesh Singh wrote:
> When `next < old_addr`, `next - old_addr` arithmetic underflows
> causing `extent` to be incorrect.
> 
> Make `extent` the smaller of `next - old_addr` or `old_end - old_addr`.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

This patch fixes the problem I had observed when booting 'parisc'
images.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  mm/mremap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index c5590afe7165..f554320281cc 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -358,7 +358,9 @@ static unsigned long get_extent(enum pgt_entry entry, unsigned long old_addr,
>  
>  	next = (old_addr + size) & mask;
>  	/* even if next overflowed, extent below will be ok */
> -	extent = (next > old_end) ? old_end - old_addr : next - old_addr;
> +	extent = next - old_addr;
> +	if (extent > old_end - old_addr)
> +		extent = old_end - old_addr;
>  	next = (new_addr + size) & mask;
>  	if (extent > next - new_addr)
>  		extent = next - new_addr;
> -- 
> 2.29.2.729.g45daf8777d-goog
> 
