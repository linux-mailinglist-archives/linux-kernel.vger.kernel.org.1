Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733951E7316
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 05:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407617AbgE2C7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 22:59:23 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43900 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407560AbgE2C6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:50 -0400
Received: by mail-il1-f193.google.com with SMTP id l20so1027444ilj.10;
        Thu, 28 May 2020 19:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m6kcwlIC7SKtx9thDsfIOgDZfkogbuD8SNG7gHAFV2g=;
        b=s4aBb0TzRVNe4K4CCs7+pXaeD3TSO/nKwYdZEBOfCxcoFziIt4BIumIb6at8uYdYfl
         dPgxXy0B59b2s0iXzcpIZgueiagK9VHXJY443wAs2Xx0BUfcwmrInnZ75E6E3EpIbWgm
         Y+UgA/Q9q6ohu6mhImnsmukzkKrjyBgoK+AjiWeS6BU7joyGodbylH9ZSmhMm5/f2FVD
         JC5ZmiNDbZ1iGY8TNVAE81VPBLdinmHahZ/+aoFseUMUVkhDYtOdhY8SMSb2VXJnEs55
         YVIG5HmeqAE00DuynVHTD4qkN/SjAQ6x39tJ1kFjGm9p7Ih2FaKiabYltgiaIWAGmzXG
         HK6A==
X-Gm-Message-State: AOAM530iCUN34/HSFeexXqoOki8wfTQZ5AW7g4K1Kg0YI1ZTl5rmSDYK
        13ySgXlwlxiXxAIMffAaSg==
X-Google-Smtp-Source: ABdhPJzvfcF83aDlvSVv+tXYOmvv+ugf8LjGNXP4oxa2f48ct9MiDm/qpBCJ2AWztc8Ety30ZSqprg==
X-Received: by 2002:a92:9c04:: with SMTP id h4mr5267706ili.190.1590721128061;
        Thu, 28 May 2020 19:58:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p75sm4101531ilb.23.2020.05.28.19.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:58:47 -0700 (PDT)
Received: (nullmailer pid 1186722 invoked by uid 1000);
        Fri, 29 May 2020 02:58:46 -0000
Date:   Thu, 28 May 2020 20:58:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: sound: tlv320adcx140: Fix dt-binding-check
 issue
Message-ID: <20200529025846.GA1185629@bogus>
References: <20200528144711.18065-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528144711.18065-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:47:11AM -0500, Dan Murphy wrote:
> Fix dt-binding-check issue
> 
> ti,gpi-config:0:0: 4 is greater than the maximum of 1
> ti,gpi-config:0:1: 5 is greater than the maximum of 1
> ti,gpi-config:0:2: 6 is greater than the maximum of 1
> ti,gpi-config:0:3: 7 is greater than the maximum of 1
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/sound/tlv320adcx140.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the quick fix.

Reviewed-by: Rob Herring <robh@kernel.org>
