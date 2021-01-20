Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4932FDA1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbhATSoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404512AbhATSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:33:40 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:32:44 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x18so12979076pln.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=8c+9ajqGNyuEOzCDkVwNBb94YS/VsoSEZ7DQMmpNsTA=;
        b=I5tYk215vcOaTnqxqDl1qlp4RJxNPrjJycdTL6dIkpVjDgB9CMBLhlo0Pa7NaHGBaC
         osjFLATyMFXIFH2IKRr0oYL5GtljuPhfXhGnatI2dRPSv7bcZYgWhJxGFx7BuesRwXB7
         ocig8bvmAiBB9pvp171SeMfWxTVhAIiDFHjbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=8c+9ajqGNyuEOzCDkVwNBb94YS/VsoSEZ7DQMmpNsTA=;
        b=Pp0BL3V4/saF7x/mqqNLX7x85xpjAE8t79uPm4zsCNY6CrH5gVqtzGRC92r5TFCv7B
         G2UKosidrg3Acseq8iO/eYjKj3dQdsEiRRSrSZEp5OcyISQkWs+2/HtEoF8Zzs5r+AKR
         ysSbgh/Qh2sQkybkW78F+TP3pEOo2X/Mg0w6KCUHZtAHFrCbRIdL62uvzOpEX6RZPFbj
         p2x47ApYugApKRqvppYG8MZOT73gfQv8pmvE3YGvLVUc0hGk1yzrjMCdzMaW+zsEaA3q
         0RhYNTbRgzl3KCO8wUXpuUjznRqJ7thO9Vp08+HhX6VtUnMhFGHfitrgm//dxbBqyjKE
         bBqA==
X-Gm-Message-State: AOAM532tutTVx54y4nlKAjhZRCrf7bs7cqnpdT7c/knw+Or2yr9bNXGE
        T7Kw2NAcYw/oV63KFoVAZKqqwoROy5Uc2Q==
X-Google-Smtp-Source: ABdhPJwnEgMjqq4KvvEbYOuovvQRQQlTWVHcpeH+sc6TWBydOg6QQQJk2igpk0oqKOx/EerP/YEXBg==
X-Received: by 2002:a17:90a:b010:: with SMTP id x16mr7022862pjq.74.1611167564283;
        Wed, 20 Jan 2021 10:32:44 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 4sm3408494pjn.14.2021.01.20.10.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:32:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YAf+o85Z9lgkq3Nw@mwanda>
References: <YAf+o85Z9lgkq3Nw@mwanda>
Subject: Re: [PATCH] soc: qcom: socinfo: Fix an off by one in qcom_show_pmic_model()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 20 Jan 2021 10:32:41 -0800
Message-ID: <161116756167.3661239.9611045261884718600@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dan Carpenter (2021-01-20 01:57:55)
> These need to be < ARRAY_SIZE() instead of <=3D ARRAY_SIZE() to prevent
> accessing one element beyond the end of the array.
>=20
> Fixes: e9247e2ce577 ("soc: qcom: socinfo: fix printing of pmic_model")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
