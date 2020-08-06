Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B00D23DCD0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 18:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgHFQ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 12:56:38 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:44077 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgHFQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:40:43 -0400
Received: by mail-qk1-f177.google.com with SMTP id j187so45469190qke.11;
        Thu, 06 Aug 2020 09:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gc23MbsN7Py2AbboYagkFP2z88M/HrX+ProFw+VbFVM=;
        b=ROfPHsG6aonG5ia7Kjn4qzG5KZvRkxWic1szCGP6lTh53B6aupm1JBYrYjidlefO+K
         GI/z5QCsB5xrIqeJQHmS8I7ANLG1fvkD/Nzpufp0+wxPOanjWlV9SeBUjTnTI+T4egmK
         o+zR8Ra8siBZtlGN0h2MbIa0yF5Ff96VYfMJsWrfwT+0iRsd1qOSUNtUBhDuedo/agTz
         TWrGvmcFU+kEgHclxWTGAmZOSHXhPOkCq2S9+WSV68TwCWSzCmT432EMQ+qY2oq9NrXD
         aUpya/G7M2l+4TSFQipVySQg2xjJ7umDBOcYz3pzvnhsvLhrm0FSR1MCnlnU35sew8cJ
         CGXQ==
X-Gm-Message-State: AOAM532r5OyYGjGo1ZXBdDtaw7EHHCx9wUJm/9JJ2v/AwnKv0uUhAS5m
        nR+U0L+FHfpQpD3K4B/6Hmn6BHA=
X-Google-Smtp-Source: ABdhPJyL1DZXcZGnPUV+B06ZfrnB9Tblb5Z4e91WZYwHydSuUfJe04oo3xFTp2utb9Cfoqi/+eTqGA==
X-Received: by 2002:a02:3445:: with SMTP id z5mr12031366jaz.134.1596725365863;
        Thu, 06 Aug 2020 07:49:25 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n10sm4371029ila.2.2020.08.06.07.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 07:49:25 -0700 (PDT)
Received: (nullmailer pid 838369 invoked by uid 1000);
        Thu, 06 Aug 2020 14:49:23 -0000
Date:   Thu, 6 Aug 2020 08:49:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-input@vger.kernel.org, Ahmet Inan <inan@distec.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        kernel@collabora.com, devicetree@vger.kernel.org
Subject: Re: [PATCHv4 1/4] dt-bindings: touchscreen: Convert EETI EXC3000
 touchscreen to json-schema
Message-ID: <20200806144923.GA838296@bogus>
References: <20200805160520.456570-1-sebastian.reichel@collabora.com>
 <20200805160520.456570-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805160520.456570-2-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Aug 2020 18:05:17 +0200, Sebastian Reichel wrote:
> Convert the EETI EXC3000 binding to DT schema format using json-schema
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../input/touchscreen/eeti,exc3000.yaml       | 53 +++++++++++++++++++
>  .../bindings/input/touchscreen/exc3000.txt    | 26 ---------
>  2 files changed, 53 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
