Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA0294238
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437545AbgJTSiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437535AbgJTSiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:38:12 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4A1C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:38:12 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i2so3120962ljg.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPHy2iOCVRnPTfeb/Xot34qh9SylFH4zQ2qtnuy+mZY=;
        b=d489tptTRMiPFgd13GYy1drjFSbt2x0wlqQlFfkw0IrDKhcEd3aUB54X0/dX9PcAPP
         UToVMTjQ5R4J2HlJ8Hb8j7unmMXTwGtWhVFrXYG5jHDQHZ8B7OM6OQFfsuZYd54lys83
         STxBgKr8Rf9vB4HSlpaSETe0mtLtvJEedL89c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPHy2iOCVRnPTfeb/Xot34qh9SylFH4zQ2qtnuy+mZY=;
        b=n4EVRimtOqLCmvpi0dbXls8Q9NawPpNaO3bN9ih/IqBfLWnYRB/wgbSIJA68HErBb5
         6y6Ud4AhaF3FRtqFptU+FxqI8yER9TW4g++Zsggyg99XZAX0zEvDVcTBhJ5xhZRY9HBE
         dnWFEj/W6q2Fx5FJ0SkhbBFyOmOAMtaDTexp9LTeAT/RmAPAc+9L7XYHmDetrBo6HHeB
         fm5Gzl5JYMcAD5KVUtbaDUIkQDeO4GGXOQG5lt6R2Er8tIR2eAaCF7JQWij/rh+8ZK56
         Ymk5OU79UVWykfXud1R4WhBxiuudFdV2FZRqHfEA4xSLi0BS1krYKvZbRSsh8DdVbCgf
         /18g==
X-Gm-Message-State: AOAM530jWBMKKT1998gOTL45zkk/H7sIgCWHBtCce6pVf7bw18BcjRCK
        0Blc2qNU0MXUwTR6cD6wIouKhB/tZ2VeJw==
X-Google-Smtp-Source: ABdhPJz66cIAjHHa+aZIRRrdd8ZcqmVbOqypI/O/nuV8HJDRbRM2Y0F4ANtIDpX0TpC9sLvOZqUdKA==
X-Received: by 2002:a2e:80d0:: with SMTP id r16mr1639228ljg.161.1603219090201;
        Tue, 20 Oct 2020 11:38:10 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 62sm417932lfk.47.2020.10.20.11.38.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 11:38:09 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id h6so3371355lfj.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:38:09 -0700 (PDT)
X-Received: by 2002:a19:c883:: with SMTP id y125mr1330347lff.485.1603219088467;
 Tue, 20 Oct 2020 11:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <1602786476-27833-1-git-send-email-sibis@codeaurora.org>
In-Reply-To: <1602786476-27833-1-git-send-email-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 20 Oct 2020 11:37:31 -0700
X-Gmail-Original-Message-ID: <CAE=gft4FrAm_QHKm_dF6G0R8fkfJrYFYPMrRu0nPNrQtZ83skw@mail.gmail.com>
Message-ID: <CAE=gft4FrAm_QHKm_dF6G0R8fkfJrYFYPMrRu0nPNrQtZ83skw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Fixup modem memory region
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 11:28 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> The modem firmware memory requirements vary between 32M/140M on
> no-lte/lte skus respectively, so fixup the modem memory region
> to reflect the requirements.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
