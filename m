Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D762A2CC61B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgLBTCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgLBTCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:02:16 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFD6C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:01:36 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n10so1495366pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xm4VGai40mVfU1KDiOQQ0ruatOar3xR8M6PEtESptL8=;
        b=BOTDt7cxNAex0LeSeJ0Bd0epvVBMchFl+S3d5BAw4jBe6cs8DEJyHSf+DkFhiosw7s
         lkaLbQ7Yt+dfQBgaizkChhWc0pKV3yes/+T/4oY/CzbjnpcXPIQF6n9TgnAor+JYXJXi
         oN2RQYGGl9SmfzExNN0ok3gT3iXCUoUzwQ4Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xm4VGai40mVfU1KDiOQQ0ruatOar3xR8M6PEtESptL8=;
        b=iMdEL7rFjN7cauQc6fO33W/s02Y8EbRRbxZoT7HS3kxdn3FFdlqtm3c39C670rnu7c
         VQ5vT+WTMwxdmtmARRu3ccf7nu18g7aznLFYuRJOHwsjBp7dH4EUdxZLWamIzqlwthW4
         GpK6fKAgCDy2ijAOhEJfDQLxvDfvjgn8ZJopo0KQApPCqgM4E9OlkVGhdacsQko2OtLO
         7aSTlfXt0v4xMcqBPs0olWr3E1Y5xliFuSNk1xQy2/dgpnDIKRfdx9eRH16flaCouneZ
         rKPpa/7o5S33x8aJzjXz3SdRHnDsBJ/x9AFfJAvK5cWSlCL6EJH0jxK3hCDJ9q1T3mZG
         eFdA==
X-Gm-Message-State: AOAM530TgQOWhCYJyCatufpRq8ggtOKQsVfB6mMv8fkD4Zu+KAqvtMmj
        ZjMO2oc7MvAK9yAMVnDcTCGYZg==
X-Google-Smtp-Source: ABdhPJx3VqSsGJkmnkbKOrKvM3mPguRPfGXpejwNXC3FxfcOsVcXUkpKD/QpYIAX3BR4LaEu03malw==
X-Received: by 2002:a63:171b:: with SMTP id x27mr1199959pgl.70.1606935696197;
        Wed, 02 Dec 2020 11:01:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j16sm448198pgl.50.2020.12.02.11.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:01:35 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:01:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Emese Revfy <re.emese@gmail.com>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: remove code for GCC versions older than 4.9
Message-ID: <202012021101.E0BAFC3B@keescook>
References: <20201202134929.99883-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202134929.99883-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:49:29PM +0900, Masahiro Yamada wrote:
> Documentation/process/changes.rst says the minimal GCC version is 4.9.
> Hence, BUILDING_GCC_VERSION is greater than or equal to 4009.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

Do you want to carry this in the kbuild tree, or would you like me to
pick it up?

Thanks!

-- 
Kees Cook
