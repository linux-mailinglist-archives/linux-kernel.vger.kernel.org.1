Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922F52B811E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgKRPrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:47:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgKRPrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605714459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wz5+FE9bAMzYtx+QuurlfxPZ+X0bOUwPaG6fhTkatsc=;
        b=QLhP61T72RJKGn6icXp9Jh4UrI5fqzfwy6eq4pmc9Pu++FtbkSACk2mpulFMaJyJRixqYU
        w2G2mjdolA8c/zyQlIJkrXHgGZioLjVnmfOtzTNFyI5iT4Gq5AXWQmsPqe3cTmrWJUUI+0
        vx3vh7E4LV4HefHAxqkioG1oPiAS44o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-lZ70b5zRNk-bfoB3v7rtZA-1; Wed, 18 Nov 2020 10:47:38 -0500
X-MC-Unique: lZ70b5zRNk-bfoB3v7rtZA-1
Received: by mail-qv1-f70.google.com with SMTP id s8so1564178qvr.20
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Wz5+FE9bAMzYtx+QuurlfxPZ+X0bOUwPaG6fhTkatsc=;
        b=e7PTtOSaqQ+xFc976PkOTT1VQtAMZklEosLWlVZGtq3H0+DENGyL2S1F7JhIG+Ivi/
         9S3hleFX7cgtjj5GWdZlvBo4L2raCdCcD7IxvCP37BDyTpNZjkwtWYxDXWkd7SNBxj93
         chmTDWl9Kbn5GgBspLekNXsXqIOg920n7bkp9/evqhNFkUU9q0+IXqfOUZCbPKf7WZvm
         B1C4/xHArRINTfMGykOAD5R7Jz5Kmm8UlasbC3QwL+Jf6cP32BRa2w34eL131qjGwVJX
         tAu0EzvFhAE6GjCWXtb+g/8uIs9in9XH3AGMF8pJFTDVU0PtUAxgRC8nKIWZZFOaufgh
         MyuA==
X-Gm-Message-State: AOAM530zXwxs6V709X2E6N5gf8m30SLABDlFuLOJq3rCVLpXhiSDuHaa
        76D9z4Zy1YYEAw8oxuMJxjjRWvf/c+Y4w/J9qW1xgwWl/gG3NIW4NXlkFZb0kr/os/NSezFHQ5Y
        9NgF0bCTEttuFIcD6IN50N4N/
X-Received: by 2002:a05:620a:15a8:: with SMTP id f8mr5620970qkk.346.1605714457729;
        Wed, 18 Nov 2020 07:47:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUwdxtFqbmmvh/827o34k0fEoaZM4SbxhMKEuNheO3LWAfgr7xeAquFb53rUrLMKbQZWy7wA==
X-Received: by 2002:a05:620a:15a8:: with SMTP id f8mr5620956qkk.346.1605714457473;
        Wed, 18 Nov 2020 07:47:37 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f56sm16794253qta.49.2020.11.18.07.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 07:47:36 -0800 (PST)
Subject: Re: [PATCH v5 2/6] fpga: m10bmc-sec: create max10 bmc secure update
 driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201114005559.90860-1-russell.h.weight@intel.com>
 <20201114005559.90860-3-russell.h.weight@intel.com>
 <9b42ad34-84bf-7409-414b-925c143c7959@redhat.com>
 <dd900582-5179-d877-2a21-c592b34fc831@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1e9cf9b4-18db-be29-1133-c15e2e55cbd6@redhat.com>
Date:   Wed, 18 Nov 2020 07:47:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <dd900582-5179-d877-2a21-c592b34fc831@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
>>> +			       hash, sha_num_bytes / stride);
>> Assumes !(sha_num_bytes % stride)
> Yes - good point. I'll add WARN_ON() here and for the CSK cancellation vectors.
> In these cases, the size values are fixed, so a WARN_ON should be sufficient.

Yes, thanks.

Tom

> Thanks,
> - Russ
>

