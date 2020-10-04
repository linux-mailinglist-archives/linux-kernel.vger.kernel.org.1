Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31313282C87
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 20:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgJDS2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 14:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgJDS2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 14:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601836126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xOxSfxeCI1vhD/dskmKSRI9XvKMJ7mCuzK0/TO95BvA=;
        b=TFQ/YTSGqgv+H33fkaXIYgf+X1+mJ3VOwYIixeCFes1UvCUpdHQfYnqZMeBmBYFe0xvQFm
        yD4TVver2phNDcy1NVNKtMWWHL95tjgmfWzRZJ667tEzz+q3QiVyMz+0ySgZLi5vDhNt1+
        81k4sTibatwA2W4owQS3vYnlpnGaWb8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-odN5ziqHMVasKandq0iNjA-1; Sun, 04 Oct 2020 14:28:45 -0400
X-MC-Unique: odN5ziqHMVasKandq0iNjA-1
Received: by mail-qk1-f198.google.com with SMTP id a2so5090100qkg.19
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 11:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xOxSfxeCI1vhD/dskmKSRI9XvKMJ7mCuzK0/TO95BvA=;
        b=PF6qGDpnFfoghgrAJI2DlHpnGu6D4YkZXHv2IZAsq4QwJRa3KbUiM9UGTNIYlvjTPo
         G1NNTC8wxD36ixi4aMWvzT6hLeGeUtt0lQBSLeFiZ7krhVrx1jXvwn1ptQVReT8ZM/gh
         ybtU4QunY8taMsqi8DlbL0NENgo3P+dUVstIWIGMENaa/bEXekHeMcCO76llhS7tvJMp
         Q9Zkn2SGq758cdUkEPQbv13RAWEwHOF4dYMqVBvEWrpYgx0p/jlTaBqfYo3kDZb+dZHA
         Yxhco25JPesEskmvtLKzbc/Xap9gn6yy4k59Z6FLaBW3OZlmKbCaPZLHbRKKrWml6aDQ
         XJTA==
X-Gm-Message-State: AOAM530FWpiT5Gi38a8QjVUkaQ3eVUX3BaPjFsa07Bd7+2RFUEsQOc2s
        0zL5Lxwe3sifTxCtUbca6QMRapTZFRj21ctJyPP/oX58vqDpNsUG1dZviI4wQ4Jx4Aq00OcFbw6
        x6xfwoM31aTh6T7Jh/BbRnqi3
X-Received: by 2002:ac8:66da:: with SMTP id m26mr11188060qtp.111.1601836124802;
        Sun, 04 Oct 2020 11:28:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxCRLUrv/x6qqQxWUHnqymYZ8mtoHMNhTSs+0hGnFHZmrk8KbdFz6OM03cgsqXAfd5hwRCYg==
X-Received: by 2002:ac8:66da:: with SMTP id m26mr11188048qtp.111.1601836124631;
        Sun, 04 Oct 2020 11:28:44 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l11sm5715834qkk.35.2020.10.04.11.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:28:44 -0700 (PDT)
Subject: Re: [PATCH 08/10] fpga: fpga-mgr: xilinx-spi: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-9-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2bb733ed-1a8e-c45a-6729-f910f78ffccf@redhat.com>
Date:   Sun, 4 Oct 2020 11:28:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-9-mdf@kernel.org>
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
>  drivers/fpga/xilinx-spi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

LOTM

Reviewed-by: Tom Rix <trix@redhat.com>


