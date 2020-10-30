Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9A02A02AA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgJ3KSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgJ3KS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:18:28 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99C6C0613D8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:18:27 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h62so5079640oth.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwY6FSEEQBoBQdBLoaBkXQfT/X+1XphfDMCbhC85FPE=;
        b=DvmaArxE3OLEtqflsjntfLlw/Wss53+p2/dgBLUeQywMt9TgtmFviI9Ck1dtZoxs0S
         osEpDNFeaFdOpCvTmssUE0GQLkrYE7+2oesIMZe3W7dBb3WC9jZOuo94KTIjnbM2W3kP
         7hevmXm2cfinGdnEnBdAJM3QkvRQc5FGjF/jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwY6FSEEQBoBQdBLoaBkXQfT/X+1XphfDMCbhC85FPE=;
        b=Blo4Fk49KJgVjVBlLshtJlyUwlgcX61h99RkkXouKgWWxD6n+5zuGm7avh+aJPv4uu
         yGwChesUUra+FxJyWfxwDLigdihE0Kp1lcelLvaww8A8r7z/R+FeVRStvs3mn/1pGs4y
         xtxxDYCJYT2PtIacv5NUjKzsmuF9xXnnlYpJb2DDYHCc7EDisTaHKPG0Vq+tZySCbCwQ
         qG0bhHNqr79Hy/IQAu7AQsLKCG0FGQGpPK1B1Sg0Oc10OxFTrFO+4SS/dVRtTq3+NkvL
         4QDNmjFBPjgXLyIFxFpuiO1iXISvzINSRwps3oAL7/g02zYsmPlamVtZtY1MwvNH7Hs4
         bIrA==
X-Gm-Message-State: AOAM531LVCqku/xpiQrpA7zCouyVljIMOV3sVE+v9Jlse4hEegkI9q30
        nZ1P2FuRnepxBXllSlmjMv0legiwWhTtSQ==
X-Google-Smtp-Source: ABdhPJwNLgKTWIj63vjmfctr/rZlagCYJao+munl2DbiNbZUTDbkhDdbm1ZuvlpFI+INEwA2neI5+A==
X-Received: by 2002:a9d:6052:: with SMTP id v18mr1076852otj.33.1604053106639;
        Fri, 30 Oct 2020 03:18:26 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id t5sm1307133oth.16.2020.10.30.03.18.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 03:18:25 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id d9so149613oib.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:18:25 -0700 (PDT)
X-Received: by 2002:a05:6808:95:: with SMTP id s21mr1001625oic.55.1604053104887;
 Fri, 30 Oct 2020 03:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201013124428.783025-1-acourbot@chromium.org> <20201013124428.783025-2-acourbot@chromium.org>
In-Reply-To: <20201013124428.783025-2-acourbot@chromium.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 30 Oct 2020 19:18:14 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUscqohRt4v10=L+yM0KO65Ny6DskvG5V549YByVDDgbA@mail.gmail.com>
Message-ID: <CAPBb6MUscqohRt4v10=L+yM0KO65Ny6DskvG5V549YByVDDgbA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: mtk-vcodec: move firmware implementations
 into their own files
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 9:44 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> mtk-vcodec supports two kinds of firmware, VPU and SCP. Both were
> supported from the same source files, but this is clearly unclean and
> makes it more difficult to disable support for one or the other.
>
> Move these implementations into their own file, after adding the
> necessary private interfaces.
>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>

This should also have included a

Fixes: bf1d556ad4e0 ("media: mtk-vcodec: abstract firmware interface")

Sorry for the omission.
