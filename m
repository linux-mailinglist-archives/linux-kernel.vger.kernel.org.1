Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB726B20E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgIOWko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgIOQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:10:42 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74466C061A27
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:10:13 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s65so2259466pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=VViAJQqCvZ+W9uKbOdPfvJ2v9Gv3o3z5TpkfLft1QN0=;
        b=mLt3BNJxdOh19yipmm71v7ESh85fTnPPhOp909aaBqwHzYh0Z8haywshZUQGt5Ub7i
         Sps0C46SrrzYmVP5MyIzrjV/K7w2aUyQm0AQHgjU++eTk3eLjsZG5PIBlPMmHdSH09/P
         Zc1IpYY8szJm/56pT/OlAtNDhFnEFK2E2JXbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=VViAJQqCvZ+W9uKbOdPfvJ2v9Gv3o3z5TpkfLft1QN0=;
        b=f1nL7fiFhjNOPes9v15EwECoL0D6JJN/4OKM1NCbwrB1d2wftTbQSJFUHyRZNUnPco
         uQxf4hqCxyl5GwzcInKHkKqwD6YtRmS2g0sAN1VFQU/n0RXh78jRpJMcjY/hgrDf73Vs
         11yhI48W8+jUkuuxRP+3Kih6jypRN9nYmbpswl9GvKst/Vh4OKd3LaMeD+nk542aDnPz
         gMSTnqqHngd6ZXuNyfnVvHnfJrCi9ZU+VmmqlilqsuKiZKIeHd1InaIUkZrVJbBlrMLm
         dezkuwhrrNSuSfN/P+RrabppSYfb7nK0PjUG3lvygzE9AtuZQMUaPwdLAkS7C/OUhiN3
         kSUA==
X-Gm-Message-State: AOAM533vuJ0mXFbqN1Q50rDRBRxRLRA17o9WMFoVeBPm46kZHGlSVJkK
        rxOdtqkGgdMG/ou+rFFugZFqUQ==
X-Google-Smtp-Source: ABdhPJyQhOUohpeWiD2vfgf0NpuEB+YxIfxqgz9VrJsEZIm1ZpTzwn6VBdTQeRAA0JOY8If+Yrc50Q==
X-Received: by 2002:aa7:8597:0:b029:142:2501:39ff with SMTP id w23-20020aa785970000b0290142250139ffmr2593371pfn.78.1600186212985;
        Tue, 15 Sep 2020 09:10:12 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id c202sm14039243pfc.15.2020.09.15.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:10:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <51f9ad67333eedf326212dd1b040aade6978e5b1.1600151951.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1600151951.git.saiprakash.ranjan@codeaurora.org> <51f9ad67333eedf326212dd1b040aade6978e5b1.1600151951.git.saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv5 1/2] soc: qcom: llcc: Move llcc configuration to its own function
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Date:   Tue, 15 Sep 2020 09:10:10 -0700
Message-ID: <160018621088.4188128.12098946410444446853@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2020-09-14 23:55:25)
> Cleanup qcom_llcc_cfg_program() by moving llcc configuration
> to a separate function of its own. Also correct misspelled
> 'instance' caught by checkpatch.
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
