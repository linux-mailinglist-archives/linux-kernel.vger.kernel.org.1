Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9870028CBF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgJMKtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgJMKtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:49:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3857EC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:49:37 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x20so13325073qkn.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yIOA7zSjyrX4Zs7s/5Bx6EkRK+TbV8s3nkbgBG6Fvo=;
        b=NC8/NuxJy67mC+3rEmmrb8EZ/mvlbwIQkiCNQgPnpZRn3raZq6Vn6xfJ+ckHWgn1M1
         QI8VJzOvs9lTbpT6j5KdNWBEbVGuLFGubJYqjc9a77hu+nchRW9qOFgfTH6GLeGEZQub
         adBGZbZf1HGEhPjW2McyQf6cz338U3/ge27uacoLNG0871VXKO0yFRTxLA4N9wrDFJvI
         4dDThvH6XY+tbKFprSaWxtwBJDLQ9Wf6+x0sP8afGuaF36Y9UK7rYyfUVhYpUXDPPUs9
         KIEbyWRJ3SAOYa+l4d1ct5tDV1+sbI8MzQJ4DSEuZddvV1Sbs1f0DAQGRc+89E3kkpqL
         K1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yIOA7zSjyrX4Zs7s/5Bx6EkRK+TbV8s3nkbgBG6Fvo=;
        b=mHah1M/4iAiyO3A41HMWuUlQfSvur83JR6hai9BNm61EQQQGOs14E51XoT19l6S1SI
         KpMWlhyoeAbK1XjED5O+hXu+ewTrP9+f/S5ElBbJudH79MFj9zpTpbfDOGI3I0SNAcsX
         BkJoky/rTyq2qqmYzL5BILePndaLpqZowVsFD24coyTwtx86yT8D8l+IsNyS6b9UfbNo
         jdOPvLXQ0Ya0D27mjElgNtuvXEFVIdjV63M8x+VaGpPiyIq3XTeOInlIJXeFnClDNPHM
         +/y4vir5QuwTzf6bLJqVSwMU51zxE0zMXWBoikQmPRT4s/hu4pXQ55PMwwa4Q6Y2NBiY
         V31Q==
X-Gm-Message-State: AOAM53250pMiShDOslZNTZws6EdBjz0twa9hS55LQyzPTHNLyLUrYqmb
        6IboSoAJvymvW4gS0QIlW8yls1B3WQkx5soU3PtBEXHf9k0=
X-Google-Smtp-Source: ABdhPJwPArjX1/GNiWi7DgVkMB7AMSGfJphdxv8GAO9L+oqwA47B1TRWy3HHHsK69qtyzYJr7RiSbchJ1miUu/bHKfg=
X-Received: by 2002:a05:620a:657:: with SMTP id a23mr13835127qka.121.1602586176472;
 Tue, 13 Oct 2020 03:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com>
 <20201012190037.GB17643@Asurada-Nvidia> <CAEnQRZBrXNgMDNgQ=dMJfZQpZvdq6sUx2y21_fuk9teRd5UM0Q@mail.gmail.com>
In-Reply-To: <CAEnQRZBrXNgMDNgQ=dMJfZQpZvdq6sUx2y21_fuk9teRd5UM0Q@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 13 Oct 2020 18:49:25 +0800
Message-ID: <CAA+D8AOCR+Hvq9K=LjbaPW0jJB+00nFORahErWyJJJr0LVUq4g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for higher sample rates
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 6:42 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Tue, Oct 13, 2020 at 12:29 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > Hi Shengjiu,
> >
> > On Mon, Oct 12, 2020 at 04:49:42PM +0800, Shengjiu Wang wrote:
> > > Add 88200Hz and 176400Hz sample rates support for TX.
> > > Add 88200Hz, 176400Hz, 192000Hz sample rates support for RX.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> >
> > Probably should put your own Signed-off at the bottom?
>
> Hi Shengjiu,
>
> Also please keep the original author of the patch. You can change that
> using git commit --amend --author="Viorel Suman <viorel.suman@nxp.com>".

Actually I combined my commit with viorel suman's commit to one commit,
not only viorel suman's.


>
> With that,
>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
