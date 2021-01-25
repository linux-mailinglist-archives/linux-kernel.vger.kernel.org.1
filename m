Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AF93021D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 06:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbhAYF3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 00:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAYF33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 00:29:29 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37636C061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 21:28:48 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f2so8577030ljp.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 21:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sz3SySkIkX6Vb8I4Q0a7jSbUCKhB1+secykTFRzzKtI=;
        b=Gj4snBeO76j2dDQRt28WI+I9dAXUMGYNe27LC7g6OG3HihpFaYych+IQ19UvXMe658
         p0B7r24G3/3GdEVoUVGmBQb1ZI3s+mhwEOKtCSAB0T2tM2C0627On3BOSNUTNpsmSWMP
         B7TVKauTd8DQYDPWtsVIsAc+eu2TARXwfE2czvPHLSHHWHY6GZ9+/1CZSKhw+tOK2Y2t
         4FrXScLkJH8AzCFMl7PMrRneGqw5W1m8a1gjPRbG61obTOvHSJ2VklfjB0DV4fmIGxuo
         PfDj8NG5FI7WQ9pJfthm3wPGzrVM4kKJoI9oP2vEeaJSq7steTor6eevTOeLDs6HJg5K
         SeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sz3SySkIkX6Vb8I4Q0a7jSbUCKhB1+secykTFRzzKtI=;
        b=CUBfY+x6F4keIVLl2HhjwUzFKCqipdkpl+P29XSdydnklyOvrQ8QxDezA3QTKU7L1c
         oPcsxEp9DOhJVsOAyHfXCzoRf4dhX8/qj3Fk0J0B9o0/qc+V5iweryMT0iKk2kAx1ppy
         +P7RJALzI3AUkvV1Q5lI70JKbkRplEZMId5zqny9sZvoWw3GvF5G1pg402uQx18h+Ily
         hhW3yjDt7p2mo6CyYnAC1CHaCLK8nC/DzVfeeauiu+HlhiyYUW0ciRgt/tfBWseNsF5n
         09UBSnU0FvQ1oiPkArEg4I3oUk5sJGKfvSZwNNAX50QtJbLG2b3ZKybWPZiV9jNMHzFD
         mPqw==
X-Gm-Message-State: AOAM5309zOvIhY1nd5vyk90TU2OI8RfXmecsHLYvBZwzUWTvAPv2Enav
        GrlOcxc+gmIVlDA1k/sVIbCXG2v/zjNSlXQ+q3c=
X-Google-Smtp-Source: ABdhPJysNmZ0/gm8z1KXdAG7NN3Zmd5z+IUCc/5XbMx2SgxNFc1Olkpu6mFbiKn2ht3KVU2FYwwcpzJEWUS3g1mfPrA=
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr685564ljo.52.1611552526684;
 Sun, 24 Jan 2021 21:28:46 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
 <816e944c-72bc-d94d-449f-bfb915382290@amd.com> <6e55d84c-7b9a-167c-34cf-9e980f8e2354@amd.com>
 <CABXGCsM8yYNz7gQW26a4hHwBR+MunXoopHEiyDJdC-muNrRxkQ@mail.gmail.com>
 <77b696b9-3248-d329-4f7d-5e27a21eabff@amd.com> <CABXGCsOcBMT4rL-bb4K_TzK70YmQsgNX37sHEHiqp_1kK1_UEQ@mail.gmail.com>
 <5f9e7752-68e8-aa5f-80ff-bb1196ea458d@amd.com> <CABXGCsP4KFFeSMLovCPV2yw17Pm9ovzwV5gp3CaQ9vUwx=Y-TA@mail.gmail.com>
 <CABXGCsM85uYEM0fKs5fubj9Lf=xM8oa5QzteVbKJr1eDWsk0wA@mail.gmail.com> <bb671243-7031-31ff-c6c3-dc1e4192ef71@amd.com>
In-Reply-To: <bb671243-7031-31ff-c6c3-dc1e4192ef71@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 25 Jan 2021 10:28:35 +0500
Message-ID: <CABXGCsOhn_2xg=HcZ3b=nuWhmBGF5Xz7WuLHORVZ-DV=eZQTPQ@mail.gmail.com>
Subject: Re: [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
 framebuffer with error -12
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 at 18:27, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> I still have no idea what's going on here.
>
> The KASAN messages from the DC code are completely unrelated.
>
> Please add the full dmesg to your bug report.
>

I did it.
https://gitlab.freedesktop.org/drm/amd/-/issues/1439#note_776267

--=20
Best Regards,
Mike Gavrilov.
