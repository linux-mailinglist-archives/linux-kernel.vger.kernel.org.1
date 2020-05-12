Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7303F1CFF30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 22:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbgELU0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 16:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729942AbgELU0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:26:49 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF647C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 13:26:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x13so1027092pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=H1+2swSK0ijtdladJlvxa7bbEzZPqsR62nbBx9yOv3g=;
        b=JE/V+wE1UITbWdIxoFhww9gWKZXunG95YOlUyT/vk3cKWXiI7WS4hSgNdGFYXXeWq4
         qbOqyh6cY6JFc4Ex7PSmIGIeMoXilx3K1YD1zTSnxGNYkBKxlRfntW38VgCWgbQcsm+k
         b/iBEbYxUFXZLSqtef+YbXCHzwcFceN52RCCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=H1+2swSK0ijtdladJlvxa7bbEzZPqsR62nbBx9yOv3g=;
        b=foYbjGXNu5AM4z9uNpEs30s2xxLkhHR6B902A1YGM6UmK2sEAatbJn4lwUoXvoYLXh
         mDcLOA+TBK/ZJ9MmQOieQjOCHUoWxI5b4ej/P0Y5BJr5/ZNKfmScbrZOelm/3OvtQfo0
         LIR3Tb2eNkvV56LHLK5R+DtvBb8q7m+HnY62Drws283Tht4nupq+kRvTlW0Hh3f/pxjx
         CHi/sShd6pHygsg8qSkUgdS8Un2DzRGyIVtfa21KC24FF3yVyIXuEzJaOnGjzS9GS+qy
         rwvAEKiZfYbhJU9pZHILdoLtX9ritLIvKBJZnRbELXIK3BkKNwHLscKA1wWM+nVW+hI7
         Vlkg==
X-Gm-Message-State: AGi0PuZGUBwIw7smM9omAmKuWSZ0RK0oDI99XvQZX/ndOTqomxhQLbwp
        Yw1jnE+iw4UVem169I0Z8QPqcA==
X-Google-Smtp-Source: APiQypLe8sd80AjBjKfNOmw9eKS5QoYDfT462qPcJ4ychbs6jqUvUTNFyPQJKYLB8FBDLFHSBXQeyQ==
X-Received: by 2002:a63:4f0f:: with SMTP id d15mr20990453pgb.339.1589315207257;
        Tue, 12 May 2020 13:26:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w69sm12692970pff.168.2020.05.12.13.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 13:26:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200422090443.12529-1-harigovi@codeaurora.org>
References: <20200422090443.12529-1-harigovi@codeaurora.org>
Subject: Re: [v1] drm/bridge: ensure bridge suspend happens during PM sleep
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Harigovindan P <harigovi@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        kalyan_t@codeaurora.org, nganji@codeaurora.org,
        dianders@chromium.org
To:     Harigovindan P <harigovi@codeaurora.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Date:   Tue, 12 May 2020 13:26:45 -0700
Message-ID: <158931520588.215346.14524550377627605126@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject is not specific enough. I'd expect it to be something like:

drm/bridge: ti-sn65dsi86: ensure bridge suspend happens during PM sleep

Quoting Harigovindan P (2020-04-22 02:04:43)
> ti-sn65dsi86 bridge is enumerated as a runtime device.
>=20
> Adding sleep ops to force runtime_suspend when PM suspend is
> requested on the device.
>=20
> This change needs to be taken along with the series:
> https://patchwork.kernel.org/patch/11494309/

Why? It doesn't seem like it should be required to go along with a qcom
specific driver patch.

>=20
> Signed-off-by: Harigovindan P <harigovi@codeaurora.org>
> ---

Besides the subject:

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
