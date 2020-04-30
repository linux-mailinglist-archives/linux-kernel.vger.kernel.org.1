Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3281BFFCB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 17:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgD3PMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 11:12:21 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:44318 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgD3PMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:12:21 -0400
Received: by mail-oo1-f66.google.com with SMTP id p67so1348536ooa.11;
        Thu, 30 Apr 2020 08:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=obpQxpSJiyFLGTkwGrLdNKbwi6uRMLRDKh8cYyDjJsI=;
        b=tnOqxCrTJGePguJFugSrWx8GaWchdS9npWVa9TtaeGPiGjx4bxTWO3BMgCpzPAIydu
         FQgVr3KNfFBnHiATvfI1etKhO3ul4JC5FGUPTp4+EtP5hfOCAGaRF7RIT2kSZPKxHg/j
         hQz8pWlfCwhDBu26WinoLKoWTnBLUQC3HWq7/aVUcyOhxKUW5NgU9yAfXdLr+inoWei/
         YXqPqFoqtYLmPFazGIVk/LNdPI/eivk8y9V/9VcgmAwg8vMUim6j/9EXWMK/GJhxgpHZ
         uZiXASAE67cQclHCO6DYEF+Qd/dEmE4eCR/+ihzBMqFisJQ5HEvoYN1LVCc1flqqNbsm
         D8rQ==
X-Gm-Message-State: AGi0PubXlm0nRD6maCRlcJEn7MwO/48UAJJG5tA1SBBBZDuMrs30/Jf4
        Ih94CEZS5fFqAz4/TjOXCA==
X-Google-Smtp-Source: APiQypJ4BHLeZGMcwyA8O7CLgokYWdf16RFXaSVYKFjfgHJjv8YSnSyns/hrZx52G4ePwLQZAGxRzA==
X-Received: by 2002:a4a:8253:: with SMTP id t19mr3218052oog.69.1588259538956;
        Thu, 30 Apr 2020 08:12:18 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o10sm43210oti.52.2020.04.30.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:12:18 -0700 (PDT)
Received: (nullmailer pid 11469 invoked by uid 1000);
        Thu, 30 Apr 2020 15:12:17 -0000
Date:   Thu, 30 Apr 2020 10:12:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hyunki00.koo@samsung.com
Subject: Re: [PATCH v8 2/3] dt-bindings: serial: Add reg-io-width compatible
Message-ID: <20200430151217.GA11429@bogus>
References: <20200420013300.17249-1-hyunki00.koo@samsung.com>
 <CGME20200420013325epcas2p13f65e6bc8ba68f89c805704830144870@epcas2p1.samsung.com>
 <20200420013300.17249-2-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420013300.17249-2-hyunki00.koo@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 10:32:57 +0900, Hyunki Koo wrote:
> Add a description for reg-io-width options for the samsung serial
> UART peripheral.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
