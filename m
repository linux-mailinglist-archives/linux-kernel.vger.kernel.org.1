Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DF02F1A79
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbhAKQJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbhAKQJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:09:07 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3703C061786;
        Mon, 11 Jan 2021 08:08:26 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id d203so20678279oia.0;
        Mon, 11 Jan 2021 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/YOqvpiTVL662Hepssj8vJdOMVdXcftTrsd30jyzSVo=;
        b=X7tgxB6yDUKuDb9mVNX12KgefcJACkw5OMYWUO+CpS0+1VX7njt3cjjslREW51qyTS
         1ixwpLIOgUzbd8/0CfFHkNDtXBj3RYmxFsEiihR7yZEEG27+ZEBxI9RqicKhGz9ha6fM
         Je74eepw4O8O2q63DJvPmiTIDROBOeXMcibu23c77JOvviN68jofmODCPTq7KCEaY3GT
         VRLX1I/UvV//2870PaJZ4M7cLs14FQ7rUNmTdOTwwWOiP2t+Gy9Capao8xETef4qeLNB
         LRURF+IWnv5GOOyqmR98rbLSLH5nrFPLgPQKUh70YRIEg4jjsUYrXkbS+EdYdzZeNxom
         8A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/YOqvpiTVL662Hepssj8vJdOMVdXcftTrsd30jyzSVo=;
        b=rLLCtkr6ZULq5W652lohvs1GjQd/0y8j+2We0qsSmZ9YQXGfkyBK/81V3ySbFo2Dp1
         QHEhSQgHVmru9mbzDYrZQMSLvMx3Xy5IEDcn7GOiaUlXDrNCNOguLkNh25/9PbT1WJ5P
         eYgJxUmHhQxfNLQ1oHx2jM3ZXQVMPjyWCuC6JcYFgXMAaIIeRjWabVSkDKbcva4utlvs
         6mkkQy8g46W01LfT5n1vNK4XnCcuJSVVqTml0DPer9wGPoDSTGihTc9SFq4DjwZEp1zW
         OKVI6As0qRg7o65wtChH7lGxt2pNlk54pg93nKhS0vYdUxfIlXP+i+MP2pmYiVvSzyXO
         HOvA==
X-Gm-Message-State: AOAM530WIr5Y3P6WyiEGAyNaCVdx0qJ1eRc3f0dJfPYOa+a8sXTuQHSf
        GwK33XuoJGoPbP4s7r0LhPS2VUO+5OEUwumXKgw=
X-Google-Smtp-Source: ABdhPJz9ubzcMQ0bhYd3SCX3r+gDygi5EmdKEP3E0TwUheIMmT2Xnf9EqL8wN+RBk/OHqN+D+C5I+SjgyZ/yccDcSDc=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr43764oib.123.1610381306350;
 Mon, 11 Jan 2021 08:08:26 -0800 (PST)
MIME-Version: 1.0
References: <20210111084640.28500-1-lukas.bulwahn@gmail.com> <MW3PR12MB45540B2E1C07A2A666D4A938F9AB0@MW3PR12MB4554.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB45540B2E1C07A2A666D4A938F9AB0@MW3PR12MB4554.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Jan 2021 11:08:15 -0500
Message-ID: <CADnq5_OswDHBTHrGJUR58WphBvi5sS7uBcCj5uyBVgweA1tHpA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: tweak the kerneldoc for active_vblank_irq_count
To:     "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jan 11, 2021 at 10:54 AM Lakha, Bhawanpreet
<Bhawanpreet.Lakha@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Thanks,
>
> Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ________________________________
> From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Sent: January 11, 2021 3:46 AM
> To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Kazlauskas, Nicholas =
<Nicholas.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.co=
m>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
> Cc: dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; li=
nux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-doc@vger.k=
ernel.org <linux-doc@vger.kernel.org>; kernel-janitors@vger.kernel.org <ker=
nel-janitors@vger.kernel.org>; Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Subject: [PATCH -next] drm/amd/display: tweak the kerneldoc for active_vb=
lank_irq_count
>
> Commit 71338cb4a7c2 ("drm/amd/display: enable idle optimizations for linu=
x
> (MALL stutter)") adds active_vblank_irq_count to amdgpu_display_manager
> in ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h.
>
> The kerneldoc is incorrectly formatted, and make htmldocs warns:
>
>   ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:
>     340: warning: Incorrect use of kernel-doc format:          * @active_=
vblank_irq_count
>     379: warning: Function parameter or member 'active_vblank_irq_count' =
not described in 'amdgpu_display_manager'
>
> Tweak the kerneldoc for active_vblank_irq_count.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies on amdgpu's -next and next-20210111
>
> Bhawanpreet, Nick, please review and ack.
>
> Alex, Christian, please pick on top of the commit above.
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index f084e2fc9569..5ee1b766884e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -337,7 +337,7 @@ struct amdgpu_display_manager {
>          const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
>
>          /**
> -        * @active_vblank_irq_count
> +        * @active_vblank_irq_count:
>           *
>           * number of currently active vblank irqs
>           */
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
