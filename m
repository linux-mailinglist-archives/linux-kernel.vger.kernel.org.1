Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11238283F72
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgJETSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgJETSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:18:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9815AC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 12:18:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h2so5818pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 12:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3v9XMAoPYBW3DQG8S1vG0ISp7LAFeik4tO7mnWA/PIE=;
        b=Flg1imdKdG4du95+yUiD8rHugdWmz6cDZdnv/sBc3wx8jJOqjfa7uieMvm3riwXyUI
         d404b0MWwm+wMfVIA1reIs4P7RfcgVAqIpujkXFfeGQEYKFlADn4+XkI+2HukATPeqjj
         2eyzcNW5tsvijHild1n+/cAlaRhHeKyu75KtNhSIAkAh88eoo7p7HAJQxh0SbSRxNPSw
         O9mCkSyio2shfaTtsaPjtbxApzM7O79tx8SirEtDb/FvTfqwcoMnaYwxbWALS9PFd0d7
         KrheOFiQ//V0ZFuzS/Zyhige/8QeCpzLB8Glud45L1MBzR04prFwwbB3Gu8AWu5iL204
         v6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3v9XMAoPYBW3DQG8S1vG0ISp7LAFeik4tO7mnWA/PIE=;
        b=IctX/K9L6f1iouvLuLi34KDN3vjwSxqisfWN8qdfySB/FPeXuv4pCeXnluNqyFtWGE
         e8GODOpKCZQGtzoplsGRVxka2hB+quysKeVlT5pXQqyV5hHeKMsxQ/g2StQV/p2Q0fOr
         pyTMjDZmuqNwhDFE0tt8qX9OH4YKmH02PfJE5VjslYsMjyfdi5sj/H9eQIjMgXTLmRCm
         nnBREQfOm0w748NfyUAHGRobuBTdppGgDZBi0w9gvfKf5ols7YZ1PitAKYDKbiC0Hwoh
         onOcgo2ph/SU0urj0V3LK9V28ilpTFVrhcv/R2skH5Epm6JD8DXaMWlsByUD6VAB03cf
         rz3g==
X-Gm-Message-State: AOAM533XNTeuQY1uvPpzVXZI9eGOQrKXaMRionh+a0noJfg04N5BFn+G
        /LcIVEAKYpuL8uTaYvRSI2VEawrsgKOuDXsGLq0=
X-Google-Smtp-Source: ABdhPJzg/smmDdSNBg0mwczEB7Lzlcc/N8/29nYapgcYl/zwOjuHCvGd9zmnksVlr8dsnxPs/GFCiCSVeZHsW0cr4N8=
X-Received: by 2002:a17:90a:ab0b:: with SMTP id m11mr904112pjq.197.1601925494043;
 Mon, 05 Oct 2020 12:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201002233057.74462-1-coiby.xu@gmail.com>
In-Reply-To: <20201002233057.74462-1-coiby.xu@gmail.com>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Tue, 6 Oct 2020 00:47:37 +0530
Message-ID: <CAAs364_NiSJ-mH+v938Mz-qLgDjUsO=7V7FLPo9=Tne63bUxXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] staging: greybus: fix warnings about endianness
 detected by sparse
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alex Elder <elder@linaro.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 3, 2020 at 5:01 AM Coiby Xu <coiby.xu@gmail.com> wrote:
>
> This patch fix the following warnings from sparse,
>
> $ make C=2 drivers/staging/greybus/
> drivers/staging/greybus/audio_module.c:222:25: warning: incorrect type in assignment (different base types)
> drivers/staging/greybus/audio_module.c:222:25:    expected restricted __le16 [usertype] data_cport
> drivers/staging/greybus/audio_module.c:222:25:    got unsigned short [usertype] intf_cport_id
> drivers/staging/greybus/audio_topology.c:460:40: warning: restricted __le32 degrades to integer
> drivers/staging/greybus/audio_topology.c:691:41: warning: incorrect type in assignment (different base types)
> drivers/staging/greybus/audio_topology.c:691:41:    expected unsigned int access
> drivers/staging/greybus/audio_topology.c:691:41:    got restricted __le32 [usertype] access
> drivers/staging/greybus/audio_topology.c:746:44: warning: incorrect type in assignment (different base types)
> drivers/staging/greybus/audio_topology.c:746:44:    expected unsigned int
> drivers/staging/greybus/audio_topology.c:746:44:    got restricted __le32
> drivers/staging/greybus/audio_topology.c:748:52: warning: incorrect type in assignment (different base types)
> drivers/staging/greybus/audio_topology.c:748:52:    expected unsigned int
> drivers/staging/greybus/audio_topology.c:748:52:    got restricted __le32
> drivers/staging/greybus/audio_topology.c:802:42: warning: restricted __le32 degrades to integer
> drivers/staging/greybus/audio_topology.c:805:50: warning: incorrect type in assignment (different base types)
> drivers/staging/greybus/audio_topology.c:805:50:    expected restricted __le32
> drivers/staging/greybus/audio_topology.c:805:50:    got unsigned int
> drivers/staging/greybus/audio_topology.c:814:50: warning: restricted __le32 degrades to integer
> drivers/staging/greybus/audio_topology.c:817:58: warning: incorrect type in assignment (different base types)
> drivers/staging/greybus/audio_topology.c:817:58:    expected restricted __le32
> drivers/staging/greybus/audio_topology.c:817:58:    got unsigned int
> drivers/staging/greybus/audio_topology.c:889:25: warning: incorrect type in assignment (different base types)
> drivers/staging/greybus/audio_topology.c:889:25:    expected unsigned int access
> drivers/staging/greybus/audio_topology.c:889:25:    got restricted __le32 [usertype] access
>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Alex Elder <elder@linaro.org>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
Hi Coiby,

Thanks for sharing the patch. Sorry, I could not reply to the v1 series.
Now, I have gone through the patches. Looks good (all 3 patches).

Reviewed-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>

--
Thanks,
