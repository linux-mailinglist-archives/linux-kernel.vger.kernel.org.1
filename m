Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112261F9CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 18:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgFOQQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 12:16:04 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34750 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbgFOQQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:16:03 -0400
Received: by mail-il1-f196.google.com with SMTP id x18so15870455ilp.1;
        Mon, 15 Jun 2020 09:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LceDJi3HuuWFN2rUgpbq9GLOkPnvp0H8zJIFHXcribA=;
        b=R8rWbmQQ1Ld2NioytF8AOE6s+UHsz3atLKm5HT9H5Fua52uJILAcgnM0R7v6gOgJ/7
         Gi1tK+bikXadGd4FQld/WRA8ugGq5y8JERAr3p9mlXT+M7kj8xmdd5mjQi+B1pF4Z90p
         nEgHFOQNkv9dMqUgSJemQWi6+2DU0eOHAbKJlSdrjbG5Tl02LSsV5uXVQa27O1Lwlxkw
         lNfFJPJOE+yPr4S6gJX2MnKISJL8HQxPLOqWnmVBZk9NDwzdUsWR0h6BW9vA6a6o0Q/2
         +7RY5zJnn219rlBr2XgI/ESjKSKVuroYE8k3fZYGfmUL21bdOslgXSPn1tyyMbkk6eMs
         KvoA==
X-Gm-Message-State: AOAM530PEcVF4AKFW/OQrNTeYnm+A9HZIVd4Mgw90KuDCEh2XHmHKkJu
        rlE6ZSH9+7eo9pAt1HyW824Fgng=
X-Google-Smtp-Source: ABdhPJyZayJnee33cEuYPLpvv8OyZZt5YkVa8FQA9aXv9nTs8vxc6i5A2MxwMGdecxLvtPyRUjxzAQ==
X-Received: by 2002:a92:c6cb:: with SMTP id v11mr27435851ilm.206.1592237761673;
        Mon, 15 Jun 2020 09:16:01 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g15sm8158427ilr.5.2020.06.15.09.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:16:01 -0700 (PDT)
Received: (nullmailer pid 1876770 invoked by uid 1000);
        Mon, 15 Jun 2020 16:15:59 -0000
Date:   Mon, 15 Jun 2020 10:15:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: remoteproc: k3-dsp: Update bindings
 for C71x DSPs
Message-ID: <20200615161559.GA1876521@bogus>
References: <20200612225357.8251-1-s-anna@ti.com>
 <20200612225357.8251-2-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612225357.8251-2-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 17:53:56 -0500, Suman Anna wrote:
> Some Texas Instruments K3 family of SoCs have one of more newer
> generation TMS320C71x CorePac processor subsystem in addition to
> the existing TMS320C66x CorePac processor subsystems. Update the
> device tree bindings document for the C71x DSP devices.
> 
> The example is also updated to show the single C71 DSP present
> on J721E SoCs.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v3:
>  - Dropped Rob's previous Reviewed-by tag due to decent changes in the
>    patch
>  - Replaced the minItems and maxItems from reg with actual items list
>  - Dropped C71 reserved memory nodes from example
> v2: https://patchwork.kernel.org/patch/11563231/
> 
>  .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 68 +++++++++++++++----
>  1 file changed, 55 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
