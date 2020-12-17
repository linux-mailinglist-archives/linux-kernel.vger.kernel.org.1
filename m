Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC6B2DD643
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgLQRcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgLQRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:32:04 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E0CC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:31:23 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id j22so21074983eja.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRH0nNLIlpmjZsnoLyF+WIPiAVZ6XtEocGlFLxpMeW0=;
        b=OEUlRGVeZnKjUtgqBTQhGdax0DL+bK/jS6tYUHlCIwBtS+CnQD9hiehNK9J6fD2EbR
         WaEFwR5wiGDPMLednXfXQwIJkHbIHJ6qcvaV19PiQx/gI5MHc1/M+C/A+iL374B4WYfb
         prbR3vyLhPFo6A820EwUUosYFoD/RbUbUqE98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRH0nNLIlpmjZsnoLyF+WIPiAVZ6XtEocGlFLxpMeW0=;
        b=Q79+y+ZgemZTiUIwlqbSCRgqTrtmydH6dBmE/9NvAEnbAUT+yL7ZoHXNiW6e6x/MfU
         dnaqL9JcH+qPxyT7VuOSpj8AztgbrPQh40ns698R7Yi8ViXj9hYmoM5yn5LOfdpOUP2w
         gyy63hNKbRefRCzncFl7bPjeG2nM4ziCT/v15i7t2jD6jLhlTweCjznngIUFn5i77F9a
         9ZvQeUi8VyzfQdmRhpKeGrnzB0kJcoYXtfyevaTP4e7au49eEQhjxzaQJStY1mw/O/GD
         96iNBRz4oihxa1lkfqitiTTkKcc0xvvmChKVVA4Wajuybefs/y+7RlhmTRyw8fa6HEHI
         00GA==
X-Gm-Message-State: AOAM533czc2ZxZL/ux+vrCEzP0kUEq1cdpsDQtxXbBdCFR7zFJPW94FY
        7disiwkNfn7u9/cDlrxTnvVliCtfIbscSWRdCnlUTA==
X-Google-Smtp-Source: ABdhPJxYcR/ZaW8UNJh4As4nwhQnIZ55MyeoEoQ/SutBKacgHhcplYRiGf9rmZVU4Cw5h3zYv/wITf03jEIsaotrS7o=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr62463ejc.418.1608226282357;
 Thu, 17 Dec 2020 09:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20201215235639.31516-1-adrien.grassein@gmail.com> <20201215235639.31516-2-adrien.grassein@gmail.com>
In-Reply-To: <20201215235639.31516-2-adrien.grassein@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 17 Dec 2020 23:01:10 +0530
Message-ID: <CAMty3ZBq_mUimNrK+SvVigKZwvWHogXD1_6HZnsuTK6Ze7qtNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] regulator: dt-bindings: remove useless properties
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 5:26 AM Adrien Grassein
<adrien.grassein@gmail.com> wrote:
>
> regulator-name is a generic property of the regulator.
> Don't repeat it here.
>
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../regulator/nxp,pf8x00-regulator.yaml         | 17 -----------------
>  1 file changed, 17 deletions(-)

Please add pf8x00 in commit head, otherwise

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
