Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF2282C80
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgJDSZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 14:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgJDSZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 14:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601835937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wU6OhJko6VhIO7lVSPg3P81cYiicmmD1jTy02y5YtSU=;
        b=AphX0evQn/6oNAkVG4UF6NeI8h15B04XXBVZEsb4FChXyRqiNYk4gyV4+hJ+sdi4XHZt64
        FSFtjOhFAi+SkxbW3/w7YLFqPoZ/WXAYAaLEoz07cU7K41mz32Y1tHatx5gO2HgGtkwvaq
        eGlR68PqkeT0z6X32GenXJ0ekjVSkAY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-uQ8GRNiqPu-wWsdB-Mr-3A-1; Sun, 04 Oct 2020 14:25:35 -0400
X-MC-Unique: uQ8GRNiqPu-wWsdB-Mr-3A-1
Received: by mail-qv1-f70.google.com with SMTP id h9so4454291qvr.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 11:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wU6OhJko6VhIO7lVSPg3P81cYiicmmD1jTy02y5YtSU=;
        b=gjJn/dRgI0gFMUvWeNqf86oc7xMhMukAo2xAv/p4Y/aWz1lxs1Q7i465m8qNaz8jS5
         NTbCXSF4OT/YQHzgGUiZntuiXKjCaZPcCYSWgtxXmAkTM7FszNX/r//qADY808ZK0MFL
         V0ec2aC3o6/tII41nkVmRuoG0NLFv6rEjnVSOnJaIVN9E1nqB+d/lM6fWpMVh4jILb5Y
         T0zh+MD0xQUUMS0luDslMCO73hOwHclsVT7bC5mkKXKPiwKQTivP+CkRS7DnX3UjzEVJ
         6B33ThUOOtGdpaeCamM3qOatSr4c/TBRG+aLcUJzje7uOxvgCYyGK1JugRfvhcJjo63l
         qsOg==
X-Gm-Message-State: AOAM5305HpE4WGko5qbRuYcQoxPGl2L3G5DK78XiaxQ71HPs4nNAZYTk
        U/HwDyfQ6FPU0tfrzdkc8kt8GwZUHKkjGvvMLVb/egQGw08Hx4T2RJ7XcI5zdT5rImclWhvSkIH
        a6LWpeyWa2EphN4OhHJ0lajnD
X-Received: by 2002:a05:620a:a52:: with SMTP id j18mr10483345qka.445.1601835934842;
        Sun, 04 Oct 2020 11:25:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcoC9UKCgEDXEt5EzfhF7NcNBdnOuM8EvSugC2qsBV1EiKi8UvArEvWnZX7HBfQdQ7Esb1wQ==
X-Received: by 2002:a05:620a:a52:: with SMTP id j18mr10483335qka.445.1601835934634;
        Sun, 04 Oct 2020 11:25:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k30sm4260566qte.16.2020.10.04.11.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:25:34 -0700 (PDT)
Subject: Re: [PATCH 05/10] fpga: fpga-mgr: machxo2-spi: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-6-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7551aeea-3284-7384-fd43-947d77f29101@redhat.com>
Date:   Sun, 4 Oct 2020 11:25:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-6-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/3/20 10:14 PM, Moritz Fischer wrote:
> Simplify registration using new devm_fpga_mgr_register() API.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/machxo2-spi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

LOTM

Reviewed-by: Tom Rix <trix@redhat.com>


