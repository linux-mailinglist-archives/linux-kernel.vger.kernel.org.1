Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51562FCC33
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbhATH5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbhATH5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:57:04 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59F6C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:56:23 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m5so1683472pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=uD3doS0EVCu1WoiDmQKvRQ7GKx+7H2pBnCgA8Mq4TGY=;
        b=Ik2EQFIOdWoF83W0IFY4s5vJcg5khkzq8iuElxJp2W/hCn54d74jRJlfYqzAFYeaE/
         SCwZ7o4QaSmoCOaLOdCXLvHwC0SwazOJG7I5ZpRXrz/CniD9lcjd8IImxM59SSJEnpNp
         +Un7zsbGbIec4DskaXWM6tUOldf3p/66yeNL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=uD3doS0EVCu1WoiDmQKvRQ7GKx+7H2pBnCgA8Mq4TGY=;
        b=Vo3tFCd54FxhQf+e38Ye4dwRef2khydH+WRpH6gZVgOpQjyfnhGd5J5tixWUQcERJJ
         2NjRAli8iQrzPqffT6QDpLeCsveZJpvEES4LpqRUvTM7CHG2PQek78D4761vGMoRtjYx
         a/syqsBZAMJbwDSjU7htXzxZkciBR2GxhiL5peOKc9wRed1f7w81Kx9NE4gzdkPb0gmB
         DdVntw9iv3sY3anQXACXt/tBlq05pb/B5wbV3KBuX6b6ftZlZg1ejOAuADLuL0DxDZdL
         OJeVH8M7R6xxeH5LZ4kLFS3EAZ3VWBP9EOHGI52IrBpaa6drJYqBNfP9l0QIhRuscx3s
         Db5A==
X-Gm-Message-State: AOAM530CVKTlxZW9Y56MEjA3lCfp2TaKYv0OuO8clV/iaeGrNcF0TfID
        se7FLf+0msVbf4rrzxtKkwId+sR9y3NB0Q==
X-Google-Smtp-Source: ABdhPJy0JUQmrhyJ+jBmDeADXQqctK0klVJV0/Qjm9JoxIHblf4rrb/sYMmsksqvU2HE6wOKugM29g==
X-Received: by 2002:a17:90a:eacf:: with SMTP id ev15mr4364491pjb.209.1611129383013;
        Tue, 19 Jan 2021 23:56:23 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id a188sm1362494pfb.108.2021.01.19.23.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 23:56:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1608055716-14796-1-git-send-email-dikshita@codeaurora.org>
References: <1608055716-14796-1-git-send-email-dikshita@codeaurora.org>
Subject: Re: [PATCH v5] venus: core: add support to dump FW region
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, Dikshita Agarwal <dikshita@codeaurora.org>
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Date:   Tue, 19 Jan 2021 23:56:20 -0800
Message-ID: <161112938062.3661239.3637358377915949789@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dikshita Agarwal (2020-12-15 10:08:36)
> Add support to dump video FW region during FW crash
> using devcoredump helpers.
>=20
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>=20
> Major changes since v1:
> - update the name of function (Stephen)
> - store start address and size in resource structure during
>   probe and reuse while dumping (Stephen, Stanimir)
> ---

Can this be picked up for the next merge window?
