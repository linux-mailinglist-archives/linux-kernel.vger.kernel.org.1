Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9046E26D486
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgIQHUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgIQHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:20:42 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C1EC061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:20:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s14so2443040pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=qTwre4ZeIJuKy55xpBHaxVBN8pj7CPhlTLeYSSpiSIU=;
        b=mUK1l+0V3m0aQzgpa7FBva6vX516YzP+V0Ikp9EOOpWanHA6Oqd/eds6F+JWOODp5F
         lRVkvzD5o394JcSu9xKkcS+1wIY/QVYxmY8V/+1GAwI8vuVSxeRJquEr4tUCdJ7dgwBS
         JPwCv9bw4jQvsjgSpvgiFXug1bnoUS8X3LQqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=qTwre4ZeIJuKy55xpBHaxVBN8pj7CPhlTLeYSSpiSIU=;
        b=mzDLDZPF/Z9Yg86ZFkebWXDB3csufGQd+DfZ+RIV5xPTPYXqoxJSKKxc5cBMkxegl8
         75Hd6oSFJs8XTI+J5tGrUtbkWl/03BZRiG3XJRX/bnCy5PKIAZ/JKFA21zyaqGu9eBMT
         FSAKhu4ghdHjotF5A+HVtzwmyF7LO1Zk6123eNOZcMb0hDeiQyXTveDOPwvjJecz6SG2
         FdzxzoveSAIdGEzcQIpbqwemDl2RGqDF/Ons8/+NdeRjGkOBK66F97KdYHOPgh1loTxe
         qoW+P0rESD53W3mdSeXKn3on+401bhiiuTl01Nc7o6tB6HnDlCqgs2y0L0G84TLwjq7f
         mfVg==
X-Gm-Message-State: AOAM532onWID+rS6s1EWhQjAQIZ+EtUdsrMOlSYj8zcMN71VK8h0YJ2V
        0OEhKC9BUKkgJQFscAZxwtpc33HBCe5EqQ==
X-Google-Smtp-Source: ABdhPJwg+azqcg7sWP3zo0LXxIcosCEY+c69pW80exTxTNCPi7oboCX55uPw+dUh9lC85AB99OkYuA==
X-Received: by 2002:a17:90b:1916:: with SMTP id mp22mr6792303pjb.132.1600327240752;
        Thu, 17 Sep 2020 00:20:40 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id g23sm19530034pfh.133.2020.09.17.00.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:20:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1600305963-7659-2-git-send-email-mansur@codeaurora.org>
References: <1600305963-7659-1-git-send-email-mansur@codeaurora.org> <1600305963-7659-2-git-send-email-mansur@codeaurora.org>
Subject: Re: [RESEND v2 1/4] venus: core: change clk enable and disable order in resume and suspend
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>
To:     Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Date:   Thu, 17 Sep 2020 00:20:39 -0700
Message-ID: <160032723903.4188128.6871272126838595856@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mansur Alisha Shaik (2020-09-16 18:26:00)
> Currently video driver is voting after clk enable and un voting
> before clk disable. Basically we should vote before clk enable
> and un vote after clk disable.
>=20
> Corrected this by changing the order of clk enable and clk disable.
>=20
> Fixes: 7482a983d ("media: venus: redesign clocks and pm domains control")
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
