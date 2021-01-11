Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717BE2F2237
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbhAKVwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbhAKVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:52:02 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DD6C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:51:21 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x20so180075lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DpKyJxgz/kDKF4w0QpSfkKSwc8QdmlZ1/wqnkxJFVtg=;
        b=J2gN7DigSzXMjR26SwttE56zrz3W7Z/uQLQTd9ukj6qbovk7M4cha2CVykXPj1z27E
         eM5WNGtPQiyxQQEKmXlxiEoeEcqT2JIle40AuTsIqVtaNzwYBYmlOpFxOLc6PegL8l+e
         AC1AFKVJLqrRIKamd5fVKlbC+3YMudrOf2/dzHCOrxJ7wQ/TO3tdoia8h7zQMdNUsjC/
         ATLgSLJBM+dKVo49BXA4Poqf5prCTuiTSLayZaSK5siCj0yrxG2m1HqVTOPb8RzZdmoH
         CeDzp7g+uCVQ/Hqlzm+rDvBDbg2tIrQH6hJ+yZp0tla1IxfLtU0xQrNQ6og+P5u+LgiY
         ItUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DpKyJxgz/kDKF4w0QpSfkKSwc8QdmlZ1/wqnkxJFVtg=;
        b=rPLwK+s3NYOIGTXLpYQKbVP4jb03pWvWi9P+YMYu5z3kcZ7vNKqwdMJPR/oXaDy1xh
         otYDGN6+bEHLQa7wITgSKbRRQGPgrqo11JZymP+Pz/Qnu9fdoyFb2B11DQbGRPJJIP7d
         0zMQ6hS2tZkcovYzHbvbCcCXkyNt+c8AADo0saAYyD7ZgFcV67ndGfOP1iRyPnmR2rLi
         dketVEbg05cHWh5hcbnlsMXCbMP9WeWm6J74dTEyGjbygXUqTn3zKTIeq5Yz9Vji9nr2
         /4CS8DcQUqVN4e8o5TzYFfo3VIdgP1jQFw6mMiYvcwu0hd8aMa4PsW2+cl7mgK19VHYY
         Hxfw==
X-Gm-Message-State: AOAM531so+9mBDN8HPdyrKBF/ZJys8O85+Ej9Jduet9w8CGORvZ8MbpD
        NTAS0YBLPzHU81tFlUtoaTSz98YMQW+F4X3AzaI=
X-Google-Smtp-Source: ABdhPJzc6UzGgMcUd8OAMsFVuBKMHsr4j4AmR+jXSc8W8Sqa3i89zVWlmMuvasJGl8v8499zHcSd/VQ1jl2hCeiQ9SU=
X-Received: by 2002:a19:cb45:: with SMTP id b66mr708982lfg.441.1610401879923;
 Mon, 11 Jan 2021 13:51:19 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
 <816e944c-72bc-d94d-449f-bfb915382290@amd.com> <6e55d84c-7b9a-167c-34cf-9e980f8e2354@amd.com>
 <CABXGCsM8yYNz7gQW26a4hHwBR+MunXoopHEiyDJdC-muNrRxkQ@mail.gmail.com> <77b696b9-3248-d329-4f7d-5e27a21eabff@amd.com>
In-Reply-To: <77b696b9-3248-d329-4f7d-5e27a21eabff@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 12 Jan 2021 02:51:08 +0500
Message-ID: <CABXGCsMYkKrrTw3DTPJjLq+6oQnyXATCYi0DbqkO_UuYjvJjLg@mail.gmail.com>
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

Hi Christian,

On Tue, 12 Jan 2021 at 01:45, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Hi Mike,
>
> Unfortunately not, that's DC stuff. Easiest is to assign this as a bug
> tracker to our DC team.
Ok

> At least some progress. Any objections that I add your e-mail address as
> tested-by tag?
Yes, feel free add me.

> I can take a look at this one here. Looks like some missing error
> handling when allocating memory.
> Can you decode to which line number ttm_tt_swapin+0x34 points to?
$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname
-r`/kernel/drivers/gpu/drm/ttm/ttm.ko.debug ttm_tt_swapin+0x34
ttm_tt_swapin+0x34/0xd0:
mapping_gfp_mask at
/usr/src/debug/kernel-20210108gitf5e6c330254a/linux-5.11.0-0.rc2.20210108gi=
tf5e6c330254a.120.fc34.x86_64/./include/linux/pagemap.h:105
(discriminator 2)
(inlined by) ttm_tt_swapin at
/usr/src/debug/kernel-20210108gitf5e6c330254a/linux-5.11.0-0.rc2.20210108gi=
tf5e6c330254a.120.fc34.x86_64/drivers/gpu/drm/ttm/ttm_tt.c:210
(discriminator 2)

$ cat -s -n /usr/src/debug/kernel-20210108gitf5e6c330254a/linux-5.11.0-0.rc=
2.20210108gitf5e6c330254a.120.fc34.x86_64/drivers/gpu/drm/ttm/ttm_tt.c
| head -220 | tail -20
   201      struct page *from_page;
   202      struct page *to_page;
   203      gfp_t gfp_mask;
   204      int i, ret;
   205
   206      swap_storage =3D ttm->swap_storage;
   207      BUG_ON(swap_storage =3D=3D NULL);
   208
   209      swap_space =3D swap_storage->f_mapping;
   210      gfp_mask =3D mapping_gfp_mask(swap_space);
   211
   212      for (i =3D 0; i < ttm->num_pages; ++i) {
   213          from_page =3D shmem_read_mapping_page_gfp(swap_space, i,
   214                              gfp_mask);
   215          if (IS_ERR(from_page)) {
   216              ret =3D PTR_ERR(from_page);
   217              goto out_err;
   218          }
   219          to_page =3D ttm->pages[i];
   220          if (unlikely(to_page =3D=3D NULL)) {

> Please use this one here:
> https://gitlab.freedesktop.org/drm/amd/-/issues/new
>
> If you can't find the DC guys of hand in the assignee list just assign
> to me and I will forward.
https://gitlab.freedesktop.org/drm/amd/-/issues/1439
Ok, let's continue there.

--
Best Regards,
Mike Gavrilov.
