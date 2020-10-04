Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C0282C72
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 20:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJDSP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 14:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgJDSP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 14:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601835356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrSe+vZS53bNuwy2q7zYrWnCsVjNNKWA2YIO62AZBM0=;
        b=B8voeDro2xW2yUh1rBtjOhMbKQhdECSYVmw5AENeBIzzmZjsfvPdJKJmpD0tRCbVqw4Yhz
        RBtErKe2WvnsGoJTiLnvxeWVNCGJcFCuvGw1lAuQYTFBmLlzzAripJ9jTVMmC47qB8nEmo
        cEXnjUZRpasluUASWSWPLfqpW/tKf84=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-lLoJOvajNIe9PLjMvsNM9A-1; Sun, 04 Oct 2020 14:15:55 -0400
X-MC-Unique: lLoJOvajNIe9PLjMvsNM9A-1
Received: by mail-qv1-f69.google.com with SMTP id h9so4444993qvr.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 11:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mrSe+vZS53bNuwy2q7zYrWnCsVjNNKWA2YIO62AZBM0=;
        b=LKcNS2AgaphMoZLZDwb5RqFdCxHiNPLGtkOL1fC3WrCVZ+RpN6pUwJ+Q7BqJubW8ib
         B6elZKnOibZGEsCGJSTJpU+WFxDdvIWlAY8FNjFE4URkfyN7prLy0r+h86nXLeP8KHVc
         b/UG3U+bfhosaudpjTkigkH0tjrJkn4TEFB41+IaZm8NG4OnSPvy6smHwSSoPAdKL2gR
         khmyO48fxgcA8+MqFBwipvue5pY4DzpvjdWr5CNBzfUag2MTWz+ywb1usHtvGWNoq5IC
         jgKJxS+ip4aN6LGRvQGsTpxJQRaL1zeyMUD4IloV+QAATB7NjXACqzXYTvzugRmua1bf
         jIqA==
X-Gm-Message-State: AOAM531qku6MVZhfa4frGjEZSSnhRhMPJJ++6H9flt6UE5VdY0fF/zOa
        oTP6as4eCtIF02FYxUbJEbcJXKBkImr/vgkyfJSPkyX0Bq9CBVqhAPO7c6oabGdSVk2+GNbhV2B
        DIOXScRIRvFZJqRMg8AHHdw2O
X-Received: by 2002:a0c:ac44:: with SMTP id m4mr3186866qvb.50.1601835354673;
        Sun, 04 Oct 2020 11:15:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVUr6M1R/Z6CyNz7FvpTQCknO+UlcbpcaFLyqCNcLT81JWrrTWR76EUxBVmoCbS2nhohE6gA==
X-Received: by 2002:a0c:ac44:: with SMTP id m4mr3186853qvb.50.1601835354525;
        Sun, 04 Oct 2020 11:15:54 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f12sm5760340qti.70.2020.10.04.11.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:15:53 -0700 (PDT)
Subject: Re: [PATCH 02/10] fpga: fpga-mgr: altera-ps-spi: Simplify
 registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-3-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <828731c3-04ca-7c44-7686-863027993d55@redhat.com>
Date:   Sun, 4 Oct 2020 11:15:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-3-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/3/20 10:14 PM, Moritz Fischer wrote:
> Simplify registration by using new devm_fpga_mgr_register() API.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/altera-ps-spi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Looks fine

Reviewed-by: Tom Rix <trix@redhat.com>

