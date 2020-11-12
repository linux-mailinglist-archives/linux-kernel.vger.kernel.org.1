Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DE42B0858
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgKLP0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgKLP0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:26:08 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D4C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:26:05 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so6373767wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EOQb8O713MWYvow0PtzHAqGajIqBfUVJt3v16q2UGow=;
        b=aiCtk0g4nFa+6R7y70FQ1VrpNMQHV4DKaaP8uelsKRqxbUOvUNo6enbrEPVLmFiCSe
         BgJRYxQIyqJeeI72nDnl6ZwMz0E8ym4+ZXLv0jMw8JJMUiS1Cq3TUsown5TUri8VQBYt
         mdO3JLhuGclqRKm8hSxNRV93Kn78visyOoCUJnI9yEstttBK9bLcayY7LFMe9zGQwGET
         Xrx1GcoYlNdEJqTqz5oxsj3peCEoWU+SOFPUCms0E4l688Ibu4uY26CBjf46LjFmrehJ
         LRl+ij7JT0bDSoyUsAnL5vbZpcyNteqZR/LAzQj7pp20+42YusnyViGgPlp1BHg96mSj
         Ifgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EOQb8O713MWYvow0PtzHAqGajIqBfUVJt3v16q2UGow=;
        b=RxMDrClKSqSqeENCsiK1XzDsmajUGARxiswPM56ygoLWW486BwTxYrhBt2VpT8CN4s
         2kwvugPxU9LOR1WIttGDTVoXY2M6aWWuQ2+yAr63kjqy7fqtxDb3cUcFTRU/uxEeBDBO
         NTsvzu8VgTxtOF1Z9FteU607fCc8RC+xsTxMvnRN/Ir13afSjI6ZkqC16y6pEjCTaOOO
         +4e691ejkAUhfqzSQPcoOg45vOaYeqIzA6n5GaSkqe2ti7hVeTZi/XBYdWKAiLwSWmHu
         Q+EVRELfTSkvQA4TxH1OZ7N0gcf1Kpe3HNMu00LgkOAo3TkJ6VrM3nO5nZ6Tls05twJ1
         EI4g==
X-Gm-Message-State: AOAM531SlJTP9Myywe+10NOWs9FIL8syZwhBxz77A7THsrZe1m9igfRE
        PUTiBRzo0Ukxz0xs95Q/e19wGqACyBlSqg==
X-Google-Smtp-Source: ABdhPJwrBah6ufYMOGrvvq8G9uj8QIoJ6cnPvXKHRu2xUsVIf144ik/dLCep+nXuAnm5oqOWNREAxw==
X-Received: by 2002:a05:6000:347:: with SMTP id e7mr39577wre.35.1605194764601;
        Thu, 12 Nov 2020 07:26:04 -0800 (PST)
Received: from netronome.com ([2001:982:7ed1:403:9eeb:e8ff:fe0d:5b6a])
        by smtp.gmail.com with ESMTPSA id r10sm6740333wmg.16.2020.11.12.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:26:03 -0800 (PST)
Date:   Thu, 12 Nov 2020 16:26:03 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kuba@kernel.org, davem@davemloft.net, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfp: Fix passing zero to 'PTR_ERR'
Message-ID: <20201112152602.GA13694@netronome.com>
References: <20201112145852.6580-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112145852.6580-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 10:58:52PM +0800, YueHaibing wrote:
> nfp_cpp_from_nfp6000_pcie() returns ERR_PTR() and never returns
> NULL. The NULL test should be removed, also return correct err.
> 
> Fixes: 63461a028f76 ("nfp: add the PF driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks, this does indeed seem to be the case.

Reviewed-by: Simon Horman <simon.horman@netronome.com>
