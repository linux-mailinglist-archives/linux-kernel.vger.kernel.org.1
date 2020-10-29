Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CC129F42B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 19:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgJ2Sg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 14:36:56 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:37233 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgJ2Sgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 14:36:55 -0400
Received: by mail-ej1-f65.google.com with SMTP id p9so5215729eji.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lTgq2KUsCb/reJLVeXMJ6WnOU7EAbYhrVIOVottwPXY=;
        b=TH+qHdzmjQcCaNi1yyBSx6HJoQKktWZBFVLcaH/rzYr9TdsJALPFN0xAaahb0sdzwZ
         V6RKZo/qzM7/ACOFjSfvAuXnsyd/7JoUB72CX3xdznf9f+AvTMsJr9uJAzou9yxEcmOF
         GwlCct6aIx/mvx2xi5ECsPwfRU1OoVw332PtPoDNl9ZdLd105JkLVbk2VVIHYuMHKr4B
         FFtdRGYtCZO5RNeLXzvjvet3oF7DUaBQrd1RYRjj+iuJWbXrCYTPRYRhdkEBvsko56r6
         /CUIhtd+HQC7uTgoNg6BqpDSu2S4rUR8K4NV2USZwGe1mFRkGYk03WAXo/Y+lJ7YjIZE
         kgGA==
X-Gm-Message-State: AOAM530uj2S0Wlkk80rqY2SosDj5es/KonHBg1ot3TpsIWcYIhDyeFFC
        GP/IkCsh3hOoQMCw5Jx0mh72EPRwkACT2A==
X-Google-Smtp-Source: ABdhPJz15Gme1PyxsPn9plDfwSvEBR1ta3aL6LW0bJn08NQn+YqpzcbGI2E5da08qYYQ2eW1WaED+Q==
X-Received: by 2002:a17:906:3daa:: with SMTP id y10mr5377897ejh.23.1603996614181;
        Thu, 29 Oct 2020 11:36:54 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id w25sm1888481ejy.123.2020.10.29.11.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 11:36:52 -0700 (PDT)
Date:   Thu, 29 Oct 2020 19:36:51 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     sbkim73@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: samsung: i2s: Remove redundant null check before
 clk_disable_unprepare
Message-ID: <20201029183651.GA90952@kozik-lap>
References: <20201029083715.28561-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201029083715.28561-1-vulab@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 08:37:15AM +0000, Xu Wang wrote:
> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.

You missed other places with it - the resume part.

Best regards,
Krzysztof

> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  sound/soc/samsung/i2s.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
