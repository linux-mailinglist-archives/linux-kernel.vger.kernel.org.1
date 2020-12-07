Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C882D1CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgLGWNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:13:44 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:32992 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgLGWNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:13:43 -0500
Received: by mail-oo1-f67.google.com with SMTP id f8so3592213oou.0;
        Mon, 07 Dec 2020 14:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=48t+bOSWWAxhp/tegsOE6F95FDw1uWSdhgQF+J+swBg=;
        b=eAaO4V2dNKoOtLf8N71OoNSc2EUoWpiKalNMLK86rvrXIdxGesij+P4Y9VauQlBgCq
         pGW3uNQ15MxuW+WMDnu5omIykGcAsHLCuCEMw/ZWR2ON4U/XyWTd6kgZK2Mtg8K6V4yq
         4CXOJDTJrq/+/NgmpnU16J9in7tgUUR48/nyHeYkOJRbxRiw7uH+GTAp3n1hlsYB/Ja/
         VQY5ukv+kv5GOtwCk4jD5WGPXQvQPE4kIZ3Sr5xNMdwuvfdkn7kh0dqXPT5ljIbbs7Mo
         c9HTKfSFEeHEol0WNyfhAlrDtvY6p+FeQLqoyNWqXsWPSfXfRkZyjwTCy+/an96V3Rol
         XCog==
X-Gm-Message-State: AOAM532iR+Nhxyu1WMirDFdsz2HjQa04acQrM7P3JpU+Srs2XxHG36gj
        de+XOrfe8uqUw2npCnnTuA==
X-Google-Smtp-Source: ABdhPJzUUSjy0quOPbp/g8awC+ferlhaMKmZw7lCZs26C/Jnpj7fIIhyckPClhkzRPismucgeUD8lQ==
X-Received: by 2002:a4a:d043:: with SMTP id x3mr14268036oor.19.1607379183035;
        Mon, 07 Dec 2020 14:13:03 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v4sm1366519otk.50.2020.12.07.14.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:13:02 -0800 (PST)
Received: (nullmailer pid 930521 invoked by uid 1000);
        Mon, 07 Dec 2020 22:13:01 -0000
Date:   Mon, 7 Dec 2020 16:13:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>, linux-fsi@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: fsi: Add P10 OCC device documentation
Message-ID: <20201207221301.GA930468@robh.at.kernel.org>
References: <20201120010315.190737-1-joel@jms.id.au>
 <20201120010315.190737-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120010315.190737-2-joel@jms.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 11:33:13 +1030, Joel Stanley wrote:
> From: Eddie James <eajames@linux.ibm.com>
> 
> Add the P10 compatible string.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
