Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FAC2AC1AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbgKIREK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgKIREK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:04:10 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522DEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 09:04:10 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c66so3019243pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5J0v6bYJRFruSxqa8B/xUWOyZVLxu8eMyj5FJF6bRVw=;
        b=La3X2XjEh27SKUdGlM3dY+15XxIJ12A2EhoqdA6Cf++BfrQcNVAMNNH/YKBLl7SxFo
         CA0QRztgRermwL2G5d8XYXrPzK+5MtgXEFAeDVcovX8hPkAxI/iKrDEX7d+gobWO/swa
         eG94SkVrRkZ+B2aFLaB/PTbSSxFX3x2jOy4rakuwIklUnt6tpnODSBXK+qeoWVugsqk9
         iIF/+fBfcLMOXG4AMELJQXkVLpyuNvytHbNOKVn/fYD4QqivUJYdPJn8GkoAzQtPFQ3m
         DZuRmqzR9uxj/4AKwHsVl4mGrU+5CS+e5AVvYlh7PH3JFQZBz/ZmtWzpJoNVdT66l+B2
         9Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5J0v6bYJRFruSxqa8B/xUWOyZVLxu8eMyj5FJF6bRVw=;
        b=Yp6hByfjakDsjCZvv0XN9LhC/8y3Wmo1FGlIxipnp2MPYP4g/tQUd8UhcZfZaI+PxK
         /P3GqBvUQSQeJgTySjl6uc08oSXyhDHcuLCbTMhmQR1Zo5b1rCcdybvbaqFajEOaRMft
         9L95e4JCizu0lqERhP9hyyMYZB32sE2wORxeuI7BSmr1KjkUB42VbMmEkGz81CODlO2y
         pBhhT7Ef/o0j+3ZNJN48nIK8osyMMMGrW1ORGNOge3ipz9W0SpCNZJ+mK5nrXRIBYJ7U
         xw294JaT/x5fmJjLeAcR4whdBmE/j/wMwrVJzxBpDcqd762kr+n+DvrIcvGPTa+/5J1F
         JvKA==
X-Gm-Message-State: AOAM532M7Cek4Tykr0Hg9cFq36Qbiliu2Jdb98aOGbwZYEj0WUw4WJhg
        MiZ02jTwAfGnFCfZmMhF+UQesPaH1uI=
X-Google-Smtp-Source: ABdhPJxJsXSvztuBojD20E401zZWP3yWEanGUUSL9+d21jdXmhNOBYgLyZMmhcakcssRabiCA2i48A==
X-Received: by 2002:a62:e914:0:b029:174:77ea:4881 with SMTP id j20-20020a62e9140000b029017477ea4881mr14373874pfh.69.1604941449844;
        Mon, 09 Nov 2020 09:04:09 -0800 (PST)
Received: from google.com (c-67-188-94-199.hsd1.ca.comcast.net. [67.188.94.199])
        by smtp.gmail.com with ESMTPSA id b13sm11356363pfi.185.2020.11.09.09.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:04:08 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 9 Nov 2020 09:04:06 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Andrew Morton <akpm@linux-foundation.org>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, sjenning@linux.vnet.ibm.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
Message-ID: <20201109170406.GC449970@google.com>
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201107165645.1b139b595b6b64feaca61bcb@linux-foundation.org>
 <fb776accd14ddb5ec1251a6147a2ff45@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb776accd14ddb5ec1251a6147a2ff45@agner.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 02:16:37AM +0100, Stefan Agner wrote:
> On 2020-11-08 01:56, Andrew Morton wrote:
> > On Sat,  7 Nov 2020 16:22:06 +0100 Stefan Agner <stefan@agner.ch> wrote:
> > 
> >> Most architectures define MAX_PHYSMEM_BITS in asm/sparsemem.h and don't
> >> include it in asm/pgtable.h. Include asm/sparsemem.h directly to get
> >> the MAX_PHYSMEM_BITS define on all architectures.
> >>
> >> This fixes a crash when accessing zram on 32-bit ARM platform with LPAE and
> >> more than 4GB of memory:
> >>   Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > 
> > Mysterious.  Presumably without this include, some compilation unit is
> > picking up the wrong value of MAX_PHYSMEM_BITS?  But I couldn't
> > actually see where/how this occurs.  Can you please explain further?
> 
> Not sure if I got that right, but from what I understand if
> MAX_PHYSMEM_BITS is not set in mm/zsmalloc.c it will set
> MAX_PHYSMEM_BITS to BITS_PER_LONG. And this is 32-bit, too short when
> LPAE is in use...

True. It's headache in the zsmalloc.
Somedays I'd really like to fix it via redesigning of metadata
management.

Thanks for the fixing the ancient bug, Stefan.
