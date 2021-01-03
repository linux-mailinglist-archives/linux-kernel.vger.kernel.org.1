Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438E22E8D43
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 17:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbhACQlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 11:41:03 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:37340 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhACQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 11:41:02 -0500
Received: by mail-io1-f46.google.com with SMTP id p187so22840283iod.4;
        Sun, 03 Jan 2021 08:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rc/T2TxBypt5YVdMY5gdMitHpPCBNSiGVrsGEuahx7A=;
        b=tSVyRvdhcAXiFP38UViB2mATWmQ3OR71RNPNdnl7qxP9LnXBG2C76Mfcltw/9pmD3D
         3dCxeE3dQU+cdK71qUG1JwE/6SfGK3jNTfFJBZWiKJZ7cfzq4Tw8ohrV+LtwWkj0FFhQ
         BBgORCEAaGd2itP4zTOTfenYsui8cClUC7bDEh12yoNx7UePW0TyeauBH6txZ7J+but3
         vf2ZFIqvejDVmAL3JcrkxpawqnVPR4OvUIWCXvxi8SgPSdgyJJBgpcvryXl3WYsslkSp
         6dMHbqTXrdmbqPKorwZL1mciDuherA2lSWcuPb9dN/sV/FWa8JRY5U1xT0c9VGisCHda
         R9xA==
X-Gm-Message-State: AOAM532FulPS3AJmH+GCEekfFOjLiS641mvQ6doAjrfmTWBOWIfa6ioK
        Cy2ZjRlseGN1+z+uEU6a5A==
X-Google-Smtp-Source: ABdhPJxs/kO48sUqzs4UxzlSJTLqxQi5BmNyrSpXEO+cqHnc2G+YA08xASJJOHU3sif9obc4r6Iklw==
X-Received: by 2002:a05:6602:228c:: with SMTP id d12mr58240904iod.67.1609692021238;
        Sun, 03 Jan 2021 08:40:21 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d5sm38692050ilf.33.2021.01.03.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 08:40:20 -0800 (PST)
Received: (nullmailer pid 4012762 invoked by uid 1000);
        Sun, 03 Jan 2021 16:40:16 -0000
Date:   Sun, 3 Jan 2021 09:40:16 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        james.quinlan@broadcom.com,
        "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE Mes..." 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: Add optional interrupt to
 smc/hvc SCMI transport
Message-ID: <20210103164016.GA4012686@robh.at.kernel.org>
References: <20201222145603.40192-1-jim2101024@gmail.com>
 <20201222145603.40192-2-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222145603.40192-2-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020 09:56:02 -0500, Jim Quinlan wrote:
> In normal use of smc/hvc transport in SCMI the message completion is
> indicated by the return of the SMC call.  This commit provides for an
> optional interrupt named "a2p" which is used instead to
> indicate the completion of a message.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scmi.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
