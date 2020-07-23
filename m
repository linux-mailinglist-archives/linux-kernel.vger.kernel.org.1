Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9B922B42D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgGWRJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 13:09:13 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37729 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgGWRJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:09:13 -0400
Received: by mail-il1-f193.google.com with SMTP id r12so4943907ilh.4;
        Thu, 23 Jul 2020 10:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kze7uV82SUZpJUOtNuBnD6sFmN/SrEeVHBi08SLQeLQ=;
        b=EA1NtiF79HQ1jKCrg/JQzDIsiWdB2tb8OL/8CIqsVZFr5FVKjc/L8mvuiiWUxmFz1R
         OS0v7aeknKZiAZs8/Ur3D1T7vcarataQaMLhDdcsXWRgbRQOJbatL9oWRMIK4davI0iP
         PeaKHeCpF7tzOJHibOLZCJV4uo/0lrzALUnbhu1wwyynDEo8pk/+iylT9F/iR7unxMyX
         UIMTzVxBTWQER282KpvktiQ9HyMDQ6aWwKGhLvF67SNVW76EbsgjjAFWdPFi87hWmWgf
         mPijGzcmJJtOvYJ7D5e1sVDleYOgEpLPp+LkzdHBVGD4PTzgq2X3+wtqsL1TrP42bbwX
         MDOg==
X-Gm-Message-State: AOAM533BC2Ye3PSvZXygSZUEahibVDHRbgA2nG0j42cIJZUAM5sQKuI7
        K1LCUI/a1fRFnoUqOkXyDw==
X-Google-Smtp-Source: ABdhPJwAoGVIDmO0+nmhcKlcUs+phhhTWD14e8hUiqneEXeaH3ip09RFCPy8OBqVRcv3YPZwJ2M5Dw==
X-Received: by 2002:a92:9804:: with SMTP id l4mr5879435ili.271.1595524152087;
        Thu, 23 Jul 2020 10:09:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o16sm1783266ilt.59.2020.07.23.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:09:11 -0700 (PDT)
Received: (nullmailer pid 544431 invoked by uid 1000);
        Thu, 23 Jul 2020 17:09:10 -0000
Date:   Thu, 23 Jul 2020 11:09:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     linux-kernel@vger.kernel.org, agx@sigxcpu.org, kernel@puri.sm,
        broonie@kernel.org, mchehab@kernel.org, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        festevam@gmail.com, devicetree@vger.kernel.org,
        Anson.Huang@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
        angus@akkea.ca
Subject: Re: [PATCH v4 3/3] dt-bindings: arm: fsl: Add the librem 5 phone
Message-ID: <20200723170910.GA544402@bogus>
References: <20200721153225.7593-1-martin.kepplinger@puri.sm>
 <20200721153225.7593-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721153225.7593-3-martin.kepplinger@puri.sm>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 17:32:25 +0200, Martin Kepplinger wrote:
> Add entries for the imx8mq based Librem 5 phone. The "Birch" and
> "Chestnut" hardware revisions are supported by r2. The "Dogwood"
> revision by r3.
> See https://puri.sm/products/librem-5/ and https://developer.puri.sm/Librem5/
> for the schematics and more information.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
