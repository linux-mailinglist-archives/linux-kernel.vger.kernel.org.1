Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7423C230DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgG1Per (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 11:34:47 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:42312 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbgG1Peq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:34:46 -0400
Received: by mail-ej1-f66.google.com with SMTP id g19so7277872ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Gt0QHwtzdH4z262wIb70iMKw+A0SGUVc8Tn0FAViKU=;
        b=JlBcAlfY+3CNhUNtkIasbzWm3KWI9thdJLC4MHEJSLzldjbNm1/2QHXtdyTMFejMN9
         EVJ6BiPaO/Y0wNMc6GQNZlORX3bo12iVz2mwMshK8zOJdiMqf0h/biX2s2p2EbdlPJyi
         VDSdGa7hKyuB4PtFmoWAFJkoAChZbFKy4SFNsqghxdxuOlNRkn068jYE1ZohWS+F0ER5
         UlY3FU++TO75gh7sv+saR2nKd2ujjBVpPKMQvZ4eAumdZq5RhQRomDp9M45wUWnvBuU3
         kFbc2VpKByqhH+wqrqDq9ObUgUPK9PrrDe82ARF5d33g25Ck9BC3dL5UsQEiRDUmrkwa
         dIUw==
X-Gm-Message-State: AOAM532q/9nppWfjOAgk1c9VIjFvPgju/dFREQji8OAjkA09s/TWPwxT
        KZB6YCliGfABrfVJPDGvkGk=
X-Google-Smtp-Source: ABdhPJwfnB21m8a4Fuk44HDkuAi2hrixWDa4/7urjvF4eeV0L4xhSM1bpHjKRFF0s/xoDfrFx3fESg==
X-Received: by 2002:a17:907:41dc:: with SMTP id og20mr27042300ejb.183.1595950484801;
        Tue, 28 Jul 2020 08:34:44 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id ck6sm10070701edb.18.2020.07.28.08.34.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jul 2020 08:34:44 -0700 (PDT)
Date:   Tue, 28 Jul 2020 17:34:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2] memory: jz4780_nemc: Only request IO memory the
 driver will use
Message-ID: <20200728153441.GA15034@kozik-lap>
References: <20200728152629.28878-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728152629.28878-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 05:26:29PM +0200, Paul Cercueil wrote:
> The driver only uses the registers up to offset 0x54. Since the EFUSE
> registers are in the middle of the NEMC registers, we only request
> the registers we will use for now - that way the EFUSE driver can
> probe too.
> 
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: Only ioremap() the registers we will use
> 
>  drivers/memory/jz4780-nemc.c | 17 ++++++++++++++++-

Thanks, applied.

Best regards,
Krzysztof

