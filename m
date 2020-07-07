Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE88216387
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 03:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgGGBvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 21:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgGGBvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:51:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CA0C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 18:51:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e13so36800986qkg.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 18:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qx/C0isL60DPbKTPxrph0kJVnu1AM2M66vCo2gvDUxo=;
        b=JOfLIPJL+2nxndCtc9jPaSJdkd+AmzkyaD1JzoVZhJb34tgPdJuaPVJbdhGbbmlot1
         nP0PCUA2MnDCVjOTzLofNt5MbSHBNXQxCZtyBJJABBz2HfoEZbvQdmxYmb7leoUTt+DX
         hLzm1z/RZbt8s91F2R4d+0vl+3C0GK31Catd+BJ3duwE76ybY8oTZisVGdhKSxuv+eQJ
         HnaAvpjQGIkO0c1lLMZNsMXGcVW/f8n8D9tDW/DKceRkvWp9rTl9lqt0AOwOMH3hp17c
         g+nXeOpHlQsh/gG9W0Nkmgnc6EpRs9y15S8Up7ybEJLf3nOF7TMorGn6XpoLBKi0AF8+
         vY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qx/C0isL60DPbKTPxrph0kJVnu1AM2M66vCo2gvDUxo=;
        b=VtAldLmAGRmDjF/HB+Aq9fZ/t/TZChzET4UH1RAOXFGEQSs+/1qYNvJ1PcnvlWRisT
         XotVDvUe0Hg1a9ELXS4E8H+pK0O4re+683A8cLTofSgnqe5bObNqSBYy511KjfXuvksI
         zQNictVeXFX205mD1Mgs6hs9tkuG42A/XbGQ0fmXgi1lYf52r/icqCv7y6E7VTd+CLOA
         stb5kN9RAxWEulI37KoHa5o166GSfRzWmUdQxtFp1MUj2UjO0qd+jdm4kWK7N2+Fo2B2
         /ggS4Qctxf9yrjNzND5KHGuXk0tUXOXw4SvPXrt8UhvJEtRfrXiXPn9pDvyxvk5NoJ8U
         LV5g==
X-Gm-Message-State: AOAM533Sz5j84l55RFKXQnRo7pz7/CMjQkjVOpwpS/b+ExYDg4O3wBd/
        CocV4qZURinw83r68yA7eQtk01CiuXCw+vIfAeZW3qdJ
X-Google-Smtp-Source: ABdhPJxbdu1UR0UwC4VJ18/+W8RImTA2mJWd60dbnKAprt4YwcWVw4xJ/jqDfQmncoedyIwf0fGD5hIXQ2ivhdVou/E=
X-Received: by 2002:a37:bcb:: with SMTP id 194mr51351661qkl.103.1594086702672;
 Mon, 06 Jul 2020 18:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200702193102.25282-1-nicoleotsuka@gmail.com>
In-Reply-To: <20200702193102.25282-1-nicoleotsuka@gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 7 Jul 2020 09:51:31 +0800
Message-ID: <CAA+D8AMMKKDyPXXN0790LswNh_sOfUUDVw5PiMoLB-U4qX8G9w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Shengjiu to reviewer list of sound/soc/fsl
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, timur@tabi.org,
        Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 3:33 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Add Shengjiu who's actively working on the latest fsl/nxp audio drivers.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> To Shengjiu, please ack if you feel okay with this (your email address too).

Thanks Nicolin for nominating me as a reviewer.

I'd like to use my gmail address "shengjiu.wang@gmail.com".
with this then

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

best regards
wang shengjiu

>
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 496fd4eafb68..54aab083bb88 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6956,6 +6956,7 @@ M:        Timur Tabi <timur@kernel.org>
>  M:     Nicolin Chen <nicoleotsuka@gmail.com>
>  M:     Xiubo Li <Xiubo.Lee@gmail.com>
>  R:     Fabio Estevam <festevam@gmail.com>
> +R:     Shengjiu Wang <shengjiu.wang@nxp.com>
>  L:     alsa-devel@alsa-project.org (moderated for non-subscribers)
>  L:     linuxppc-dev@lists.ozlabs.org
>  S:     Maintained
> --
> 2.17.1
>
