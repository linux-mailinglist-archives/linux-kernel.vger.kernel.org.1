Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34502B4D59
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbgKPRgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:36:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45582 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731590AbgKPRgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:36:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id k3so16754828otp.12;
        Mon, 16 Nov 2020 09:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eu89zIOkkQ+RwpYfgoglgMZA8e7V2O4a44a0i8NV0Ww=;
        b=uWz5skyCwca/Lw5bEb00tD4rsww1ygt+PSKDS/tY8PTd11z3uaVh7tbFPnvBqBM4gu
         hpXuCT8m/vgW7MObbszDFJ5KaidNfmkZ+xZOGxo3pKUKXBdLWG8oySxl7QRKKMW2qXqv
         BTDSshLG13X3gosSdKISEMjeofoYPkFzgJ6yUf0qKtubwO3urwMjdVKbIi9gnV2AUUBh
         irHY1/Yq1/o9YtGAUF42xLV/6qD4ImLwDpA3vJmw1j/9moHQyIP/vwC0Bs1yhTgL3ll5
         Ng+W09Rbbmv8Zng6Z8ReU1LTMij/TNke9bkUwTGGfeguGcYQ2Tr+PdCWWikXdtDJVQCX
         SdoA==
X-Gm-Message-State: AOAM533E54YwADmk2E4Vuxg7l6X/gXCp/tBeEcQ4itgRjB58RjRYH61q
        1a/8gWRTGXq/aSOnX5kBeQ==
X-Google-Smtp-Source: ABdhPJzcJKA6DG3DNaW7RINXauhrTJBWHQr9psD8GzmUDpKfVnqr1JGdZSSOZD10NyPP2yCcXifMAA==
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr270339ots.336.1605548181631;
        Mon, 16 Nov 2020 09:36:21 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d26sm4944086ooh.19.2020.11.16.09.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:36:21 -0800 (PST)
Received: (nullmailer pid 1852133 invoked by uid 1000);
        Mon, 16 Nov 2020 17:36:20 -0000
Date:   Mon, 16 Nov 2020 11:36:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org, mark.thoren@analog.com,
        devicetree@vger.kernel.org, jdelvare@suse.com,
        ardeleanalex@gmail.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: hwmon: ltc2945: add device tree doc
 for ltc2945
Message-ID: <20201116173620.GA1852071@bogus>
References: <20201111091259.46773-1-alexandru.ardelean@analog.com>
 <20201111091259.46773-5-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111091259.46773-5-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 11:12:59 +0200, Alexandru Ardelean wrote:
> This change adds a device-tree binding documentation for the Linear
> Technology (now Analog Devices) LTC2945 Wide Range I2C Power Monitor.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/hwmon/adi,ltc2945.yaml           | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
