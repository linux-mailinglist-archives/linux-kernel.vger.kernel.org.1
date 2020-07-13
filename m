Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7946821AB4A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 01:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGIXNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 19:13:41 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35461 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:13:41 -0400
Received: by mail-il1-f194.google.com with SMTP id t18so3516962ilh.2;
        Thu, 09 Jul 2020 16:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qVYJSmIH5pGs/4dhKNiiY1TOXTho3Eq5GDRG0ULpRKU=;
        b=V7XIFnZuJH+UNp/ReoPeWYAQHb6LdWLXvZeDMdtKNiMUlRge1jaW1bXoM0ITCWcxG2
         +jpR95Lhc7erG2uOnJlt84dYIwdKWoonrILoBSn4BAx03uVlfUJJfQKoO94Xeerd6tHL
         5pppKFazt0qP6wWwBi+bIQeYWf9zsfQ+dIyYpfgtUN8FrB0FWxQhVE/AOvkRK1SupYw9
         CiL+kVYBuauActX8WucXRjzff/qFcWZFAt3759VJF97B6dRG0Zbt8GGeRfXPMv7TrXNm
         GnRQzsycGh0v4/2YHIN+vdlmDlJZLZp9dNxUsEcqGfKsRT/mSa6qarvJCetkmAkTHyKn
         8qiQ==
X-Gm-Message-State: AOAM5330fP7NFfbSlo72vGjKPh4DW/Gu24PIlxCM8NNbMTTPHrzdqPMc
        /msfaRxlWJWkAflGOB3rUg==
X-Google-Smtp-Source: ABdhPJwSaf8vHd4K9Dyi8pY6+VkhDEivCPd1Hgh2whPHR6+/lCW9ltyoN1fWo70Xj5XWqmqCNSCjJQ==
X-Received: by 2002:a92:cece:: with SMTP id z14mr19176614ilq.120.1594336420385;
        Thu, 09 Jul 2020 16:13:40 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id p84sm2739075ill.64.2020.07.09.16.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:13:39 -0700 (PDT)
Received: (nullmailer pid 1073745 invoked by uid 1000);
        Thu, 09 Jul 2020 23:13:38 -0000
Date:   Thu, 9 Jul 2020 17:13:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Add Sparx5 temperature sensor
Message-ID: <20200709231338.GA1073694@bogus>
References: <20200618135951.25441-1-lars.povlsen@microchip.com>
 <20200618135951.25441-2-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618135951.25441-2-lars.povlsen@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 15:59:49 +0200, Lars Povlsen wrote:
> This add the DT binding specification for the Sparx5 temperature
> sensor.
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../bindings/hwmon/microchip,sparx5-temp.yaml | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
