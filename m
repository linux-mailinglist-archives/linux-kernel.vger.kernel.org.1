Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080E4242D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 18:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHLQom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 12:44:42 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44514 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgHLQol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:44:41 -0400
Received: by mail-il1-f193.google.com with SMTP id j9so2384174ilc.11;
        Wed, 12 Aug 2020 09:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vd2lCK883RYVXk9yUMzFNuAN84iOpzHHcd6aV2A90eI=;
        b=j6rMjmIcwnARnTzYV5KsiF+/m8D2Ovk2Uq7MsRZraR9lcYWQv2d8IA8xDg25GKHbEG
         qJMuekvmrw95nxPC//39iEIq5ML/YdLSL9T5PjnHSeAXeNtMWhD/pwqpupqS7RQpmm1L
         ext80SbAn/V/zR1jAg+OWkyopw2g16rz7Hd6zbbZ3sA79C3BNPSlPyEydLPUkb2farbE
         noJRxcnpQOT+EZ9XFjzNXi7QhyuwpesYPxniGrnRDeJc1jrn7zwDydXL7L5y14tnup2d
         nG81uVpEXJYQUuyRd4JfT8SzO4dMJV4wTQQlgLadHKb8X9zK19f44C+PXMNG3HK83+61
         D91A==
X-Gm-Message-State: AOAM530hhdgDCUoD0RpA4alIEgj0MxsgsrndLB6+jJZiuyUhu9uG91WB
        Om8cvukiz5/oWwXK+wKaNw==
X-Google-Smtp-Source: ABdhPJy2UKlfaNw+pWSw0cTLNMRo0qWo8T+zel7LF5arcYSnWIPpPpVStaucz+G2GRXXdsPmPSGkkQ==
X-Received: by 2002:a92:414b:: with SMTP id o72mr495343ila.59.1597250679488;
        Wed, 12 Aug 2020 09:44:39 -0700 (PDT)
Received: from xps15 ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t5sm1317213ilp.15.2020.08.12.09.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:44:38 -0700 (PDT)
Received: (nullmailer pid 2348541 invoked by uid 1000);
        Wed, 12 Aug 2020 16:44:37 -0000
Date:   Wed, 12 Aug 2020 10:44:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net
Subject: Re: [PATCH v8 6/6] dt-bindings: hwmon: Add bindings for ADM1266
Message-ID: <20200812164437.GA2348280@bogus>
References: <20200812142055.9213-1-alexandru.tachici@analog.com>
 <20200812142055.9213-7-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812142055.9213-7-alexandru.tachici@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 17:20:55 +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add bindings for the Analog Devices ADM1266 sequencer.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/hwmon/adi,adm1266.yaml           | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
