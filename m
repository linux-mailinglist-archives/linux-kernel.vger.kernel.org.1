Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE4B281DCB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgJBVqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJBVqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:46:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0FDC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 14:46:01 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so1679140pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=FCCI7a1Hx5plWli+fqb0y60ghvpUMhQaFbafJt11w5A=;
        b=Q0bSA1YsffZPuTfUlxWGGVnq7Y/DWX6Rzio6KfwSmNQ3xIrP3HcSPxdOYPBbB43dr9
         GvV6ssM7LaR6kMqlD0lDdQWvXcSyyEkPslbJWrYqKa9AuMwaCb68dfOnlwiy+bBTnTHs
         ntBGrL07KTYOBibCMlXSJy1WkGjZFrg7x0hTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=FCCI7a1Hx5plWli+fqb0y60ghvpUMhQaFbafJt11w5A=;
        b=O/WwbClpU2G8/GF/XJm8VZ5ZY/kjRhFZYijIhHHNmNe88dDD9avmShd8zaLFEnfMEt
         VIDA+j/Tzb+GQkH3nz01ZJFso/iTK2T4naik320Cqrk8lJrMdDyxhPG9e0+iYYbPFAc+
         /qKd5ooqtyYjpktO3VxVVL/p5n2xPA29CS7TRcW5/k9MI2UmF2GeCOsM3kTzogRJtx6+
         kr0gwh318HDIhDotFuCgMgBye3RY9me2etC9Yhe7Bxsbq1NYhhJsxH/3sddfpn8RKAqJ
         WM0xcpcTgA4s/GnqIt+aGbQV4v1TGEbC17fmDFm97tqMgqmrDcWOLeffGxawLqxZYDi2
         +LPw==
X-Gm-Message-State: AOAM533xcVB10P5vvu7wY3fExOGIQNh63scDC2Nu+oXAQAMe13+95M99
        1835RBwyK3gxBUG7lvkHJ20k51ybX1IVIA==
X-Google-Smtp-Source: ABdhPJyE6MdNJzMEQZG+mxpSNhpnLH2ZKlF2kT2OnVXVTMI7yIsURIph1nliHrA3Oi4P0udXBGQMyw==
X-Received: by 2002:a05:6a00:1506:b029:142:2501:3971 with SMTP id q6-20020a056a001506b029014225013971mr4727209pfu.54.1601675161346;
        Fri, 02 Oct 2020 14:46:01 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id w19sm3037317pfn.174.2020.10.02.14.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 14:46:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b638e342aae1f6866cad33ff408f2894@codeaurora.org>
References: <1580997328-16365-1-git-send-email-kgunda@codeaurora.org> <5e3c63d0.1c69fb81.c2bba.0957@mx.google.com> <b638e342aae1f6866cad33ff408f2894@codeaurora.org>
Subject: Re: [PATCH V3 1/2] mfd: qcom-spmi-pmic: Convert bindings to .yaml format
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, linux-arm-msm-owner@vger.kernel.org
To:     kgunda@codeaurora.org
Date:   Fri, 02 Oct 2020 14:45:58 -0700
Message-ID: <160167515893.310579.11853207494346374403@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kgunda@codeaurora.org (2020-02-06 21:57:49)
> On 2020-02-07 00:36, Stephen Boyd wrote:
> > Quoting Kiran Gunda (2020-02-06 05:55:26)
> >> Convert the bindings from .txt to .yaml format.
> >>=20
> >> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> >> ---
> >=20
> > Did something change? Is there a cover letter?
> >=20
> Other than converting the bindings to .yaml not much changed from the=20
> previous post.
> I will log the per patch changes in next post.

What happened to this series? It never got resent.
