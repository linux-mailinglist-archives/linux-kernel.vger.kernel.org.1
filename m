Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653A030403C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405658AbhAZO0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392439AbhAZOYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:24:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74FAC0611BD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:23:25 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a14so8645279edu.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1czbBZLLxHwEsDj/a0a94VF0yBz3u23rkRDZfhlmeos=;
        b=nyCAT2ReufMhKUDlIx0rQQya1EhvNd3CAXYn6nE2QL4Vmc6395uy5mK+D+jGDLbH8z
         YBTHMXZ5OTYvLZQCey/ax2VfTRjckHrVObU3ETyQjToqgDfw4if7zzGcu1bFvjVsLdLT
         F4gzk6kKy+eZ2ZD6f+6CMfR+xgdho8L/8V2tlsFkR6eehlqnDN5KeIm2DzPp7oGr46TA
         I1QpUnH2hx6ubfWT7ZKBTQ13Ru+n+hkvKoz317kqYa32yGBC2jDOOm4nFn9neiUgZb6E
         n4mwe9IXjh/CKhqAes1aQMDcP5JYr8mrKYekaWRrWhxbJQXU9qlhVaUOoSQLVgeLluAG
         GjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1czbBZLLxHwEsDj/a0a94VF0yBz3u23rkRDZfhlmeos=;
        b=dk7JmKqUwGdEG8VAEvyrWAbAnaZEZEioHYqInbN4r/B6fE8fKz7RV/6ya1QAZZ6Cd6
         8SzocG9bGlkzwyCZd42T5EePCvBJs0CxcKXeAZ7+YhA00qEWOKt0C2xW3Uc89m1ROSpt
         L6al/ngHFskYz4dBnepZCOKo1dw/BiVwxn6O3+1urcFoEu4HzBXo6SzfbIEA1cZb3E9v
         9rDN8qI+ICvE0q15zGvcBkNCmMO8Yt3tckR/Fh9unU1cOKxeyc+zSZwiXzk+mWEEeDqq
         EyLyrePo0sbxMlneQcxBzbfFuOJCHGSQRHRyftD7WTKS2SeeaE5NEdGFSl/ex1wO+DoT
         o2Cg==
X-Gm-Message-State: AOAM531MBOdDoprcVmqDPOJAAUuu/3oUpCg4oirZ6ovQJPsJnwNdoWZY
        lJLlaXWy5xUsYtDuVNoJ07Bclv+zv2oYVNZ5LSNwdg==
X-Google-Smtp-Source: ABdhPJxP3v2LeM908ihblFdyCJ83JaTf4lsLhbskKLoinjZa37ZibxDpo5jfrONK2pUpfuITkUtYiA+FbDR8mmfbk/0=
X-Received: by 2002:a05:6402:3508:: with SMTP id b8mr4815634edd.341.1611671004588;
 Tue, 26 Jan 2021 06:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20210125201156.1330164-1-pasha.tatashin@soleen.com>
 <20210125201156.1330164-2-pasha.tatashin@soleen.com> <YA/fwFU+Wg6+jr85@pevik>
In-Reply-To: <YA/fwFU+Wg6+jr85@pevik>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 26 Jan 2021 09:22:48 -0500
Message-ID: <CA+CK2bBVdVOP6TmJED4Wndovxf+dGbcbw=0LQ8neAGL_2=TEwA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] loop: scale loop device by introducing per device lock
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>, lukas.bulwahn@gmail.com,
        hch@lst.de, ming.lei@redhat.com, mzxreary@0pointer.de,
        mcgrof@kernel.org, zhengbin13@huawei.com, maco@android.com,
        Colin King <colin.king@canonical.com>, evgreen@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 4:24 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi,
>
> > Currently, loop device has only one global lock:
> > loop_ctl_mutex.
>
> > This becomes hot in scenarios where many loop devices are used.
>
> > Scale it by introducing per-device lock: lo_mutex that protects the
> > fields in struct loop_device. Keep loop_ctl_mutex to protect global
> > data such as loop_index_idr, loop_lookup, loop_add.
>
> > Lock ordering: loop_ctl_mutex > lo_mutex.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thank you for reviewing this patch.

Pasha
