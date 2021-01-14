Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DAE2F60BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbhANMHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbhANMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:07:34 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC7C061573
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 04:06:48 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id c22so3620141pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 04:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fiog8H9JHWxwErQLGQMdS+ArsaltJnopljT7s4Ik8ZY=;
        b=dSKR9NXV6e4vAA84G+WrEZGoalt5AvNiG2hWr9G4Jpz+QTBRFH43ipDIRgBSHne2bq
         1N92dzCciyXu0xYGOfxE2kGYGAr1DuWwj8bHjO1+DbO43rliyKHsEc1qUZVUF0q6a6MM
         iayCuW4YtQTqRCkHhLM5oCHby5ns5fRoechKwIMRDSF+yyIXxFs/gq/J1hc74Hpr3TI/
         e63zjkZNfPIQjjD0U3mvNsyxTc8pjpFy8xWZzsMrmpW1AbMfy/vgph3XHWpk5q+EoFhv
         NMzXuliIVAbGeQT078LWx2Tfq6rVd4Bbb/pvEPrjja8AOOsH9LBFD/YYkDaUnTOIB3Re
         Ofbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fiog8H9JHWxwErQLGQMdS+ArsaltJnopljT7s4Ik8ZY=;
        b=lCCn1wvy79wOt8A96UsrjZ4sa72yu81wsATVkQY9IYi71zqMwNbNAcs4VHioSnGL81
         dUAt2O0IW5R0W/FMdU6AUNOUN0vDOGl9mYX4IyuO53xJ/FhgjPx0lkfV6+9c5rucu1Ys
         8CLrXg2FxmIGRPwf/0cIdFU7UXYALe4kbzv7ecsZDgDUtqW8IP1/W0EIZBrJVHlxLPSQ
         YJJqqHgioKayxuciPXKQePdQEowy+rCH3zI8z2wkbvAD0BQA/O3Fnch4fx7HP2bcNOQf
         p6AZwpsa7quA+0TAYVTG8V9PhwkG6vjbdqi6NMaWKks3qw0lC5N8LiuZWq5iiFPKMR9f
         8Bgg==
X-Gm-Message-State: AOAM530wsrpnk9OQSzb/tuDBZhniojJbDmj58OPv0MZamSBFMYhyJAEA
        q3FkUsJwoK3j/3SpQNe2XYw=
X-Google-Smtp-Source: ABdhPJypylW31RdX/EJS4vcF0cxZvR9NQTQx0++6oQldJi//IJ2iyAgFSPt7C90mXzyN1nlD/iBo4w==
X-Received: by 2002:a63:1863:: with SMTP id 35mr7370323pgy.191.1610626007597;
        Thu, 14 Jan 2021 04:06:47 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id u25sm5040630pfn.101.2021.01.14.04.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 04:06:46 -0800 (PST)
Date:   Thu, 14 Jan 2021 21:06:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zsmalloc.c: Convert to use kmem_cache_zalloc in
 cache_alloc_zspage()
Message-ID: <YAAz0/nc/Pl2OIW1@jagdpanzerIV.localdomain>
References: <20210114120032.25885-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114120032.25885-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/14 07:00), Miaohe Lin wrote:
>
> We always memset the zspage allocated via cache_alloc_zspage. So it's more
> convenient to use kmem_cache_zalloc in cache_alloc_zspage than caller do it
> manually.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
