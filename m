Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E5D2F1940
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbhAKPNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:13:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35136 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731299AbhAKPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610377923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zH2sY2KFOZF7TSs2Cj/3HvzX9baKiIPNLIu6OGwY2+M=;
        b=iTZ9Dt3UGCVQ2+XRFE/ePihDxClp91i2MsAPxbXquzHCVVMUJTQKrRybR13eezKOgDMoAv
        HYCgf1Hu3Rj18s27IdG3TsgeNJSVyPN9y+/i4BT3zI23MSiGE5XDyZgUhn1azcL3xZKaRP
        +CZV7xKAH6oAlHazgq2rqa4n3DdDDDU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-NCasrmK5MWygKp9owwR6TA-1; Mon, 11 Jan 2021 10:12:02 -0500
X-MC-Unique: NCasrmK5MWygKp9owwR6TA-1
Received: by mail-qv1-f71.google.com with SMTP id t16so13372944qvk.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zH2sY2KFOZF7TSs2Cj/3HvzX9baKiIPNLIu6OGwY2+M=;
        b=GXsxRX3vIUC52qEwPbJqK6AxpCCYDNLymGVZdpboDVR0p75SShIlsYbfnLrDrfyx+Y
         A+daRQi+TdtY8tWm3GtBC63Cdkp1lc8xFEiPiwgmUr341drIEYZRwHD4vTElZUPk6yst
         3YuGtefaW/3r47m+IRQRx17ytqNjlcqbUNCeYzxfdXvl7s/XuxWzwXckGpzIm85dqXOW
         Z5Cl7USpCdgpRSeNlF8zvpmChpgo4zHz3IS3e+QURCZN147tQwAWrYmSh8pgAmASzb19
         tQ+/HWVqp7RV5Rl2Gr30VOfv5t6J4+AVONE7INRy3YCjYWxtz51kK2/080GaokO/WU7A
         jdpQ==
X-Gm-Message-State: AOAM531FK0+/8y8YYCPJ8oktbzpD9fryIMzDMkF8KQKXo6k3gLp8Aj59
        bbdoTdMTH4MDu3cFUWJ9CTn2RhIpux4A80Sl6XodGsWBXXLdPwuUpMhuWqHPM1x86Zkg4pDWred
        hu+glDUc8BNmYLAIF189uGI5iQJBns1TDIRWvkYzb4FU7h22jiRMrnpJwqQuHPXgU9dQ+LB8=
X-Received: by 2002:a0c:a789:: with SMTP id v9mr64927qva.41.1610377921922;
        Mon, 11 Jan 2021 07:12:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcAqysHBNs93WJfvR2O2qKdvrvzOgfLz+paIVyIwplHKXl+Trm6gELqe7+VJOEgIEjl7lfig==
X-Received: by 2002:a0c:a789:: with SMTP id v9mr64894qva.41.1610377921612;
        Mon, 11 Jan 2021 07:12:01 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id n31sm2516266qtn.66.2021.01.11.07.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 07:12:01 -0800 (PST)
Subject: Re: [PATCH -next] fpga: dfl-pci: rectify ReST formatting
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210111112113.27242-1-lukas.bulwahn@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d22ccfa1-19a1-d48c-d822-76ea289965ab@redhat.com>
Date:   Mon, 11 Jan 2021 07:11:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111112113.27242-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/11/21 3:21 AM, Lukas Bulwahn wrote:
> Commit fa41d10589be ("fpga: dfl-pci: locate DFLs by PCIe vendor specific
> capability") provides documentation to the FPGA Device Feature List (DFL)
> Framework Overview, but introduced new documentation warnings:
>
>   ./Documentation/fpga/dfl.rst:
>     505: WARNING: Title underline too short.
>     523: WARNING: Unexpected indentation.
>     523: WARNING: Blank line required after table.
>     524: WARNING: Block quote ends without a blank line; unexpected unindent.
>
> Rectify ReST formatting in ./Documentation/fpga/dfl.rst.

Can you explain how to reproduce this problem ?

Tom

>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210111
>
> Moritz, Matthew, please ack.
>
> Greg, please pick this doc fixup to your fpga -next tree on top of
> the commit above.
>
>  Documentation/fpga/dfl.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ea8cefc18bdb..c41ac76ffaae 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -502,7 +502,7 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>  could be a reference.
>  
>  Location of DFLs on a PCI Device
> -===========================
> +================================
>  The original method for finding a DFL on a PCI device assumed the start of the
>  first DFL to offset 0 of bar 0.  If the first node of the DFL is an FME,
>  then further DFLs in the port(s) are specified in FME header registers.
> @@ -514,6 +514,7 @@ data begins with a 4 byte vendor specific register for the number of DFLs follow
>  Offset/BIR vendor specific registers for each DFL. Bits 2:0 of Offset/BIR register
>  indicates the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
>  zero.
> +::
>  
>          +----------------------------+
>          |31     Number of DFLS      0|

