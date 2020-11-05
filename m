Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7FE2A8512
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbgKERjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:39:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38594 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKERjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:39:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id b2so2186115ots.5;
        Thu, 05 Nov 2020 09:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9/dAV+YUfcPWYAGUU9ajuM8GiwgLWOqAlRSGNWO1bN0=;
        b=Gd2zjTIi1M7D/xqFzjUDR1nX8iv71ES4BJqizGyhsoYh0yuaXBHp//BS1eLJmNkQEG
         JGhJ1TP21IxR/Iqq6dKivwz7nviytA43AvoJOZU5Rm8bbK5kj4FzJEwcYKeHe2ZEZS15
         vHb8RDrWnyFblOwHkPB9/chiXHd4fg+JrTZnDLwQr3KUsGV9j1zYEIy1Yu44EWSwJArT
         /FxhJU9Xh3SlwyxgvyPevhXMA3ffXgPz77zc1MEDGYeRJKKBUGnFJWRuWvp5NBMrbAW8
         2yMyQGC45cEgnWfw1QJG+tlUiSmtxmrEuY2dQxI7DL219h3eMvBkfrofpO9WPCtsLKu5
         62kg==
X-Gm-Message-State: AOAM530jY5qZf4aZ7iMF7nag0qPqstx9LI7OGI3xWETwzAQuOimtFEJr
        lGurVZbg32G01hH7q/d3LQ==
X-Google-Smtp-Source: ABdhPJxuTPEGRlBXmeiLBNkynERL2O1cojLMdnhsZ8onnyLrfiW5WFpgdCvpm7EGy1R6riJ/6dgDMg==
X-Received: by 2002:a9d:3e88:: with SMTP id b8mr2195881otc.331.1604597945734;
        Thu, 05 Nov 2020 09:39:05 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h136sm188660oib.19.2020.11.05.09.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:39:05 -0800 (PST)
Received: (nullmailer pid 1528840 invoked by uid 1000);
        Thu, 05 Nov 2020 17:39:04 -0000
Date:   Thu, 5 Nov 2020 11:39:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     vincent.guittot@linaro.org, Jonathan.Cameron@Huawei.com,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        linux-arm-kernel@lists.infradead.org, satyakim@qti.qualcomm.com,
        f.fainelli@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, souvik.chakravarty@arm.com,
        etienne.carriere@linaro.org, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] dt-bindings: arm: add support for SCMI Regulators
Message-ID: <20201105173904.GA1528783@bogus>
References: <20201102173238.4515-1-cristian.marussi@arm.com>
 <20201102173238.4515-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102173238.4515-6-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020 17:32:38 +0000, Cristian Marussi wrote:
> Add devicetree bindings to support regulators based on SCMI Voltage
> Domain Protocol.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v3 --> v4
> - added list of supported Regulator bindings.
> v2 --> v3
> - avoid awkard examples based on _cpu/_gpu regulators
> v1 --> v2
> - removed any reference to negative voltages
> ---
>  .../devicetree/bindings/arm/arm,scmi.txt      | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
