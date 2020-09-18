Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D9526EA0C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 02:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIRAnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 20:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRAnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:43:51 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D2BC061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 17:43:51 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id c17so3061204ybe.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 17:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Fbuu+N/rr0QMGhmDlrnMnIzun18VD3BLmNAc5Myj9Y=;
        b=g4Fh/zsrl3iWnIJC8Ych5c8ZwL8DA+JQOLZ71/Jw/2PKET0WMZAuabA2GJafRqKC0/
         DNXkRuEp9RLUOuUSJxti9u4H8TxKgNFCWlRRv5tRPRiueyN1fKHF1e7mKgpZyi6QqpKM
         T8Z5DMPR1BzSKK4ZVw0pdud+PlDZWwOZ3I/QEFSHpJjrFOJVeiKVOLMB+KNhHy8RrQwu
         FNTZjI2uYgom6vvQvv9OkG6H8aLNhew6nhriGYI8zKTgS0DI/aM5RxRG9pSyNpWj4aIq
         HuN/rhj3Ac5ceZ+8s0PapeKbdFR4MoOEvxwsdpQ0IY7kxAPAG3JVfJM4Y1fUNU4xkEwi
         ObMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Fbuu+N/rr0QMGhmDlrnMnIzun18VD3BLmNAc5Myj9Y=;
        b=L6QRPAsOCnK4tVLdF8Ng9rSq9VzxDYlPRCrXbyo5YqQF4Up3SlHVxiQzY/Bp3RWD5y
         p/Ckku2CC82xOkbcFmhfaiWTBkjjXlZaziCceinaIRiqFT85/gT711pPPy466Tw5D9P1
         VRJcf6FTbyj9QR9jU6252d7z6iDhA36eLrCZVhEYKbqQ4ebdK8O4UnYLXDHKE5BcFSLi
         NOfv9e1f+2XhxJL23gYiJd1cKwaqARX9Eb9LrlVpHi84iGa2+pu5BTnsbWZ+9AibvYaR
         qPdjTj2KkwVlVi/zZh1LSeTphrkvJaSxpt4d/ricg09FANmnxI0qehh+v11SdlIAerOW
         f6FQ==
X-Gm-Message-State: AOAM531wniPq+NASRgH2vODlwsvlit85q/V/qOpN+aFWyqzhcmA7uqgB
        3m333ej82ywK5msiDMoXxzqpKE0G2xrqYnZiY4rWmA==
X-Google-Smtp-Source: ABdhPJyN5VchFReE9lSL3fJdNDH+SyMJ1oU3sF0hfnq+46d3nFs9PMZTuIc7VwwpyCoZYngG1ngvU0DhlzbwQpHRoP4=
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr26247685ybt.346.1600389830440;
 Thu, 17 Sep 2020 17:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200825170152.6434-1-georgi.djakov@linaro.org>
In-Reply-To: <20200825170152.6434-1-georgi.djakov@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 17 Sep 2020 17:43:14 -0700
Message-ID: <CAGETcx-N6FHK3dNmq8eSLoBoscBtHjSq=F6cepnCrrJrVuTV9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add interconnect sync state support
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Mike Tipton <mdtipton@codeaurora.org>, okukatla@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Saravana Kannan <saravanak@google.com>

to all 3 patches in the series.

-Saravana

On Tue, Aug 25, 2020 at 10:01 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Bootloaders often leave some system resources enabled such as clocks,
> regulators, interconnects etc. We want to keep these resources enabled
> until all their consumers are probed. These resources are often shared,
> so we must wait for all the consumers to come up, before deciding
> whether to turn them off or change the configuration. This patchset is
> trying to solve the above problem just for the on-chip interconnects.
>
> The problem is solved by allowing the providers to implement the get_bw()
> function which should return the current average/peak bandwidth. These are
> used as floor values, that are enforced during boot while the requests from
> all consumers are being collected. Then the sync_state() callback is used
> to signal that all consumers have been probed, meaning that the floor
> bandwidth is not needed anymore and the framework is ready to re-aggregate
> and process all requests. If get_bw() is not implemented, the framework
> will use INT_MAX as default bandwidth value.
>
> v3:
> * Go back to introducing the get_bw() function as in v1. (Saravana)
> * If querying the current bandwidth is not supported, max out the
>   bandwidth. (Saravana)
> * Use icc_sync_state also for sc7180.
>
> v2: https://lore.kernel.org/r/20200722110139.24778-1-georgi.djakov@linaro.org/
> * Support initial values for both average and peak bandwidth (Mike)
> * Skip aggregating/setting for nodes that don't specify initial bw (Mike)
> * Drop patch 2/4: Add get_bw() callback (Mike)
> * Squash patches 3 and 4.
>
> v1: https://lore.kernel.org/lkml/20200709110705.30359-1-georgi.djakov@linaro.org/
>
> Georgi Djakov (3):
>   interconnect: Add get_bw() callback
>   interconnect: Add sync state support
>   interconnect: qcom: Use icc_sync_state
>
>  drivers/interconnect/core.c           | 67 +++++++++++++++++++++++++++
>  drivers/interconnect/qcom/osm-l3.c    |  1 +
>  drivers/interconnect/qcom/sc7180.c    |  1 +
>  drivers/interconnect/qcom/sdm845.c    |  1 +
>  include/linux/interconnect-provider.h |  7 +++
>  5 files changed, 77 insertions(+)
>
