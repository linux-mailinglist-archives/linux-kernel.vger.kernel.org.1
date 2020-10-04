Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87300282C7D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 20:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgJDSYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 14:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgJDSYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 14:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601835856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8ZxNpupxwPTV65+RP81g4lkpz2i0Y6pCQ1xRwIRNME=;
        b=IyXvCt1Ia0Ddun5PbFpaXmQLRWs/7yIFDwLxYspqb2p9Ar8+C7EXSnOyL6fADC2KcDRHTO
        f2gWx3Dx8E5NiuNZ3pAZKq+jzSidZjGJTi/5961kYWt3YMvXd5UkzNtVzgLFVPZDaIh6II
        IQY+RaAF7P3CIj2WEbaenWoLEypLQNg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-nfVHkUZ6OxSRn07iUkW03A-1; Sun, 04 Oct 2020 14:24:14 -0400
X-MC-Unique: nfVHkUZ6OxSRn07iUkW03A-1
Received: by mail-qt1-f199.google.com with SMTP id y20so3556214qta.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 11:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E8ZxNpupxwPTV65+RP81g4lkpz2i0Y6pCQ1xRwIRNME=;
        b=CxT1P15BxmChvsAtw/RfDwd6JAXV1yJ/kVp2lbR2Plho+W5DbH5ymuAAP411jvhaGG
         g9uW0UecBiPaL2vZrOwtyKQu4K/ztCEUBIgssAFUyR7Ez1LE3VZZf50wIMcLFfcb5Bj5
         WVVK6Ypnpe/KneXVhoI3dNHL0Xn75RXAyOn9lnbBQ2t6S+KbvI1ZkiYcUrHgxSxSDgMc
         JBdbTPRUa9qR9PVw16dOg5GkKuQckm4taH/pz9nNGetGzrEabUQ7W4qT3Bfwpk06u1xW
         lr0QKhXD56W7w3KovoyibR1fD+vCXvyWgXnBVzfnirZQXHwn1t/xhxzScWLgRoFRU5f+
         hh5g==
X-Gm-Message-State: AOAM5317SDOB8GwAmQ0NuHH4+/4rNlYi61qHEtHTlFs/XUb6mxQ9OBiG
        KI4SGpj+G+7QpD3j9SKua2DLieX2YzdiVPl2jPTTicjn+Y+HfErtRDMXn+wolp5evIKie/7xKzn
        UEaEljnnwIO5kazFM/lbZE7EO
X-Received: by 2002:a37:a09:: with SMTP id 9mr11595367qkk.258.1601835854184;
        Sun, 04 Oct 2020 11:24:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD6FYIDoIjEuVUH1ue/9evG4iw0FY1m5Y5S3lDj8QlchqRq0P5tNL/UmpyyKi5RI1PY4dYNQ==
X-Received: by 2002:a37:a09:: with SMTP id 9mr11595349qkk.258.1601835853987;
        Sun, 04 Oct 2020 11:24:13 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b191sm3008044qkg.81.2020.10.04.11.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:24:13 -0700 (PDT)
Subject: Re: [PATCH 04/10] fpga: fpga-mgr: ice40-spi: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-5-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7db1517f-0244-ae4a-4a2d-78b3a9adf64a@redhat.com>
Date:   Sun, 4 Oct 2020 11:24:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-5-mdf@kernel.org>
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
>  drivers/fpga/ice40-spi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

LOTM

Reviewed-by: Tom Rix <trix@redhat.com>


