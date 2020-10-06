Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970152853C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgJFVR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:17:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36712 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgJFVR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:17:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id 60so228940otw.3;
        Tue, 06 Oct 2020 14:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDfEFjOxvV5lnlJ5Dhtp3js2iortYdXKM+0f6FyQWho=;
        b=cpsmOD66oVflxCH+Xfp8sA7BQMedOe41NDfEIpF4Khx2c/b3gKYlwOwYYQtH2VGJKH
         w6hb6G6yJ634502S5rDx5JEBnYl0t+ExspJGpML8u8SfhUTN08r/zlkTbjQiadUzLfFn
         0gXOXhr7kTQOhb3+vnUEbI2hVR8hwF/0IznYJxdYkS8c0EuQMcF/iA14YcgdBzk6TIxa
         Fd+bLwvpQXTq03Ja90Is92EYjhct/MrFcXkxbyo8+ntQzSeT6GB7BJa2Te2Ll4Y9r0Ka
         iNpCH0uBBHc4q16f1fpdl15TrTrQaA0UAdphDDgtbG3IXql7kef1TjGC1wfG4wTq0BQb
         pFiA==
X-Gm-Message-State: AOAM533z3baOrozNpR+BrBtChic0xVLpXuhiexWKmtzvwbN6Y2f1QqYa
        RDCOO74a8FgZ6RprLKXBc+NL+Jx9gSZC
X-Google-Smtp-Source: ABdhPJxHWw8Nsyci8DS/igtGgNuSzSxHHAh9iRU+J8qZ4eCIk3SbSIp1v9rGpeD5riEEemBsERVA7g==
X-Received: by 2002:a05:6830:2425:: with SMTP id k5mr4129010ots.86.1602019044700;
        Tue, 06 Oct 2020 14:17:24 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f11sm133739oot.4.2020.10.06.14.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:17:24 -0700 (PDT)
Received: (nullmailer pid 2858433 invoked by uid 1000);
        Tue, 06 Oct 2020 21:17:22 -0000
Date:   Tue, 6 Oct 2020 16:17:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chu Lin <linchuyuan@google.com>
Cc:     linux-hwmon@vger.kernel.org, linux@roeck-us.net,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: max20730: adding device tree
 doc for max20730
Message-ID: <20201006211722.GA2858348@bogus>
References: <20201004031445.2321090-1-linchuyuan@google.com>
 <20201004031445.2321090-2-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004031445.2321090-2-linchuyuan@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Oct 2020 03:14:44 +0000, Chu Lin wrote:
> max20730 Integrated, Step-Down Switching Regulator with PMBus
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---
> ChangeLog v1 -> v2
>   hwmon: pmbus: max20730:
>   - Don't do anything to the ret if an error is returned from pmbus_read_word
>   - avoid overflow when doing multiplication
> 
> ChangeLog v2 -> v3
>   dt-bindings: hwmon: max20730:
>   - Provide the binding documentation in yaml format
>   hwmon: pmbus: max20730:
>   - No change
> 
> ChangeLog v3 -> v4
>   dt-bindings: hwmon: max20730:
>   - Fix highefficiency to high efficiency in description
>   - Fix presents to present in vout-voltage-divider
>   - Add additionalProperties: false
>   hwmon: pmbus: max20730:
>   - No change
> 
>  .../bindings/hwmon/maxim,max20730.yaml        | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
