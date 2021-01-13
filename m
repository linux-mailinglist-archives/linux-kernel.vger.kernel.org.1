Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A42F550F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 00:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbhAMXAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 18:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbhAMWlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:41:31 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB36AC0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:39:24 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v3so1876082plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=gh8rbttIouy/6SgRYtlbp+yCr9Aj2T9LalSbJ62Hzw0=;
        b=aqsVLG12WY5SVKk8ztS9n/LrwE79M0ulsj0CkzRH7CwZ7CciJj+5RT9jiGuVneRiP5
         aRRvTW5CPqEUWfpgeIP+chHk6qhzjV3q70jshCZiVcEMyQJqz4j7GLu5rF4jyKCbw6G7
         zQAIRi1Ju0yBerf3OiN5SpU8vXNjjh9P4E9ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=gh8rbttIouy/6SgRYtlbp+yCr9Aj2T9LalSbJ62Hzw0=;
        b=EZ8X9nraUoFKy2sderVYgF4zPJPn+YcQMrET1+x6pyc1qlkkqqb3xaldE0LBzh+AM+
         /C0H2LwZYbw1HAxLzHWtoilkyJFrVS7BjT1bM1BpwtyH8b2XHayiYnTjCRSKSknHtcUK
         CsE0zf/SSWN4g/X8rrBaiGB/YpsrHVfvEnAIe3n84fw6y27bHtdeAGUkpqE7iOthT56e
         hhJBquqzf53EDl0HuO56T35RHoctVLNOaY9gnfWC17eJIcVqG2ofHMMFculohotR4/58
         QeDC8lAJ+Jb6lKNU0LlwBuPJ6zDYAM6YGFUWnHwQUnd0vSs1jn6RwAkK4pw6Ph5UE8Rw
         x+rQ==
X-Gm-Message-State: AOAM530ta5ZhnzhdjtljywUjoJyPnmiU0o5Gay/vVK5gMv8CGnodF+YT
        Gf3jDLq/H2b7Dkx+QDk2j1+SMQ==
X-Google-Smtp-Source: ABdhPJxZdWVLDt3uZDkJTFcJ8PFyFQeU3MsJ8ddVuDRk/eVp50Kq8uE8i8woOhxikahB8u3ZhhBiag==
X-Received: by 2002:a17:902:ba97:b029:db:f662:a547 with SMTP id k23-20020a170902ba97b02900dbf662a547mr4442619pls.68.1610577564332;
        Wed, 13 Jan 2021 14:39:24 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id p15sm3584031pgl.19.2021.01.13.14.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:39:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210113141426.v5.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
References: <20210113141426.v5.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
Subject: Re: [PATCH v5 1/2] dt-bindings: input: Create macros for cros-ec keymap
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dianders@chromium.org, Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>,
        dmitry.torokhov@gmail.com
Date:   Wed, 13 Jan 2021 14:39:22 -0800
Message-ID: <161057756231.3661239.9132526298211013930@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-01-13 14:15:01)
> In Chrome OS, the keyboard matrix can be split to two groups:
>=20
> The keymap for the top row keys can be customized based on OEM
> preference, while the keymap for the other keys is generic/fixed
> across boards.
>=20
> This patch creates marcos for the keymaps of these two groups, making
> it easier to reuse the generic portion of keymap when we override the
> keymap in the board-specific dts for custom top row design.
>=20
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

You should carry forward Acks and Review tags when resending patches.
Rob acked the previous one.
