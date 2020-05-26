Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8CE1C2DC8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgECP4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 11:56:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39839 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgECP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:56:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id m10so4458283oie.6;
        Sun, 03 May 2020 08:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AuVp8U3lUOpSxeWV6NIshZiOxwm/x49dcEZgnd1MVVY=;
        b=NkxUa8KAgmioROFnePGASfBsiweXKgI6qnbLhbY6VOtNzaiMwB5+YLMsGSdUqgIDIp
         nRT43SbyW9x+C1C3SyWU0JaRF4VLprvIyje46VYvPzX4D1ekpyENgTZ1eoQe2za2Ql3K
         mQTGpHmVhw3kyEw0kDBURQRukzhmaH+OIlJwqEaaXe1QYiGUC9qYCGxPMPwtOg5XnGR4
         h+O1Hj7Na8HK4cauJ9fbZysQUptnkXX1FLp62tn5nI1JLzBmoyIOzZiY6Oq/2BjFgxhA
         7PyqR9vaQi+1AxCUrPbvOOJMC7PsGKjbemWtAXQFOywFmm02lM7dEYZoBwwRBTLcyun4
         nGlg==
X-Gm-Message-State: AGi0PuZCTyDhGhgBZoht9mbwRioimAg0DvR1DWfQeXeuTLjwazYwOpCZ
        MRzUu1/AEIwbaox+J2KPhw==
X-Google-Smtp-Source: APiQypKjV4PG8jLS/iGjenYZhgg6QXvELjLNIbQW1FvLo1A6vgT6B95EbaPC/6tNrbjvAH1sMuxGMA==
X-Received: by 2002:aca:1709:: with SMTP id j9mr6155165oii.59.1588521365873;
        Sun, 03 May 2020 08:56:05 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j42sm2498223ooi.5.2020.05.03.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 08:56:05 -0700 (PDT)
Received: (nullmailer pid 21916 invoked by uid 1000);
        Sun, 03 May 2020 15:56:04 -0000
Date:   Sun, 3 May 2020 10:56:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v3 6/8] dt-bindings: memory-controllers: Convert Calxeda
 DDR to json-schema
Message-ID: <20200503155604.GA21813@bogus>
References: <20200430211054.30466-1-andre.przywara@arm.com>
 <20200430211054.30466-7-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430211054.30466-7-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 22:10:52 +0100, Andre Przywara wrote:
> Convert the Calxeda DDR memory controller binding to DT schema format
> using json-schema.
> Although this technically covers the whole DRAM controller, the
> intention to use it only for error reporting and mapping fault addresses
> to DRAM chips.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../memory-controllers/calxeda-ddr-ctrlr.txt  | 16 -------
>  .../memory-controllers/calxeda-ddr-ctrlr.yaml | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.yaml
> 

Applied, thanks.

Rob
