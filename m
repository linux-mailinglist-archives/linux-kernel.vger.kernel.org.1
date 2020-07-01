Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4473A210EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 17:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbgGAPI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731928AbgGAPI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:08:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D964C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 08:08:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so11106271pfi.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r//RURoO3TnB3wTz8mwe3gfHxqmQYWwVK9iwzBO1A80=;
        b=UO8tTv46sKsUUVWPDwHcDgy4ubT579oFxF+ACPnaKkPTqHrHqlrIIsdao1sYMGriZ2
         IyR0/1tFThmpImSrIF0wLRAHLfL0ADbk5GXoyYXl5tml6omd9DrB6qbEBmOvltPHmqlV
         OrcuwgBj3IcMBg2pIX/SCjhXT7cklFQpHIV2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r//RURoO3TnB3wTz8mwe3gfHxqmQYWwVK9iwzBO1A80=;
        b=AMjS86MXX4ktM1h7DzHe0KRyi7qrlC6SjlgnpcoLApaLkurq8hK/sYMneHqdlnIJ1Y
         dEps/EyPxr8GVGuYL3zMlxuZjYnAmth7JZk1RwnOqfcRoPDc4pq1vtqdSPK/vtlXSsSS
         1lTZqGoyaXuRl15dJBRZps8/Mrqhzky1NSgHSbmJYukV7FRBcqORn1n/iUtHJNGfrcfC
         kT/C2HnFSaI9GfjTk5iGbqlhUjGvgQhT7WzLsJHL1CHHqt8eNI3kjSd2PR4aTB3iFdj4
         Hd056jP6aycwu1kBbqrCpPPXYDRhLubJBHC6JDHhrp5SgHOMP6MHySUAV1R1V+poGC/3
         j0lw==
X-Gm-Message-State: AOAM533TAFKy1VuBmh7q+LZuTB1PK79pPf+Qo8EhJ9T6pJy1uOy/98H6
        q51Eaxuris4SPOnVM3P/rupVMg==
X-Google-Smtp-Source: ABdhPJyUHWfSn4p4nAusnO2St4+eWaSv2zhKgithl7JoGjHXORjuhCmtCWuk9nCPfc66aRvEn++/ww==
X-Received: by 2002:a63:7c51:: with SMTP id l17mr20058757pgn.303.1593616135540;
        Wed, 01 Jul 2020 08:08:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id g12sm5965952pfb.190.2020.07.01.08.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:08:55 -0700 (PDT)
Date:   Wed, 1 Jul 2020 08:08:54 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     robdclark@gmail.com, sean@poorly.run, agross@kernel.org,
        bjorn.andersson@linaro.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: sc7180: Add DSI and MDP OPP tables and
 power-domains
Message-ID: <20200701150854.GN39073@google.com>
References: <1593518176-24450-1-git-send-email-rnayak@codeaurora.org>
 <1593518176-24450-5-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593518176-24450-5-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 05:26:16PM +0530, Rajendra Nayak wrote:
> Add the OPP tables for DSI and MDP based on the perf state/clk
> requirements, and add the power-domains property to specify the
> scalable power domain.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
