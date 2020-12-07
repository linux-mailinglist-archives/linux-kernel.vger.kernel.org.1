Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43932D1B3E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgLGUtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgLGUtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:49:03 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3493C061257
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 12:48:21 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id t22so16594906ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 12:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afeBzrAkz5BwizCHeAJgvDbsOemFkWApafPEH+e5coo=;
        b=MvYUbDa0VUimGq7DOGdUVu7dwP7LEF2c3QsAWimh87QwX6Nv62K9zLhFFVLn9qBZac
         SPFcpd1egvO5SmP1TWr17dth5GA8Xk9bwLt62acxeqFQkA7Ma/6fAj+4oKYPHChpgFAc
         6XXBxW93B3u11eAa8Sr/erm+EJuO63LFruir3fMCB/telhLRjG+3w+lzyEwcS0auKbme
         g7aVUrv10BGIV8btAjzhMMOUft24h7/jP4KOqscuqXZ6gcLw8+PftjN7G5T4aE7WfFs8
         JiCkYcIWL+nY1SOW0pH1lKeUDGsURRRIWavwwOR9ZiiHw/pQiCWHXayr1KMAs61R1dDC
         CczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afeBzrAkz5BwizCHeAJgvDbsOemFkWApafPEH+e5coo=;
        b=GD8aJsY/cdVrkzEeum+4n3mFoKPoLBm/birDcDe4zCEQII9Olzv5KHIJAzRz2Pojyw
         zG4YbgNiZnIeuYyqHlB+yT6jBKJudDGtFuRbYkaAE56fNyBGCm1kP2CrPrV+p7AKOaac
         3Uqes9woa47EOmDY2UlMNSlnnPFSttOorbbQq0RTrgwmVQeONy/J6/j07VGxyHHdBbj/
         asd//wFss8mtiz34Wh6x9Ps6g6ESmtfWzTC1VlUCVuSRw0EFoR0fqES9cyFgtcLWzECq
         W5583FaAKtTk7Qjzlm9GVg19XL2bQbvwIy8SF3IQUa1OXVClKRKPI9k+Ufl/bRi2pTbW
         XzsQ==
X-Gm-Message-State: AOAM532sFEzSrfHiq5rrijzSQPb8oelmyt6bQBPeCRlKM3UX9kAlpBdq
        yYMjBRBpMaKWrV7Ezb0qzJF2e8bgPL7Qhqp2Y0I=
X-Google-Smtp-Source: ABdhPJwTkr+9lK2EQYVg4JAu6qvcY0ivTKIzhAQQRziBGRp+n2S9E83RzY48r1SabrKZFJZwphmIcgtUl5P2VwiF/sI=
X-Received: by 2002:a2e:9747:: with SMTP id f7mr3313388ljj.262.1607374100396;
 Mon, 07 Dec 2020 12:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20201207133024.16621-1-jgross@suse.com> <20201207133024.16621-3-jgross@suse.com>
In-Reply-To: <20201207133024.16621-3-jgross@suse.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Mon, 7 Dec 2020 15:48:09 -0500
Message-ID: <CAKf6xpuqdY=TctOjNsnTTexeBpkV+HMkOHFsAd4vxUudBpxizA@mail.gmail.com>
Subject: Re: [PATCH 2/2] xen: don't use page->lru for ZONE_DEVICE memory
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 8:30 AM Juergen Gross <jgross@suse.com> wrote:
>
> Commit 9e2369c06c8a18 ("xen: add helpers to allocate unpopulated
> memory") introduced usage of ZONE_DEVICE memory for foreign memory
> mappings.
>
> Unfortunately this collides with using page->lru for Xen backend
> private page caches.
>
> Fix that by using page->zone_device_data instead.
>
> Fixes: 9e2369c06c8a18 ("xen: add helpers to allocate unpopulated memory")
> Signed-off-by: Juergen Gross <jgross@suse.com>

Would it make sense to add BUG_ON(is_zone_device_page(page)) and the
opposite as appropriate to cache_enq?  Either way:
Reviewed-by: Jason Andryuk <jandryuk@gmail.com>
