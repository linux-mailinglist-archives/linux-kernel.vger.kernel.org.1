Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8E62AF9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgKKU0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:26:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41014 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgKKU0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:26:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id n15so3380976otl.8;
        Wed, 11 Nov 2020 12:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hj4+pw8ddDfVRLtVVhtMI2FMKPhHhrdKPEjjLMu5Maw=;
        b=k/Vk3fCP3rp1YbVcOPiaM12BUyGkuafvgzY7v7ZyaVF6hramo6s9WBFF2RZgEol9oX
         lcp56nCLFD8fSIE0q7V6nT68oOH3BkuMjf+bksF4qox65rFy0/3xGQBrHQqWgBlZRZyB
         bE68QVv1of1Ku3D7gTR02TK69ndcDYS/jK02/zlgnn0IKRyCwVB560ii6cNWVCi19aIi
         Vm7dhR0s/8eOKiJIpmJmxQetTRQvPvMbwWb/xUg9Jvw3Tz2OzHzJ/3I4DaO3JZM64r65
         +GJxZk1otB9941ofeSXPI01mP8o8uW43zgSkV7qBc3PgMYsD5IoYzKQPyERU5wJxM8LE
         4EIg==
X-Gm-Message-State: AOAM533UTiQi3lH8Myv4z5LmZOUhumTsqLzQ7QS94RBqokDgz6ndjewN
        5UL68ZSPnembbT796k8KiA==
X-Google-Smtp-Source: ABdhPJxr4q2zIpY09NpELS89LQibqWQjpbSRdmMZh63473nOtuxnOzgW3Rb86xN0M0DADa2i2F92QQ==
X-Received: by 2002:a9d:75d6:: with SMTP id c22mr6031778otl.350.1605126404918;
        Wed, 11 Nov 2020 12:26:44 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x190sm638931oia.35.2020.11.11.12.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:26:44 -0800 (PST)
Received: (nullmailer pid 1971079 invoked by uid 1000);
        Wed, 11 Nov 2020 20:26:42 -0000
Date:   Wed, 11 Nov 2020 14:26:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <lijun.kernel@gmail.com>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 2/5] dt-bindings: usb: Add DT bindings for STUSB160x
 Type-C controller
Message-ID: <20201111202642.GA1971049@bogus>
References: <20201106165805.31534-1-amelie.delaunay@st.com>
 <20201106165805.31534-3-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106165805.31534-3-amelie.delaunay@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020 17:58:02 +0100, Amelie Delaunay wrote:
> Add binding documentation for the STMicroelectronics STUSB160x Type-C port
> controller.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/usb/st,stusb160x.yaml | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/st,stusb160x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
