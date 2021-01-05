Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C439C2EA143
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 01:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbhAEAFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 19:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbhAEAFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:05:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA809C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 16:04:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h205so68589192lfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 16:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RIAu8uS5feNbhsyipiwLYRptnpa/P53/nDDHuTAmANU=;
        b=Bg9iEFVIyFaOS5eu9+24tFOHTVbPYXmXuPa8fLOxoTJNvzX7lxDPyZ8FAgHgcuxGaB
         rNhgDMM2EisQbSa2Aj0W4NSs3lhHF6a74Ql9LVu/WjaiGVHd7gE92eQZ0c/CRKtu4JzJ
         t/mD5T/ww180To3bcVRi1WuBNjyUSBRo97HViY0FMmvBtDXhlUIIrTy/XTGz3fIwFHkK
         kHiEZC0MaxBAUF8ROHsWr7rD5NvAzo4FTMeU+gGGXMJmHuv8bjr4kABJUaH6RTCw5DHh
         /9K7UvN+ot87vJi5tatgaZ6zBm8NK9C6k3l1aHFojaY0KShox6iK0tzjrdDt0ysO/eRQ
         41Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RIAu8uS5feNbhsyipiwLYRptnpa/P53/nDDHuTAmANU=;
        b=egID+kh7l0rmgWZKw3lsLxCtUuMV39rxuyd+ZyJHm46lBZEr1NJKzc32gcSVFvk+aO
         K74Xg10R+VT+djQPavWiY4M7TcY1D1PHm4eGinhs0Hp5oYeBLDHUyoPwm5bcMWEexKGk
         UhM7Wa5nVKTEROIdnMz72NSWa8Mx+p5otzNfFYsPtLC3DOU4jLCzoRXY0veDkNX+XuQE
         2lJwZpTOWGlmy3lGpXIHnobHDzdp66tQkf68qtx3FBMlfPURGeTYyDTD2g9snaJkVXn5
         r/iYviCo4+yhjUcRTpPSUndZcKvpthxjg2XP3XXVPkGPQErBwUI7o2rMzKfybNt2JLWP
         MZIA==
X-Gm-Message-State: AOAM531CkkorPdF+Bf2u5wUdxnzcLzER53uhO9aP+XadJTWmUk9kE2B3
        rl2O59uTbfB+bBTEEQI7HkvFqRpYbswdX8ohtQE=
X-Google-Smtp-Source: ABdhPJzCBtNw3KUV+mj0Gs5HT7pcbktTyblGdVU5raqwsE0oZINcZDbSwiY7ga3F3OiSvTBdo312EebrkCkPF+R6x98=
X-Received: by 2002:a19:301:: with SMTP id 1mr31231450lfd.67.1609805081256;
 Mon, 04 Jan 2021 16:04:41 -0800 (PST)
MIME-Version: 1.0
References: <1acf4202-e5e6-f3fb-73c3-11bc965d3058@canonical.com>
In-Reply-To: <1acf4202-e5e6-f3fb-73c3-11bc965d3058@canonical.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 5 Jan 2021 09:04:30 +0900
Message-ID: <CACOAw_zqsY9u4t5zhh+yk-bNVVhZS2J3f6fyOX78tZBc19JeBg@mail.gmail.com>
Subject: Re: [f2fs-dev] f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Daeho Jeong <daehojeong@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Thanks for notifying me. We need to just continue without
set_page_dirty() and f2fs_put_page().

2021=EB=85=84 1=EC=9B=94 4=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 11:43, C=
olin Ian King <colin.king@canonical.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> Hi,
>
> Static analysis using Coverity has detected a potential null pointer
> dereference after a null check in the following commit:
>
> commit 5fdb322ff2c2b4ad519f490dcb7ebb96c5439af7
> Author: Daeho Jeong <daehojeong@google.com>
> Date:   Thu Dec 3 15:56:15 2020 +0900
>
>     f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
>
> The analysis is as follows:
>
> 4025 static int redirty_blocks(struct inode *inode, pgoff_t page_idx,
> int len)
> 4026 {
> 4027        DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, page_idx);
> 4028        struct address_space *mapping =3D inode->i_mapping;
> 4029        struct page *page;
> 4030        pgoff_t redirty_idx =3D page_idx;
> 4031        int i, page_len =3D 0, ret =3D 0;
> 4032
> 4033        page_cache_ra_unbounded(&ractl, len, 0);
> 4034
>
>     1. Condition i < len, taking true branch.
>     4. Condition i < len, taking true branch.
>
> 4035        for (i =3D 0; i < len; i++, page_idx++) {
> 4036                page =3D read_cache_page(mapping, page_idx, NULL, NUL=
L);
>
>     2. Condition IS_ERR(page), taking false branch.
>     5. Condition IS_ERR(page), taking true branch.
>
> 4037                if (IS_ERR(page)) {
> 4038                        ret =3D PTR_ERR(page);
>
>     6. Breaking from loop.
>
> 4039                        break;
> 4040                }
> 4041                page_len++;
>
>     3. Jumping back to the beginning of the loop.
>
> 4042        }
> 4043
>
>     7. Condition i < page_len, taking true branch.
>
> 4044        for (i =3D 0; i < page_len; i++, redirty_idx++) {
> 4045                page =3D find_lock_page(mapping, redirty_idx);
>
>     8. Condition !page, taking true branch.
>     9. var_compare_op: Comparing page to null implies that page might be
> null.
>
> 4046                if (!page)
> 4047                        ret =3D -ENOENT;
>
> Dereference after null check (FORWARD_NULL)
>
>    10. var_deref_model: Passing null pointer page to set_page_dirty,
> which dereferences it.
>
> 4048                set_page_dirty(page);
> 4049                f2fs_put_page(page, 1);
> 4050                f2fs_put_page(page, 0);
> 4051        }
> 4052
> 4053        return ret;
> 4054 }
>
> The !page check on line 4046 sets ret appropriately but we have a
> following call to set_page_dirty on a null page that causes the error.
> Not sure how this should be fixed, should the check bail out immediately
> or just avoid the following set_page_dirty anf f2fs_put_page calls?
>
> Colin
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
