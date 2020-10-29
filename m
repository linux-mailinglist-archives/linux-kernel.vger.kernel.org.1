Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF99429F669
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgJ2Usp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgJ2Uso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:48:44 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3767C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:48:44 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x13so3332616pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7jTNHive/FLwf9ZZT3i6CSw/O2mDxcoGdERzu325nls=;
        b=S1eLSOvxPle2SWTXmcWkjdxAG8gKeMEQNERefUSZtQOj35IZKWi6zQ3XA/x7yozwz8
         SuJqxRhbB4i6YZ/pUVv4PdoQ6A/WOXxwmF1BPT1/90DX/CA1WzuJ0SBOp9PqwSiCKXSH
         F0G3QbbwVleLe5Wk2wNrW1vW/731JkCOacLvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7jTNHive/FLwf9ZZT3i6CSw/O2mDxcoGdERzu325nls=;
        b=j1Rm/vKVRay7io/cmrcp+0org/pbwpV6ADyxEkZUfuT6M5cTpnk2W40Zd3tgEbUpPZ
         R++HJDt8pxZB+FAmq2qt7QThUvUoOrpShRlwb4iiA2yvkA0F7gPC7VQxMG7acymzTXgZ
         B1T7ZD2Lu/1ucu2dY/jeK4aFjkOOB7OLSAjmi2CA1+m3US5XS4RcWb0cb8OCzoS224Yc
         DYlgsg3yQY3J744cq8Wn9j3s3AZVIdpTbRV8a3AWNUr+9FvEGQiMRZD7mmoaTb/JsjZU
         qEEJ1qU0MmSgWhAiaNmHPl+6+63vY3+hO0UyjNt4GSTSJIbbenxumW22quqsbN7/kaDS
         hYRA==
X-Gm-Message-State: AOAM530STq4moG9WA8xPAqKnnBKlCknfOdYYsHnYkqsVAp/U5wePB+Kc
        WaUHZntCeSEK3hwK4pXPwy/UEXwcFqMsVQ==
X-Google-Smtp-Source: ABdhPJyNFMcPbWUco+Y+QNwEzgo/c6cxhTHy+B3buEgXZaS5imhK9G19CfKi/1d1jqh/zqA5P53RtQ==
X-Received: by 2002:a17:90a:6984:: with SMTP id s4mr1082688pjj.206.1604004524081;
        Thu, 29 Oct 2020 13:48:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id e5sm808565pjd.0.2020.10.29.13.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 13:48:43 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:48:42 -0700
From:   mka@chromium.org
To:     Akhil P Oommen <akhilpo@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, dri-devel@freedesktop.org
Subject: Re: [v4,1/3] drm/msm: Add support for GPU cooling
Message-ID: <20201029204842.GC1855806@google.com>
References: <1603958841-20233-1-git-send-email-akhilpo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1603958841-20233-1-git-send-email-akhilpo@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 01:37:19PM +0530, Akhil P Oommen wrote:
> Register GPU as a devfreq cooling device so that it can be passively
> cooled by the thermal framework.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Wait, I did not post a 'Reviewed-by' tag for this patch!

I think the patch should be ok, but I'm still not super happy
about the resource management involving devfreq in general (see
discussion on https://patchwork.freedesktop.org/patch/394291/?series=82476&rev=1).
It's not really something introduced by this patch, but if it ever
gets fixed releasing the cooling device at the end of
msm_gpu_cleanup() after everything else might cause trouble.

In summary, I'm supportive of landing this patch, but reluctant to
'sign it off' because of the above.

In any case:

Tested-by: Matthias Kaehlcke <mka@chromium.org>
