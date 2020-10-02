Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B48E281D29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgJBUxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:53:21 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FE2C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 13:53:21 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id z5so2477859ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wHq6QcELskmqQRbbU4Ez9UDNOIMAxI4Z5sj87N48/Fw=;
        b=z14sUQRsQEbcJRMRplX/SB/Ow/6qIPls8y6yDJzR/FwPuwWmFNRGds+el15H0RGFzO
         jP43lWR+p5I7KG3G+ykDaNPYi0NhybSEys6KL11wzljEV9sMGvj1+B6Tya8yS/yOJL5y
         Et4LyH0jPCD0bkzdUxLZ6fIZbufd7XiJH1dMYDHxjVI409VP+02GJ3jLIhpktz1tAQNP
         PtPOPdsBwSmjqfJuZdJ6TT7Z0ka3S0bKEPK5MBdihkh2aJZkgF9bjVBS4OchCPv8BBHz
         tYMdziLTfSAkllmIkzMadb8ty757m8uSCpjv2/d3++0qguU6qjQALNx3XSfmOympLcQH
         Ji7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wHq6QcELskmqQRbbU4Ez9UDNOIMAxI4Z5sj87N48/Fw=;
        b=bX8UnXhN2mbtFvYStgdX/U6GAkd/k11JZ29Jl1sJ5r5zoTcCejFTRn5+uOfPq8RAS4
         B0x6iDOaVVcKw/HZ1+mricGOriwRJXaOZmXFdt213L+mamPW3LRAo7Rn59wFJHNluyog
         KI5zJ03R/MVCp3wz99khdvk0w/WuJLScsa8UGjQsj2v5Hcveht8ZwOG3gbAjpduw0Egy
         ab/Sj6lFm9owksxsji9ti7s3sMN1Kk7dAfVwJWf53MOjNgi0btKE9stn45XPjiCK4W24
         Crl57mL/1it1VILtS41xnCsYdjDwSW/iViTYv+dAOmEGDyXfyqUVu4cKe+9MN5M1sTCY
         1F8Q==
X-Gm-Message-State: AOAM530xbdGfPs69Bl7kh8+730QiMu70EnDsdn3G2NzvF/2+ik+7SBXZ
        gUkeCljsDk/U6Nv/FGy3+7wYknjr8IUYFw==
X-Google-Smtp-Source: ABdhPJy9gj0Vn/6u+oU0soLG1bBBgGtK/ALilnTiu7tfBCDQ/q7rkmoX8MaVq5GEPkRsft6i7ujlGg==
X-Received: by 2002:a05:6e02:1085:: with SMTP id r5mr3184792ilj.44.1601672000703;
        Fri, 02 Oct 2020 13:53:20 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v15sm1341214iln.83.2020.10.02.13.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 13:53:19 -0700 (PDT)
Subject: Re: [PATCH -next] sata, highbank: simplify the return expression of
 ahci_highbank_suspend
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200921082451.2592033-1-liushixin2@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <908d3f35-3243-2f7a-edb2-5bcc5e9348de@kernel.dk>
Date:   Fri, 2 Oct 2020 14:53:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921082451.2592033-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/20 2:24 AM, Liu Shixin wrote:
> Simplify the return expression.

Applied, thanks.

-- 
Jens Axboe

