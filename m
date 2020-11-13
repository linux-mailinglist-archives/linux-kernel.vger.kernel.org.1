Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BD52B257B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgKMU2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:28:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgKMU2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605299290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N4d0vkH2jDuVh6EaDMA0To+X9vsAdXrKKMJenCgweLo=;
        b=MGBs7GepnTVu1sly0G/68cYTOLiYhblBjvRWEWwePn4z/TA9QVvEZabbn1TCTYu1zqqFk0
        pZcaO4h/3EcIPJ/D6a6Nk2pXJiItvOiH/c2Cv9WLSXh/fHoFeedj7WbmubhCHpexAk32OQ
        B6UQWQZhJqDwtZOMHvJ6iKnvfVjAPR0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-tLvclXSVPtCzwUMdTzflJA-1; Fri, 13 Nov 2020 15:28:07 -0500
X-MC-Unique: tLvclXSVPtCzwUMdTzflJA-1
Received: by mail-qk1-f198.google.com with SMTP id b191so7384411qkc.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=N4d0vkH2jDuVh6EaDMA0To+X9vsAdXrKKMJenCgweLo=;
        b=TVcn6o76sW2TVP/eOU1TvvcKXzYof+sxIeAP5IFE2EsYJAalw3L5VKf1R3vr+s/EMW
         wszv1j9AHEQXo+5YDt054fg4WET7aoTsEA9wgNyrgWCqxX3mm7hghQ8M7LutLhLaaeyR
         PQ6Q7ncfF8/IapGrGFxuRtCfXCINqpOpE22SmaR07vC21PFgx29nUrdJAqAFRDRTez4Q
         LoqoiiXiLEDOjHz1RkjFvY6gcce1G1+AVKoF6yWy3MvaPSb+SPLKxOz+bn4KdbXGoEqf
         AmiT/DibfV7XaiDAK+NikHn+9tbm/qQsEPAosTBeYDrUVp4uzTci4e4s4aVi5i8FOQMj
         hjYA==
X-Gm-Message-State: AOAM533L3EKygbQhAi5efLqDtlRkfROX3H9D5h2xkQVy5FO2/mCHH230
        R7HVaSlE0G9A9zoPzCNT6SxuJycK+QG1ElVw59RpkEoxBr220YHrbs8W3RQU5NYa62z5m3K00l6
        UyvjzKlZlLgNGx3vuG7e8JLEt
X-Received: by 2002:a0c:ff28:: with SMTP id x8mr3795912qvt.46.1605299287273;
        Fri, 13 Nov 2020 12:28:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyH1HPtDvm4zxJ5teG+say4QQPsf31SE1HYPgNlKf4LmiEo6c5waFRcDwTqwrktk95SZP4V/w==
X-Received: by 2002:a0c:ff28:: with SMTP id x8mr3795896qvt.46.1605299287114;
        Fri, 13 Nov 2020 12:28:07 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w1sm6006071qta.34.2020.11.13.12.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:28:06 -0800 (PST)
Subject: Re: [PATCHv1 3/4] dt-bindings: fpga: add authenticate-fpga-config
 property
To:     richard.gong@linux.intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <94ccfc8d-ecf9-7782-9044-d3c0cb862118@redhat.com>
Date:   Fri, 13 Nov 2020 12:28:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/12/20 10:06 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> Add authenticate-fpga-config property for FPGA bitstream authentication.
>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index e811cf8..7a512bc 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -187,6 +187,7 @@ Optional properties:
>  - external-fpga-config : boolean, set if the FPGA has already been configured
>  	prior to OS boot up.
>  - encrypted-fpga-config : boolean, set if the bitstream is encrypted
> +- authenticate-fpga-config : boolean, set if do bitstream authentication

The list is mostly in alphabetical order so the new 'authenticate-... ' should go at the top.

Improve what you mean by 'authentication' similar to my comment in the first patch.

Tom

>  - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
>  	bridges to successfully become enabled after the region has been
>  	programmed.

