Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7ED21B982
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 17:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgGJP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 11:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgGJP3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:29:55 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEB462083B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594394994;
        bh=a0/T1AKOzSuMCEceEuEQxM/B0IMqnV9YaAtTzrlJlns=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zEP5PXx8jeump1kOB1NmkNFEOezLxdjjXtV1rxPOkDq1IAKcNPYCzz2tBKZ5hTgT4
         2edQlOitD9D1M9TBDOEeAcsmGodOMUn7xsVRafF3CfWBIu0ip5JaMzZAfDFgyU474E
         ABoYSRda0wx4j30SrM5rEOjNJXfIHjuZwzjQMv7Y=
Received: by mail-ot1-f53.google.com with SMTP id a21so4457352otq.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:29:54 -0700 (PDT)
X-Gm-Message-State: AOAM531mrEJo6WGuNoCCayfP4hBGB6AJCHsLoB6Paz1ylHu+vESjrtlg
        gQor8hdSSzPoGgfzFexL+N+p2z++BqGLKQPU+w==
X-Google-Smtp-Source: ABdhPJx48r7S6iGwaE/Ld3SXFZT/cPpT/4A5xKQgPidcviKig/k1brHa/paWBNqloBLAnlESElt4zz9Hi6nmUtm1R1E=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr55279246otb.107.1594394994157;
 Fri, 10 Jul 2020 08:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <1594369172-27278-1-git-send-email-akashast@codeaurora.org>
In-Reply-To: <1594369172-27278-1-git-send-email-akashast@codeaurora.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 10 Jul 2020 09:29:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMM+k+9OMJ8UBN-RsC4ortgtqtf+PWrcw0nFTda4MtuQ@mail.gmail.com>
Message-ID: <CAL_JsqLMM+k+9OMJ8UBN-RsC4ortgtqtf+PWrcw0nFTda4MtuQ@mail.gmail.com>
Subject: Re: [PATCH] of: Add stub for of_get_next_parent
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        saipraka@codeaurora.org, msavaliy@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 2:19 AM Akash Asthana <akashast@codeaurora.org> wrote:
>
> Fixes compilation error reported on x86 platform:
>
> drivers/soc/qcom/qcom-geni-se.c:819:11: error: implicit declaration of
> function 'of_get_next_parent'.
>
> drivers/soc/qcom/qcom-geni-se.c:819:9: warning: incompatible integer to
> pointer conversion assigning to 'struct device_node *' from 'int'
>
> Fixes: 048eb908a1f2 ("soc: qcom-geni-se: Add interconnect support to fix
>                         earlycon crash")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
>  include/linux/of.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Already have a similar patch.
