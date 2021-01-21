Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8332FEA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbhAUMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731453AbhAUMs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:48:27 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3744C061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:47:46 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x20so1606295pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pchBZ7HrMs8fZphopy3YDMD9Pzv91Q8ikc/LwQCGD9A=;
        b=Qo7/tKnFyoY63WscJuG87dCR0YHTLw4CuGfhNpL027Ij1ktidD14qE1r0pPniXYlsK
         2gCnCtdtvfrEx2OCmB2KG48Pu4wjmh2X7jxjUYI1nqYqtjk0/Q0A+xjDA8ynIYzV+5PA
         gEp6wH5Xa6gzI3P7E4KOBBF+8QhSFkgqhk3UgubMDoH2F9tObgSjI4HDNjBCHkRVSb7V
         /FYzj8b5ah+97R5TGGlkxVIhPt+lcBEQppuxkeymQVlNofcjLlQLE4vzZyPaNDLBF5Gi
         q6Hh2KNuOy6alvDcQ6vVJGpg1+SlGXmJIjiKGJXMgRONl0F+EI4Bnmt4WhkTaFvquZp+
         e7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pchBZ7HrMs8fZphopy3YDMD9Pzv91Q8ikc/LwQCGD9A=;
        b=ErM2mg57EXWGDbsBGnje9W9NpYVLz6PJfV/CYiMP+xz5TQkvX9CGP5tj8QucLQN2PV
         oRLY/8NiEiSn8kcVLWAa7ow4bjtuJ+jRH5ttVTqtwJn9C29azyNagIdrSBeBOf3ZEHpa
         zaK27ypIZOC0OMxtJajha6hiOgBmZUbzVHsh7FWXGGuDyE3jBNpp6/h0txF1Z10Stwvf
         ZXIVXBzzkCs6oCQyk4fX7GiE774NCeI6IBtlMDh9lxyPyCTYzLkFt9W1kVIl/edUle/G
         zOmAZL1tysyctUTq8qN6tOG7CxtGMTKqW+W66nQNaspb8VujeNriSby+x2iac+THWFQQ
         UFTg==
X-Gm-Message-State: AOAM5324ClPrey3wuKh6YotxY3bg2+hKlhTfjT+d7mssX64BsirpQ5dB
        kB/V/TYTvsAtr5sHmpV/Q84ghmvaVHT03w==
X-Google-Smtp-Source: ABdhPJzQPMUrZphrYzYVhVNMuufMyE+goiPwMAGTU/u0GeF2CpcRzIxMclsebqO1hVr+1hVPj+HEtw==
X-Received: by 2002:a17:90b:11d4:: with SMTP id gv20mr11776619pjb.116.1611233265990;
        Thu, 21 Jan 2021 04:47:45 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id e17sm5889996pjh.39.2021.01.21.04.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 04:47:45 -0800 (PST)
Subject: Re: [PATCH] lightnvm: fix memory leak when submit fails
To:     Pan Bian <bianpan2016@163.com>, Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210121072202.120810-1-bianpan2016@163.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
Date:   Thu, 21 Jan 2021 05:47:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121072202.120810-1-bianpan2016@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/21 12:22 AM, Pan Bian wrote:
> The allocated page is not released if error occurs in
> nvm_submit_io_sync_raw(). __free_page() is moved ealier to avoid
> possible memory leak issue.

Applied, thanks.

General question for Matias - is lightnvm maintained anymore at all, or
should we remove it? The project seems dead from my pov, and I don't
even remember anyone even reviewing fixes from other people.

-- 
Jens Axboe

