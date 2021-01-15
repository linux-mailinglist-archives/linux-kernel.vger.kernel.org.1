Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685D42F888A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbhAOWjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbhAOWjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:39:11 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EBDC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:38:31 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id be12so5443335plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=X6ix/lPlXp6WWxl9CuxKy3fRftVKMmAfY7z/prnCNME=;
        b=ODs33rWerpS6wtQKh0hwNJe1Gga0fHjZeRWT4X58AarvoTFe8T+b16OKmdKFvgc4JO
         3D2uYZ4ZrDNSC4XgVtjf6I6oWc0Ico58TugUITeoN0Ut3kFTBrVph+LGikvKSnLRv+Fs
         rQ0sofgvKeltYgpeJ4tV7kRq2uWGmAz7aCmw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=X6ix/lPlXp6WWxl9CuxKy3fRftVKMmAfY7z/prnCNME=;
        b=nXnShlvjZQXePyHG98m70BJiDSqD0yRzrMS3TLU35QuM+3HLaVktC5wnhQ8JxmEp8V
         Ohh/jN0q057OlGSvNdJDcF1o+Q0/I4jwS/oQxRal/p+B/sKXL0I08oFcXWYJeXcJKI/T
         hspZ9yG90oVi7ao6gzT1xLzcAnXZoTsKLROiTkNR5kKpyUsGndwblsixkN4x5T0cKcj5
         7JCEu3fL78bOmg4mo5tZlr/iAThv6AedepvQMbJcNMuOg0j6Ms0GHV47TvjEJRO5uj3m
         6uieUqLoEevlI9hGXtobGMq5wtNJAN8PvHnz7twNL7P1AdQldmq+gb/N9jnIBh2qMwWx
         sUbA==
X-Gm-Message-State: AOAM531L7/RACdhFxQkZD7MnTrypLzKs75WTPn4oGOdyacjPTx0Bz42F
        YCm9bDjDihDlIdr9qWrzmnjdaA==
X-Google-Smtp-Source: ABdhPJzt1nlcahq1GdatqOqabwL5+09IMZowXr4BcYOtaVjUZQG/JlpWvxkfqxCQVnpJxARKEyb2eg==
X-Received: by 2002:a17:90a:5308:: with SMTP id x8mr12879582pjh.151.1610750311224;
        Fri, 15 Jan 2021 14:38:31 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u68sm8917706pfu.195.2021.01.15.14.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:38:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
References: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
Subject: Re: [PATCH v6 1/3] dt-bindings: input: Create macros for cros-ec keymap
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dianders@chromium.org, Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>,
        dmitry.torokhov@gmail.com
Date:   Fri, 15 Jan 2021 14:38:29 -0800
Message-ID: <161075030927.3661239.13484813586536559071@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-01-15 14:36:15)
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
>=20
> (no changes since v2)

Please keep reviewed-by tags by adding them yourself when resending a
patch with no changes.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
