Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E141C2DCC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 17:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgECP4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 11:56:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34203 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgECP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:56:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id x10so4483196oie.1;
        Sun, 03 May 2020 08:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PLOLvZE+s39Hp3IKRQqs7UuDfEqpShYvBhp9hM9EmJI=;
        b=c/cv4V5SLg+nUvB9paCCBJN45jZtLj6fQqp/luysw6gTpKlYlTUJHNi0ZVk53hBFQu
         ASvHrV1R9Mz9PVXi6rFFumTiwhbeuS0VLjZ5teZvNQiQLg/ccdrbatVscQMc7pFzhlNr
         UWeWG80O2FlA2H6KTacsFqtW+Pe51vk52TRf1LzY0zcgeDta5rAH8QEwJ+C4RxDS32uV
         Ub1TUM//qEoIs3qYjgGB3M5XCTGUbdJnkRaOXmS0YONfybJc/vMHgFR523TOMrK6sgpg
         Y2N8UOA0AbpmOlOUt8LWkuOjAq/YrIDWnfZInke/lGijPfMalh519JUtofZKc/0syXXa
         iyRQ==
X-Gm-Message-State: AGi0Pub+vx9zvBm4Y8giUcJM0jksoRQfglp7M+/7oVp65pLVq0nQ/UFB
        l1T9T0G2Ij7zxLv9I+guEw==
X-Google-Smtp-Source: APiQypLIuHNhlfXyGR1tRhlXU/FmUWgupHa1Z2ZRPxSlSoRpqcq6frZKcvRA/5O/V70e+xNobWFmKA==
X-Received: by 2002:aca:c546:: with SMTP id v67mr6016397oif.84.1588521386842;
        Sun, 03 May 2020 08:56:26 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g10sm2518523oou.31.2020.05.03.08.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 08:56:26 -0700 (PDT)
Received: (nullmailer pid 22903 invoked by uid 1000);
        Sun, 03 May 2020 15:56:25 -0000
Date:   Sun, 3 May 2020 10:56:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v3 8/8] dt-bindings: arm: Add Calxeda system registers
 json-schema binding
Message-ID: <20200503155625.GA22844@bogus>
References: <20200430211054.30466-1-andre.przywara@arm.com>
 <20200430211054.30466-9-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430211054.30466-9-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 22:10:54 +0100, Andre Przywara wrote:
> The Calxeda system registers are a collection of MMIO register
> controlling several more general aspects of the SoC.
> Beside for some power management tasks this node is also somewhat
> abused as the container for the clock nodes.
> 
> Add a binding in DT schema format using json-schema.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../bindings/arm/calxeda/hb-sregs.yaml        | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml
> 

Applied, thanks.

Rob
