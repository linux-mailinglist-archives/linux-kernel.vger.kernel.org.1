Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899512D1F09
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 01:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgLHAem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 19:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgLHAem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:34:42 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4760C061749;
        Mon,  7 Dec 2020 16:34:01 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id l14so14637880ybq.3;
        Mon, 07 Dec 2020 16:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFsfxa4veOiibQTwIgedttH2AAFVaQePgM6gYJBZUiY=;
        b=HBycuVvcfuYQ/xmxoe6FqB+Vwa2mMMVbddnv/XaQdaMdYMJzVNUCfQhTdjsMuLUoKH
         GpEiWYUkaFuI+lzVKK7qtIJHYmTgtMsNIk+Zz+7PQ6QoEGe45EEUvV2towZ9fNCOxtcn
         VRpQvDlQ037KMEkKfq+UC5/9BmTAqaHN7Zln6arc1EqC/U5C4ASbtP5GBpiw50CmF3aX
         5HrQibHJyneik9T89gF/N6C+jfm1tlu5yQ6LRc0nXbTrdYgVeQbvRJX3HsY06Vf/RZ86
         ZTHaC8oWaDCjAkcypu/yfUfhdA19HQGrWiAToK8RVmGaUeaR5w0jpoIFrtqFZ9w/4pNv
         R+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFsfxa4veOiibQTwIgedttH2AAFVaQePgM6gYJBZUiY=;
        b=CxC+/2EvkCk3A4r9pZ1ZEbq+O+OsnF3ayoGpobA5FAplLE3cfJM9Jle5QWGi3fQVDI
         xaDJwqpmYlquWBH1oNoOAZRwR/6gp658vPKiwS4Ej/rgtdiREZBUWQrNi7q59QMmhGjP
         NGGYMZcESW5l9FJJBXjmSgPW1x1PX2YjAJp4oVEp3s1ru3dqnjxb6P0UVDHbrefsqd7g
         TNx+iotoIwz+XqpIybTdN16luqQlk+pvbungtiMGOq3sH8LE0WhBXFy9w4qCPvMJMayw
         prRu5xwUvdRqXzq/ZQrYnHTekFNRolB7s3nU4x4+UuNU5CQdRPARbS02YqCaD+YscV5p
         qjgg==
X-Gm-Message-State: AOAM5310iB4jp5K3ZhH37iXQ+RtSAnQkooCtirsuWXu+vGwCEvwh8HrT
        YsC6qdnmEQ1h/ZWsfeY1XoLETsPgYnOBmgKcB53EXvWT
X-Google-Smtp-Source: ABdhPJzfOVqA1C9kcUnkiaT1S285oFUkE5nP6dUSyilA/bf3umrqyQ1Izm5M1evR2jPTDmDYPn33B51I4jMEsnNcSRg=
X-Received: by 2002:a25:9d8d:: with SMTP id v13mr18779843ybp.81.1607387640927;
 Mon, 07 Dec 2020 16:34:00 -0800 (PST)
MIME-Version: 1.0
References: <CADxRZqwn0uUi+J3bN=uLYMpXYhcYpkQb68Vkgmg70Tn87mhzOw@mail.gmail.com>
In-Reply-To: <CADxRZqwn0uUi+J3bN=uLYMpXYhcYpkQb68Vkgmg70Tn87mhzOw@mail.gmail.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 8 Dec 2020 03:33:50 +0300
Message-ID: <CADxRZqyD1rYOtB8AEtLEhvuXc9-hKq0nLrMXZWNECk98GitiJQ@mail.gmail.com>
Subject: Re: [sparc64] current git kernel networking is broken
To:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     debian-sparc <debian-sparc@lists.debian.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 3:09 AM Anatoly Pugachev <matorola@gmail.com> wrote:
> bisected kernel to the following commit:
>
> linux-2.6$ git bisect good
> fdf8bee96f9aeaac4559725c2dfae6e1bd7b7043 is the first bad commit

forgot to add, that reverting this commit, fixes networking for me.
