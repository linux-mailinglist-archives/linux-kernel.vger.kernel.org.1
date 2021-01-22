Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205593001C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbhAVLlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbhAVLi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:38:59 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C0BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 03:38:07 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id e15so2830413vsa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 03:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZYhrKDX05Fu4IUqaFcdjZRq+8CY91wL8jDh2Z/MV/4=;
        b=MBcNG9z2Hb6WAwrB1JN1d/worvVz5QR1zriYc7K+lrE0Pagjjlhwh6irlilxTfAj4U
         8fM7xzRz5It8hDg1naGFuiT9o8y4iLcRd983YYTzU8b0SmTya/AyI+Sd3Cu4fghq4eyq
         jJ1zjF45KEgIWTRsLEqUYUYSKgJcG2znQU9J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZYhrKDX05Fu4IUqaFcdjZRq+8CY91wL8jDh2Z/MV/4=;
        b=asGGM6rJD/4vcj8cXOlNFsJ54IG8eisirQ82q2sS6iSZ3cAyDLgrLpp492Q8dMkH8p
         GkkfKxTyZ2lBuwtUzBq7XRoCTBJHX1tnUjAOEmWP/JqHk9EEkz2OiqzzeB0yLOaVt3fr
         OSS9RcoZjsnd0qCGdXHV1KcJ3N3ZrvtMQplEtDQ4kG63pactbmJAHFFX+aBNhJ3IsOpX
         QRoYouzkDbhKmTP+izVkf7ur6ZMFcxp5u/I0WM13jm7/JC2oYF9ngKap3L7LgFO2I8Jw
         iA7mxfdB3BRuKWpRBgEZNqVCrtwMcsyXzlxuMTa5GZDE0Fws0mRjeQggxN31I7rM5x/E
         qhQQ==
X-Gm-Message-State: AOAM532ZluyMBI+ZHkA81knCbMdxMHd1WYFzz0AR8XIAlO800n25umnT
        12ekjiTXku9S1BiboZkSwqKPwAKvPBGLq6sM8czIrQ==
X-Google-Smtp-Source: ABdhPJwnSGP+Mc4rfj2dyutH+BQMdCvkEL0hJAvcSX8BjscWRzVzBA5KxCAPoLiuRRh5z9kJRXe8kNi8uo+d3p/nOSA=
X-Received: by 2002:a67:fb86:: with SMTP id n6mr12683vsr.0.1611315486301; Fri,
 22 Jan 2021 03:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20201222030626.181165-1-liangyan.peng@linux.alibaba.com>
 <20201222032633.GS3579531@ZenIV.linux.org.uk> <c9ca7e00-acfa-3718-8e0d-fc3b9df28f69@linux.alibaba.com>
In-Reply-To: <c9ca7e00-acfa-3718-8e0d-fc3b9df28f69@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 22 Jan 2021 12:37:55 +0100
Message-ID: <CAJfpegsbjDF9VyDnYpfoOJYqpPTm87up3_2Sux1xQUZRojbn3w@mail.gmail.com>
Subject: Re: [PATCH v4] ovl: fix dentry leak in ovl_get_redirect
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Liangyan <liangyan.peng@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 6:59 AM Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
>
> Hi Miklos,
>
> Any comments on this patch?

Queued for 5.11.  Thanks.

Miklos
