Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3306021AB2D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 01:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGIXEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 19:04:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36185 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgGIXEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:04:37 -0400
Received: by mail-io1-f66.google.com with SMTP id y2so4122908ioy.3;
        Thu, 09 Jul 2020 16:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sKfdcOYHoV5x+EbguEEkL2F4ngssXhas7N0aidMzE/o=;
        b=Ff1dyrJxw3iyTediyJBFmEOcLmLmIdBPtMH7bNR3oOK1KyUP5ziB7qfcmhvTwqIsHo
         VxVM+XtsV4+cfUfT/T4BXmcnYRSk6JtLzYdH9g8S0sw2+AcQPOsuOGOHyyMjAW1fbDnR
         eXvDKMSAbxqozILyRumofzwVpFU/DoKijNWYqZTyeFo1Gr7e6fX8ATxFO8IQokFaHgva
         u40ncKZI0p2wdBmjnt23XWsaMwmZp0qgJPjZnOgkpR+mgho8Nfe/OZzh6A0yJorKeocB
         joTITZsc78BrkaU/rpqwmWWU4OJXq6VSuiLl+TuvM+IUgdazjHMdXU0XASIW0CIbrjnM
         3viA==
X-Gm-Message-State: AOAM530oDBYHVlIcefEbLl/6SXQmo8+S2RJOj0sze3F3YG+iuZHHhsge
        KNeSgvuMbtTcCi6l0DTeug==
X-Google-Smtp-Source: ABdhPJzUIumORGv7wn8Kdn0T50nd2ADrEn/VStg/TnOv+en+1MScNsGPnY7vLHR1U3jWMI87DaoRqQ==
X-Received: by 2002:a6b:ee15:: with SMTP id i21mr45102373ioh.25.1594335876791;
        Thu, 09 Jul 2020 16:04:36 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id c9sm2472200ilm.57.2020.07.09.16.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:04:36 -0700 (PDT)
Received: (nullmailer pid 1058734 invoked by uid 1000);
        Thu, 09 Jul 2020 23:04:35 -0000
Date:   Thu, 9 Jul 2020 17:04:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/12] dt-bindings: vendor-prefixes: Add sstar vendor
 prefix
Message-ID: <20200709230435.GA1058682@bogus>
References: <20200612130032.3905240-2-daniel@0x0f.com>
 <20200616121525.1409790-1-daniel@0x0f.com>
 <20200616121525.1409790-3-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616121525.1409790-3-daniel@0x0f.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 21:15:15 +0900, Daniel Palmer wrote:
> Add prefix for Xiamen Xingchen Technology Co., Ltd
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
