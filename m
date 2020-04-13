Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC7A1A6FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 01:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389872AbgDMXCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 19:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727968AbgDMXCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 19:02:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE740C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:02:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l1so5197762pff.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=u3KDTSVXv0G9CPqt4rOITnttjWd68okDX2macURumrQ=;
        b=n4sci+1yC9dhea8Ld6m2EkOlXaVXZ4Mvcv8sQslyGPpQ6N+uSvcMuBE4GemsmnbyFP
         lcY/bkCD2b0vzmYWO/UCm/RnpF06K/2OITxl/Q18RtW1ocd1mUZOhNPEB4iOaQuGH1kL
         nlglXjS+y4HTTQWqKkhaCrFhTAejAn5LX0P+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=u3KDTSVXv0G9CPqt4rOITnttjWd68okDX2macURumrQ=;
        b=YvacfKnzbhqvJC3gY8jogpXsCogqsqFxMGVWJNkxrf6slhwnU/aFa0oUhXoEYewzKC
         OmK/2U3z/vSxxbgLr5SIrZmWp4PDF/oWBM7hkO9Usbj7jQqZ5qdEPN+XvwRNpiicl9zR
         iiYFziYXpLSq2HhEgKcjH3TmL/8RjhdeV33uPnLy1lCQx16kbnG+sKSJ1r/EV6WiclBs
         cBDjZxJhl6+HWH4wA0eKDJHjwr4FVnfOLtX16ejpVesGUrjiCtZeJZBu/LG2t+QLQOlx
         26Tlx3cMQfEXn0cvltkSKoLf3vJEv/sXkQqbJuaQkRcHszYBOrCSO1aTlkXcToOUlkmb
         3NjA==
X-Gm-Message-State: AGi0PubcPb8Z0XeecfZcqdIfLnNHyjfCSKSuK02zh7Md9hSmpqJIzDp3
        usQh03d3nTV2tZp79Uw/JVhQKw==
X-Google-Smtp-Source: APiQypIf8hHrxsaa0BaxWFoOdC3OegBx+rcNktTAQXtM/XA7n0O0tcSlc/yBMFlwH8r1VrUlkXL7og==
X-Received: by 2002:a63:dd0a:: with SMTP id t10mr18844423pgg.229.1586818924267;
        Mon, 13 Apr 2020 16:02:04 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x4sm9566683pfa.191.2020.04.13.16.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 16:02:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200413100321.v4.8.I8e187cdfb7a31f5bb7724f1f937f2862ee464a35@changeid>
References: <20200413170415.32463-1-dianders@chromium.org> <20200413100321.v4.8.I8e187cdfb7a31f5bb7724f1f937f2862ee464a35@changeid>
Subject: Re: [PATCH v4 08/10] drivers: qcom: rpmh-rsc: Don't double-check rpmh payload
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>
Date:   Mon, 13 Apr 2020 16:02:02 -0700
Message-ID: <158681892294.84447.13195059143414023653@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-13 10:04:13)
> The calls rpmh_rsc_write_ctrl_data() and rpmh_rsc_send_data() are only
> ever called from rpmh.c.  We know that rpmh.c already error checked
> the message.  There's no reason to do it again in rpmh-rsc.
>=20
> Suggested-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
> Tested-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
