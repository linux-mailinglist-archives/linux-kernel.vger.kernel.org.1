Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4270E274C59
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgIVWnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:43:06 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34515 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVWnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:43:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id h17so17200388otr.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ujRFzrNNNsh5z7M9S1n/AHFDhC/eiAX1cUWK4oCO5/o=;
        b=itI6g8zWCZTkO+JjsMcWsAYUaZmNWPUWn6O4CFjeADe36d4RU5gpbGQ91IEUdqFMCD
         NjVUGAJpQ+rYGFbLBAekl05/D8DPkMlpwSewg3mHBgZakVnR0O7aU2fzIWZkcaudL/pk
         109sXYZsRkvvNV3ojms52AclMUIPftdPL4ir6P+ZbM8feYZ+eqD2YMDj1Hdavgza3xu/
         KGj058nSrgo/+9wqumkXyA3l5qArLmD9xXkgvrnn7j1LzGrFz4hKwOFx81AkU7WxUarb
         06/k2FPrxLzKbbMT1sTUxAtDuSFmY5dvnXessSo2aT/0kSZ6gFW4ozQPijiSBzdpvlfU
         OYgA==
X-Gm-Message-State: AOAM530MnLpkY5EIvtDFH7LAWOz+LvpTBNmH+gWC7oC9pFRS5tTqTI4C
        aYSACrsb74nmbGNUzftW/8Ug3TQsXVI=
X-Google-Smtp-Source: ABdhPJzCTxS9liazLcqg3hK3HNoARI0ZUmby4pOiSznV8usi6uzS8sMpFs9L1LoPhWfRXiWu+EAV4A==
X-Received: by 2002:a9d:2009:: with SMTP id n9mr3988585ota.41.1600814585328;
        Tue, 22 Sep 2020 15:43:05 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id j26sm8173148oor.21.2020.09.22.15.43.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 15:43:04 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 60so17183787otw.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:43:04 -0700 (PDT)
X-Received: by 2002:a05:6830:196:: with SMTP id q22mr4056424ota.221.1600814584178;
 Tue, 22 Sep 2020 15:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200920202625.11377-1-krzk@kernel.org>
In-Reply-To: <20200920202625.11377-1-krzk@kernel.org>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 22 Sep 2020 17:42:52 -0500
X-Gmail-Original-Message-ID: <CADRPPNTJ0GfZX6Ms43o1oP8hpA-jbZLJuM7gp8_XY97TtX+mog@mail.gmail.com>
Message-ID: <CADRPPNTJ0GfZX6Ms43o1oP8hpA-jbZLJuM7gp8_XY97TtX+mog@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qbman: Fix return value on success
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Roy Pledge <roy.pledge@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 3:27 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On error the function was meant to return -ERRNO.  This also fixes
> compile warning:
>
>   drivers/soc/fsl/qbman/bman.c:640:6: warning: variable 'err' set but not used [-Wunused-but-set-variable]
>
> Fixes: 0505d00c8dba ("soc/fsl/qbman: Cleanup buffer pools if BMan was initialized prior to bootup")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next.  Thanks.

> ---
>  drivers/soc/fsl/qbman/bman.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
> index f4fb527d8301..c5dd026fe889 100644
> --- a/drivers/soc/fsl/qbman/bman.c
> +++ b/drivers/soc/fsl/qbman/bman.c
> @@ -660,7 +660,7 @@ int bm_shutdown_pool(u32 bpid)
>         }
>  done:
>         put_affine_portal();
> -       return 0;
> +       return err;
>  }
>
>  struct gen_pool *bm_bpalloc;
> --
> 2.17.1
>
