Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2BF3009ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbhAVRa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:30:59 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:44312 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbhAVPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:49:25 -0500
Received: by mail-ot1-f44.google.com with SMTP id e70so5440844ote.11;
        Fri, 22 Jan 2021 07:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IJdsjZNSCEQvolS06e2LzBH4VLzd6i5FaqMcJkm05UE=;
        b=JaFcrWDLx4S0hWLW3sp71XroteKRD32LY3j2iDy/vQPSHhsJ38NYI0MpGlUu+sn7e7
         V/WIKavZ9Lfl4pdzv/AJRF9CzvGcL7zVVegHdpR95+h1WUamYDlQkbaTWsKoa4ykKppe
         zkJhg4ob3OJis6gBTFo25g49OwTKQb4kge1QjsaGFVuGlG0UDVEMr09BwqARB+ezD+X2
         K2ql5pdQub5bY22rjx3NfUhQ26Qq2i7Lxz7B84VSmk513rBLqmi1IcU/jvB959N8q8DN
         QC2DShgqkW18TZP/IBnQDaVRXI+lEZgxoaSiF/XtSHE+ASoQpJ1XPQW/VHPDd9oXdH3u
         p9Bw==
X-Gm-Message-State: AOAM533lZAxxFHO7lqduXRqub4p9miCjwNMY2IG9F5Boz4IVq4Z7OUPK
        B0GfFN6Gpq1v5F7VFwpKjFMHlmONmQ==
X-Google-Smtp-Source: ABdhPJzGN0HB/SjLoRL/FYxZrHlQD+EhxhrSpXrs/2UptZxyd2R/mBjbaPonONY27jl1HXzgQW5NRg==
X-Received: by 2002:a9d:17aa:: with SMTP id j39mr3435004otj.255.1611330524488;
        Fri, 22 Jan 2021 07:48:44 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q26sm269282otg.28.2021.01.22.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 07:48:43 -0800 (PST)
Received: (nullmailer pid 854341 invoked by uid 1000);
        Fri, 22 Jan 2021 15:48:42 -0000
Date:   Fri, 22 Jan 2021 09:48:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>, John Crispin <john@phrozen.org>,
        devicetree@vger.kernel.org,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: Add Realtek
 RTL838x/RTL839x support
Message-ID: <20210122154842.GA854287@robh.at.kernel.org>
References: <20210120101018.237693-1-bert@biot.com>
 <20210120101018.237693-2-bert@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120101018.237693-2-bert@biot.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 11:10:17 +0100, Bert Vermeulen wrote:
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  .../realtek,rtl-intc.yaml                     | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
