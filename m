Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D532F559B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 01:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbhANAc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 19:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbhANAX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:23:56 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1502C061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:22:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m12so5474083lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NHx6cOmF9H+3oeO1NzvO+G1sr0qFE9WCAeIZ2WKr5OU=;
        b=jqmVgsX8RTXFXONNRRKx1wmvRnXZD1l3Vtt86Gw+2x7IRb+4doLuwHA88sH/CCCncj
         bQ/Mlgvi3V8K6FaQpkeyKaDBYFT5mWkhy5Ngvy64/RSftsDtzB5sbxAD7rQDBw2NiAC2
         Jnv+cGp4ZX30zFXssT0dafcrayXtJFtTk/17B2JXedwSByA6n8+YFz5JlEUBPR5sb9jt
         QJh3pWEiRxWXnywzSEILVOBZWg2dB5+lCPRQHbwlYKGutIFfTKzeA/jnFUKH126GHGmR
         ngpQQf44Q478cxtCIgrJBPvujAGp92VUVdUbCdCKl1YvzYy0aVdeP1w41Sua8L+trVSN
         5LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NHx6cOmF9H+3oeO1NzvO+G1sr0qFE9WCAeIZ2WKr5OU=;
        b=R/rKUTJvSGKn07OvsGVoJbRoKhjeQFl7Tjay6eaF9K+DlPsXHjuEXSqsUzykZhVC8t
         qD9H7uekGbwsJsUhqcEZrFY63uj7fgonh4na4I5A1j0yPe1UpsEYhj4x6BFoBg1osHxh
         Ey8TRA6+epzlWAMCxGqFYXSmQJCvHTNfe30aiWgl0tBC3YSzZdyXz/I9XXTYvBgMWQHr
         Z7cgAf3A+N7Q97OoOAq5hsAFh5Tj/ZZoPYomeT5HSlEbHGTkB3OL3q9D5Zz5YOyneNNj
         DJGqEFT6t/vhOb4CbX1KZKru6yAdNHBQPPNjqw9Ct3+GgI37UQoUz2B6u9dyLJlJ9P7i
         DETg==
X-Gm-Message-State: AOAM532cA62cWIFJDmxKkwXiGgrEKXHqfn+oo39COvkUgoXFjK8I0OXp
        uhEmOZmTRr6tMDtRTn6ZPJt4bxU3Hwqf2Rc590xM/jyPVgCUDg==
X-Google-Smtp-Source: ABdhPJzKKKsjj7+sy2+hHoOsiI3jtp9uH+slbZWSLs368X4wm/8gU+UlmI/1PznIcmVxxOsLXWe54p30Xw400YlQE9k=
X-Received: by 2002:a19:890b:: with SMTP id l11mr2024934lfd.66.1610583770239;
 Wed, 13 Jan 2021 16:22:50 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
 <816e944c-72bc-d94d-449f-bfb915382290@amd.com> <6e55d84c-7b9a-167c-34cf-9e980f8e2354@amd.com>
 <CABXGCsM8yYNz7gQW26a4hHwBR+MunXoopHEiyDJdC-muNrRxkQ@mail.gmail.com> <77b696b9-3248-d329-4f7d-5e27a21eabff@amd.com>
In-Reply-To: <77b696b9-3248-d329-4f7d-5e27a21eabff@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 14 Jan 2021 05:22:37 +0500
Message-ID: <CABXGCsOcBMT4rL-bb4K_TzK70YmQsgNX37sHEHiqp_1kK1_UEQ@mail.gmail.com>
Subject: Re: [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
 framebuffer with error -12
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 at 01:45, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> But what you have in your logs so far are only unrelated symptoms, the
> root of the problem is that somebody is leaking memory.
>
> What you could do as well is to try to enable kmemleak

I captured some memleaks.
Do they contain any useful information?

[1] https://pastebin.com/n0FE7Hsu
[2] https://pastebin.com/MUX55L1k
[3] https://pastebin.com/a3FT7DVG
[4] https://pastebin.com/1ALvJKz7

--
Best Regards,
Mike Gavrilov.
