Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08D0281D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgJBUxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:53:49 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121D6C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 13:53:49 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y13so2996036iow.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EMlZtDSCazODTZpCvnwVrtAIuDpmFexo2dGZiSThtRQ=;
        b=lK+TuASA8wS5wwFzSWB1/JFG8CsKbIAC0qL9RnpN50/8XpsmayepLgunk/nsufbMVs
         nQbNfvLEA3QqNMX5WAqDXI0KlioBkePEoapSAQNNPOEs4cMxD0MlEm9AnvdY3PvSK7gG
         FVC5lIoFlKj3a6zpBwZ83LKJiwdk2eoKGb1dMPiDbWMHbnPnK85kUGHSyYbPudAin6FH
         YlDp+j10jB7Vc3lIzWpe4ZCDySruK91nlaDgn1HJJ7rNBicBx/exwNq6yJee94P3jSrF
         x+NUyoJQprpAQXa4BLTp/jLWYyqBOp5mbU5x7VqmRr/ebGPNWA7mE96kGt8yomKYF6ry
         38vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EMlZtDSCazODTZpCvnwVrtAIuDpmFexo2dGZiSThtRQ=;
        b=QTRKT7C966MxGOm2LZkyB6kcKnHH93BAbhQXPxsCB9nk9duvbHMklnY19FWXdzyux1
         YNofAHY+2MYugzE5Uo5CqKX5TeAiwQBnJt5aMLvauJl+/QebBhvB4EJeyRThhjgjp6Td
         6EGeeFy23xjriMH+avz+H44XyiPAdQJAdy6AH1imseaCw63OpzpBKw4nWaZO3FksgMBU
         GnSZZzBslQfUrLMrEDS1wxDC88jT0tyRX0J3XgjxQqzeinpTNtFnLBGdFEvOEgmGW0Rb
         Vqu/h5iIo/5YIp0BtSwqZ3w18Xo6UoXEnXuU0F9pw9S0QDkCZxWfpNJyKGBj9VTG9bC1
         /A3w==
X-Gm-Message-State: AOAM531dfR0nz7G0ds1qWUzpcTLrbjvHGlTbneXnHWaMOgTp2+OZOgSv
        cAkh2yjL+t/eU3Z2TVgPsVEYIBjiKzBjwA==
X-Google-Smtp-Source: ABdhPJyKFIG6LsYP9hYPo5YmGLJdHj7QUoUTE4D7yEHwDg/QE078YislAC1NdnVmn9Wjpevy/TpbvQ==
X-Received: by 2002:a5d:8e14:: with SMTP id e20mr3269850iod.119.1601672028385;
        Fri, 02 Oct 2020 13:53:48 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c4sm1380949ilg.25.2020.10.02.13.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 13:53:47 -0700 (PDT)
Subject: Re: [PATCH] ahci: qoriq: enable acpi support in qoriq ahci driver
To:     andy.tang@nxp.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Udit Kumar <udit.kumar@nxp.com>
References: <20200817082204.13523-1-andy.tang@nxp.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <79f76fbe-4b64-bef2-fcb4-45f9f14570ae@kernel.dk>
Date:   Fri, 2 Oct 2020 14:53:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817082204.13523-1-andy.tang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 2:22 AM, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> This patch enables ACPI support in qoriq ahci driver.

Applied, thanks.

-- 
Jens Axboe

