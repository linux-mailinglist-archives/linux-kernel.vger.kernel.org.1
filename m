Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA602D298F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 12:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgLHLH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 06:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgLHLH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:07:58 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B23C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 03:07:18 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k10so1755668wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 03:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2NnCE+nkCzmC8SJdxfDZNmmoxjUO7CAw3RZJC+yBn6Q=;
        b=P7004MFuh+TIp0PuvsmG20j7fXiRGd54xOlEnHkLKNWL0nTqhJQHm/RcK7i6FsCzws
         hlNbSubFctUSyvRA3/YGpEAcrUbrxVX7hgD2OfC9w1fUoiAey+Flqe0UWcSy1V71FMrF
         WhvyOoLOspo+SxjSS13cYIjJ6yaBYp3jSLA1zpvQS/GL5c1uQ0b3IpAGcKC89J9LDoGo
         mm2bWOhcSwGGqbbTSwgcii2MLdgk1gZgi2f0F0/fzGB9oAsBJaOMM3pxtasN0Vd/C02h
         B2SRcAewskzNZ1a1XkoruteKxBO5phGT3s/D+MuRpukM1Ya4UmpE67jBzRdqaSp7M0cm
         PFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2NnCE+nkCzmC8SJdxfDZNmmoxjUO7CAw3RZJC+yBn6Q=;
        b=o6X7vVapdZN4X8tDXlom+Nn0GBbk22AynJRjMwfpj+dWp43LzoVXcqWIrmv+LLqQpU
         4ruUwwWP3vjvYuHA1VYWnpzp718vhQj78Hno6yPLqNhGXARpCk4BKRq2OUVk62NoWcEN
         MpTmL8tuXx2un5WN8AvjklDHPazWTk7uClvasdb2QgaM1mNYbRDS5GuyiDdL1V/Z94NM
         7/JXx9RX80sgoqettXx8GtAo2X5Sg/JvcXWLTk0vYRQXaZrJoc36BvMwBqxyeAgUT955
         gDrrxGCNdsEAw6lRRAGylN8qLsecmh2C+yT273Jw7W+qAo9XGstWN0MRtYp2uDRyiwft
         tPhA==
X-Gm-Message-State: AOAM532oyQNc3ftbWGxJcaowv59mBRK99AVYiHzslMdxQiSJ4uv+wcJM
        1i+j3EDEyLs1a+qRKzZZFoa3Xg==
X-Google-Smtp-Source: ABdhPJzM/cXN+ywswkURy4kyudPj+jpqw6iKygOl10+1E4y8ipwMdhQ45wzk2yuZOfVEpkLcT4832w==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr3000935wmj.74.1607425636802;
        Tue, 08 Dec 2020 03:07:16 -0800 (PST)
Received: from dell ([91.110.221.209])
        by smtp.gmail.com with ESMTPSA id j15sm14612745wrr.85.2020.12.08.03.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 03:07:16 -0800 (PST)
Date:   Tue, 8 Dec 2020 11:07:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, Maya Erez <merez@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH 01/17] wil6210: wmi: Correct misnamed function parameter
 'ptr_'
Message-ID: <20201208110714.GT4801@dell>
References: <20201126133152.3211309-2-lee.jones@linaro.org>
 <20201202185044.AD737C43460@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201202185044.AD737C43460@smtp.codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Dec 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Function parameter or member 'ptr_' not described in 'wmi_buffer_block'
> >  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Excess function parameter 'ptr' description in 'wmi_buffer_block'
> > 
> > Cc: Maya Erez <merez@codeaurora.org>
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: wil6210@qti.qualcomm.com
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Failed to apply:
> 
> error: patch failed: drivers/net/wireless/ath/wil6210/wmi.c:262
> error: drivers/net/wireless/ath/wil6210/wmi.c: patch does not apply
> stg import: Diff does not apply cleanly
> 
> Patch set to Changes Requested.

That's so strange.

I just rebased my branch onto the latest -next with no issue.

I will re-submit after the merge-window closes.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
