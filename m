Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F152E9379
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbhADKiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbhADKiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:38:11 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F53C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 02:37:30 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h205so63169943lfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 02:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Irv4bODSEyX5XuG9TV4/17jq5rkGQP+jA8EeoSsmog0=;
        b=yM/HspTPWUOUdDtGnjbz69E6rk8+MvJdzll4p3tIgPVeMhh46SvXxLeMZbDKiKHQAq
         aWwOynY75uJHaxml4DYcMpEOav2D/ifRbOwPnCi1InYMRMBTlR5nZCSD8xuXs2GrueHo
         cQ5Fw9+ypOODVbrOwTwgjg/Z6UZ+Jm7jIUX10Wwq0jtVYmhQz9PQ9tuD498wJSCaDCcR
         NKSFfBl7OYIQMP3G8v8mJtv/lZp7DWHDTvrIT3OOMOB5Pbirxv+oqg86hQCyl1z7stKv
         L2Bgo40CIw3cQCMl7Gf0T+WMDFdd//OmSgxeJ1c1JZctF6oOHd9167p+a1pFwDp1KYIm
         U2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Irv4bODSEyX5XuG9TV4/17jq5rkGQP+jA8EeoSsmog0=;
        b=NhkHMISlSEsu6nOIl5JYyNXYPVgriDEs3Ue5Qj+kNdfJDiFGz5EMYfwoERIKHJEvkv
         01RjqD4Z87edgb82OEj+SUjybfd+1SKh9DqHYI7pS5DFgTtWRA7bSQpoOtC8VBQg6R6z
         ckSyFqjs26d4C+K717auWkeKg976uOlxnZ3ePSJH1g3k2V7OGeB1CY7EiEFcmVDUsrB2
         +fam9rt/i3ZLgcjtHkEfrHJBM2L0KOaizt+PuRzUN0KMvI0xnTspOPvuk2gzNNd2MGxJ
         vaDqnXRxgUoLp3+6HVEsGdqimIApKY840fMCUGGptDWhXEsfqe3RhllYShfh5VNhQ6mI
         oisw==
X-Gm-Message-State: AOAM532xBChvWWTTZ0yIGsbiuRA0H0V3ZkTXnffkYX0AosrVc6Edh9rl
        brkVir47ae9YrlRXJdqqGOpOZgXoS1BbHfEFGO/3L5R7u24=
X-Google-Smtp-Source: ABdhPJyCnxVWy/iIBCxCsmDOVLxJmjJwlmPAsbExyn0NTrsorfovm2BiIrmx2Nh9utTkaKG/wOKDmRD7Leg6ZImBQQI=
X-Received: by 2002:a2e:586:: with SMTP id 128mr37945106ljf.273.1609756649236;
 Mon, 04 Jan 2021 02:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20201211084541.2318-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201211084541.2318-1-zhengyongjun3@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Jan 2021 11:37:18 +0100
Message-ID: <CACRpkda9NMy9vPnnxQm-go+hK1D_JbiK0RJ3iLYnULnpV63GqA@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl/pinctrl-at91: convert comma to semicolon
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 9:45 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:

> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Patch applied.

Yours,
Linus Walleij
