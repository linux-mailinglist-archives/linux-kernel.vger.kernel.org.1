Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690D921AB36
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 01:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGIXGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 19:06:44 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39583 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:06:44 -0400
Received: by mail-il1-f194.google.com with SMTP id k6so3498210ili.6;
        Thu, 09 Jul 2020 16:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xWvjfe4d5jeOho7/LR3VXZ1hzAtbqiVX9N0YJ60owzY=;
        b=Q/EnoQDcZXjc3i6sVdENfKBAn2cF1yg/k4GpNll7+dBXmLmOqao3WhnJ56MXomCXxQ
         u1fIKpk0oy/YQNVlYyJUPzTtRafVl0Ti8raz2GS8pYFG57vtgqChtyNCuSFRJGUp+bBH
         Wvp17/MTIxIy+PYl8OScLtrPwoNFsMcJFUhG4DRqZs8U4cx4+1ec3LuPSggvtEECp0jL
         FFQMyf7ZJ5UJlRdmm6GmzH1LDAhZakc8pxdmG9oHe8qBDWXFi5oBeqwIr1Ices5GzNsm
         fZxcKd3uY4g+Z9+9ilY09QYE70B0XbseN3lqI4xxq2MhAMgWh0erZXZlKe9q5CcV8WLC
         qsRw==
X-Gm-Message-State: AOAM531elqa6kK13dUo3KoH5EasTSAzpNe1iJ3xkpGRI/d8vbBlWQYMX
        6CqK0BIu/Rg44jQHzPWHQkdhgzG1Dg==
X-Google-Smtp-Source: ABdhPJwelEpIIxRBztDDYZL/Qq660cQMgX15MtWfksuUg5HvaWRlaF8p3yrUKuub+naB5qngvsL7Vg==
X-Received: by 2002:a92:488f:: with SMTP id j15mr10261011ilg.269.1594336003689;
        Thu, 09 Jul 2020 16:06:43 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id v10sm2524461ilj.40.2020.07.09.16.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:06:43 -0700 (PDT)
Received: (nullmailer pid 1062430 invoked by uid 1000);
        Thu, 09 Jul 2020 23:06:42 -0000
Date:   Thu, 9 Jul 2020 17:06:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 07/12] ARM: mstar: Add binding details for
 mstar,l3bridge
Message-ID: <20200709230642.GA1062369@bogus>
References: <20200612130032.3905240-2-daniel@0x0f.com>
 <20200616121525.1409790-1-daniel@0x0f.com>
 <20200616121525.1409790-8-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616121525.1409790-8-daniel@0x0f.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 21:15:20 +0900, Daniel Palmer wrote:
> This adds a YAML description of the l3bridge node needed by the
> platform code for the MStar/SigmaStar Armv7 SoCs.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  .../bindings/misc/mstar,l3bridge.yaml         | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/mstar,l3bridge.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
