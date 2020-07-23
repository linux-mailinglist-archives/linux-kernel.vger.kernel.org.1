Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3402022B350
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 18:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgGWQS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 12:18:27 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:39852 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgGWQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:18:26 -0400
Received: by mail-ej1-f67.google.com with SMTP id gg18so3615046ejb.6;
        Thu, 23 Jul 2020 09:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t4n7avDIfbjejyLahGPAWeDks2RRttB7YWwdukT5JYY=;
        b=G0xXgUexGCcZy3H4EB/dwoZBBUPFlLkAbjiBev+DZ61/X+Xa0LSVR13fEDtwZ0SH1g
         GmjtHDfAJTgDCNQMieleV4gqdMliOCU0nKQsEeMYf8epjN4RlxekqRagQKQrHFxbA0Xg
         gT3VGeHT7KX0j4mpS5d2kEYEpcLONHs6tGVDm2ak8tD4vKs2aT9DRa4z/Lx6tzWNLann
         +/e8rbDjP3AXhCFSDE3fQ3cR0SxGPstMcehxXuPw8nuRd3iqid4pcBevTheJq7VOQrZ0
         /0aJYp+RHz6yxli7ZPE9WOUK5fWFsQVRCjLrHW1rdZjF44vUtsLxMGOvTBgzTFk5aZjh
         nASg==
X-Gm-Message-State: AOAM5313anM/5ZVVlxGsPP0/ai2x7i4eQfbiVEAD71IMgpa1uu9Juz/+
        P94aDxaBHx+qycaJngJ0D6xVBlLhyAE=
X-Google-Smtp-Source: ABdhPJyO0TZdQEK6f6PdYNCQvZRMf5aohvfKrQ/3IWk4FdQ8edZBvGjscctZ+XwSokSaqsS4yxDhGw==
X-Received: by 2002:a17:906:26c7:: with SMTP id u7mr4924975ejc.13.1595521104506;
        Thu, 23 Jul 2020 09:18:24 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id lm22sm2327391ejb.109.2020.07.23.09.18.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jul 2020 09:18:23 -0700 (PDT)
Date:   Thu, 23 Jul 2020 18:18:21 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max14577: remove redundant initialization of
 variable current_bits
Message-ID: <20200723161821.GA31365@kozik-lap>
References: <20200723161541.994669-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200723161541.994669-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 05:15:41PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable current_bits is being initialized with a value that is
> never read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mfd/max14577.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
