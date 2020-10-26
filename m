Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24E4298FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782155AbgJZOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:52:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46120 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442716AbgJZOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:52:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id n6so12917217wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p1ATpOW7fjmmAl8xtmCr7FlKnqWcx/tsWTiaC0juAts=;
        b=GbcCABbn1MZFMyY8cJ/56fcj0+99V3U20gVd6W+DTtpqeh2pRBDHXc2kPz3NECc09R
         SFP5KXC7nzZ4pSDHJ//lx3ABs34GR8mF22hsFPkOBHNHwua1ZmE3Ynpiu6ZfIuBcZ62T
         et2Q84Pi+O672GcidITbxefBnFxMNBxiTbrHioJSoF5dEDws5lISknG0QmiQja3ga9Ii
         u2PpyKc4BSOagB2n1WiDiDOZCs4kAZ9nZRuTuXs1OU+Bjz66ll7uoBXfY3V/QJf4l9g6
         TItcw6UVuXLjA6W6bqHSIrlQDJnFMfnPh9QLhKDGfiH/AafJOirtwKmNyzkPbhnmghl9
         R/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p1ATpOW7fjmmAl8xtmCr7FlKnqWcx/tsWTiaC0juAts=;
        b=Ywqiik3R48R3F9pXUIvCwFKS/7qXrK9sK38KBFdcntSXthTau6zbBLzJdBExrMrG+L
         t7t/xclLAd+FxPrro1mw+2Vymjwgq6BmuV1HbIrAHRy1wK8+f4CQM7E8RFhXnRtdWovp
         7Cg1BOUstKY/kqUrJ5XE63ZdtWKnANpD1W3JNd7t7BTLZBcy2zf6a/wV640otBw1D3wQ
         stmVPLukK9eLm2svvU31ADMlj5OWLbZRWrxgtf9Lyp+CF6KaDI6OZzt4VHPXE3PVEHr9
         oWXNUtbrtaDMkZ5Uze/OBE+xgA0drXlp+n/dMyR+aOPYPdGk12x49YPGMdwJtsTPqmQb
         47Dw==
X-Gm-Message-State: AOAM532/mAQ69Q1hao9JJB215tjuWhre+DuFZiBOhOoearZzGg0Ocn5v
        jS+sdcB0//r3ADPa1WNJNHxJ5ETfVu2QaA==
X-Google-Smtp-Source: ABdhPJxdpFTwysYkqbRSmVcQK0EOy70eZY5M5Qd3me5h/gpBQEZ0sPw8BPz+c1sg2SluLFkLJ2uflg==
X-Received: by 2002:adf:9dd1:: with SMTP id q17mr18548114wre.317.1603723973333;
        Mon, 26 Oct 2020 07:52:53 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id j9sm23341810wrp.59.2020.10.26.07.52.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:52:52 -0700 (PDT)
Subject: Re: [PATCH v3 28/56] slimbus: fix a kernel-doc markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <7a581d05aec5ebbd02be27513de1c5e5a25b7922.1603469755.git.mchehab+huawei@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7b37a351-9f11-e639-66d6-4ca251bcfeab@linaro.org>
Date:   Mon, 26 Oct 2020 14:52:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7a581d05aec5ebbd02be27513de1c5e5a25b7922.1603469755.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/10/2020 17:33, Mauro Carvalho Chehab wrote:
> Fix the name of the enum on its kernel-doc markup:
> 	enum slim_ch_aux_fmt -> enum slim_ch_aux_bit_fmt
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   drivers/slimbus/slimbus.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
> index c73035915f1d..00a7f112574b 100644
> --- a/drivers/slimbus/slimbus.h
> +++ b/drivers/slimbus/slimbus.h
> @@ -244,7 +244,7 @@ enum slim_ch_data_fmt {
>   };
>   
>   /**
> - * enum slim_ch_aux_fmt: SLIMbus channel Aux Field format IDs according to
> + * enum slim_ch_aux_bit_fmt: SLIMbus channel Aux Field format IDs according to
>    *	Table 63 of SLIMbus Spec 2.0
>    * @SLIM_CH_AUX_FMT_NOT_APPLICABLE: Undefined
>    * @SLIM_CH_AUX_FMT_ZCUV_TUNNEL_IEC60958: ZCUV for tunneling IEC60958
> 

Applied thanks!

srini
